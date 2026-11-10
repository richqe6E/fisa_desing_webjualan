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

	// Kunjungan hari ini (sejak jam 00:00)
	public function countToday()
	{
		$this->db->where('visited_at >=', date('Y-m-d 00:00:00'));
		return $this->db->count_all_results('visitor_logs');
	}

	/**
	 * Kunjungan 7 hari terakhir untuk grafik dashboard.
	 * Mengembalikan array: 'Y-m-d' => jumlah kunjungan.
	 */
	public function last7Days()
	{
		// FALSE pada select() agar fungsi SQL (DATE, COUNT) tidak di-escape
		$this->db->select('DATE(visited_at) AS visit_date, COUNT(*) AS total', FALSE);
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
