-- ====================================================================
-- Script Pengisian Data Produk FISA DESIGN & PRINTING ke Database Supabase
-- Jalankan query ini di: Supabase Dashboard -> SQL Editor -> New query -> Run
-- ====================================================================

-- 1. Tambahkan Kategori Baru untuk FISA Design & Printing
INSERT INTO categories (id, name, slug, description, sort_order, is_active) VALUES
(10, 'Stiker Custom', 'stiker-custom', 'Aneka stiker custom nama, foto, stiker racing, dan paket hemat', 1, 1),
(11, 'Merchandise & Custom', 'merchandise-custom', 'Korek api custom, gantungan kunci laminasi panas, dan merchandise', 2, 1)
ON CONFLICT (id) DO UPDATE 
SET name = EXCLUDED.name,
    slug = EXCLUDED.slug,
    description = EXCLUDED.description,
    is_active = 1;

-- Pastikan sequence id kategori terupdate
SELECT setval(pg_get_serial_sequence('categories', 'id'), COALESCE((SELECT MAX(id) FROM categories), 1));

-- 2. Hapus produk default pakaian lama (opsional / bersihkan jika masih ada)
DELETE FROM products WHERE slug IN (
    'kaos-oversize-premium', 'kaos-polos-lengan-pendek', 'kemeja-lengan-pendek',
    'kemeja-kerja-katun', 'jaket-denim-pria', 'hoodie-fleece-hangat',
    'dress-floral-musim-panas', 'blouse-ruffle', 'celana-pendek-anak',
    'dress-kasual-summer', 'maxi-dress', 'outfit-wanita-kasual',
    'gaun-pesta-elegan', 'setelan-anak', 'kaos-anak-karakter',
    'kaos-bayi-motif', 'baju-bayi-lengan-panjang', 'kaos-anak-kasual'
);

-- 3. Masukkan 5 Produk FISA Design & Printing
-- Produk 1: Korek Api Custom (Rp 10.000)
INSERT INTO products (id, category_id, name, slug, description, price, stock, image, is_active, views) VALUES
(101, 11, 'Korek Api Custom', 'korek-api-custom', 
'Korek Api Custom berkualitas dengan berbagai pilihan desain keren & kekinian (termasuk tema Ultra Milk: Biru, Putih, Pink, Moka, Orange, Kuning, Ungu, Blueberry).

Keunggulan & Pilihan:
- Bebas custom Nama, Foto, atau Nama MIX Foto
- Desain lucu, estetik, dan unik
- Mau bawa korek sendiri? Bisa juga, hanya Rp 7.000!
- Cocok untuk souvenir, kado teman, merchandise komunitas, maupun koleksi pribadi.',
10000.00, 100, 'korek-api-custom.jpg', 1, 15)
ON CONFLICT (id) DO UPDATE 
SET name = EXCLUDED.name,
    category_id = EXCLUDED.category_id,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    stock = EXCLUDED.stock,
    image = EXCLUDED.image,
    is_active = 1;

-- Produk 2: Stiker Custom (Rp 7.000)
INSERT INTO products (id, category_id, name, slug, description, price, stock, image, is_active, views) VALUES
(102, 10, 'Stiker Custom', 'stiker-custom', 
'Stiker Custom (Best Seller) cetak tajam dan potongan rapi presisi!

Pilihan & Spesifikasi:
- Custom Nama dan Foto
- Custom Nama saja
- Custom Foto saja
- Warna bebas pilih sesuai selera
- Ukuran Standar 10cm x Menyesuaikan desain dan bentuk foto
- Bebas request model lain selain contoh desain (BEBAS DESIGN)!',
7000.00, 100, 'stiker-custom.jpg', 1, 28)
ON CONFLICT (id) DO UPDATE 
SET name = EXCLUDED.name,
    category_id = EXCLUDED.category_id,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    stock = EXCLUDED.stock,
    image = EXCLUDED.image,
    is_active = 1;

