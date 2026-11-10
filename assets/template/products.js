// Data produk demo — dipakai saat file HTML dibuka langsung (tanpa yStore).
// Pada halaman yStore, data diambil dari endpoint JSON (window.ystore.api).
const imgUrl = (id, w, h) => `https://images.unsplash.com/${id}?auto=format&fit=crop&w=${w}&h=${h}&q=75`;
const makeProduct = o => ({
  ...o,
  img: imgUrl(o.photos[0], 700, 560),
  gallery: o.photos.map(x => imgUrl(x, 1100, 900)),
  thumbs: o.photos.map(x => imgUrl(x, 220, 180))
});

const DEMO_PRODUCTS = [
  makeProduct({
    id: 'muffin-chair', name: 'Muffin Chair', price: 126, rating: 4.8, reviews: 132, cat: 'chair',
    photos: ['photo-1618219944342-824e40a13285', 'photo-1615873968403-89e068629265', 'photo-1724582586529-62622e50c0b3'],
    colors: [['Beige', '#c8a98d'], ['Brown', '#8a6b5a'], ['Grey', '#9a9a9a']],
    desc: 'A plush, rounded lounge chair with a soft boucle seat and solid oak legs. Made for cozy corners and long reading sessions.',
    specs: [['Material', 'Boucle fabric, oak legs'], ['Dimensions', 'W 68 x D 72 x H 84 cm'], ['Weight', '12 kg'], ['Assembly', 'Legs attach in 2 minutes']]
  }),
  makeProduct({
    id: 'elite-chair', name: 'Elite Chair', price: 150, rating: 4.9, reviews: 98, cat: 'chair',
    photos: ['photo-1615971677499-5467cbab01c0', 'photo-1618219944342-824e40a13285', 'photo-1615873968403-89e068629265'],
    colors: [['Cream', '#e3d5c3'], ['Black', '#2b2b2b'], ['Green', '#6f7d6a']],
    desc: 'A sculptural accent chair with a curved plywood shell and cushioned seat. A statement piece for modern living rooms.',
    specs: [['Material', 'Plywood shell, recycled cushion'], ['Dimensions', 'W 65 x D 70 x H 80 cm'], ['Weight', '10 kg'], ['Assembly', 'None']]
  }),
  makeProduct({
    id: 'easy-drawer', name: 'Easy Drawer', price: 66, rating: 4.5, reviews: 76, cat: 'cabinet',
    photos: ['photo-1581467695675-7e3753e5ab26', 'photo-1556908221-f685cdb3b0ea', 'photo-1552154083-7213635f4298'],
    colors: [['Oak', '#b98d5f'], ['White', '#e8e6e1'], ['Walnut', '#7a5230']],
    desc: 'A compact three-drawer cabinet on soft-close glides. Keeps your living room tidy without sacrificing style.',
    specs: [['Material', 'FSC-certified oak'], ['Dimensions', 'W 45 x D 40 x H 68 cm'], ['Weight', '18 kg'], ['Assembly', 'Simple, 10 minutes']]
  }),
  makeProduct({
    id: 'easy-sofa', name: 'Easy Sofa', price: 126, rating: 4.7, reviews: 210, cat: 'chair sofa',
    photos: ['photo-1615529182904-14819c35db37', 'photo-161613205093-3158f3a65fb5', 'photo-1724582586529-62622e50c0b3'],
    colors: [['Blue', '#7d9bbf'], ['Terracotta', '#c07b5e'], ['Sage', '#9caf94']],
    desc: 'A compact two-seater with deep seats and washable covers. Easy to move, easy to live with, built to last.',
    specs: [['Material', 'Recycled fabric, birch frame'], ['Dimensions', 'W 160 x D 85 x H 82 cm'], ['Weight', '34 kg'], ['Assembly', 'Legs only']]
  }),
  makeProduct({
    id: 'cabinet', name: 'Cabinet', price: 138, rating: 4.6, reviews: 64, cat: 'cabinet',
    photos: ['photo-1556908221-f685cdb3b0ea', 'photo-1581467695675-7e3753e5ab26', 'photo-1552154083-7213635f4298'],
    colors: [['Natural', '#c4a275'], ['Black', '#2b2b2b']],
    desc: 'A generous storage cabinet with adjustable shelves and a matte finish. Made from responsibly sourced timber.',
    specs: [['Material', 'Oak veneer, birch carcass'], ['Dimensions', 'W 90 x D 42 x H 78 cm'], ['Weight', '26 kg'], ['Assembly', 'Moderate, 20 minutes']]
  }),
  makeProduct({
    id: 'rumpi-chair', name: 'Rumpi Chair', price: 100, rating: 4.4, reviews: 58, cat: 'chair',
    photos: ['photo-1618219944342-824e40a13285', 'photo-1615873968403-89e068629265', 'photo-1615971677499-5467cbab01c0'],
    colors: [['Blush', '#d8b4a0'], ['Charcoal', '#4a4a4a']],
    desc: 'A lightweight dining chair with a warm wooden frame and contoured seat. Stacks up to four high.',
    specs: [['Material', 'Beech, padded seat'], ['Dimensions', 'W 46 x D 52 x H 82 cm'], ['Weight', '7 kg'], ['Assembly', 'None']]
  }),
  makeProduct({
    id: 'romp-stool', name: 'Romp Stool', price: 86, rating: 4.3, reviews: 41, cat: 'bed sofa',
    photos: ['photo-1615971677499-5467cbab01c0', 'photo-1615529182904-14819c35db37', 'photo-1724582586529-62622e50c0b3'],
    colors: [['Mustard', '#d9a441'], ['Grey', '#8f8f8f']],
    desc: 'A sturdy stool that works as extra seating, a footrest, or a bedside perch. Finished with natural oil.',
    specs: [['Material', 'Solid ash'], ['Dimensions', 'W 38 x D 38 x H 45 cm'], ['Weight', '4 kg'], ['Assembly', 'None']]
  }),
  makeProduct({
    id: 'almirah', name: 'Almirah', price: 222, rating: 4.9, reviews: 187, cat: 'cabinet bed',
    photos: ['photo-1552154083-7213635f4298', 'photo-1556908221-f685cdb3b0ea', 'photo-1581467695675-7e3753e5ab26'],
    colors: [['Walnut', '#6f4a2c'], ['White', '#eceae4']],
    desc: 'A tall wardrobe with hanging rail, drawers and adjustable shelving. A calm, clutter-free storage piece for any bedroom.',
    specs: [['Material', 'Walnut, birch interior'], ['Dimensions', 'W 110 x D 55 x H 190 cm'], ['Weight', '52 kg'], ['Assembly', 'Two-person, 30 minutes']]
  })
];

