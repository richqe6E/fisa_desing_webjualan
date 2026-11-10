(function () {
  const baseUrl = (window.ystore && window.ystore.baseUrl) || '';
  const root = document.getElementById('pd');
  const icon = (n, fb) => `<i class="bi bi-${n}" data-fb="${fb}"></i>`;
  const esc = s => String(s == null ? '' : s).replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));
  const nl2br = s => esc(s).replace(/\n/g, '<br>');

  // ID produk dari hash URL (#easy-drawer), fallback query (?id=), lalu path (/produk/<slug>)
  function getId() {
    const h = location.hash.replace(/^#\/?/, '');
    if (h && !h.includes('=')) return h;
    const q = new URLSearchParams(location.search).get('id');
    if (q) return q;
    const seg = location.pathname.split('/').filter(Boolean);
    return seg.length ? seg[seg.length - 1] : null;
  }

  function render() {
    if (!root) return;
    const p = PRODUCTS.find(x => x.id === getId());

    if (!p) {
      document.title = 'Produk tidak ditemukan';
      document.getElementById('crumbName').textContent = 'Tidak ditemukan';
      document.getElementById('relatedSec').hidden = true;
      root.className = 'pd-missing';
      root.innerHTML = '<h1>Produk tidak ditemukan</h1><p>Produk yang Anda cari tidak ada atau sudah dihapus.</p><a href="' + baseUrl + 'produk" class="btn-dark">Lihat produk <span class="arrow">' + icon('arrow-up-right', '↗') + '</span></a>';
      return;
    }

    document.title = p.name + ' · ' + ((window.ystore && window.ystore.name) || '');
    document.getElementById('crumbName').textContent = p.name;
    document.getElementById('relatedSec').hidden = false;
    root.className = 'pd-grid';

    const colors = Array.isArray(p.colors) ? p.colors : [];
    const specs = Array.isArray(p.specs) ? p.specs : [];
    const gallery = p.gallery || p.photos || [];
    const thumbs = p.thumbs || gallery;
    let color = colors.length ? colors[0][0] : '';
    let qty = 1;
    const inStock = p.stock === undefined || p.stock === null || p.stock > 0;

    const rating = (p.rating && p.reviews) ? (
      '<div class="pd-rating"><span class="stars">'
      + Array.from({ length: Math.round(p.rating) }, () => `<i class="bi bi-star-fill" data-fb="★"></i>`).join('')
      + Array.from({ length: 5 - Math.round(p.rating) }, () => `<i class="bi bi-star-fill off" data-fb="★"></i>`).join('')
      + '</span><span>' + Number(p.rating).toFixed(1) + ' · ' + p.reviews + ' ulasan</span></div>'
    ) : '';

    const acc = (n, title, open, body) => `
      <div class="acc-item${open ? ' open' : ''}">
        <button class="acc-head" id="pa${n}" aria-expanded="${open}" aria-controls="pb${n}"><span>${title}</span>${icon(open ? 'x-lg' : 'plus-lg', open ? '×' : '+')}</button>
        <div class="acc-body" id="pb${n}" role="region" aria-labelledby="pa${n}">${body}</div>
      </div>`;
    const specsHtml = specs.length
      ? '<div><dl class="specs">' + specs.map(s => `<dt>${esc(s[0])}</dt><dd>${esc(s[1])}</dd>`).join('') + '</dl></div>'
      : '<div><p>Detail produk belum tersedia.</p></div>';
    const colorSection = colors.length ? `
      <div class="pd-opt">
        <span class="pd-label">Warna: <b id="colorName">${esc(color)}</b></span>
        <div class="swatches" role="radiogroup" aria-label="Warna">
          ${colors.map((c, i) => `<button class="sw${i ? '' : ' active'}" role="radio" aria-checked="${i === 0}" aria-label="${esc(c[0])}" data-name="${esc(c[0])}" style="--c:${esc(c[1])}"></button>`).join('')}
        </div>
      </div>` : '';

    root.innerHTML = `
      <div class="pd-media" data-reveal>
        <div class="pd-main">
          <img id="mainImg" src="${gallery[0]}" alt="${esc(p.name)}" width="1100" height="900">
          <div class="notch br"><button class="circle wish" id="wish" aria-label="Tambah ke wishlist" aria-pressed="false">${icon('heart', '♡')}</button></div>
        </div>
        <div class="pd-thumbs">
          ${thumbs.map((t, i) => `<button class="pd-thumb${i ? '' : ' active'}" data-i="${i}" aria-label="Tampilkan foto ${i + 1}"><img src="${t}" alt="" width="220" height="180" loading="lazy"></button>`).join('')}
        </div>
      </div>
      <div class="pd-info" data-reveal>
        <h1>${esc(p.name)}</h1>
        ${rating}
        <p class="pd-price">${money(p.price)}</p>
        <p class="pd-stock${inStock ? '' : ' habis'}">${inStock ? 'Stok: ' + p.stock : 'Stok habis'}</p>
        ${p.desc ? `<p class="pd-desc">${nl2br(p.desc)}</p>` : ''}
        ${colorSection}
        <div class="pd-buy">
          <div class="qtybox" aria-label="Jumlah">
            <button class="qbtn" id="qMinus" aria-label="Kurangi jumlah">${icon('dash-lg', '−')}</button>
            <b id="qVal" aria-live="polite">1</b>
            <button class="qbtn" id="qPlus" aria-label="Tambah jumlah">${icon('plus-lg', '+')}</button>
          </div>
          <button class="btn-dark" id="addBtn"${inStock ? '' : ' disabled'}>${inStock ? 'Tambah ke Keranjang <span class="arrow">' + icon('arrow-up-right', '↗') + '</span>' : 'Stok Habis'}</button>
        </div>
        <div class="acc">
          ${acc(1, 'Detail produk', true, specsHtml)}
          ${acc(2, 'Perawatan', false, '<div><p>Cuci sesuai petunjuk pada label. Simpan di tempat kering dan terhindar dari sinar matahari langsung.</p></div>')}
          ${acc(3, 'Pengiriman &amp; pengembalian', false, '<div><p>Hubungi kami via WhatsApp untuk biaya dan estimasi pengiriman. Barang dapat dikembalikan dalam 7 hari bila cacat atau tidak sesuai.</p></div>')}
        </div>
      </div>`;

    // Galeri
    const main = document.getElementById('mainImg');
    document.querySelectorAll('.pd-thumb').forEach(b => b.addEventListener('click', () => {
      document.querySelectorAll('.pd-thumb').forEach(x => x.classList.remove('active'));
      b.classList.add('active'); main.src = thumbs[+b.dataset.i];
    }));
    // Warna
    if (colors.length) {
      document.querySelectorAll('.sw').forEach(b => b.addEventListener('click', () => {
        document.querySelectorAll('.sw').forEach(x => { x.classList.remove('active'); x.setAttribute('aria-checked', 'false'); });
        b.classList.add('active'); b.setAttribute('aria-checked', 'true');
        color = b.dataset.name; document.getElementById('colorName').textContent = color;
      }));
    }
    // Jumlah + keranjang
    const qVal = document.getElementById('qVal');
    const setQty = n => { qty = Math.min(10, Math.max(1, n)); qVal.textContent = qty; };
    document.getElementById('qMinus').addEventListener('click', () => setQty(qty - 1));
    document.getElementById('qPlus').addEventListener('click', () => setQty(qty + 1));
    const addBtn = document.getElementById('addBtn');
    if (inStock) {
      addBtn.addEventListener('click', e => window.addToCart(p.id, color, qty, e.currentTarget));
    }
    // Wishlist
    const wish = document.getElementById('wish');
    wish.addEventListener('click', () => {
      const on = wish.getAttribute('aria-pressed') !== 'true';
      wish.setAttribute('aria-pressed', on);
      const i = wish.querySelector('i'); i.className = 'bi bi-' + (on ? 'heart-fill' : 'heart'); i.dataset.fb = on ? '♥' : '♡';
    });

    // Produk terkait (kategori sama dulu)
    const others = PRODUCTS.filter(x => x.id !== p.id);
    const cats = String(p.cat || '').split(' ');
    others.sort((a, b) => String(b.cat || '').split(' ').filter(c => cats.includes(c)).length - String(a.cat || '').split(' ').filter(c => cats.includes(c)).length);
    document.getElementById('related').innerHTML = others.slice(0, 3).map(x => `
      <article class="card" data-reveal data-cat="${esc(x.cat)}">
        <img src="${x.img}" alt="${esc(x.name)}" width="700" height="560" loading="lazy">
        <div class="row"><span>${esc(x.name)}</span><strong>${money(x.price)}</strong></div>
        ${x.stock === 0 ? '<span class="soldout">Stok habis</span>' : ''}
        <div class="notch br"><a class="circle" href="${baseUrl}produk/${encodeURIComponent(x.id)}" aria-label="Lihat ${esc(x.name)}">${icon('arrow-up-right', '↗')}</a></div>
      </article>`).join('');
    if (window.scanReveals) window.scanReveals();
  }

  window.whenProducts(() => {
    render();
    addEventListener('hashchange', render);
  });
})();