-- Produk 3: Stiker Custom Paket (Rp 50.000)
INSERT INTO products (id, category_id, name, slug, description, price, stock, image, is_active, views) VALUES
(103, 10, 'Stiker Custom Paket', 'stiker-custom-paket', 
'1 PAKET LEBIH MURAH & HEMAT!

Spesifikasi Paket:
- Dengan 1 Desain pilihan Anda
- Isi 10 hingga 20 pcs per paket (jumlah tergantung ukuran desain)
- Hanya Rp 50.000 per paket!
- Sangat cocok untuk kalian yang mau buat stiker TIM / KELOMPOK / KOMUNITAS atau KELAS sekolah.',
50000.00, 50, 'stiker-custom-paket.jpg', 1, 22)
ON CONFLICT (id) DO UPDATE 
SET name = EXCLUDED.name,
    category_id = EXCLUDED.category_id,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    stock = EXCLUDED.stock,
    image = EXCLUDED.image,
    is_active = 1;

-- Produk 4: Ganci (Gantungan Kunci) Custom (Rp 7.000)
INSERT INTO products (id, category_id, name, slug, description, price, stock, image, is_active, views) VALUES
(104, 11, 'Ganci (Gantungan Kunci) Custom', 'ganci-custom', 
'Gantungan Kunci (Ganci) Custom Best Seller, awet dan unik!

Spesifikasi & Keunggulan:
- Bahan Laminasi Panas berkualitas (Bukan akrilik, sehingga lebih ringan dan tidak mudah pecah)
- Pilihan: Custom Nama dan Foto, Custom Nama saja, Custom Foto saja
- Warna bebas pilih sesuai keinginan
- Bisa Request model lain selain desain yang tertera (BEBAS DESIGN)!',
7000.00, 100, 'ganci-custom.jpg', 1, 35)
ON CONFLICT (id) DO UPDATE 
SET name = EXCLUDED.name,
    category_id = EXCLUDED.category_id,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    stock = EXCLUDED.stock,
    image = EXCLUDED.image,
    is_active = 1;

-- Produk 5: Stiker No Star Racing Custom (Rp 7.000)
INSERT INTO products (id, category_id, name, slug, description, price, stock, image, is_active, views) VALUES
(105, 10, 'Stiker No Star Racing Custom', 'stiker-no-star-racing-custom', 
'Bikin tampilan motor kesayangan kamu jadi makin keren, sporty, dan gagah dengan stiker nomor start ala-ala racing!

Spesifikasi:
- Custom Nomor Start dan Nama Rider/Pembalap
- Desain racing tajam dan warna tahan luntur
- Harga terjangkau mulai dari Rp 7.000 (menyesuaikan ukuran stiker)
- Cocok ditempel di spakbor, batok motor, visor, atau bodi samping.',
7000.00, 100, 'stiker-no-star-racing-custom.jpg', 1, 19)
ON CONFLICT (id) DO UPDATE 
SET name = EXCLUDED.name,
    category_id = EXCLUDED.category_id,
    description = EXCLUDED.description,
    price = EXCLUDED.price,
    stock = EXCLUDED.stock,
    image = EXCLUDED.image,
    is_active = 1;

-- Pastikan sequence id products terupdate
SELECT setval(pg_get_serial_sequence('products', 'id'), COALESCE((SELECT MAX(id) FROM products), 1));

-- 4. Galeri Gambar Produk (product_images)
DELETE FROM product_images WHERE product_id IN (101, 102, 103, 104, 105);
INSERT INTO product_images (product_id, file_name, sort_order) VALUES
(101, 'korek-api-custom.jpg', 0),
(102, 'stiker-custom.jpg', 0),
(103, 'stiker-custom-paket.jpg', 0),
(104, 'ganci-custom.jpg', 0),
(105, 'stiker-no-star-racing-custom.jpg', 0);

-- 5. Perbarui Data Profil Toko FISA Design & Printing
UPDATE stores 
SET name = 'Fisa Design & Printing',
    tagline = 'Jasa Desain, Percetakan Stiker & Merchandise Custom',
    whatsapp = '082250797051',
    phone = '082250797051',
    about = 'Fisa Design & Printing melayani pembuatan aneka Stiker Custom, Korek Api Custom, Gantungan Kunci Laminasi, Stiker Nomor Start Racing, dan berbagai merchandise custom dengan kualitas terbaik dan harga bersahabat.',
    hero_line1 = 'Design & Cetak Merchandise',
    hero_line2 = 'Custom Keren Harga Bersahabat'
WHERE id = (SELECT id FROM stores LIMIT 1);
