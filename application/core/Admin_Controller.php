<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Base controller untuk semua halaman admin.
 *
 * CATATAN: CI3 hanya auto-load MY_Controller.php dari application/core/,
 * jadi setiap controller admin WAJIB memuat file ini lebih dulu:
 *   require_once APPPATH . 'core/Admin_Controller.php';
 */
class Admin_Controller extends CI_Controller {

	/** @var object|null Profil toko untuk layout admin */
	public $store;

	public function __construct()
	{
		parent::__construct();

		// Proteksi: halaman admin hanya untuk admin yang sudah login
		if ( ! $this->session->userdata('admin_logged_in'))
		{
			redirect('admin/auth/login');
		}

		$this->load->model('Store_model');
		$this->store = $this->Store_model->getStore();

		$this->load->library('upload');
	}

	/**
	 * Upload satu file gambar (cover produk / logo toko).
	 * Mengembalikan nama file hasil upload, atau NULL jika
	 * tidak ada file / upload gagal (pesan error via flashdata).
	 */
	protected function doUpload($field, $folder = 'products')
	{
		if ( ! isset($_FILES[$field]) || ! is_uploaded_file($_FILES[$field]['tmp_name']))
		{
			return NULL;
		}

		$folderClean = trim($folder, '/');
		$targetDir   = FCPATH . 'assets/uploads/' . $folderClean . '/';
		$isWritable  = is_dir($targetDir) && is_writable($targetDir);

		// Jika di Vercel/serverless (folder assets tidak writable), fallback ke folder temp sistem
		$uploadPath = $isWritable ? $targetDir : (rtrim(sys_get_temp_dir(), DIRECTORY_SEPARATOR) . DIRECTORY_SEPARATOR);

		$config['upload_path']   = $uploadPath;
		$config['allowed_types'] = 'gif|jpg|jpeg|png|webp';
		$config['max_size']      = 2048; // KB
		$config['encrypt_name']  = TRUE;

		$this->upload->initialize($config);

		if ( ! $this->upload->do_upload($field))
		{
			$this->session->set_flashdata('error', 'Gagal upload gambar: ' . strip_tags($this->upload->display_errors('', '')));
			return NULL;
		}

		$uploadData = $this->upload->data();
		$fileName   = $uploadData['file_name'];
		$localFile  = $uploadPath . $fileName;

		// Jika Supabase Storage aktif, kirim file ke cloud
		$cfg = $this->getSupabaseConfig();

		if ($cfg !== NULL)
		{
			$uploaded = $this->pushToSupabaseStorage($localFile, $fileName, $folderClean, $cfg['url'], $cfg['key'], $cfg['bucket'], $uploadData['file_type']);

			// Jika di serverless/Vercel, hapus file lokal temp setelah terkirim ke Supabase
			if ( ! $isWritable && is_file($localFile))
			{
				@unlink($localFile);
			}

			if ( ! $uploaded)
			{
				return NULL;
			}
		}

		return $fileName;
	}

	/**
	 * Ambil environment variable dengan pembersihan whitespace, newline, dan tanda kutip.
	 */
	protected function getCleanEnv($key, $default = '')
	{
		$val = getenv($key);
		if ($val === FALSE || $val === '')
		{
			$val = isset($_ENV[$key]) ? $_ENV[$key] : (isset($_SERVER[$key]) ? $_SERVER[$key] : $default);
		}
		$val = (string) $val;
		return trim($val, "\"' \t\n\r\0\x0B");
	}

	/**
	 * Ambil konfigurasi Supabase Storage yang sudah dinormalisasi dan divalidasi.
	 */
	protected function getSupabaseConfig()
	{
		$url    = $this->getCleanEnv('SUPABASE_URL');
		$key    = $this->getCleanEnv('SUPABASE_KEY');
		$bucket = $this->getCleanEnv('SUPABASE_BUCKET', 'uploads');

		if ($url === '' || $key === '')
		{
			return NULL;
		}

		// Jika pengguna memasukkan URL pooler/database alih-alih URL project REST
		if (strpos($url, 'pooler.supabase.com') !== FALSE || strpos($url, 'postgres://') !== FALSE)
		{
			if (preg_match('/([a-z0-9]{20})/', $url, $m))
			{
				$url = 'https://' . $m[1] . '.supabase.co';
			}
		}

		// Pastikan skema http:// atau https:// ada
		if ( ! preg_match('#^https?://#i', $url))
		{
			$url = 'https://' . $url;
		}

		// Buang spasi dan karakter newline di dalam URL
		$url = str_replace(array(' ', "\r", "\n", "\t"), '', $url);
		$url = rtrim($url, '/');

		// Bersihkan nama bucket dari karakter liar
		$bucket = trim(preg_replace('/[^a-zA-Z0-9_-]/', '', $bucket));
		if ($bucket === '')
		{
			$bucket = 'uploads';
		}

		return array(
			'url'    => $url,
			'key'    => $key,
			'bucket' => $bucket
		);
	}

