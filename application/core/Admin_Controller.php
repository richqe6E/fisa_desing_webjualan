<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Base controller untuk semua halaman admin.
 *
 * CATATAN: CI3 hanya auto-load MY_Controller.php dari application/core/,
 * jadi setiap controller admin WAJIB memuat file ini lebih dulu:
 *   require_once APPPATH . 'core/Admin_Controller.php';
 */
class Admin_Controller extends CI_Controller {

	/** @var object|null Profil toko untuk layout admin */
	public $store;

	public function __construct()
	{
		parent::__construct();

		// Proteksi: halaman admin hanya untuk admin yang sudah login
		if ( ! $this->session->userdata('admin_logged_in'))
		{
			redirect('admin/auth/login');
		}

		$this->load->model('Store_model');
		$this->store = $this->Store_model->getStore();

		$this->load->library('upload');
	}

	/**
	 * Upload satu file gambar (cover produk / logo toko).
	 * Mengembalikan nama file hasil upload, atau NULL jika
	 * tidak ada file / upload gagal (pesan error via flashdata).
	 */
	protected function doUpload($field, $folder = 'products')
	{
		if ( ! isset($_FILES[$field]) || ! is_uploaded_file($_FILES[$field]['tmp_name']))
		{
			return NULL;
		}

		$config['upload_path']   = FCPATH . 'assets/uploads/' . $folder . '/';
		$config['allowed_types'] = 'gif|jpg|jpeg|png|webp';
		$config['max_size']      = 2048; // KB
		$config['encrypt_name']  = TRUE;

		$this->upload->initialize($config);

		if ( ! $this->upload->do_upload($field))
		{
			$this->session->set_flashdata('error', 'Gagal upload gambar: ' . strip_tags($this->upload->display_errors('', '')));
			return NULL;
		}

		return $this->upload->data('file_name');
	}

	/**
	 * Hapus file gambar hasil upload dari disk.
	 */
	protected function deleteUpload($fileName, $folder = 'products')
	{
		if ($fileName === NULL || $fileName === '')
		{
			return;
		}

		$path = FCPATH . 'assets/uploads/' . $folder . '/' . $fileName;
		if (is_file($path))
		{
			unlink($path);
		}
	}
}
