<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Endpoint JSON untuk template front-end (client-side rendering).
 *
 * Sengaja tidak extends MY_Controller: setiap halaman memuat endpoint ini
 * sekali via fetch, sehingga kunjungan tidak terhitung ganda di visitor_logs.
 *
 * Dua endpoint:
 * - products() : daftar produk aktif (beranda & /produk).
 *   Parameter query (opsional): per_page (0/tanpa = semua, maks 50), page,
 *   kategori (slug), q (pencarian), urut (featured|price-asc|price-desc|name).
 *   Respons: { products, meta: { total, page, per_page, total_pages } } —
 *   meta dipakai listing.js untuk pagination beranda & halaman /produk.
 * - product($slug) : satu produk + produk terkait (halaman detail), supaya
 *   halaman detail tidak perlu mengunduh seluruh katalog.
 *   Respons: { product, related: [...] }.
 */
class Api extends CI_Controller {

	// Daftar produk aktif untuk halaman depan
	public function products()
	{
		$this->load->model('Product_model');

		$perPageRaw = $this->input->get('per_page');
		$pageRaw    = $this->input->get('page');
		$kategoriRaw = $this->input->get('kategori');
		$qRaw       = $this->input->get('q');
		$urut       = $this->input->get('urut');

		// Sengaja pakai is_scalar: input berbentuk array (?page[]=2) jangan
		// sampai memicu warning PHP 8 saat di-cast/di-trim.
		$perPage  = is_scalar($perPageRaw) ? min(50, max(0, (int) $perPageRaw)) : 0;
		$page     = is_scalar($pageRaw) ? max(1, (int) $pageRaw) : 1;
		$kategori = is_scalar($kategoriRaw) ? trim((string) $kategoriRaw) : '';
		$q        = is_scalar($qRaw) ? trim((string) $qRaw) : '';
		$urut     = (is_scalar($urut) && in_array((string) $urut, array('featured', 'price-asc', 'price-desc', 'name'), TRUE))
			? (string) $urut
			: 'featured';

		$kategoriArg = ($kategori !== '') ? $kategori : NULL;

		$total      = $this->Product_model->countProducts($kategoriArg, $q);
		$totalPages = ($perPage > 0) ? max(1, (int) ceil($total / $perPage)) : 1;
		$page       = min($page, $totalPages); // halaman di luar jangkauan → halaman terakhir
		$offset     = ($perPage > 0) ? ($page - 1) * $perPage : 0;

		$rows = $this->Product_model->getProducts($perPage > 0 ? $perPage : NULL, $offset, $kategoriArg, $q, $urut);

		// Semua gambar galeri diambil dalam satu query (hindari N+1).
		$images = $this->Product_model->getImagesForProducts(array_map(
			function ($product) { return $product->id; },
			$rows
		));

		$out = array();
		foreach ($rows as $product)
		{
			$out[] = $this->payload($product, isset($images[$product->id]) ? $images[$product->id] : array());
		}

		$this->_respond(array(
			'products' => $out,
			'meta'     => array(
				'total'       => (int) $total,
				'page'        => (int) $page,
				'per_page'    => (int) $perPage,
				'total_pages' => (int) $totalPages,
			),
		));
	}

	/**
	 * Satu produk aktif (berdasarkan slug) + produk terkait.
	 * Dipakai halaman detail: cukup 1+beberapa produk, bukan seluruh katalog.
	 */
	public function product($slug = NULL)
	{
		$this->load->model('Product_model');

		$product = ($slug !== NULL) ? $this->Product_model->getProductBySlug($slug) : NULL;

		if ($product === NULL)
		{
			$this->output
				->set_status_header(404)
				->set_content_type('application/json')
				->set_output(json_encode(array('product' => NULL, 'related' => array())));

			return;
		}

		$related = $this->Product_model->getRelated($product->category_id, $product->id, 4);

		// Kategori bisa berisi sedikit produk — lengkapi dengan produk terbaru
		// lain supaya bagian "Produk Terkait" tidak kosong.
		if (count($related) < 4)
		{
			$exclude = array_merge(
				array($product->id),
				array_map(function ($row) { return $row->id; }, $related)
			);
			$related = array_merge($related, $this->Product_model->getLatest(4 - count($related), $exclude));
		}

		// Gambar untuk produk utama + semua terkait, satu query.
		$images = $this->Product_model->getImagesForProducts(array_map(
			function ($row) { return $row->id; },
			array_merge(array($product), $related)
		));

		$relatedOut = array();
		foreach ($related as $row)
		{
			$relatedOut[] = $this->payload($row, isset($images[$row->id]) ? $images[$row->id] : array());
		}

		$this->_respond(array(
			'product' => $this->payload($product, isset($images[$product->id]) ? $images[$product->id] : array()),
			'related' => $relatedOut,
		));
	}

	/**
	 * Susun daftar URL foto satu produk: cover dulu, lalu galeri.
	 * Bila belum ada foto sama sekali, pakai gambar cadangan.
	 */
	private function photos($product, array $images)
	{
		$photos = array();

		if ($product->image !== NULL && $product->image !== '')
		{
			$photos[] = upload_asset_url($product->image, 'products');
		}

		foreach ($images as $image)
		{
			$photos[] = upload_asset_url($image->file_name, 'products');
		}

		// Foto cadangan bila produk belum memiliki gambar
		// (file di assets/template/ ikut ter-deploy dari git — bukan di uploads/)
		return empty($photos) ? array(base_url('assets/template/img/noimage.jpg')) : $photos;
	}

	/** Bentuk satu produk jadi array siap-render di front-end. */
	private function payload($product, array $images)
	{
		return array(
			'id'      => $product->slug,
			'name'    => $product->name,
			'price'   => (int) round((float) $product->price),
			'stock'   => (int) $product->stock,
			'rating'  => 0,
			'reviews' => 0,
			'cat'     => (string) $product->category_slug,
			'photos'  => $this->photos($product, $images),
			'colors'  => array(),
			'desc'    => (string) $product->description,
			'specs'   => array(),
		);
	}

	/** Kirim array sebagai JSON. */
	private function _respond(array $data)
	{
		$this->output
			->set_content_type('application/json')
			->set_output(json_encode($data, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE));
	}
}
