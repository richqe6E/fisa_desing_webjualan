<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Tampilan cadangan halaman 404 (dipakai CI_Exceptions untuk show_404()).
 *
 * Halaman 404 normal dirender memakai template situs lewat
 * MY_Controller::notFound() / controller Errors. Berkas ini hanya sebagai
 * jaring pengaman, jadi sengaja dibuat mandiri: tanpa helper, tanpa view lain,
 * dan bisa dipakai walau framework belum selesai memuat apa pun.
 */

// Alamat beranda: pakai base_url() bila helper URL sudah termuat.
if (function_exists('base_url'))
{
	$homeUrl = base_url();
}
else
{
	$script  = isset($_SERVER['SCRIPT_NAME']) ? (string) $_SERVER['SCRIPT_NAME'] : '/index.php';
	$dir     = rtrim(str_replace(basename($script), '', $script), '/');
	$scheme  = ( ! empty($_SERVER['HTTPS']) && strtolower($_SERVER['HTTPS']) !== 'off') ? 'https' : 'http';
	$host    = isset($_SERVER['HTTP_HOST']) ? (string) $_SERVER['HTTP_HOST'] : '';
	$homeUrl = $scheme . '://' . $host . $dir . '/';
}

// Nama toko: dari profil yang mungkin sudah dimuat controller, atau query langsung.
$storeName = '';

if (function_exists('get_instance'))
{
	$CI =& get_instance();

	if (isset($CI->store->name))
	{
		$storeName = (string) $CI->store->name;
	}
	elseif (isset($CI->db) && is_object($CI->db))
	{
		$row = $CI->db->select('name')->get_where('stores', array('id' => 1))->row();

		if ($row !== NULL)
		{
			$storeName = (string) $row->name;
		}
	}
}

if ($storeName === '')
{
	$storeName = 'yStore';
}
?><!DOCTYPE html>
<html lang="id">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="noindex, follow">
<title>404 &middot; Halaman tidak ditemukan &middot; <?php echo html_escape($storeName); ?></title>
<style>
	:root { color-scheme: light; }
	* { box-sizing: border-box; }
	body {
		margin: 0;
		min-height: 100vh;
		display: flex;
		align-items: center;
		justify-content: center;
		padding: 32px 20px;
		background: #f7f6f4;
		color: #1b1b1b;
		font: 16px/1.6 "Urbanist", "Segoe UI", system-ui, -apple-system, Arial, sans-serif;
	}
	.card { max-width: 520px; text-align: center; }
	.mark { width: 34px; height: 34px; color: #1b1b1b; }
	.brand { display: inline-flex; align-items: center; gap: 8px; font-size: 1.3rem; font-weight: 600; }
	h1 { font-size: 2rem; font-weight: 600; letter-spacing: -.02em; margin: 26px 0 12px; }
	p { color: #5f5f5f; margin: 0 auto 28px; max-width: 44ch; }
	.actions { display: flex; flex-wrap: wrap; gap: 12px; justify-content: center; }
	.btn {
		display: inline-block;
		background: #1b1b1b;
		color: #fff;
		text-decoration: none;
		border-radius: 99px;
		padding: 12px 22px;
		font-weight: 500;
	}
	.btn.ghost { background: transparent; color: #1b1b1b; border: 1px solid #d8d5d0; }
</style>
</head>
<body>
	<main class="card">
		<span class="brand"><svg class="mark" viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M12 0c1 6.5 5.5 11 12 12-6.5 1-11 5.5-12 12-1-6.5-5.5-11-12-12C6.5 11 11 6.5 12 0z"/></svg><?php echo html_escape($storeName); ?></span>
		<h1>404 &mdash; Halaman tidak ditemukan</h1>
		<p>Maaf, halaman yang kamu cari tidak ada atau sudah dipindahkan.</p>
		<div class="actions">
			<a class="btn" href="<?php echo html_escape($homeUrl); ?>">Ke Beranda</a>
			<a class="btn ghost" href="<?php echo html_escape(rtrim($homeUrl, '/') . '/produk'); ?>">Lihat Produk</a>
		</div>
	</main>
</body>
</html>