// Bentuk data seragam: foto dari API sudah berupa URL,
// data demo perlu penurunan ukuran via imgUrl().
const derive = o => ({ ...o, img: o.photos[0], gallery: o.photos, thumbs: o.photos });

window.PRODUCTS = [];
window.PRODUCTS_META = null;
window.money = n => 'Rp ' + Math.round(Number(n) || 0).toLocaleString('id-ID');

const readyCbs = [];
window.whenProducts = fn => { if (window._productsReady) { fn(); } else { readyCbs.push(fn); } };

function setProducts(list, meta) {
  window.PRODUCTS = (list || []).map(p => (p.img && p.gallery && p.thumbs) ? p : derive(p));
  // meta (total/halaman) dari API untuk pagination; fallback untuk data lokal.
  window.PRODUCTS_META = meta || { total: window.PRODUCTS.length, page: 1, per_page: 0, total_pages: 1 };
  window._productsReady = true;
  readyCbs.forEach(fn => fn());
}

// Parameter fetch awal: konfigurasi grid (window.ystore.grid) + filter di URL
// (query string dulu, lalu hash lama #kategori=/#q=). Tanpa grid → kosong,
// mis. halaman detail yang membutuhkan seluruh produk (produk terkait + keranjang).
window.gridParams = () => {
  const p = new URLSearchParams();
  const g = window.ystore && window.ystore.grid;
  if (!g) return p;
  const perPage = Number(g.perPage) || 0;
  if (perPage > 0) p.set('per_page', String(perPage));
  if (g.paged) p.set('page', String(Number(g.page) || 1));
  const sp = new URLSearchParams(location.search);
  const hp = new URLSearchParams(location.hash.replace(/^#\/?/, ''));
  ['kategori', 'q', 'urut'].forEach(k => { const v = sp.get(k) || hp.get(k); if (v) p.set(k, v); });
  return p;
};

// Versi lokal (file demo statis tanpa yStore, atau API gagal): filter, urut,
// dan batasi di memori — bentuk meta-nya sama seperti respons API.
window.demoProducts = p => {
  const cat = p.get('kategori') || '';
  const term = (p.get('q') || '').trim().toLowerCase();
  const urut = p.get('urut') || 'featured';
  let list = DEMO_PRODUCTS.filter(x =>
    (!cat || x.cat.split(' ').includes(cat)) &&
    (!term || x.name.toLowerCase().includes(term) || x.cat.includes(term)));
  const sorters = {
    'price-asc': (a, b) => a.price - b.price,
    'price-desc': (a, b) => b.price - a.price,
    name: (a, b) => a.name.localeCompare(b.name)
  };
  if (sorters[urut]) list = list.slice().sort(sorters[urut]);
  const perPage = Math.max(0, parseInt(p.get('per_page'), 10) || 0);
  const total = list.length;
  const totalPages = perPage > 0 ? Math.max(1, Math.ceil(total / perPage)) : 1;
  const page = Math.min(Math.max(1, parseInt(p.get('page'), 10) || 1), totalPages);
  const sliced = perPage > 0 ? list.slice((page - 1) * perPage, page * perPage) : list;
  // derive() juga di sini: konsumen (listing.js) selalu dapat bentuk siap render
  return Promise.resolve({ list: sliced.map(derive), meta: { total, page, per_page: perPage, total_pages: totalPages } });
};

// Ambil daftar produk: live memakai endpoint JSON (window.ystore.api),
// demo/fallback memakai data lokal. Mengembalikan Promise { list, meta }.
window.fetchProducts = params => {
  const p = params instanceof URLSearchParams ? params : new URLSearchParams(params || {});
  const qs = p.toString();
  if (!(window.ystore && window.ystore.api)) return window.demoProducts(p);
  return fetch(window.ystore.api + (qs ? '?' + qs : ''), { headers: { Accept: 'application/json' } })
    .then(r => { if (!r.ok) { throw new Error('HTTP ' + r.status); } return r.json(); })
    .then(d => ({ list: (d.products || []).map(derive), meta: d.meta || null }))
    .catch(() => window.demoProducts(p));
};

if (window.ystore && window.ystore.api) {
  const detail = window.ystore.detail;
  if (detail && detail.api) {
    // Halaman detail: hanya ambil satu produk + produk terkait (bukan seluruh
    // katalog). Bentuk respons { product, related }.
    window._fetchedParams = new URLSearchParams();
    fetch(detail.api, { headers: { Accept: 'application/json' } })
      .then(r => { if (!r.ok) { throw new Error('HTTP ' + r.status); } return r.json(); })
      .then(d => {
        const list = (d.product ? [d.product] : []).concat(d.related || []);
        setProducts(list, null);
      })
      .catch(() => setProducts([], null));
  } else if (window.ystore.grid) {
    const initParams = window.gridParams();
    // Catat parameter fetch awal — listing.js memakainya untuk merender langsung
    // tanpa mengulang request bila state halaman sama persis.
    window._fetchedParams = initParams;
    fetchProducts(initParams)
      .then(({ list, meta }) => setProducts(list, meta))
      .catch(() => setProducts(DEMO_PRODUCTS, null));
  } else {
    // Halaman tanpa grid produk (tentang, 404, halaman legal): tidak perlu
    // katalog. Keranjang tetap jalan dari snapshot localStorage (lihat cartP).
    window._fetchedParams = new URLSearchParams();
    setProducts([], null);
  }
} else {
  window._fetchedParams = new URLSearchParams();
  setProducts(DEMO_PRODUCTS, null);
}
