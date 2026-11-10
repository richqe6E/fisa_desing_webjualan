<?php
defined('BASEPATH') OR exit('No direct script access allowed');

// --------------------------------------------------------------------
// Helper yStore: fungsi tampilan yang dipakai berulang di view
// --------------------------------------------------------------------

if ( ! function_exists('format_rupiah'))
{
	/**
	 * Format angka ke Rupiah, mis. 79000 -> "Rp 79.000"
	 */
	function format_rupiah($angka)
	{
		return 'Rp ' . number_format((float) $angka, 0, ',', '.');
	}
}

if ( ! function_exists('format_waktu'))
{
	/**
	 * Format waktu/tanggal ke gaya Indonesia, mis.
	 * "2026-10-13 14:05:00" -> "13 Okt 2026, 14:05".
	 * NULL/kosong dikembalikan sebagai $kosong.
	 */
	function format_waktu($datetime, $kosong = '&ndash;')
	{
		if ($datetime === NULL || $datetime === '')
		{
			return $kosong;
		}

		static $bulan = array(
			1 => 'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
			'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
		);

		$ts = strtotime((string) $datetime);
		if ($ts === FALSE)
		{
			return $kosong;
		}

		return sprintf(
			'%02d %s %04d, %02d:%02d',
			(int) date('j', $ts),
			$bulan[(int) date('n', $ts)],
			(int) date('Y', $ts),
			(int) date('G', $ts),
			(int) date('i', $ts)
		);
	}
}

if ( ! function_exists('active_nav'))
{
	/**
	 * Class Tailwind untuk link navigasi publik yang sedang aktif.
	 * Cocokkan uri_string() persis atau sebagai awalan path.
	 */
	function active_nav($page, $active = 'text-sky-600 font-semibold', $inactive = 'text-gray-600 hover:text-sky-600')
	{
		$uri = uri_string();

		if ($uri === $page || strpos($uri, $page . '/') === 0)
		{
			return $active;
		}

		return $inactive;
	}
}

if ( ! function_exists('active_admin'))
{
	/**
	 * Class untuk link navigasi admin yang sedang aktif
	 * (kelas .a-* dari assets/admin/admin.css).
	 * Membandingkan segment ke-2 URI (nama controller admin).
	 */
	function active_admin($controller, $active = 'a-nav-link is-active', $inactive = 'a-nav-link')
	{
		$CI =& get_instance();

		// Rute /admin dipetakan ke admin/dashboard, sehingga segment kosong = dashboard
		$segment = (string) $CI->uri->segment(2);
		if ($segment === '')
		{
			$segment = 'dashboard';
		}

		return ($segment === $controller) ? $active : $inactive;
	}
}

if ( ! function_exists('social_url'))
{
	/**
	 * Ubah isian kolom stores.instagram / stores.facebook jadi URL yang aman.
	 *
	 * - kosong                      -> '' (tautan disembunyikan)
	 * - diawali http(s)://          -> dipakai apa adanya
	 * - selain itu (mis. "@ystore") -> dianggap nama pengguna, dirakit ke
	 *                                  https://<domain>/<pengguna>
	 *
	 * Nilai selain http(s) sengaja tidak diteruskan mentah supaya isian admin
	 * tidak bisa menyisipkan skema berbahaya seperti javascript:.
	 */
	function social_url($value, $domain)
	{
		$value = trim((string) $value);

		if ($value === '')
		{
			return '';
		}

		if (preg_match('#^https?://#i', $value))
		{
			return $value;
		}

		$handle = ltrim($value, '@/');

		return preg_match('/^[A-Za-z0-9._-]+$/', $handle) ? 'https://' . $domain . '/' . $handle : '';
	}
}

if ( ! function_exists('meta_description'))
{
	/**
	 * Bersihkan teks untuk <meta name="description"> / og:description:
	 * buang tag HTML (deskripsi produk disimpan mentah), rapikan spasi,
	 * lalu potong pada batas kata paling dekat dengan $limit karakter.
	 */
	function meta_description($text, $limit = 160)
	{
		$text = trim(preg_replace('/\s+/u', ' ', strip_tags((string) $text)));

		if ($text === '' || mb_strlen($text) <= $limit)
		{
			return $text;
		}

		// Potong sedikit lebih panjang, lalu mundur ke spasi terakhir supaya
		// tidak ada kata yang terbelah.
		$cut   = mb_substr($text, 0, $limit + 1);
		$space = mb_strrpos($cut, ' ');

		$cut = ($space !== FALSE && $space >= (int) ($limit * 0.5)) ? mb_substr($cut, 0, $space) : mb_substr($cut, 0, $limit);

		return rtrim($cut, " \t\n\r\0\x0B.,;:-") . '…';
	}
}

