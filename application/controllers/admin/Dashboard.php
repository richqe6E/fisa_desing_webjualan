<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require_once APPPATH . 'core/Admin_Controller.php';

class Dashboard extends Admin_Controller {

	// Halaman utama admin: statistik, grafik 7 hari,
	// produk terbanyak dilihat
	public function index()
	{
		$this->load->model('Product_model');
		$this->load->model('Category_model');
		$this->load->model('Visitor_model');

		// Susun data 7 hari terakhir (hari tanpa kunjungan diisi 0)
		$last7 = $this->Visitor_model->last7Days();
		$chart = array();
		for ($i = 6; $i >= 0; $i--)
		{
			$day = date('Y-m-d', strtotime('-' . $i . ' days'));
			$chart[$day] = isset($last7[$day]) ? $last7[$day] : 0;
		}

		$data['title']          = 'Dashboard';
		$data['pageDesc']       = 'Ringkasan aktivitas toko dan kunjungan pengunjung.';
		$data['totalProducts']  = $this->Product_model->countAll();
		$data['totalCategories'] = $this->Category_model->countAll();
		$data['visitorsToday']  = $this->Visitor_model->countToday();
		$data['visitsTotal']    = $this->Visitor_model->countTotal();
		$data['chart']          = $chart;
		// Seragamkan label grafik: "13/10" per hari
		$data['chartLabels']    = array_map(function ($day) {
			return date('d/m', strtotime($day));
		}, array_keys($chart));
		$data['chartValues']    = array_values($chart);
		$data['topProducts']    = $this->Product_model->topViewed(5);

		$this->load->view('admin/templates/header', $data);
		$this->load->view('admin/dashboard', $data);
		$this->load->view('admin/dashboard_charts', $data);
		$this->load->view('admin/templates/footer', $data);
	}
}
