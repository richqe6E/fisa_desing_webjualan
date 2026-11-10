<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Store_model extends CI_Model {

	// Profil toko (selalu baris dengan id = 1)
	public function getStore()
	{
		return $this->db->get_where('stores', array('id' => 1))->row();
	}

	public function updateStore(array $data)
	{
		return $this->db->where('id', 1)->update('stores', $data);
	}
}