	/**
	 * Kirim file ke Supabase Storage via REST API (mendukung curl dan stream context).
	 */
	protected function pushToSupabaseStorage($filePath, $fileName, $folder, $supabaseUrl, $supabaseKey, $bucket, $mimeType)
	{
		$folderClean = trim($folder, '/');
		$pathPrefix  = ($folderClean !== '') ? ($folderClean . '/') : '';
		$url         = rtrim($supabaseUrl, '/') . '/storage/v1/object/' . $bucket . '/' . $pathPrefix . rawurlencode($fileName);

		$fileData = @file_get_contents($filePath);
		if ($fileData === FALSE)
		{
			$this->session->set_flashdata('error', 'Gagal membaca file gambar untuk dikirim ke cloud storage.');
			return FALSE;
		}

		$headers = array(
			'Authorization: Bearer ' . $supabaseKey,
			'apikey: ' . $supabaseKey,
			'Content-Type: ' . ($mimeType ? $mimeType : 'application/octet-stream'),
			'x-upsert: true'
		);

		if (function_exists('curl_init'))
		{
			$ch = curl_init();
			curl_setopt($ch, CURLOPT_URL, $url);
			curl_setopt($ch, CURLOPT_POST, TRUE);
			curl_setopt($ch, CURLOPT_POSTFIELDS, $fileData);
			curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
			curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
			curl_setopt($ch, CURLOPT_TIMEOUT, 30);
			$response = curl_exec($ch);
			$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
			$curlErr  = curl_error($ch);
			curl_close($ch);

			if ($httpCode >= 200 && $httpCode < 300)
			{
				return TRUE;
			}

			// Berikan pesan ramah jika bucket belum ada atau RLS belum disetel
			$msg = 'Supabase Storage error (HTTP ' . $httpCode . '): ' . $response;
			if ($httpCode === 404 && strpos($response, 'Bucket not found') !== FALSE)
			{
				$msg = "Bucket '{$bucket}' belum dibuat di Supabase Storage. Silakan buat bucket '{$bucket}' atau jalankan SQL perizinan storage.";
			}
			elseif ($httpCode === 403 || strpos($response, 'row-level security') !== FALSE)
			{
				$msg = "Izin upload Supabase ditolak (RLS). Pastikan policy INSERT pada storage.objects untuk bucket '{$bucket}' sudah aktif.";
			}
			elseif ($curlErr)
			{
				$msg .= ' (' . $curlErr . ')';
			}

			$this->session->set_flashdata('error', $msg);
			return FALSE;
		}

		$options = array(
			'http' => array(
				'method'        => 'POST',
				'header'        => implode("\r\n", $headers) . "\r\n",
				'content'       => $fileData,
				'timeout'       => 30,
				'ignore_errors' => TRUE
			)
		);
		$context  = stream_context_create($options);
		$response = @file_get_contents($url, FALSE, $context);

		if (isset($http_response_header) && preg_match('#HTTP/\S+\s+2\d\d#', $http_response_header[0]))
		{
			return TRUE;
		}

		$this->session->set_flashdata('error', 'Gagal upload ke Supabase Storage via HTTP stream.');
		return FALSE;
	}

	/**
	 * Hapus file gambar hasil upload dari disk lokal dan/atau Supabase Storage.
	 */
	protected function deleteUpload($fileName, $folder = 'products')
	{
		if ($fileName === NULL || $fileName === '')
		{
			return;
		}

		$folderClean = trim($folder, '/');
		$pathPrefix  = ($folderClean !== '') ? ($folderClean . '/') : '';

		// 1. Hapus dari disk lokal jika file ada
		$path = FCPATH . 'assets/uploads/' . $folderClean . '/' . $fileName;
		if (is_file($path))
		{
			@unlink($path);
		}

		// 2. Hapus dari Supabase Storage jika dikonfigurasi
		$cfg = $this->getSupabaseConfig();
		if ($cfg !== NULL)
		{
			$url = $cfg['url'] . '/storage/v1/object/' . $cfg['bucket'] . '/' . $pathPrefix . rawurlencode($fileName);

			$headers = array(
				'Authorization: Bearer ' . $cfg['key'],
				'apikey: ' . $cfg['key']
			);

			if (function_exists('curl_init'))
			{
				$ch = curl_init();
				curl_setopt($ch, CURLOPT_URL, $url);
				curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'DELETE');
				curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
				curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
				curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
				curl_setopt($ch, CURLOPT_TIMEOUT, 15);
				curl_exec($ch);
				curl_close($ch);
			}
		}
	}
}
