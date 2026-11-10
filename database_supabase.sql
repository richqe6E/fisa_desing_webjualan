-- ========================================================
-- Schema & Seed Data yStore untuk PostgreSQL (Supabase)
-- Dapat langsung dijalankan di menu "SQL Editor" pada Supabase
-- ========================================================

-- 1. Tabel Admins
CREATE TABLE IF NOT EXISTS admins (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  username VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  last_login TIMESTAMP NULL DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 2. Tabel Categories
CREATE TABLE IF NOT EXISTS categories (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  slug VARCHAR(100) NOT NULL UNIQUE,
  description TEXT DEFAULT NULL,
  sort_order INT NOT NULL DEFAULT 0,
  is_active SMALLINT NOT NULL DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 3. Tabel Login Attempts
CREATE TABLE IF NOT EXISTS login_attempts (
  id SERIAL PRIMARY KEY,
  ip_address VARCHAR(45) NOT NULL,
  attempted_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 4. Tabel Products
CREATE TABLE IF NOT EXISTS products (
  id SERIAL PRIMARY KEY,
  category_id INT NOT NULL REFERENCES categories(id) ON UPDATE CASCADE,
  name VARCHAR(255) NOT NULL,
  slug VARCHAR(255) NOT NULL UNIQUE,
  description TEXT DEFAULT NULL,
  price NUMERIC(10,2) NOT NULL,
  stock INT NOT NULL DEFAULT 0,
  image VARCHAR(255) DEFAULT NULL,
  is_active SMALLINT NOT NULL DEFAULT 1,
  views INT NOT NULL DEFAULT 0,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 5. Tabel Product Images (Galeri)
CREATE TABLE IF NOT EXISTS product_images (
  id SERIAL PRIMARY KEY,
  product_id INT NOT NULL REFERENCES products(id) ON DELETE CASCADE ON UPDATE CASCADE,
  file_name VARCHAR(255) NOT NULL,
  sort_order INT NOT NULL DEFAULT 0,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 6. Tabel Stores (Pengaturan Toko)
CREATE TABLE IF NOT EXISTS stores (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  tagline VARCHAR(255) DEFAULT NULL,
  address TEXT DEFAULT NULL,
  phone VARCHAR(30) DEFAULT NULL,
  whatsapp VARCHAR(30) DEFAULT NULL,
  about TEXT DEFAULT NULL,
  hero_line1 VARCHAR(255) DEFAULT NULL,
  hero_line2 VARCHAR(255) DEFAULT NULL,
  hero_pill1 VARCHAR(255) DEFAULT NULL,
  hero_pill2 VARCHAR(255) DEFAULT NULL,
  logo VARCHAR(255) DEFAULT NULL,
  instagram VARCHAR(255) DEFAULT NULL,
  facebook VARCHAR(255) DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 7. Tabel Visitor Logs (Log Pengunjung)
CREATE TABLE IF NOT EXISTS visitor_logs (
  id SERIAL PRIMARY KEY,
  ip_address VARCHAR(45) NOT NULL,
  user_agent VARCHAR(255) DEFAULT NULL,
  page_url VARCHAR(255) NOT NULL,
  visited_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_products_category_active ON products(category_id, is_active);
CREATE INDEX IF NOT EXISTS idx_product_images_product_id ON product_images(product_id);
CREATE INDEX IF NOT EXISTS idx_visitor_logs_visited_at ON visitor_logs(visited_at);

-- Trigger Function untuk auto-update kolom updated_at
CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS set_timestamp_admins ON admins;
CREATE TRIGGER set_timestamp_admins BEFORE UPDATE ON admins FOR EACH ROW EXECUTE FUNCTION trigger_set_timestamp();

DROP TRIGGER IF EXISTS set_timestamp_categories ON categories;
CREATE TRIGGER set_timestamp_categories BEFORE UPDATE ON categories FOR EACH ROW EXECUTE FUNCTION trigger_set_timestamp();

DROP TRIGGER IF EXISTS set_timestamp_products ON products;
CREATE TRIGGER set_timestamp_products BEFORE UPDATE ON products FOR EACH ROW EXECUTE FUNCTION trigger_set_timestamp();

DROP TRIGGER IF EXISTS set_timestamp_stores ON stores;
CREATE TRIGGER set_timestamp_stores BEFORE UPDATE ON stores FOR EACH ROW EXECUTE FUNCTION trigger_set_timestamp();

-- ========================================================
-- SEED DATA
-- ========================================================

-- Seed Admin (Password default: admin123)
INSERT INTO admins (id, name, username, password, last_login, created_at, updated_at)
VALUES (1, 'Admin yStore', 'admin', '$2y$10$x/0bsxlX/4QBzqATabWEcu8P7bCCRdJoSbFea.Cgn4OKkgEy6MyCa', '2026-10-15 07:40:04', '2026-10-04 09:42:19', '2026-10-15 12:40:04')
ON CONFLICT (id) DO NOTHING;

-- Seed Categories
INSERT INTO categories (id, name, slug, description, sort_order, is_active, created_at, updated_at) VALUES
(1, 'Pria', 'pria', 'Pakaian pria casual dan semi-formal', 1, 1, '2026-10-04 09:42:19', '2026-10-04 09:42:19'),
(2, 'Wanita', 'wanita', 'Pakaian wanita harian dan acara', 2, 1, '2026-10-04 09:42:19', '2026-10-04 09:42:19'),
(3, 'Anak-anak', 'anak-anak', 'Pakaian anak yang nyaman dan aman', 3, 1, '2026-10-04 09:42:19', '2026-10-04 09:42:19')
ON CONFLICT (id) DO NOTHING;

-- Seed Products
INSERT INTO products (id, category_id, name, slug, description, price, stock, image, is_active, views, created_at, updated_at) VALUES
(1, 1, 'Kaos Oversize Premium', 'kaos-oversize-premium', 'Kaos oversize berbahan cotton combed 30s, potongan longgar dan nyaman dipakai sehari-hari. Tersedia dalam beberapa pilihan warna netral.', 79000.00, 50, 'kaos-oversize-premium-1.jpg', 1, 12, '2026-10-12 04:31:17', '2026-10-15 13:42:35'),
(2, 1, 'Kaos Polos Lengan Pendek', 'kaos-polos-lengan-pendek', 'Kaos polos basic dengan jahitan rapi, bahan serap keringat dan awet meskipun dicuci berkali-kali.', 65000.00, 60, 'kaos-polos-lengan-pendek-1.jpg', 1, 3, '2026-10-12 04:32:17', '2026-10-13 14:10:22'),
(3, 1, 'Kemeja Lengan Pendek', 'kemeja-lengan-pendek', 'Kemeja casual berbahan katun lembut, cocok untuk harian maupun semi-formal.', 129000.00, 30, 'kemeja-lengan-pendek-1.jpg', 1, 2, '2026-10-12 04:33:17', '2026-10-15 12:33:43'),
(4, 1, 'Kemeja Kerja Katun', 'kemeja-kerja-katun', 'Kemeja kerja rapi berbahan katun stretch, nyaman dipakai seharian di kantor.', 149000.00, 25, 'kemeja-kerja-katun-1.jpg', 1, 2, '2026-10-12 04:34:17', '2026-10-15 16:32:41'),
(5, 1, 'Jaket Denim Pria', 'jaket-denim-pria', 'Jaket denim klasik dengan jahitan kuat, cocok untuk gaya street maupun kasual.', 249000.00, 20, 'jaket-denim-pria-1.jpg', 1, 10, '2026-10-12 04:35:17', '2026-10-15 16:12:50'),
(6, 1, 'Hoodie Fleece Hangat', 'hoodie-fleece-hangat', 'Hoodie berbahan fleece lembut, hangat untuk cuaca sejuk dan dilengkapi saku kanggung.', 179000.00, 35, 'hoodie-fleece-hangat-1.jpg', 1, 2, '2026-10-12 04:36:17', '2026-10-15 16:12:18'),
(7, 2, 'Dress Floral Musim Panas', 'dress-floral-musim-panas', 'Dress motif floral dengan potongan A-line, ringan dan menyerap keringat.', 149000.00, 25, 'dress-floral-musim-panas-1.jpg', 1, 0, '2026-10-12 04:37:17', '2026-10-12 04:49:17'),
(8, 2, 'Blouse Ruffle', 'blouse-ruffle', 'Blouse aksen ruffle di lengan, tampilan feminine dan elegan untuk berbagai acara.', 119000.00, 20, 'blouse-ruffle-1.jpg', 1, 1, '2026-10-12 04:38:17', '2026-10-15 16:11:33'),
(9, 2, 'Gaun Pesta Elegan', 'gaun-pesta-elegan', 'Gaun pesta panjang dengan detail kain mengalir, tampilan mewah untuk acara spesial.', 229000.00, 15, 'gaun-pesta-elegan-1.jpg', 1, 0, '2026-10-12 04:39:17', '2026-10-12 04:49:17'),
(10, 2, 'Dress Kasual Summer', 'dress-kasual-summer', 'Dress kasual berpotongan lurus, mudah dipadukan dengan sandal maupun sepatu.', 139000.00, 28, 'dress-kasual-summer-1.jpg', 1, 0, '2026-10-12 04:40:17', '2026-10-12 04:49:17'),
(11, 2, 'Maxi Dress', 'maxi-dress', 'Maxi dress dengan kain jatuh lurus, nyaman dan sopan untuk berbagai kesempatan.', 169000.00, 22, 'maxi-dress-1.jpg', 1, 0, '2026-10-12 04:41:17', '2026-10-12 04:49:17'),
(12, 2, 'Outfit Wanita Kasual', 'outfit-wanita-kasual', 'Padu padan atasan dan bawahan kasual, tampilan simpel namun tetap stylish.', 189000.00, 18, '104ffd367ffd532b69523d3ad63be5a0.jpg', 1, 0, '2026-10-12 04:42:17', '2026-10-12 05:07:06'),
(13, 3, 'Kaos Anak Karakter', 'kaos-anak-karakter', 'Kaos anak dengan motif karakter favorit, bahan lembut dan aman untuk kulit anak.', 59000.00, 40, 'b3c62e3cb7392f7120b2e8a4ca155180.jpg', 1, 2, '2026-10-12 04:43:17', '2026-10-13 08:07:14'),
(14, 3, 'Baju Bayi Lengan Panjang', 'baju-bayi-lengan-panjang', 'Baju bayi berbahan cotton halus, lembut dan nyaman untuk kulit sensitif bayi.', 55000.00, 45, 'a135b11e7d5258301b1e7441b1ce9364.jpg', 1, 0, '2026-10-12 04:44:17', '2026-10-12 05:07:41'),
(15, 3, 'Kaos Anak Kasual', 'kaos-anak-kasual', 'Kaos anak casual berbahan cotton combed, nyaman dipakai untuk bermain.', 49000.00, 50, 'fa7c1d53352c2fa54024ff2d4d2d0db9.jpg', 1, 1, '2026-10-12 04:45:17', '2026-10-12 05:06:29'),
(16, 3, 'Setelan Anak', 'setelan-anak', 'Setelan anak lengkap dengan bahan adem, cocok untuk acara keluarga dan sekolah.', 99000.00, 30, 'setelan-anak-1.jpg', 1, 9, '2026-10-12 04:46:17', '2026-10-13 14:33:26'),
(17, 3, 'Celana Pendek Anak', 'celana-pendek-anak', 'Celana pendek anak berbahan katun stretch, nyaman untuk aktivitas harian.', 75000.00, 35, '520e776fb074dd77fdc6449e3e828cb8.jpg', 1, 8, '2026-10-12 04:47:17', '2026-10-15 16:32:50'),
(18, 3, 'Kaos Bayi Motif', 'kaos-bayi-motif', 'Kaos bayi dengan motif lucu, bahan lembut dan mudah dicuci.', 45000.00, 55, '342328386b6be9d1c782858648930e55.jpg', 1, 2, '2026-10-12 04:48:17', '2026-10-13 10:40:19')
ON CONFLICT (id) DO NOTHING;

-- Seed Product Images
INSERT INTO product_images (id, product_id, file_name, sort_order, created_at) VALUES
(1, 1, 'kaos-oversize-premium-2.jpg', 1, '2026-10-12 03:26:52'),
(2, 1, 'kaos-oversize-premium-3.jpg', 2, '2026-10-12 03:26:52'),
(3, 2, 'kaos-polos-lengan-pendek-2.jpg', 1, '2026-10-12 03:26:52'),
(4, 2, 'kaos-polos-lengan-pendek-3.jpg', 2, '2026-10-12 03:26:52'),
(5, 3, 'kemeja-lengan-pendek-2.jpg', 1, '2026-10-12 03:26:52'),
(6, 3, 'kemeja-lengan-pendek-3.jpg', 2, '2026-10-12 03:26:52'),
(7, 4, 'kemeja-kerja-katun-2.jpg', 1, '2026-10-12 03:26:52'),
(8, 4, 'kemeja-kerja-katun-3.jpg', 2, '2026-10-12 03:26:52'),
(9, 5, 'jaket-denim-pria-2.jpg', 1, '2026-10-12 03:26:52'),
(10, 5, 'jaket-denim-pria-3.jpg', 2, '2026-10-12 03:26:52'),
(11, 6, 'hoodie-fleece-hangat-2.jpg', 1, '2026-10-12 03:26:52'),
(12, 6, 'hoodie-fleece-hangat-3.jpg', 2, '2026-10-12 03:26:52'),
(13, 7, 'dress-floral-musim-panas-2.jpg', 1, '2026-10-12 03:26:52'),
(14, 7, 'dress-floral-musim-panas-3.jpg', 2, '2026-10-12 03:26:52'),
(15, 8, 'blouse-ruffle-2.jpg', 1, '2026-10-12 03:26:52'),
(16, 8, 'blouse-ruffle-3.jpg', 2, '2026-10-12 03:26:52'),
(17, 9, 'gaun-pesta-elegan-2.jpg', 1, '2026-10-12 03:26:52'),
(18, 9, 'gaun-pesta-elegan-3.jpg', 2, '2026-10-12 03:26:52'),
(19, 10, 'dress-kasual-summer-2.jpg', 1, '2026-10-12 03:26:52'),
(20, 10, 'dress-kasual-summer-3.jpg', 2, '2026-10-12 03:26:52'),
(21, 11, 'maxi-dress-2.jpg', 1, '2026-10-12 03:26:52'),
(22, 11, 'maxi-dress-3.jpg', 2, '2026-10-12 03:26:52'),
(23, 12, 'outfit-wanita-kasual-2.jpg', 1, '2026-10-12 03:26:52'),
(24, 12, 'outfit-wanita-kasual-3.jpg', 2, '2026-10-12 03:26:52'),
(25, 13, 'kaos-anak-karakter-2.jpg', 1, '2026-10-12 03:26:52'),
(26, 13, 'kaos-anak-karakter-3.jpg', 2, '2026-10-12 03:26:52'),
(27, 14, 'baju-bayi-lengan-panjang-2.jpg', 1, '2026-10-12 03:26:52'),
(28, 14, 'baju-bayi-lengan-panjang-3.jpg', 2, '2026-10-12 03:26:52'),
(29, 15, 'kaos-anak-kasual-2.jpg', 1, '2026-10-12 03:26:52'),
(30, 15, 'kaos-anak-kasual-3.jpg', 2, '2026-10-12 03:26:52'),
(31, 16, 'setelan-anak-2.jpg', 1, '2026-10-12 03:26:52'),
(32, 16, 'setelan-anak-3.jpg', 2, '2026-10-12 03:26:52'),
(33, 17, 'celana-pendek-anak-2.jpg', 1, '2026-10-12 03:26:52'),
(34, 17, 'celana-pendek-anak-3.jpg', 2, '2026-10-12 03:26:52'),
(35, 18, 'kaos-bayi-motif-2.jpg', 1, '2026-10-12 03:26:52'),
(36, 18, 'kaos-bayi-motif-3.jpg', 2, '2026-10-12 03:26:52')
ON CONFLICT (id) DO NOTHING;

-- Seed Stores
INSERT INTO stores (id, name, tagline, address, phone, whatsapp, about, hero_line1, hero_line2, hero_pill1, hero_pill2, logo, instagram, facebook, created_at, updated_at)
VALUES (1, 'yStore', 'Koleksi pakaian kekinian, harga ramah kantong', 'Jl. Alamat lengkap No.123, Makassar, Sulawesi Selatan', '0411-0123456', '6281234567890', 'yStore adalah toko online pakaian dengan koleksi pria, wanita, dan anak-anak. Kami mengutamakan kualitas bahan, harga ramah kantong, dan layanan cepat lewat WhatsApp.', 'Tampilan [gambar] Kekinian', 'dengan [gambar] Harga Bersahabat', '1c973eac6a907d234592d925188b6c17.jpg', 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?auto=format&fit=crop&w=220&h=88&q=75', '77adf89785afd16673a4c7efb13e06f5.png', '', '', '2026-10-04 09:42:19', '2026-10-15 16:27:31')
ON CONFLICT (id) DO NOTHING;

-- Sync Sequence Values
SELECT setval('admins_id_seq', COALESCE((SELECT MAX(id) FROM admins), 1));
SELECT setval('categories_id_seq', COALESCE((SELECT MAX(id) FROM categories), 1));
SELECT setval('products_id_seq', COALESCE((SELECT MAX(id) FROM products), 1));
SELECT setval('product_images_id_seq', COALESCE((SELECT MAX(id) FROM product_images), 1));
SELECT setval('stores_id_seq', COALESCE((SELECT MAX(id) FROM stores), 1));
SELECT setval('visitor_logs_id_seq', COALESCE((SELECT MAX(id) FROM visitor_logs), 1));
