<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require_once APPPATH . 'core/Admin_Controller.php';

class Users extends Admin_Controller {

	// Daftar akun admin (halaman "Pengguna")
	public function index()
	{
		$this->load->model('Admin_model');

		$data['title']        = 'Kelola Pengguna';
		$data['pageDesc']     = 'Akun administrator yang bisa masuk ke panel ini.';
		$data['pageActionUrl']  = base_url('admin/users/add');
		$data['pageActionLabel'] = 'Tambah Pengguna';
		$data['admins']       = $this->Admin_model->getAll();

		$this->load->view('admin/templates/header', $data);
		$this->load->view('admin/users/index', $data);
		$this->load->view('admin/templates/footer', $data);
	}

	// Form tambah admin
	public function add()
	{
		$this->load->model('Admin_model');
		$this->_form();
	}

	// Form edit admin
	public function edit($id = NULL)
	{
		$this->load->model('Admin_model');

		$admin = ($id !== NULL) ? $this->Admin_model->getById($id) : NULL;
		if ($admin === NULL)
		{
			show_404();
		}

		$this->_form($admin);
	}

	/**
	 * Validasi + simpan akun admin (dipakai add & edit).
	 * Password wajib saat tambah, opsional saat edit.
	 */
	private function _form($admin = NULL)
	{
		$isEdit = ($admin !== NULL);

		$this->form_validation->set_rules('name', 'Nama', 'required|max_length[100]');

		// is_unique CI3 hanya menerima "tabel.kolom" — suffix ",id,N" (sintaks CI4)
		// membuat error "Unknown column". Jadi cek unik hanya dipasang saat
		// username baru atau benar-benar diubah (saat edit, username sendiri dilewati).
		$usernameRule = 'required|max_length[100]|alpha_dash';
		$postedUsername = (string) $this->input->post('username');
		if ( ! $isEdit || ($postedUsername !== '' && $postedUsername !== $admin->username))
		{
			$usernameRule .= '|is_unique[admins.username]';
		}
		$this->form_validation->set_rules('username', 'Username', $usernameRule);

		$this->form_validation->set_rules('password', 'Password', $isEdit ? 'min_length[8]' : 'required|min_length[8]');

		if ($this->form_validation->run() === FALSE)
		{
			$data['title']         = $isEdit ? 'Edit Pengguna' : 'Tambah Pengguna';
			$data['pageDesc']      = $isEdit ? 'Perbarui data akun administrator.' : 'Buat akun administrator baru.';
			$data['pageActionUrl'] = base_url('admin/users');
			$data['pageActionLabel'] = 'Kembali';
			$data['pageActionIcon']  = 'bi-arrow-left';
			$data['admin']         = $admin;

			$this->load->view('admin/templates/header', $data);
			$this->load->view('admin/users/form', $data);
			$this->load->view('admin/templates/footer', $data);
			return;
		}

		$data = array(
			'name'     => $this->input->post('name'),
			'username' => $this->input->post('username')
		);

		// Hash password hanya jika diisi (edit tanpa password mempertahankan lama)
		if ($this->input->post('password') !== '')
		{
			$data['password'] = password_hash($this->input->post('password'), PASSWORD_DEFAULT);
		}

		if ($isEdit)
		{
			$this->Admin_model->update($admin->id, $data);
			$this->session->set_flashdata('message', 'Pengguna diperbarui.');
		}
		else
		{
			$this->Admin_model->insert($data);
			$this->session->set_flashdata('message', 'Pengguna ditambahkan.');
		}

		redirect('admin/users');
	}

	// Hapus akun admin; tidak bisa menghapus diri sendiri atau admin terakhir
	public function delete($id = NULL)
	{
		$this->load->model('Admin_model');

		$admin = ($id !== NULL) ? $this->Admin_model->getById($id) : NULL;
		if ($admin === NULL)
		{
			show_404();
		}

		if ((int) $admin->id === (int) $this->session->userdata('admin_id'))
		{
			$this->session->set_flashdata('error', 'Tidak dapat menghapus akun sendiri.');
		}
		elseif ($this->Admin_model->countAll() <= 1)
		{
			$this->session->set_flashdata('error', 'Tidak dapat menghapus admin terakhir.');
		}
		else
		{
			$this->Admin_model->delete($admin->id);
			$this->session->set_flashdata('message', 'Pengguna dihapus.');
		}

		redirect('admin/users');
	}
}
