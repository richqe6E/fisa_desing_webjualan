<?php defined('BASEPATH') OR exit('No direct script access allowed');

$storeName = $this->store->name ?? 'yStore';
?>
<div class="container">
<nav class="crumbs" aria-label="Breadcrumb"><a href="<?php echo base_url(); ?>">Beranda</a><i class="bi bi-chevron-right" data-fb="›"></i><span aria-current="page">Produk</span></nav>

<section id="products" class="products plist">
	<h1 class="plist-title">Semua Produk</h1>
	<p class="plist-sub"><?php echo $category !== NULL ? 'Kategori: ' . html_escape($category->name) : 'Jelajahi koleksi ' . html_escape($storeName) . '.'; ?></p>
	<div class="tabs" id="tabs">
		<button class="active" aria-pressed="true" data-filter="all">Semua</button>
<?php foreach ($categories as $cat): ?>
		<button aria-pressed="false" data-filter="<?php echo html_escape($cat->slug); ?>"><?php echo html_escape($cat->name); ?></button>
<?php endforeach; ?>
	</div>
	<div class="toolbar">
		<p id="count" class="count" aria-live="polite">Menampilkan 0 produk</p>
		<label class="sortbox"><span>Urutkan</span>
			<select id="sort" aria-label="Urutkan produk">
				<option value="featured">Terbaru</option>
				<option value="price-asc">Harga: terendah</option>
				<option value="price-desc">Harga: tertinggi</option>
				<option value="name">Nama: A&ndash;Z</option>
			</select>
		</label>
	</div>
	<div class="grid" id="grid"></div>
	<p id="empty" class="empty" role="status" hidden>Belum ada produk di kategori ini.</p>
</section>
</div>
