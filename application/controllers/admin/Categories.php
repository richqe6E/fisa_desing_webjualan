<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require_once APPPATH . 'core/Admin_Controller.php';

class Categories extends Admin_Controller {

	public function __construct()
	{
		parent::__construct();

		$this->load->model('Category_model');
	}

	// Daftar kategori (termasuk nonaktif)
	public function index()
	{
		$data['title']        = 'Kelola Kategori';
		$data['pageDesc']     = 'Kelompokkan produk agar mudah ditemukan pembeli.';
		$data['pageActionUrl']  = base_url('admin/categories/add');
		$data['pageActionLabel'] = 'Tambah Kategori';
		$data['categories']   = $this->Category_model->getCategories(FALSE);
		// Satu query untuk semua jumlah produk (hindari N+1 di view)
		$data['productCounts'] = $this->Category_model->productCounts();

		$this->load->view('admin/templates/header', $data);
		$this->load->view('admin/categories/index', $data);
		$this->load->view('admin/templates/footer', $data);
	}

	// Form tambah kategori
	public function add()
	{
		$this->_form();
	}

	// Form edit kategori
	public function edit($id = NULL)
	{
		$category = ($id !== NULL) ? $this->Category_model->getCategoryById($id) : NULL;

		if ($category === NULL)
		{
			show_404();
		}

		$this->_form($category);
	}

	/**
	 * Validasi + simpan kategori (dipakai add & edit).
	 */
	private function _form($category = NULL)
	{
		$isEdit = ($category !== NULL);

		$this->form_validation->set_rules('name', 'Nama kategori', 'required|max_length[100]');
		$this->form_validation->set_rules('slug', 'Slug', 'trim|max_length[100]|alpha_dash');
		$this->form_validation->set_rules('sort_order', 'Urutan', 'integer');
		$this->form_validation->set_rules('description', 'Deskripsi', 'trim');

		if ($this->form_validation->run() === FALSE)
		{
			$data['title']         = $isEdit ? 'Edit Kategori' : 'Tambah Kategori';
			$data['pageDesc']      = $isEdit ? 'Perbarui detail kategori.' : 'Tambahkan kategori baru untuk mengelompokkan produk.';
			$data['pageActionUrl'] = base_url('admin/categories');
			$data['pageActionLabel'] = 'Kembali';
			$data['pageActionIcon']  = 'bi-arrow-left';
			$data['category']      = $category;

			$this->load->view('admin/templates/header', $data);
			$this->load->view('admin/categories/form', $data);
			$this->load->view('admin/templates/footer', $data);
			return;
		}

		// Slug: pakai input jika diisi, atau generate dari nama
		$slug = trim((string) $this->input->post('slug'));
		if ($slug === '')
		{
			$slug = url_title(strtolower($this->input->post('name')), 'dash', TRUE);
		}

		// Slug harus unik (kecuali milik kategori yang sedang diedit)
		if ($this->Category_model->slugExists($slug, $isEdit ? $category->id : NULL))
		{
			$this->session->set_flashdata('error', 'Slug "' . $slug . '" sudah digunakan kategori lain.');
			redirect($isEdit ? 'admin/categories/edit/' . $category->id : 'admin/categories/add');
		}

		$data = array(
			'name'        => $this->input->post('name'),
			'slug'        => $slug,
			'description' => $this->input->post('description'),
			'sort_order'  => (int) $this->input->post('sort_order'),
			'is_active'   => ($this->input->post('is_active') === '1') ? 1 : 0
		);

		if ($isEdit)
		{
			$this->Category_model->updateCategory($category->id, $data);
			$this->session->set_flashdata('message', 'Kategori diperbarui.');
		}
		else
		{
			$this->Category_model->insertCategory($data);
			$this->session->set_flashdata('message', 'Kategori ditambahkan.');
		}

		redirect('admin/categories');
	}

	// Hapus kategori; ditolak jika masih dipakai produk (FK RESTRICT)
	public function delete($id = NULL)
	{
		$category = ($id !== NULL) ? $this->Category_model->getCategoryById($id) : NULL;

		if ($category === NULL)
		{
			show_404();
		}

		$count = $this->Category_model->countProducts($category->id);
		if ($count > 0)
		{
			$this->session->set_flashdata('error', 'Kategori tidak dapat dihapus karena masih memiliki ' . $count . ' produk.');
		}
		else
		{
			$this->Category_model->deleteCategory($category->id);
			$this->session->set_flashdata('message', 'Kategori dihapus.');
		}

		redirect('admin/categories');
	}
}
