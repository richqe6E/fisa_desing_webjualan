<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Visitor_model extends CI_Model {

	// Mencatat kunjungan halaman publik
	public function logVisit()
	{
		$userAgent = $this->input->user_agent();

		$this->db->insert('visitor_logs', array(
			'ip_address' => $this->input->ip_address(),
			'user_agent' => ($userAgent === FALSE) ? NULL : substr((string) $userAgent, 0, 255),
			'page_url'   => uri_string(),
			'visited_at' => date('Y-m-d H:i:s')
		));
	}

	public function countTotal()
	{
		return $this->db->count_all('visitor_logs');
	}

	// Pengunjung unik hari ini (berdasarkan IP unik sejak jam 00:00)
	public function countToday()
	{
		$row = $this->db->select('COUNT(DISTINCT ip_address) AS total', FALSE)
			->where('visited_at >=', date('Y-m-d 00:00:00'))
			->get('visitor_logs')
			->row();

		return $row ? (int) $row->total : 0;
	}

	/**
	 * Pengunjung unik 7 hari terakhir untuk grafik dashboard.
	 * Mengembalikan array: 'Y-m-d' => jumlah pengunjung unik.
	 */
	public function last7Days()
	{
		// FALSE pada select() agar fungsi SQL (DATE, COUNT) tidak di-escape
		$this->db->select('DATE(visited_at) AS visit_date, COUNT(DISTINCT ip_address) AS total', FALSE);
		$this->db->where('visited_at >=', date('Y-m-d 00:00:00', strtotime('-6 days')));
		$this->db->group_by('visit_date');

		$result = array();
		foreach ($this->db->get('visitor_logs')->result() as $row)
		{
			$result[$row->visit_date] = (int) $row->total;
		}

		return $result;
	}

	// Kunjungan terbaru untuk dashboard
	public function getRecent($limit = 10)
	{
		$this->db->order_by('visited_at', 'DESC');
		$this->db->limit((int) $limit);

		return $this->db->get('visitor_logs')->result();
	}
}
