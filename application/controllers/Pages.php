<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Halaman statis: Syarat & Ketentuan dan Kebijakan Privasi.
 *
 * Isi halaman ada di application/views/pages/terms.php & privacy.php.
 * Teksnya bersifat umum (draf) — sesuaikan dengan kebijakan toko sebenarnya.
 */
class Pages extends MY_Controller {

	/** Tanggal berlaku draf ini; perbarui bila isi halaman legal diubah. */
	private $updated = '14 Oktober 2026';

	// /syarat-ketentuan
	public function terms()
	{
		$this->render(
			'pages/terms',
			'Syarat & Ketentuan',
			'Syarat dan ketentuan pemesanan, pembayaran, pengiriman, dan pengembalian produk di toko online ini.'
		);
	}

	// /kebijakan-privasi
	public function privacy()
	{
		$this->render(
			'pages/privacy',
			'Kebijakan Privasi',
			'Penjelasan data yang kami kumpulkan, cara pemakaiannya, dan pilihan yang tersedia untuk pelanggan.'
		);
	}

	// Render halaman dengan template situs (header + footer)
	private function render($view, $title, $description)
	{
		$data['title']       = $title;
		$data['description'] = meta_description($description);
		$data['updated']     = $this->updated;

		$this->load->view('templates/header', $data);
		$this->load->view($view, $data);
		$this->load->view('templates/footer', $data);
	}
}
