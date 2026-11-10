<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Base controller untuk halaman publik.
 * Memuat data toko (dipakai header/footer) dan mencatat
 * setiap kunjungan halaman ke tabel visitor_logs.
 */
class MY_Controller extends CI_Controller {

	/** @var object|null Profil toko (row dari tabel stores) */
	public $store;

	public function __construct()
	{
		parent::__construct();

		// Data toko untuk header, footer, dan halaman publik
		$this->load->model('Store_model');
		$this->store = $this->Store_model->getStore();

		// Catat kunjungan halaman publik
		$this->load->model('Visitor_model');
		$this->Visitor_model->logVisit();
	}

	/**
	 * Tampilkan halaman 404 memakai template situs (header + halaman 404 + footer).
	 *
	 * Dipakai dua jalur:
	 * - controller publik yang datanya tidak ada (mis. slug produk salah), dan
	 * - rute yang tidak dikenali lewat $route['404_override'] (controller Errors).
	 *
	 * Controller yang memanggil wajib `return` setelah ini.
	 */
	protected function notFound()
	{
		$this->output->set_status_header(404);

		log_message('error', '404 Page Not Found: ' . uri_string());

		$data = array(
			'title'       => 'Halaman tidak ditemukan',
			'description' => 'Halaman yang kamu cari tidak ada atau sudah dipindahkan.',
			'noindex'     => TRUE,
		);

		$this->load->view('templates/header', $data);
		$this->load->view('pages/404', $data);
		$this->load->view('templates/footer', $data);
	}
}
