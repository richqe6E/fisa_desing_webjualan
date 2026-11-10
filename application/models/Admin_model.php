<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Admin_model extends CI_Model {

	public function getAll()
	{
		$this->db->order_by('name', 'ASC');
		return $this->db->get('admins')->result();
	}

	public function countAll()
	{
		return $this->db->count_all('admins');
	}

	public function getById($id)
	{
		return $this->db->get_where('admins', array('id' => (int) $id))->row();
	}

	public function getByUsername($username)
	{
		return $this->db->get_where('admins', array('username' => $username))->row();
	}

	public function insert(array $data)
	{
		$this->db->insert('admins', $data);
		return $this->db->insert_id();
	}

	public function update($id, array $data)
	{
		return $this->db->where('id', (int) $id)->update('admins', $data);
	}

	public function delete($id)
	{
		return $this->db->where('id', (int) $id)->delete('admins');
	}

	// ----------------------------------------------------------------
	// Rate limiting login: hitung percobaan gagal dari sebuah IP
	// dalam N menit terakhir (dipakai oleh controller Auth)
	// ----------------------------------------------------------------

	public function countFailedAttempts($ip, $minutes = 15)
	{
		$this->db->where('ip_address', $ip);
		$this->db->where('attempted_at >=', date('Y-m-d H:i:s', time() - (int) $minutes * 60));

		return $this->db->count_all_results('login_attempts');
	}

	public function recordFailedAttempt($ip)
	{
		$this->db->insert('login_attempts', array(
			'ip_address'  => $ip,
			'attempted_at' => date('Y-m-d H:i:s')
		));
	}

	public function clearFailedAttempts($ip)
	{
		$this->db->where('ip_address', $ip)->delete('login_attempts');
	}

	// Bersihkan catatan gagal lama agar tabel tetap kecil
	public function purgeOldAttempts($minutes = 60)
	{
		$this->db->where('attempted_at <', date('Y-m-d H:i:s', time() - (int) $minutes * 60))->delete('login_attempts');
	}
}
