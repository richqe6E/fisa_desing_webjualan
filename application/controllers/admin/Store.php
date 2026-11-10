<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require_once APPPATH . 'core/Admin_Controller.php';

class Store extends Admin_Controller {

	/**
	 * Form kelola data toko (profil tampil di beranda,
	 * halaman tentang kami, dan checkout WhatsApp).
	 */
	public function index()
	{
		$store = $this->Store_model->getStore();

		$this->form_validation->set_rules('name', 'Nama toko', 'required|max_length[100]');
		$this->form_validation->set_rules('tagline', 'Tagline', 'max_length[255]');
		$this->form_validation->set_rules('phone', 'Telepon', 'max_length[30]');
		$this->form_validation->set_rules('whatsapp', 'WhatsApp', 'max_length[30]');
		$this->form_validation->set_rules('address', 'Alamat', 'trim');
		$this->form_validation->set_rules('about', 'Tentang', 'trim');
		$this->form_validation->set_rules('hero_line1', 'Judul baris 1', 'trim|max_length[255]');
		$this->form_validation->set_rules('hero_line2', 'Judul baris 2', 'trim|max_length[255]');
		// Sosmed: boleh kosong, boleh URL penuh atau nama pengguna (mis. @ystore)
		$this->form_validation->set_rules('instagram', 'Instagram', 'trim|max_length[255]');
		$this->form_validation->set_rules('facebook', 'Facebook', 'trim|max_length[255]');

		if ($this->form_validation->run() === FALSE)
		{
			$data['title']     = 'Kelola Toko';
			$data['pageDesc']  = 'Data toko ditampilkan di halaman beranda, tentang kami, dan checkout WhatsApp.';
			$data['store']     = $store;

			$this->load->view('admin/templates/header', $data);
			$this->load->view('admin/store/form', $data);
			$this->load->view('admin/templates/footer', $data);
			return;
		}

		$data = array(
			'name'     => $this->input->post('name'),
			'tagline'  => $this->input->post('tagline'),
			'address'  => $this->input->post('address'),
			'phone'    => $this->input->post('phone'),
			// WhatsApp disimpan sebagai angka saja (format wa.me)
			'whatsapp' => preg_replace('/[^0-9]/', '', (string) $this->input->post('whatsapp')),
			// Sosmed: kosong = tautan di footer disembunyikan
			'instagram' => trim((string) $this->input->post('instagram')),
			'facebook'  => trim((string) $this->input->post('facebook')),
			'about'    => $this->input->post('about')
		);

		// Upload logo baru menggantikan logo lama
		$logo = $this->doUpload('logo', 'logos');
		if ($logo !== NULL)
		{
			$data['logo'] = $logo;
			$this->deleteUpload($store->logo, 'logos');
		}

		// Judul beranda: 2 baris teks (penanda [gambar]) + 2 gambar pill
		$data['hero_line1'] = $this->input->post('hero_line1');
		$data['hero_line2'] = $this->input->post('hero_line2');
		$data['hero_pill1'] = $this->heroImage('hero_pill1', $store->hero_pill1 ?? NULL);
		$data['hero_pill2'] = $this->heroImage('hero_pill2', $store->hero_pill2 ?? NULL);

		$this->Store_model->updateStore($data);
		$this->session->set_flashdata('message', 'Data toko diperbarui.');

		redirect('admin/store');
	}

	/**
	 * Proses satu gambar judul beranda:
	 * - upload baru  -> nama file baru (file lama dihapus dari disk)
	 * - centang hapus-> '' (gambar disembunyikan, file lama dihapus)
	 * - selain itu   -> nilai lama tidak diubah
	 *
	 * Nilai berupa URL http(s) (foto bawaan) tidak pernah dihapus dari disk.
	 */
	private function heroImage($field, $current)
	{
		$current = (string) $current;

		$fileName = $this->doUpload($field, 'hero');
		if ($fileName !== NULL)
		{
			$this->deleteHeroFile($current);
			return $fileName;
		}

		if ($this->input->post($field . '_clear') !== NULL)
		{
			$this->deleteHeroFile($current);
			return '';
		}

		return $current;
	}

	/**
	 * Hapus file gambar judul dari disk, kecuali bila nilainya URL eksternal.
	 */
	private function deleteHeroFile($fileName)
	{
		if ($fileName === '' || preg_match('#^https?://#i', $fileName))
		{
			return;
		}

		$this->deleteUpload($fileName, 'hero');
	}
}
