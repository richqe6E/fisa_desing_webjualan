<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Products extends MY_Controller {

	/**
	 * Daftar produk dengan filter kategori (?kategori=slug), pencarian (?q=),
	 * urutan (?urut=) dan pagination (/produk/page/2).
	 *
	 * Grid-nya dirender di client (listing.js) dari endpoint api/produk;
	 * bagian server hanya menyiapkan konfigurasi grid + menghitung halaman
	 * yang valid supaya URL /produk/page/99 jatuh ke halaman terakhir.
	 */
	public function index()
	{
		$this->load->model('Product_model');
		$this->load->model('Category_model');

		$categorySlug = $this->input->get('kategori');
		$categorySlug = (is_scalar($categorySlug) && trim((string) $categorySlug) !== '') ? trim((string) $categorySlug) : NULL;
		$hasFilter    = ($categorySlug !== NULL);

		// Filter slug yang tidak valid dianggap 404
		$category = $hasFilter ? $this->Category_model->getCategoryBySlug($categorySlug) : NULL;
		if ($hasFilter && $category === NULL)
		{
			$this->notFound();
			return;
		}

		// Pencarian ikut dihitung supaya jumlah halaman sama dengan hasil API
		$rawQ  = $this->input->get('q');
		$q      = is_scalar($rawQ) ? trim((string) $rawQ) : '';

		// Konfigurasi pagination (URL: /produk/page/3; filter tetap di query string)
		$perPage    = 9;
		$totalRows  = $this->Product_model->countProducts($categorySlug, $q);
		$totalPages = max(1, (int) ceil($totalRows / $perPage));

		// Halaman saat ini (1-based); segment kosong atau bukan angka → 1,
		// di luar jangkauan → halaman terakhir. is_string() menjaga
		// ctype_digit() tidak pernah dipanggil dengan NULL (deprecation PHP 8.2).
		$segment = $this->uri->segment(3);
		$pageNow = (is_string($segment) && ctype_digit($segment) && (int) $segment > 0) ? (int) $segment : 1;
		if ($pageNow > $totalPages)
		{
			$pageNow = $totalPages;
		}

		$data['title']       = 'Produk';
		$data['description'] = meta_description(
			($category !== NULL ? 'Koleksi ' . $category->name : 'Katalog produk')
			. ' ' . ($this->store->name ?? '')
			. ' — ' . ($this->store->tagline ?? '')
		);
		$data['categories']  = $this->Category_model->getCategories();
		$data['category']    = $category;
		$data['grid']        = array(
			'paged'   => TRUE,
			'listUrl' => base_url('produk'),
			'perPage' => $perPage,
			'page'    => $pageNow,
		);
		$data['page_script'] = 'assets/template/listing.js';

		$this->load->view('templates/header', $data);
		$this->load->view('products/index', $data);
		$this->load->view('templates/footer', $data);
	}

	/**
	 * Detail produk berdasarkan slug.
	 * Counter views bertambah setiap kunjungan.
	 */
	public function detail($slug = NULL)
	{
		$this->load->model('Product_model');

		$product = ($slug !== NULL) ? $this->Product_model->getProductBySlug($slug) : NULL;

		if ($product === NULL)
		{
			$this->notFound();
			return;
		}

		// Catat views produk secara unik per sesi pengunjung (refresh tidak menambah angka berulang kali)
		$viewed = (array) $this->session->userdata('viewed_products');
		if ( ! in_array($product->id, $viewed, TRUE))
		{
			$this->Product_model->incrementViews($product->id);
			$product->views = (int) $product->views + 1;
			$viewed[] = $product->id;
			$this->session->set_userdata('viewed_products', $viewed);
		}

		$data['title']       = $product->name;
		$data['description'] = meta_description($product->description);
		$data['og_type']     = 'product';
		$data['product']     = $product;
		$data['images']      = $this->Product_model->getImages($product->id);

		// Gambar pratinjau: foto cover, atau foto galeri pertama bila cover kosong
		$ogImage = (string) $product->image;
		if ($ogImage === '' && ! empty($data['images']))
		{
			$ogImage = (string) $data['images'][0]->file_name;
		}
		if ($ogImage !== '')
		{
			$data['og_image'] = upload_asset_url($ogImage, 'products');
		}
		else
		{
			// Belum ada foto sama sekali → gambar cadangan supaya kartu share tetap punya gambar
			$data['og_image'] = base_url('assets/template/img/noimage.jpg');
		}

		// Halaman detail mengambil satu produk + terkait lewat endpoint ini,
		// bukan mengunduh seluruh katalog (lihat assets/template/products.js).
		$data['detail'] = array(
			'api' => base_url('api/produk/' . rawurlencode($product->slug)),
		);

		$data['page_script'] = 'assets/template/product.js';

		$this->load->view('templates/header', $data);
		$this->load->view('products/detail', $data);
		$this->load->view('templates/footer', $data);
	}
}
