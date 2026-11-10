<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Category_model extends CI_Model {

	// Daftar kategori, diurutkan berdasarkan urutan lalu nama
	public function getCategories($activeOnly = TRUE)
	{
		$this->db->order_by('sort_order', 'ASC');
		$this->db->order_by('name', 'ASC');

		if ($activeOnly)
		{
			$this->db->where('is_active', 1);
		}

		return $this->db->get('categories')->result();
	}

	// Kategori aktif berdasarkan slug (untuk halaman publik)
	public function getCategoryBySlug($slug)
	{
		return $this->db->get_where('categories', array('slug' => $slug, 'is_active' => 1))->row();
	}

	// Kategori berdasarkan id (termasuk nonaktif, untuk admin)
	public function getCategoryById($id)
	{
		return $this->db->get_where('categories', array('id' => $id))->row();
	}

	public function countAll()
	{
		return $this->db->count_all('categories');
	}

	// Jumlah produk dalam kategori
	public function countProducts($categoryId)
	{
		return $this->db->where('category_id', (int) $categoryId)->count_all_results('products');
	}

	// Jumlah produk per kategori dalam satu query (untuk daftar admin)
	public function productCounts()
	{
		$rows = $this->db
			->select('category_id, COUNT(*) AS jml', FALSE)
			->group_by('category_id')
			->get('products')
			->result();

		$map = array();
		foreach ($rows as $row)
		{
			$map[(int) $row->category_id] = (int) $row->jml;
		}

		return $map;
	}

	public function insertCategory(array $data)
	{
		$this->db->insert('categories', $data);
		return $this->db->insert_id();
	}

	public function updateCategory($id, array $data)
	{
		return $this->db->where('id', (int) $id)->update('categories', $data);
	}

	public function deleteCategory($id)
	{
		return $this->db->where('id', (int) $id)->delete('categories');
	}

	// Cek apakah slug sudah dipakai kategori lain (kecuali id yang sedang diedit)
	public function slugExists($slug, $excludeId = NULL)
	{
		$this->db->where('slug', $slug);

		if ($excludeId !== NULL)
		{
			$this->db->where('id !=', (int) $excludeId);
		}

		return $this->db->count_all_results('categories') > 0;
	}
}
