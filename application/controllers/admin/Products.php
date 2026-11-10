<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require_once APPPATH . 'core/Admin_Controller.php';

class Products extends Admin_Controller {

	public function __construct()
	{
		parent::__construct();

		$this->load->model('Product_model');
		$this->load->model('Category_model');
	}

	// Daftar semua produk (termasuk nonaktif)
	public function index()
	{
		$data['title']        = 'Kelola Produk';
		$data['pageDesc']     = 'Semua produk di katalog toko, lengkap dengan harga dan stok.';
		$data['pageActionUrl']  = base_url('admin/products/add');
		$data['pageActionLabel'] = 'Tambah Produk';
		$data['products']     = $this->Product_model->getAllProducts();

		$this->load->view('admin/templates/header', $data);
		$this->load->view('admin/products/index', $data);
		$this->load->view('admin/templates/footer', $data);
	}

	// Form tambah produk
	public function add()
	{
		$this->_form();
	}

	// Form edit produk
	public function edit($id = NULL)
	{
		$product = ($id !== NULL) ? $this->Product_model->getProductById($id) : NULL;

		if ($product === NULL)
		{
			show_404();
		}

		$this->_form($product);
	}

	/**
	 * Validasi + simpan produk (dipakai add & edit).
	 * Handle upload cover, galeri multi, dan penghapusan
	 * gambar lama yang dicentang.
	 */
	private function _form($product = NULL)
	{
		$isEdit = ($product !== NULL);

		$this->form_validation->set_rules('name', 'Nama produk', 'required|max_length[255]');
		$this->form_validation->set_rules('category_id', 'Kategori', 'required|is_natural_no_zero');
		$this->form_validation->set_rules('price', 'Harga', 'required|numeric|greater_than[0]');
		$this->form_validation->set_rules('stock', 'Stok', 'required|integer|greater_than_equal_to[0]');
		$this->form_validation->set_rules('description', 'Deskripsi', 'trim');
		$this->form_validation->set_rules('slug', 'Slug', 'trim|max_length[255]|alpha_dash');

		if ($this->form_validation->run() === FALSE)
		{
			$data['title']         = $isEdit ? 'Edit Produk' : 'Tambah Produk';
			$data['pageDesc']      = $isEdit ? 'Perbarui detail produk.' : 'Isi detail produk baru untuk katalog toko.';
			$data['pageActionUrl'] = base_url('admin/products');
			$data['pageActionLabel'] = 'Kembali';
			$data['pageActionIcon']  = 'bi-arrow-left';
			$data['product']       = $product;
			$data['categories']    = $this->Category_model->getCategories(FALSE);
			$data['images']        = $isEdit ? $this->Product_model->getImages($product->id) : array();

			$this->load->view('admin/templates/header', $data);
			$this->load->view('admin/products/form', $data);
			$this->load->view('admin/templates/footer', $data);
			return;
		}

		// Slug: pakai input jika diisi, atau generate dari nama; pastikan unik
		$slug = trim((string) $this->input->post('slug'));
		if ($slug === '')
		{
			$slug = url_title(strtolower($this->input->post('name')), 'dash', TRUE);
		}
		$slug = $this->_uniqueSlug($slug, $isEdit ? $product->id : NULL);

		$data = array(
			'name'        => $this->input->post('name'),
			'category_id' => (int) $this->input->post('category_id'),
			'slug'        => $slug,
			'description' => $this->input->post('description'),
			'price'       => (float) $this->input->post('price'),
			'stock'       => (int) $this->input->post('stock'),
			'is_active'   => ($this->input->post('is_active') === '1') ? 1 : 0
		);

		// Upload cover baru menggantikan cover lama
		$cover = $this->doUpload('image');
		if ($cover !== NULL)
		{
			$data['image'] = $cover;
			if ($isEdit)
			{
				$this->deleteUpload($product->image);
			}
		}

		if ($isEdit)
		{
			$this->Product_model->updateProduct($product->id, $data);
			$productId = $product->id;
			$this->session->set_flashdata('message', 'Produk diperbarui.');
		}
		else
		{
			$productId = $this->Product_model->insertProduct($data);
			$this->session->set_flashdata('message', 'Produk ditambahkan.');
		}

		// Hapus gambar galeri yang dicentang (hanya saat edit)
		if ($isEdit)
		{
			$deleteImages = $this->input->post('delete_images');
			if (is_array($deleteImages))
			{
				foreach ($deleteImages as $imageId)
				{
					$fileName = $this->Product_model->deleteImage($imageId);
					if ($fileName !== NULL)
					{
						$this->deleteUpload($fileName);
					}
				}
			}
		}

		// Upload gambar galeri tambahan (multi file)
		$this->_uploadGallery($productId);

		redirect('admin/products');
	}

	// Hapus produk beserta semua file gambarnya
	public function delete($id = NULL)
	{
		$product = ($id !== NULL) ? $this->Product_model->getProductById($id) : NULL;

		if ($product === NULL)
		{
			show_404();
		}

		$this->deleteUpload($product->image);
		foreach ($this->Product_model->getImages($product->id) as $img)
		{
			$this->deleteUpload($img->file_name);
		}

		// Baris product_images ikut terhapus otomatis (ON DELETE CASCADE)
		$this->Product_model->deleteProduct($product->id);
		$this->session->set_flashdata('message', 'Produk dihapus.');

		redirect('admin/products');
	}

	/**
	 * Upload beberapa file gambar sekaligus (input name="images[]").
	 * Upload library memproses satu file per kali, sehingga $_FILES
	 * disusun ulang per iterasi.
	 */
	private function _uploadGallery($productId)
	{
		if (empty($_FILES['images']['name']) || ! is_array($_FILES['images']['name']))
		{
			return;
		}

		$count = count($_FILES['images']['name']);
		for ($i = 0; $i < $count; $i++)
		{
			// Lewati kolom kosong
			if (empty($_FILES['images']['name'][$i]))
			{
				continue;
			}

			$_FILES['image'] = array(
				'name'     => $_FILES['images']['name'][$i],
				'type'     => $_FILES['images']['type'][$i],
				'tmp_name' => $_FILES['images']['tmp_name'][$i],
				'error'    => $_FILES['images']['error'][$i],
				'size'     => $_FILES['images']['size'][$i]
			);

			$fileName = $this->doUpload('image');
			if ($fileName !== NULL)
			{
				$this->db->insert('product_images', array(
					'product_id' => $productId,
					'file_name'  => $fileName
				));
			}
		}
	}

	// Pastikan slug unik: tambahkan akhiran -2, -3, ... jika sudah dipakai
	private function _uniqueSlug($slug, $excludeId = NULL)
	{
		$base = $slug;
		$suffix = 1;

		while ($this->Product_model->slugExists($slug, $excludeId))
		{
			$slug = $base . '-' . (++$suffix);
		}

		return $slug;
	}
}
