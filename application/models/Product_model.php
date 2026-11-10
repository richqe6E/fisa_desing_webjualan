<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Product_model extends CI_Model {

	public function countAll()
	{
		return $this->db->count_all('products');
	}

	// Daftar produk aktif untuk toko (nama kategori ikut terambil).
	// $q   = pencarian (LIKE nama produk / nama kategori),
	// $urut = featured (terbaru) | price-asc | price-desc | name.
	public function getProducts($limit = NULL, $offset = 0, $categorySlug = NULL, $q = NULL, $urut = 'featured')
	{
		$this->db->select('products.*, categories.name AS category_name, categories.slug AS category_slug');
		$this->db->join('categories', 'categories.id = products.category_id', 'left');
		$this->db->where('products.is_active', 1);

		if ($categorySlug !== NULL && $categorySlug !== '')
		{
			$this->db->where('categories.slug', $categorySlug);
		}

		$this->filterQuery($q);
		$this->orderProducts($urut);

		if ($limit !== NULL)
		{
			$this->db->limit((int) $limit, (int) $offset);
		}

		return $this->db->get('products')->result();
	}

	public function countProducts($categorySlug = NULL, $q = NULL)
	{
		$this->db->join('categories', 'categories.id = products.category_id', 'left');
		$this->db->where('products.is_active', 1);

		if ($categorySlug !== NULL && $categorySlug !== '')
		{
			$this->db->where('categories.slug', $categorySlug);
		}

		$this->filterQuery($q);

		return $this->db->count_all_results('products');
	}

	// Klausa pencarian bersama getProducts()/countProducts() supaya total baris
	// (untuk pagination) selalu sama dengan daftar yang dirender.
	private function filterQuery($q)
	{
		$q = trim((string) $q);
		if ($q === '')
		{
			return;
		}

		$this->db->group_start();
		$this->db->like('products.name', $q);
		$this->db->or_like('categories.name', $q);
		$this->db->group_end();
	}

	// Urutan daftar sesuai kontrol "Urutkan"; id DESC jadi tiebreaker supaya
	// urutan baris stabil antar halaman (nilai sama tidak berpindah halaman).
	private function orderProducts($urut)
	{
		switch ($urut)
		{
			case 'price-asc':
				$this->db->order_by('products.price', 'ASC');
				break;
			case 'price-desc':
				$this->db->order_by('products.price', 'DESC');
				break;
			case 'name':
				$this->db->order_by('products.name', 'ASC');
				break;
			default: // 'featured' / terbaru — urutan bawaan katalog
				$this->db->order_by('products.created_at', 'DESC');
		}

		$this->db->order_by('products.id', 'DESC');
	}

	// Produk aktif berdasarkan slug (halaman detail toko)
	public function getProductBySlug($slug)
	{
		$this->db->select('products.*, categories.name AS category_name, categories.slug AS category_slug');
		$this->db->join('categories', 'categories.id = products.category_id', 'left');
		$this->db->where('products.slug', $slug);
		$this->db->where('products.is_active', 1);

		return $this->db->get('products')->row();
	}

	// Produk berdasarkan id tanpa filter status (untuk admin)
	public function getProductById($id)
	{
		$this->db->select('products.*, categories.name AS category_name');
		$this->db->join('categories', 'categories.id = products.category_id', 'left');
		$this->db->where('products.id', (int) $id);

		return $this->db->get('products')->row();
	}

	// Semua produk (termasuk nonaktif) untuk daftar admin
	public function getAllProducts()
	{
		$this->db->select('products.*, categories.name AS category_name');
		$this->db->join('categories', 'categories.id = products.category_id', 'left');
		$this->db->order_by('products.updated_at', 'DESC');

		return $this->db->get('products')->result();
	}

	// Produk terbaru untuk halaman beranda (dan pelengkap produk terkait).
	// $excludeIds dipakai halaman detail agar produk yang sedang dibuka /
	// sudah tampil sebagai terkait tidak muncul dua kali.
	public function getLatest($limit = 8, array $excludeIds = array())
	{
		$this->db->select('products.*, categories.name AS category_name, categories.slug AS category_slug');
		$this->db->join('categories', 'categories.id = products.category_id', 'left');
		$this->db->where('products.is_active', 1);

		if ( ! empty($excludeIds))
		{
			$this->db->where_not_in('products.id', array_map('intval', $excludeIds));
		}

		$this->db->order_by('products.created_at', 'DESC');
		$this->db->limit((int) $limit);

		return $this->db->get('products')->result();
	}

	// Produk aktif lain dalam kategori yang sama (untuk bagian "Produk Terkait").
	public function getRelated($categoryId, $excludeId = NULL, $limit = 4)
	{
		$this->db->select('products.*, categories.name AS category_name, categories.slug AS category_slug');
		$this->db->join('categories', 'categories.id = products.category_id', 'left');
		$this->db->where('products.is_active', 1);
		$this->db->where('products.category_id', (int) $categoryId);

		if ($excludeId !== NULL)
		{
			$this->db->where('products.id !=', (int) $excludeId);
		}

		$this->db->order_by('products.created_at', 'DESC');
		$this->db->order_by('products.id', 'DESC');
		$this->db->limit((int) $limit);

		return $this->db->get('products')->result();
	}

	// Produk paling banyak dilihat (dashboard admin)
	public function topViewed($limit = 5)
	{
		$this->db->select('products.*, categories.name AS category_name');
		$this->db->join('categories', 'categories.id = products.category_id', 'left');
		$this->db->where('products.is_active', 1);
		$this->db->order_by('products.views', 'DESC');
		$this->db->limit((int) $limit);

		return $this->db->get('products')->result();
	}

	// Total seluruh counter views produk (statistik beranda)
	public function sumViews()
	{
		return (int) $this->db->select_sum('views')->get('products')->row()->views;
	}

	// Gambar galeri suatu produk
	public function getImages($productId)
	{
		$this->db->where('product_id', (int) $productId);
		$this->db->order_by('sort_order', 'ASC');
		$this->db->order_by('id', 'ASC');

		return $this->db->get('product_images')->result();
	}

	/**
	 * Gambar galeri untuk banyak produk sekaligus, dalam satu query.
	 * Dipakai endpoint API supaya tidak terjadi N+1 (dulu satu query per produk).
	 * Mengembalikan array: product_id => array(row gambar berurut sort_order, id).
	 */
	public function getImagesForProducts(array $productIds)
	{
		$productIds = array_values(array_unique(array_map('intval', $productIds)));

		if (empty($productIds))
		{
			return array();
		}

		$this->db->where_in('product_id', $productIds);
		$this->db->order_by('sort_order', 'ASC');
		$this->db->order_by('id', 'ASC');

		$result = array();
		foreach ($this->db->get('product_images')->result() as $row)
		{
			$result[(int) $row->product_id][] = $row;
		}

		return $result;
	}

	// Tambah counter views (argumen FALSE = jangan escape ekspresi SQL)
	public function incrementViews($id)
	{
		$this->db->set('views', 'views + 1', FALSE);
		$this->db->where('id', (int) $id);
		$this->db->update('products');
	}

	public function insertProduct(array $data)
	{
		$this->db->insert('products', $data);
		return $this->db->insert_id();
	}

	public function updateProduct($id, array $data)
	{
		return $this->db->where('id', (int) $id)->update('products', $data);
	}

	public function deleteProduct($id)
	{
		return $this->db->where('id', (int) $id)->delete('products');
	}

	// Hapus satu gambar galeri; mengembalikan nama file yang dihapus (atau NULL)
	public function deleteImage($imageId)
	{
		$row = $this->db->get_where('product_images', array('id' => (int) $imageId))->row();

		if ($row === NULL)
		{
			return NULL;
		}

		$this->db->where('id', (int) $imageId)->delete('product_images');
		return $row->file_name;
	}

	// Cek apakah slug sudah dipakai produk lain (kecuali id yang sedang diedit)
	public function slugExists($slug, $excludeId = NULL)
	{
		$this->db->where('slug', $slug);

		if ($excludeId !== NULL)
		{
			$this->db->where('id !=', (int) $excludeId);
		}

		return $this->db->count_all_results('products') > 0;
	}
}
