(function () {
  const baseUrl = (window.ystore && window.ystore.baseUrl) || '';
  const icon = (n, fb) => `<i class="bi bi-${n}" data-fb="${fb}"></i>`;
  const esc = s => String(s == null ? '' : s).replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c]));

  // Merender kartu produk ke #grid (beranda & daftar produk).
  // Data datang dari API (products.js → window.fetchProducts) dengan pagination
  // server: beranda maksimum perPage (6) tanpa pager, /produk perPage (9) + pager.
  const grid = document.getElementById('grid');
  if (!grid) return;

  // --- Konfigurasi grid & state halaman -----------------------------------
  // window.ystore.grid diset controller (Welcome = beranda, Products = /produk).
  // Tanpa konfigurasi (file demo statis) → tampil semua, tanpa pager & URL.
  const cfg = (window.ystore && window.ystore.grid) || null;
  const paged = !!(cfg && cfg.paged);
  const perPage = cfg ? (Number(cfg.perPage) || 0) : 0; // 0 = tanpa batas
  const listUrl = (cfg && cfg.listUrl) || (baseUrl + 'produk');
  const URUTS = ['featured', 'price-asc', 'price-desc', 'name'];

  const readUrl = () => {
    const sp = new URLSearchParams(location.search);
    const hp = new URLSearchParams(location.hash.replace(/^#\/?/, ''));
    const get = k => sp.get(k) || hp.get(k) || '';
    return { kategori: get('kategori') || get('cat') || '', q: get('q') || '', urut: get('urut') || '' };
  };
  const pageFromPath = () => {
    const m = location.pathname.match(/\/page\/(\d+)/);
    return m ? parseInt(m[1], 10) : 1;
  };

  // Link lama memakai hash (#kategori=… / #q=…): pindahkan ke query string di
  // /produk supaya server ikut melihat filter (hitungan & clamp halaman akurat).
  if (paged && location.hash) {
    const hp = new URLSearchParams(location.hash.replace(/^#\/?/, ''));
    const sp = new URLSearchParams(location.search);
    let moved = false;
    [['cat', 'kategori'], ['kategori', 'kategori'], ['q', 'q'], ['urut', 'urut']].forEach(pair => {
      const v = hp.get(pair[0]);
      if (v && !sp.get(pair[1])) { sp.set(pair[1], v); moved = true; }
    });
    if (moved) {
      const qs = sp.toString();
      try { history.replaceState(null, '', location.pathname + (qs ? '?' + qs : '')); } catch (e) {}
    }
  }

  const state = { kategori: '', q: '', urut: '', page: 1 };
  Object.assign(state, readUrl());
  if (URUTS.indexOf(state.urut) === -1) state.urut = '';
  // pageNumber dari server sudah di-clamp; path jadi cadangan bila tidak ada
  state.page = paged ? (Number(cfg.page) || pageFromPath() || 1) : 1;
  let interacted = false; // user sudah berinteraksi sebelum fetch awal selesai

  // --- Parameter API & penulisan URL --------------------------------------
  const params = () => {
    const p = new URLSearchParams();
    if (perPage > 0) p.set('per_page', String(perPage));
    if (paged) p.set('page', String(state.page));
    if (state.kategori) p.set('kategori', state.kategori);
    if (state.q) p.set('q', state.q);
    if (state.urut) p.set('urut', state.urut);
    return p;
  };
  // Perbandingan parameter tanpa peduli urutan (untuk deteksi fetch ulang)
  const canon = p => [...(p || new URLSearchParams()).entries()].sort().map(e => e[0] + '=' + e[1]).join('&');

  const filterQs = () => {
    const qs = new URLSearchParams();
    if (state.kategori) qs.set('kategori', state.kategori);
    if (state.q) qs.set('q', state.q);
    if (state.urut) qs.set('urut', state.urut);
    return qs.toString();
  };
  const pageUrl = n => listUrl + '/page/' + n + (filterQs() ? '?' + filterQs() : '');

  const syncUrl = mode => {
    if (!cfg || !paged) return; // beranda & demo: URL tidak ditulis (seperti sebelumnya)
    const qs = filterQs();
    const url = listUrl + (state.page > 1 ? '/page/' + state.page : '') + (qs ? '?' + qs : '');
    try { history[mode === 'push' ? 'pushState' : 'replaceState'](null, '', url); } catch (e) {}
  };

  // --- Render --------------------------------------------------------------
  const cardHTML = (x, i) => `
      <article class="card" data-reveal data-cat="${esc(x.cat)}" data-price="${x.price}" data-name="${esc(x.name).toLowerCase()}" data-order="${i}">
        <img src="${x.img}" alt="${esc(x.name)}" width="700" height="560"${i > 2 ? ' loading="lazy"' : ''}>
        <div class="row"><span>${esc(x.name)}</span><strong>${money(x.price)}</strong></div>
        ${x.stock === 0 ? '<span class="soldout">Stok habis</span>' : ''}
        <div class="notch br"><a class="circle" href="${baseUrl}produk/${encodeURIComponent(x.id)}" aria-label="Lihat ${esc(x.name)}">${icon('arrow-up-right', '↗')}</a></div>
      </article>`;

  // Sinkronkan kontrol atas hasil render: tab kategori, urutan, tombol "lihat
  // semua" (beranda) ikut membawa kategori yang sedang aktif.
  const syncControls = () => {
    const tabs = document.querySelectorAll('#tabs button');
    if (tabs.length) {
      const want = state.kategori || 'all';
      tabs.forEach(t => {
        const on = t.dataset.filter === want;
        t.classList.toggle('active', on);
        t.setAttribute('aria-pressed', on ? 'true' : 'false');
      });
    }
    const sortSel = document.getElementById('sort');
    if (sortSel) sortSel.value = state.urut || 'featured';
    const allBtn = document.querySelector('#products .all-btn');
    if (allBtn && cfg) allBtn.href = listUrl + (state.kategori ? '?kategori=' + encodeURIComponent(state.kategori) : '');
  };

  const renderPager = (pages, page) => {
    const old = document.getElementById('pager');
    if (!paged || pages <= 1) { if (old) old.remove(); return; }

    let host = old;
    if (!host) {
      host = document.createElement('nav');
      host.id = 'pager';
      host.className = 'pager';
      host.setAttribute('aria-label', 'Halaman produk');
      const emptyEl = document.getElementById('empty');
      if (emptyEl && emptyEl.parentNode) emptyEl.parentNode.insertBefore(host, emptyEl.nextSibling);
      else grid.parentNode.appendChild(host);

      // Link pager berupa <a href> asli (bisa dibuka tab baru); klik biasa
      // ditangkap di sini supaya cukup fetch satu halaman, tanpa reload penuh.
      host.addEventListener('click', e => {
        const a = e.target.closest('a[data-page]');
        if (!a) return;
        e.preventDefault();
        const n = parseInt(a.dataset.page, 10);
        if (!n || n === state.page) return;
        interacted = true;
        state.page = n;
        syncUrl('push');
        load().then(() => {
          const sec = document.getElementById('products');
          if (sec) sec.scrollIntoView();
        });
      });
    }

    // Jendela nomor halaman: awal, akhir, dan ±1 dari halaman aktif
    const numbers = [];
    for (let n = 1; n <= pages; n++) {
      if (n <= 2 || n > pages - 2 || Math.abs(n - page) <= 1) numbers.push(n);
      else if (numbers[numbers.length - 1] !== '…') numbers.push('…');
    }
    const num = n => n === '…'
      ? '<span class="pnum gap" aria-hidden="true">…</span>'
      : (n === page
        ? `<span class="pnum on" aria-current="page">${n}</span>`
        : `<a class="pnum" data-page="${n}" href="${pageUrl(n)}" aria-label="Halaman ${n}">${n}</a>`);
    const step = (n, label, aria) => (n < 1 || n > pages || n === page)
      ? `<span class="pnum off" aria-hidden="true">${label}</span>`
      : `<a class="pnum" data-page="${n}" href="${pageUrl(n)}" aria-label="${aria}">${label}</a>`;

    host.innerHTML =
      step(page > 1 ? 1 : 0, '&laquo;', 'Halaman pertama') +
      step(page - 1, '&lsaquo;', 'Halaman sebelumnya') +
      numbers.map(num).join('') +
      step(page + 1, '&rsaquo;', 'Halaman berikutnya') +
      step(page < pages ? pages : 0, '&raquo;', 'Halaman terakhir');
  };

  const render = (list, meta) => {
    const total = (meta && typeof meta.total === 'number') ? meta.total : list.length;
    const page = (meta && meta.page) || state.page;
    const per = (meta && meta.per_page) || perPage;
    const pages = (meta && meta.total_pages) || (per > 0 ? Math.max(1, Math.ceil(total / per)) : 1);

    // API bisa meng-clamp halaman (mis. link lama berbasis hash yang tidak
    // terlihat server) → samakan state & URL dengan hasilnya.
    if (paged && page !== state.page) { state.page = page; syncUrl('replace'); }

    grid.innerHTML = list.map(cardHTML).join('');
    grid.querySelectorAll('.card').forEach((c, i) => c.style.setProperty('--d', (i % 3) * 0.09 + 's'));

    syncControls();

    const count = document.getElementById('count');
    if (count) {
      count.textContent = (paged && per > 0 && total > 0)
        ? `Menampilkan ${((page - 1) * per) + 1}–${Math.min(total, page * per)} dari ${total} produk`
        : `Menampilkan ${list.length} produk`;
    }

    const empty = document.getElementById('empty');
    if (empty) {
      empty.hidden = list.length > 0;
      empty.textContent = state.q ? `Tidak ada produk untuk "${state.q}".` : 'Belum ada produk di kategori ini.';
    }

    renderPager(pages, page);
    if (window.scanReveals) window.scanReveals();
  };

  // --- Muat data (fetch per halaman/filter) --------------------------------
  let seq = 0; // penanda urutan request: respons basi dibuang
  const load = () => {
    const my = ++seq;
    grid.classList.add('is-loading');
    return window.fetchProducts(params()).then(res => {
      if (my !== seq) return;
      grid.classList.remove('is-loading');
      render(res.list, res.meta);
    }, () => {
      if (my === seq) grid.classList.remove('is-loading');
    });
  };

  // --- Interaksi (dipanggil script.js untuk tab & pencarian) ---------------
  window.gridUpdate = patch => {
    let changed = false;
    ['kategori', 'q', 'urut'].forEach(k => {
      if (patch && Object.prototype.hasOwnProperty.call(patch, k)) {
        const v = patch[k] == null ? '' : String(patch[k]);
        if (state[k] !== v) { state[k] = v; changed = true; }
      }
    });
    if (patch && patch.page != null) {
      const n = Math.max(1, parseInt(patch.page, 10) || 1);
      if (state.page !== n) { state.page = n; changed = true; }
    } else if (changed) {
      state.page = 1; // ganti filter → kembali ke halaman pertama
    }
    if (!changed) return Promise.resolve(); // tidak ada perubahan → jangan fetch

    interacted = true;
    // Ganti halaman / pindah kategori → pushState (bisa back);
    // ketikan pencarian & pengurutan → replaceState (history tidak sampah)
    const push = (patch && (patch.page != null || Object.prototype.hasOwnProperty.call(patch, 'kategori')));
    syncUrl(push ? 'push' : 'replace');
    return load();
  };

  const sortSel = document.getElementById('sort');
  if (sortSel) sortSel.addEventListener('change', () => window.gridUpdate({ urut: sortSel.value }));

  // Navigasi back/forward: baca state dari URL lalu muat ulang
  if (paged) {
    addEventListener('popstate', () => {
      interacted = true;
      Object.assign(state, readUrl());
      if (URUTS.indexOf(state.urut) === -1) state.urut = '';
      state.page = pageFromPath();
      load();
    });
  }

  // Render pertama: pakai hasil fetch awal products.js bila parameternya sama
  // persis; kalau tidak (mis. URL punya filter yang belum diambil), fetch ulang.
  window.whenProducts(() => {
    if (interacted) return;
    if (window._fetchedParams && canon(params()) === canon(window._fetchedParams)) {
      render(window.PRODUCTS, window.PRODUCTS_META);
    } else {
      load();
    }
  });
})();
