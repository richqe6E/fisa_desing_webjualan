<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Auth extends CI_Controller {

	/** @var object|null Profil toko (dipakai view login) */
	public $store;

	// Batas percobaan login gagal sebelum diblokir sementara
	private $maxAttempts = 5;
	private $lockMinutes = 15;

	public function __construct()
	{
		parent::__construct();

		$this->load->model('Admin_model');
		$this->load->model('Store_model');
		$this->store = $this->Store_model->getStore();

		// Sudah login -> langsung ke dashboard
		// (kecuali request logout, agar method logout() tetap terpanggil)
		if ($this->session->userdata('admin_logged_in') && $this->router->fetch_method() !== 'logout')
		{
			redirect('admin/dashboard');
		}
	}

	// Halaman login admin (dilindungi rate limiting)
	public function login()
	{
		$ip = $this->input->ip_address();

		$this->form_validation->set_rules('username', 'Username', 'required');
		$this->form_validation->set_rules('password', 'Password', 'required');

		// GET atau input belum valid: tampilkan form
		if ($this->form_validation->run() === FALSE)
		{
			$data['title']   = 'Login Admin';
			$data['blocked'] = $this->Admin_model->countFailedAttempts($ip, $this->lockMinutes) >= $this->maxAttempts;
			$this->load->view('admin/login', $data);
			return;
		}

		// Rate limiting: tampilkan form dengan pesan error
		// (bukan redirect, agar tidak terjadi redirect loop)
		if ($this->Admin_model->countFailedAttempts($ip, $this->lockMinutes) >= $this->maxAttempts)
		{
			$data['title']  = 'Login Admin';
			$data['error']  = 'Terlalu banyak percobaan login. Silakan coba lagi dalam ' . $this->lockMinutes . ' menit.';
			$data['blocked'] = TRUE;
			$this->load->view('admin/login', $data);
			return;
		}

		$username = $this->input->post('username');
		$password = $this->input->post('password');

		$admin = $this->Admin_model->getByUsername($username);

		if ($admin !== NULL && password_verify($password, $admin->password))
		{
			// Login sukses: bersihkan catatan gagal dari IP ini
			$this->Admin_model->clearFailedAttempts($ip);
			$this->Admin_model->purgeOldAttempts();

			// Ganti ID sesi sebelum menyimpan status login (mencegah session
			// fixation: ID sesi yang dikirim sebelum login tidak bisa dipakai ulang).
			$this->session->sess_regenerate(TRUE);

			$this->session->set_userdata(array(
				'admin_id'        => $admin->id,
				'admin_name'      => $admin->name,
				'admin_logged_in' => TRUE
			));

			$this->Admin_model->update($admin->id, array('last_login' => date('Y-m-d H:i:s')));

			redirect('admin/dashboard');
		}

		// Login gagal: catat percobaan untuk rate limiting
		$this->Admin_model->recordFailedAttempt($ip);

		$this->session->set_flashdata('error', 'Username atau password salah.');
		redirect('admin/auth/login');
	}

	// Logout admin
	public function logout()
	{
		$this->session->unset_userdata(array('admin_id', 'admin_name', 'admin_logged_in'));
		$this->session->set_flashdata('message', 'Anda telah logout.');
		redirect('admin/auth/login');
	}
}
