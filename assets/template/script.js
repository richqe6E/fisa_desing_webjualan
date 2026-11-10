const $ = s => document.querySelector(s), $$ = s => [...document.querySelectorAll(s)];
const hparams = () => new URLSearchParams(location.hash.replace(/^#\/?/, ''));
const getP = id => PRODUCTS.find(p => p.id === id);
const onHome = !!$('#grid');
const baseUrl = (window.ystore && window.ystore.baseUrl) || '';

// Fallback bila CDN icon gagal dimuat
document.fonts.load('1em "bootstrap-icons"').then(f => { if (!f.length) document.documentElement.classList.add('no-icons'); }).catch(() => document.documentElement.classList.add('no-icons'));

function toast(text) {
  const t = $('#toast'); t.textContent = text; t.classList.add('show');
  clearTimeout(toast.id); toast.id = setTimeout(() => t.classList.remove('show'), 2200);
}

// Navbar fixed: beri garis tipis setelah scroll
const hdr = $('#siteHeader');
const onScroll = () => hdr.classList.toggle('scrolled', scrollY > 8);
addEventListener('scroll', onScroll, { passive: true }); onScroll();

// Menu mobile
const menu = $('#menu'), burger = $('#burger');
const setMenu = open => { menu.classList.toggle('open', open); burger.setAttribute('aria-expanded', open); };
burger.addEventListener('click', () => setMenu(!menu.classList.contains('open')));
$$('#menu a').forEach(a => a.addEventListener('click', () => setMenu(false)));

// Filter kategori + pencarian (beranda & daftar produk)
const tabs = $$('#tabs button'), empty = $('#empty'), q = $('#q');
let filter = hparams().get('kategori') || hparams().get('cat') || (($('#tabs .active') || { dataset: {} }).dataset.filter || 'all');
function setCard(c, show) {
  clearTimeout(c._t);
  const hidden = c.classList.contains('hide');
  if (show && hidden) {
    c.classList.remove('hide'); c.classList.add('enter');
    requestAnimationFrame(() => requestAnimationFrame(() => c.classList.remove('enter')));
  } else if (show) {
    c.classList.remove('leaving');
  } else if (!hidden) {
    c.classList.add('leaving');
    c._t = setTimeout(() => { c.classList.add('hide'); c.classList.remove('leaving'); }, 220);
  }
}
function applyFilter() {
  // Mode server (listing.js menyediakan window.gridUpdate): filter/pencarian
  // dijalankan API dan kartu sudah dirender sesuai hasil → jangan ditimpa lagi.
  if (!onHome || window.gridUpdate) return;
  const cards = $$('#grid .card');
  const term = q.value.trim().toLowerCase();
  let shown = 0;
  cards.forEach(c => {
    const okCat = filter === 'all' || c.dataset.cat.split(' ').includes(filter);
    const okTerm = !term || (c.dataset.name || '').includes(term) || c.dataset.cat.includes(term);
    const ok = okCat && okTerm;
    setCard(c, ok);
    if (ok) shown++;
  });
  if (empty) {
    empty.hidden = shown > 0;
    empty.textContent = term ? `Tidak ada produk untuk "${q.value.trim()}".` : 'Belum ada produk di kategori ini.';
  }
  const cnt = $('#count'); if (cnt) cnt.textContent = `Menampilkan ${shown} produk`;
}
tabs.forEach(tab => tab.addEventListener('click', () => {
  tabs.forEach(t => { t.classList.remove('active'); t.setAttribute('aria-pressed', 'false'); });
  tab.classList.add('active'); tab.setAttribute('aria-pressed', 'true');
  filter = tab.dataset.filter;
  if (window.gridUpdate) { window.gridUpdate({ kategori: filter === 'all' ? '' : filter }); return; }
  applyFilter();
  if ($('#count')) { try { history.replaceState(null, '', filter === 'all' ? location.pathname : '#kategori=' + filter); } catch (e) {} }
}));

// Search bar (di semua halaman; Enter membawa ke daftar produk dengan hasil pencarian)
const bar = $('#searchbar'), sbtn = $('#searchBtn');
let qTimer;
function setSearch(open) {
  bar.hidden = !open; sbtn.setAttribute('aria-expanded', open);
  if (open) { q.focus(); }
  else {
    q.value = ''; clearTimeout(qTimer);
    if (window.gridUpdate) window.gridUpdate({ q: '' }); else applyFilter();
  }
}
sbtn.addEventListener('click', () => setSearch(bar.hidden));
q.addEventListener('input', () => {
  if (onHome && q.value) { const sec = $('#products'); if (sec) sec.scrollIntoView({ behavior: 'smooth' }); }
  if (window.gridUpdate) {
    // Pencarian lewat API (ikut paginasi) — debounce supaya tidak fetch tiap ketikan
    clearTimeout(qTimer);
    qTimer = setTimeout(() => window.gridUpdate({ q: q.value.trim() }), 250);
    return;
  }
  applyFilter();
});
q.addEventListener('keydown', e => {
  if (e.key === 'Escape') { setSearch(false); sbtn.focus(); return; }
  if (e.key !== 'Enter') return;
  const term = q.value.trim();
  if (!term) return;
  if (window.gridUpdate) { clearTimeout(qTimer); window.gridUpdate({ q: term }); }
  else if (!onHome) location.href = baseUrl + 'produk?q=' + encodeURIComponent(term);
});
window.whenProducts(() => {
  const urlQ = new URLSearchParams(location.search).get('q') || hparams().get('q');
  if (onHome && urlQ) { setSearch(true); q.value = urlQ; applyFilter(); setTimeout(() => $('#products').scrollIntoView(), 50); }
});

// Klik kartu produk -> halaman detail
document.addEventListener('click', e => {
  const c = e.target.closest('.card');
  if (c && !e.target.closest('a')) { const a = c.querySelector('a.circle'); if (a) location.href = a.href; }
});

// Keranjang (disimpan di browser via localStorage)
const badge = $('#cartCount'), cdlg = $('#cartDialog'), list = $('#cartList');
let cart = [];
const save = () => { try { localStorage.setItem('ystore-cart', JSON.stringify(cart)); } catch (e) {} };
const el = (tag, cls, txt) => { const n = document.createElement(tag); if (cls) n.className = cls; if (txt != null) n.textContent = txt; return n; };
const same = (i, id, color) => i.id === id && (i.color || '') === (color || '');
function iconBtn(icon, fb, label, fn) {
  const b = el('button', 'qbtn'); b.type = 'button'; b.setAttribute('aria-label', label);
  const i = el('i', 'bi bi-' + icon); i.dataset.fb = fb; b.append(i); b.addEventListener('click', fn); return b;
}
// Data produk baris keranjang: prioritaskan window.PRODUCTS; kalau tidak ada
// (grid kini hanya memuat satu halaman produk — pagination), pakai snapshot
// yang disimpan saat produk ditambahkan. Keranjang jadi tidak bergantung pada
// halaman yang sedang aktif.
const cartP = item => getP(item.id) || (item.name ? { id: item.id, name: item.name, price: Number(item.price) || 0, thumbs: [item.img || ''] } : null);
function renderCart() {
  const qty = cart.reduce((s, i) => s + i.qty, 0), total = cart.reduce((s, i) => { const p = cartP(i); return s + i.qty * (p ? p.price : 0); }, 0);
  badge.hidden = qty === 0; badge.textContent = qty;
  $('#cartQty').textContent = `(${qty})`; $('#cartTotal').textContent = money(total);
  $('#cartEmpty').hidden = qty > 0; $('#cartFoot').hidden = qty === 0; list.hidden = qty === 0;
  list.replaceChildren(...cart.map(item => {
    const p = cartP(item), label = p.name + (item.color ? ' · ' + item.color : '');
    const li = el('li', 'cart-item');
    const link = el('a'); link.href = baseUrl + 'produk/' + encodeURIComponent(p.id);
    const img = el('img'); img.src = p.thumbs[0]; img.alt = p.name; img.width = 72; img.height = 72; link.append(img);
    const info = el('div', 'cart-info');
    info.append(el('strong', '', label), el('span', 'cart-price', money(p.price)));
    const qb = el('div', 'qty');
    qb.append(iconBtn('dash-lg', '−', `Kurangi ${label}`, () => changeQty(item, -1)), el('b', '', item.qty), iconBtn('plus-lg', '+', `Tambah ${label}`, () => changeQty(item, 1)));
    info.append(qb);
    const side = el('div', 'cart-side');
    side.append(iconBtn('trash', '🗑', `Hapus ${label}`, () => { cart = cart.filter(i => i !== item); save(); renderCart(); }), el('strong', '', money(item.qty * p.price)));
    li.append(link, info, side); return li;
  }));
}
function changeQty(item, d) {
  item.qty += d; if (item.qty <= 0) cart = cart.filter(i => i !== item);
  save(); renderCart();
}
function initCart() {
  try { cart = (JSON.parse(localStorage.getItem('ystore-cart')) || []).filter(i => i.id && (getP(i.id) || i.name)); } catch (e) {}
  renderCart();
}
window.whenProducts(initCart);
window.addToCart = (id, color, qty = 1, srcEl) => {
  const p = getP(id);
  if (!p) return;
  const it = cart.find(i => same(i, id, color));
  if (it) it.qty += qty;
  else cart.push({ id, color: color || '', qty, name: p.name, price: p.price, img: (p.thumbs && p.thumbs[0]) || p.img || '' });
  save(); renderCart();
  toast(`${p.name} ditambahkan ke keranjang`);
  const popBadge = () => { badge.classList.remove('pop'); void badge.offsetWidth; badge.classList.add('pop'); };
  // Animasi thumbnail bulat terbang dari tombol ke ikon cart di navbar
  const from = srcEl && srcEl.getBoundingClientRect(), to = $('#cartBtn').getBoundingClientRect();
  const dot = document.createElement('img');
  dot.className = 'fly-dot'; dot.alt = ''; dot.src = (p.thumbs && p.thumbs[0]) || p.img || '';
  if (!reduce && from && to && dot.animate) {
    const s = 48;
    const sx = from.left + from.width / 2 - s / 2, sy = from.top + from.height / 2 - s / 2;
    const dx = to.left + to.width / 2 - s / 2 - sx, dy = to.top + to.height / 2 - s / 2 - sy;
    dot.style.left = sx + 'px'; dot.style.top = sy + 'px';
    document.body.appendChild(dot);
    dot.animate([
      { transform: 'translate(0,0) scale(1)', opacity: 1 },
      { transform: `translate(${dx * .5}px, ${dy * .5 - 90}px) scale(.55)`, offset: .55 },
      { transform: `translate(${dx}px, ${dy}px) scale(.12)`, opacity: .3 }
    ], { duration: 650, easing: 'cubic-bezier(.4,.1,.3,1)' }).onfinish = () => { dot.remove(); popBadge(); };
  } else popBadge();
};
$('#cartBtn').addEventListener('click', () => cdlg.showModal());
$('#cartClose').addEventListener('click', () => cdlg.close());
$('#cartShop').addEventListener('click', () => cdlg.close());
$('#cartClear').addEventListener('click', () => { cart = []; save(); renderCart(); });
$('#cartCheckout').addEventListener('click', () => {
  cdlg.close();
  if (cart.length === 0) return;
  if (!window.ystore) { toast('Checkout belum tersedia di versi demo'); return; }
  const wa = window.ystore.whatsapp || '';
  if (!wa) { toast('Nomor WhatsApp toko belum diatur.'); return; }
  const storeName = window.ystore.name || 'yStore';
  const lines = cart.map((item, n) => {
    const p = cartP(item);
    return (n + 1) + '. ' + p.name + (item.color ? ' · ' + item.color : '') + ' x' + item.qty + ' = ' + money(p.price * item.qty);
  });
  const total = cart.reduce((s, i) => { const p = cartP(i); return s + i.qty * (p ? p.price : 0); }, 0);
  const message = 'Halo ' + storeName + ', saya ingin memesan:\n\n' + lines.join('\n') + '\n\nTotal: ' + money(total) + '\n\nTerima kasih.';
  location.href = 'https://wa.me/' + wa + '?text=' + encodeURIComponent(message);
});
cdlg.addEventListener('click', e => { if (e.target === cdlg) cdlg.close(); });

// Accordion (satu terbuka sekaligus; delegasi agar accordion hasil render ulang tetap jalan)
function setItem(item, open) {
  item.classList.toggle('open', open);
  const i = item.querySelector('i');
  i.className = 'bi ' + (open ? 'bi-x-lg' : 'bi-plus-lg'); i.dataset.fb = open ? '×' : '+';
  item.querySelector('.acc-head').setAttribute('aria-expanded', open);
}
document.addEventListener('click', e => {
  const head = e.target.closest('.acc-head');
  if (!head) return;
  const item = head.closest('.acc-item');
  const willOpen = !item.classList.contains('open');
  $$('.acc-item').forEach(i => setItem(i, false));
  if (willOpen) setItem(item, true);
});

// Dialog video (beranda)
const dlg = $('#videoDialog');
if (dlg) {
  $('#playBtn').addEventListener('click', () => dlg.showModal());
  $('#vclose').addEventListener('click', () => dlg.close());
  dlg.addEventListener('click', e => { if (e.target === dlg) dlg.close(); });
}

// Animasi saat scroll: fade-in bertahap + hitung angka statistik
const reduce = matchMedia('(prefers-reduced-motion: reduce)').matches;
$$('.card[data-reveal]').forEach((c, i) => c.style.setProperty('--d', (i % 3) * 0.09 + 's'));
$$('.stats [data-reveal]').forEach((s, i) => s.style.setProperty('--d', i * 0.12 + 's'));
const wt = $('.why-text'); if (wt) wt.style.setProperty('--d', '0.12s');

function countUp(node) {
  const end = parseInt(node.dataset.count, 10), tail = node.textContent.replace(/^\d+/, '');
  if (reduce) return;
  const t0 = performance.now(), dur = 1400;
  (function tick(now) {
    const p = Math.min((now - t0) / dur, 1), e = 1 - Math.pow(1 - p, 3);
    node.textContent = Math.round(end * e) + tail;
    if (p < 1) requestAnimationFrame(tick);
  })(t0);
}
const io = new IntersectionObserver(entries => entries.forEach(en => {
  if (!en.isIntersecting) return;
  en.target.classList.add('in');
  const n = en.target.querySelector('[data-count]'); if (n) countUp(n);
  io.unobserve(en.target);
}), { threshold: 0.15 });
function scanReveals() {
  $$('[data-reveal]').forEach(node => { if (!node.classList.contains('in')) io.observe(node); });
}
scanReveals();
addEventListener('hashchange', scanReveals);