if ( ! function_exists('upload_asset_url'))
{
	/**
	 * URL gambar unggahan:
	 * - Jika diawali http(s) -> dikembalikan apa adanya
	 * - Jika file ada di disk lokal (assets/uploads/...) -> gunakan base_url()
	 * - Jika Supabase Storage aktif -> gunakan URL public CDN Supabase
	 * - Fallback -> base_url lokal
	 */
	function upload_asset_url($fileName, $folder = 'products', $fallback = '')
	{
		$fileName = trim((string) $fileName);

		if ($fileName === '')
		{
			return $fallback !== '' ? base_url($fallback) : '';
		}

		if (preg_match('#^https?://#i', $fileName))
		{
			return $fileName;
		}

		$folderClean = trim($folder, '/');
		$localRel    = 'assets/uploads/' . $folderClean . '/' . $fileName;

		// 1. Cek disk lokal jika file ada (mis. seed bawaan yang ikut git)
		if (is_file(FCPATH . $localRel))
		{
			return base_url($localRel);
		}

		// 2. Cek Supabase Storage jika dikonfigurasi via env
		$supabaseUrl = getenv('SUPABASE_URL') ?: (isset($_ENV['SUPABASE_URL']) ? $_ENV['SUPABASE_URL'] : (isset($_SERVER['SUPABASE_URL']) ? $_SERVER['SUPABASE_URL'] : ''));
		if ( ! empty($supabaseUrl))
		{
			$bucket = getenv('SUPABASE_BUCKET') ?: (isset($_ENV['SUPABASE_BUCKET']) ? $_ENV['SUPABASE_BUCKET'] : (isset($_SERVER['SUPABASE_BUCKET']) ? $_SERVER['SUPABASE_BUCKET'] : 'uploads'));
			return rtrim($supabaseUrl, '/') . '/storage/v1/object/public/' . $bucket . '/' . $folderClean . '/' . rawurlencode($fileName);
		}

		return base_url($localRel);
	}
}

if ( ! function_exists('hero_image_url'))
{
	/**
	 * Ubah nilai kolom stores.hero_pill1 / hero_pill2 jadi URL gambar judul beranda.
	 * - '' (atau NULL)  -> '' (gambar disembunyikan)
	 * - diawali http(s) -> dipakai apa adanya (foto bawaan dari Unsplash)
	 * - selain itu      -> URL dari upload_asset_url (lokal atau Supabase Storage)
	 */
	function hero_image_url($value)
	{
		return upload_asset_url($value, 'hero');
	}
}

if ( ! function_exists('hero_line'))
{
	/**
	 * Render satu baris judul beranda ("Tampil [gambar] Kekinian").
	 *
	 * Teks admin dipecah pada penanda [gambar]; bila gambar tersedia, <img>
	 * disisipkan di posisi penanda, dan bila tidak, potongan teks disatukan
	 * dengan satu spasi supaya kalimatnya tetap utuh.
	 *
	 * Semua potongan teks di-escape (html_escape) — teks berasal dari input admin.
	 *
	 * @param string $text  Isi kolom hero_line1/hero_line2
	 * @param string $image Isi kolom hero_pill1/hero_pill2
	 * @param bool   $wide  TRUE untuk baris ke-2 (pil lebih lebar + jeda animasi)
	 * @return string HTML aman untuk disisipkan ke dalam <span class="line">
	 */
	function hero_line($text, $image = '', $wide = FALSE)
	{
		$parts = preg_split('/\[\s*gambar\s*\]/iu', trim((string) $text));
		$parts = array_values(array_filter(array_map('trim', $parts), fn ($p) => $p !== ''));

		$src = hero_image_url($image);

		// Tanpa penanda [gambar], atau gambar tidak dipilih -> teks biasa.
		if ($src === '' || count($parts) < 2)
		{
			return html_escape(implode(' ', $parts));
		}

		$tag = '<img width="' . ($wide ? 110 : 80) . '" height="44" class="pill'
			. ($wide ? ' wide' : '') . '" src="' . html_escape($src) . '" alt="">';

		$out = array();
		foreach ($parts as $i => $part)
		{
			if ($i > 0)
			{
				$out[] = $tag;
			}
			$out[] = html_escape($part);
		}

		return implode(' ', $out);
	}
}
