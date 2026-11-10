<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Migrate_fisa extends CI_Controller {

	/**
	 * Endpoint migrasi data produk & profil FISA Design & Printing
	 */
	public function index()
	{
		$token = (string) $this->input->get('token');
		if ($token !== 'fisa2026' && ! $this->session->userdata('admin_logged_in'))
		{
			show_error('Akses tidak diizinkan', 403);
			return;
		}

		$this->load->database();

		// 1. Kategori baru
		$this->db->query("
			INSERT INTO categories (id, name, slug, description, sort_order, is_active) VALUES
			(10, 'Stiker Custom', 'stiker-custom', 'Aneka stiker custom nama, foto, stiker racing, dan paket hemat', 1, 1),
			(11, 'Merchandise & Custom', 'merchandise-custom', 'Korek api custom, gantungan kunci laminasi panas, dan merchandise', 2, 1)
			ON CONFLICT (id) DO UPDATE 
			SET name = EXCLUDED.name,
			    slug = EXCLUDED.slug,
			    description = EXCLUDED.description,
			    is_active = 1
		");

		// 2. Bersihkan produk sampel pakaian bawaan lama jika masih ada
		$this->db->query("
			DELETE FROM products WHERE slug IN (
				'kaos-oversize-premium', 'kaos-polos-lengan-pendek', 'kemeja-lengan-pendek',
				'kemeja-kerja-katun', 'jaket-denim-pria', 'hoodie-fleece-hangat',
				'dress-floral-musim-panas', 'blouse-ruffle', 'celana-pendek-anak',
				'dress-kasual-summer', 'maxi-dress', 'outfit-wanita-kasual',
				'gaun-pesta-elegan', 'setelan-anak', 'kaos-anak-karakter',
				'kaos-bayi-motif', 'baju-bayi-lengan-panjang', 'kaos-anak-kasual'
			)
		");

		// 3. Masukkan 5 Produk Resmi FISA Design & Printing
		$products = array(
			array(
				'id'          => 101,
				'category_id' => 11,
				'name'        => 'Korek Api Custom',
				'slug'        => 'korek-api-custom',
				'description' => "Korek Api Custom berkualitas dengan berbagai pilihan desain keren & kekinian (termasuk tema Ultra Milk: Biru, Putih, Pink, Moka, Orange, Kuning, Ungu, Blueberry).\n\nKeunggulan & Pilihan:\n- Bebas custom Nama, Foto, atau Nama MIX Foto\n- Desain lucu, estetik, dan unik\n- Mau bawa korek sendiri? Bisa juga, hanya Rp 7.000!\n- Cocok untuk souvenir, kado teman, merchandise komunitas, maupun koleksi pribadi.",
				'price'       => 10000.00,
				'stock'       => 100,
				'image'       => 'korek-api-custom.jpg',
				'is_active'   => 1,
				'views'       => 15
			),
			array(
				'id'          => 102,
				'category_id' => 10,
				'name'        => 'Stiker Custom',
				'slug'        => 'stiker-custom',
				'description' => "Stiker Custom (Best Seller) cetak tajam dan potongan rapi presisi!\n\nPilihan & Spesifikasi:\n- Custom Nama dan Foto\n- Custom Nama saja\n- Custom Foto saja\n- Warna bebas pilih sesuai selera\n- Ukuran Standar 10cm x Menyesuaikan desain dan bentuk foto\n- Bebas request model lain selain contoh desain (BEBAS DESIGN)!",
				'price'       => 7000.00,
				'stock'       => 100,
				'image'       => 'stiker-custom.jpg',
				'is_active'   => 1,
				'views'       => 28
			),
			array(
				'id'          => 103,
				'category_id' => 10,
				'name'        => 'Stiker Custom Paket',
				'slug'        => 'stiker-custom-paket',
				'description' => "1 PAKET LEBIH MURAH & HEMAT!\n\nSpesifikasi Paket:\n- Dengan 1 Desain pilihan Anda\n- Isi 10 hingga 20 pcs per paket (jumlah tergantung ukuran desain)\n- Hanya Rp 50.000 per paket!\n- Sangat cocok untuk kalian yang mau buat stiker TIM / KELOMPOK / KOMUNITAS atau KELAS sekolah.",
				'price'       => 50000.00,
				'stock'       => 50,
				'image'       => 'stiker-custom-paket.jpg',
				'is_active'   => 1,
				'views'       => 22
			),
			array(
				'id'          => 104,
				'category_id' => 11,
				'name'        => 'Ganci (Gantungan Kunci) Custom',
				'slug'        => 'ganci-custom',
				'description' => "Gantungan Kunci (Ganci) Custom Best Seller, awet dan unik!\n\nSpesifikasi & Keunggulan:\n- Bahan Laminasi Panas berkualitas (Bukan akrilik, sehingga lebih ringan dan tidak mudah pecah)\n- Pilihan: Custom Nama dan Foto, Custom Nama saja, Custom Foto saja\n- Warna bebas pilih sesuai keinginan\n- Bisa Request model lain selain desain yang tertera (BEBAS DESIGN)!",
				'price'       => 7000.00,
				'stock'       => 100,
				'image'       => 'ganci-custom.jpg',
				'is_active'   => 1,
				'views'       => 35
			),
			array(
				'id'          => 105,
				'category_id' => 10,
				'name'        => 'Stiker No Star Racing Custom',
				'slug'        => 'stiker-no-star-racing-custom',
				'description' => "Bikin tampilan motor kesayangan kamu jadi makin keren, sporty, dan gagah dengan stiker nomor start ala-ala racing!\n\nSpesifikasi:\n- Custom Nomor Start dan Nama Rider/Pembalap\n- Desain racing tajam dan warna tahan luntur\n- Harga terjangkau mulai dari Rp 7.000 (menyesuaikan ukuran stiker)\n- Cocok ditempel di spakbor, batok motor, visor, atau bodi samping.",
				'price'       => 7000.00,
				'stock'       => 100,
				'image'       => 'stiker-no-star-racing-custom.jpg',
				'is_active'   => 1,
				'views'       => 19
			)
		);

		foreach ($products as $p)
		{
			$this->db->query("
				INSERT INTO products (id, category_id, name, slug, description, price, stock, image, is_active, views)
				VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
				ON CONFLICT (id) DO UPDATE
				SET name = EXCLUDED.name,
				    category_id = EXCLUDED.category_id,
				    description = EXCLUDED.description,
				    price = EXCLUDED.price,
				    stock = EXCLUDED.stock,
				    image = EXCLUDED.image,
				    is_active = 1
			", array($p['id'], $p['category_id'], $p['name'], $p['slug'], $p['description'], $p['price'], $p['stock'], $p['image'], $p['is_active'], $p['views']));

			$this->db->query("DELETE FROM product_images WHERE product_id = ?", array($p['id']));
			$this->db->query("INSERT INTO product_images (product_id, file_name, sort_order) VALUES (?, ?, 0)", array($p['id'], $p['image']));
		}

		// 4. Update data profil toko
		$this->db->query("
			UPDATE stores
			SET name = 'Fisa Design & Printing',
			    tagline = 'Jasa Desain, Percetakan Stiker & Merchandise Custom',
			    whatsapp = '082250797051',
			    phone = '082250797051',
			    about = 'Fisa Design & Printing melayani pembuatan aneka Stiker Custom, Korek Api Custom, Gantungan Kunci Laminasi, Stiker Nomor Start Racing, dan berbagai merchandise custom dengan kualitas terbaik dan harga bersahabat.',
			    hero_line1 = 'Design & Cetak Merchandise',
			    hero_line2 = 'Custom Keren Harga Bersahabat'
			WHERE id = (SELECT id FROM stores LIMIT 1)
		");

		header('Content-Type: text/plain; charset=utf-8');
		echo "SUKSES: 5 Produk FISA Design & Printing berhasil diisikan ke database Supabase!\n";
	}
}
