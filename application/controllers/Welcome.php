<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Welcome extends MY_Controller {

	/**
	 * Halaman beranda: info toko, kategori, produk terbaru.
	 * Maps to http://example.com/
	 */
	public function index()
	{
		$this->load->model('Product_model');
		$this->load->model('Category_model');

		$data['title']           = 'Beranda';
		$data['description']     = meta_description(trim(($this->store->tagline ?? '') . ' ' . ($this->store->about ?? '')));
		$data['categories']      = $this->Category_model->getCategories();
		$data['products']        = $this->Product_model->getLatest(8);
		$data['totalProducts']   = $this->Product_model->countAll();
		$data['totalCategories'] = count($data['categories']);
		$data['totalViews']      = $this->Product_model->sumViews();
		// Grid beranda: maksimum 6 produk (tanpa pagination — lihat listing.js).
		// getLatest(8) di atas hanya untuk foto hero (4 produk terpakai).
		$data['grid']            = array(
			'paged'   => FALSE,
			'listUrl' => base_url('produk'),
			'perPage' => 6,
		);
		$data['page_script']     = 'assets/template/listing.js';

		$this->load->view('templates/header', $data);
		$this->load->view('welcome_message', $data);
		$this->load->view('templates/footer', $data);
	}

	// Halaman tentang kami
	public function about()
	{
		$this->load->model('Category_model');
		$this->load->model('Product_model');

		$data['title']           = 'Tentang Kami';
		$data['description']     = meta_description($this->store->about ?? '');
		$data['totalProducts']   = $this->Product_model->countAll();
		$data['totalCategories'] = $this->Category_model->countAll();
		$data['totalViews']      = $this->Product_model->sumViews();

		$this->load->view('templates/header', $data);
		$this->load->view('about', $data);
		$this->load->view('templates/footer', $data);
	}
}
