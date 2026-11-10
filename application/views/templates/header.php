<?php defined('BASEPATH') OR exit('No direct script access allowed');

$storeName = $this->store->name ?? 'yStore';
$waNumber  = preg_replace('/[^0-9]/', '', (string) ($this->store->whatsapp ?? ''));
$current   = uri_string();
$navAttr   = function ($page) use ($current) {
	return ($current === $page || strpos($current, $page . '/') === 0) ? ' aria-current="page"' : '';
};

// --- Metadata SEO -----------------------------------------------------------
// Deskripsi: dari controller ($description), kalau kosong pakai tagline toko,
// lalu deskripsi toko. Semua nilai di-escape saat ditampilkan di bawah.
$pageDesc = trim((string) (isset($description) ? $description : ''));
if ($pageDesc === '')
{
	$pageDesc = trim((string) ($this->store->tagline ?? ''));
}
if ($pageDesc === '')
{
	$pageDesc = trim((string) ($this->store->about ?? ''));
}

// Gambar pratinjau (Open Graph): dari controller, lalu logo toko, lalu
// gambar judul beranda. hero_image_url() sudah menangani URL eksternal.
$ogImage = trim((string) (isset($og_image) ? $og_image : ''));
if ($ogImage === '' && ! empty($this->store->logo))
{
	$ogImage = upload_asset_url($this->store->logo, 'logos');
}
if ($ogImage === '')
{
	$ogImage = hero_image_url($this->store->hero_pill1 ?? '');
}

$ogType   = isset($og_type) ? $og_type : 'website';
$pageTitle = isset($title) ? $title . ' · ' . $storeName : $storeName;
// uri_string() tanpa query string supaya halaman filter (?kategori=…) tidak
// menghasilkan URL kanonik yang berbeda-beda.
$canonical = base_url(uri_string());

// Favicon: logo toko bila ada, kalau tidak pakai tanda bintang (SVG inline).
if ( ! empty($this->store->logo))
{
	$favicon     = upload_asset_url($this->store->logo, 'logos');
	$logoExt     = strtolower(pathinfo($this->store->logo, PATHINFO_EXTENSION));
	$faviconType = ($logoExt === 'png') ? 'image/png' : (($logoExt === 'gif') ? 'image/gif' : 'image/jpeg');
}
else
{
	$favicon     = 'data:image/svg+xml;utf8,' . rawurlencode('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path fill="#1b1b1b" d="M12 0c1 6.5 5.5 11 12 12-6.5 1-11 5.5-12 12-1-6.5-5.5-11-12-12C6.5 11 11 6.5 12 0z"/></svg>');
	$faviconType = 'image/svg+xml';
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title><?php echo isset($title) ? html_escape($title) . ' &middot; ' : ''; echo html_escape($storeName); ?></title>
<?php if ($pageDesc !== ''): ?>
	<meta name="description" content="<?php echo html_escape($pageDesc); ?>">
<?php endif; ?>
	<link rel="canonical" href="<?php echo html_escape($canonical); ?>">
<?php if ( ! empty($noindex)): ?>
	<meta name="robots" content="noindex, follow">
<?php endif; ?>
	<link rel="icon" type="<?php echo html_escape($faviconType); ?>" href="<?php echo html_escape($favicon); ?>">

	<meta property="og:type" content="<?php echo html_escape($ogType); ?>">
	<meta property="og:site_name" content="<?php echo html_escape($storeName); ?>">
	<meta property="og:locale" content="id_ID">
	<meta property="og:title" content="<?php echo html_escape($pageTitle); ?>">
<?php if ($pageDesc !== ''): ?>
	<meta property="og:description" content="<?php echo html_escape($pageDesc); ?>">
<?php endif; ?>
	<meta property="og:url" content="<?php echo html_escape($canonical); ?>">
<?php if ($ogImage !== ''): ?>
	<meta property="og:image" content="<?php echo html_escape($ogImage); ?>">
	<meta name="twitter:card" content="summary_large_image">
<?php endif; ?>
	<script>document.documentElement.classList.add("js")</script>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link href="https://fonts.googleapis.com/css2?family=Urbanist:wght@400;500;600;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" onerror="document.documentElement.classList.add('no-icons')">
	<link rel="stylesheet" href="<?php echo base_url('assets/template/style.css'); ?>">
	<script>
	window.ystore = <?php echo json_encode(array(
		'baseUrl'  => base_url(),
		'name'     => $storeName,
		'whatsapp' => $waNumber,
		'api'      => base_url('api/produk'),
		// Konfigurasi grid halaman (hanya beranda & /produk): paged = pagination
		// server, perPage = 0 berarti tanpa batas, page sudah di-clamp
		// controller. Halaman lain tidak mengeset $grid → key ini null.
		'grid'     => isset($grid) ? $grid : NULL,
		// Halaman detail: endpoint satu produk (+ terkait) supaya tidak
		// mengunduh seluruh katalog. Halaman lain: null.
		'detail'   => isset($detail) ? $detail : NULL,
	), JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE); ?>;
	</script>
</head>
<body>
<header class="site-header" id="siteHeader"><div class="nav container">
	<a href="<?php echo base_url(); ?>" class="logo">
<?php if ( ! empty($this->store->logo)): ?>
		<img class="logo-img" src="<?php echo upload_asset_url($this->store->logo, 'logos'); ?>" alt="<?php echo html_escape($storeName); ?>" width="26" height="26"><?php echo html_escape($storeName); ?>
<?php else: ?>
		<svg class="logo-mark" viewBox="0 0 24 24" width="26" height="26" fill="currentColor"><path d="M12 0c1 6.5 5.500 11 12 12-6.500 1-11 5.500-12 12-1-6.500-5.500-11-12-12C6.500 11 11 6.500 12 0z"/></svg><?php echo html_escape($storeName); ?>
<?php endif; ?>
	</a>
	<nav id="menu" class="menu">
		<a href="<?php echo base_url('produk'); ?>"<?php echo $navAttr('produk'); ?>>Produk</a>
		<a href="<?php echo base_url('tentang'); ?>"<?php echo $navAttr('tentang'); ?>>Tentang Kami</a>
	</nav>
	<div class="nav-icons">
		<button id="searchBtn" aria-label="Cari" aria-expanded="false" aria-controls="searchbar"><i class="bi bi-search" data-fb="⌕"></i></button><button id="cartBtn" class="cartbtn" aria-label="Keranjang"><i class="bi bi-bag" data-fb="🛒"></i><span class="badge" id="cartCount" hidden>0</span></button>
		<button id="burger" class="burger" aria-label="Menu" aria-expanded="false" aria-controls="menu"><i class="bi bi-list" data-fb="☰"></i></button>
	</div>
</div>
<div class="searchbar container" id="searchbar" hidden><input id="q" type="search" placeholder="Cari produk…" aria-label="Cari produk"></div>
</header>

<main>
