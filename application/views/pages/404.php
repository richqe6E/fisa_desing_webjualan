<?php defined('BASEPATH') OR exit('No direct script access allowed');

$storeName = $this->store->name ?? 'yStore';
?>
<div class="container">
<nav class="crumbs" aria-label="Breadcrumb"><a href="<?php echo base_url(); ?>">Beranda</a><i class="bi bi-chevron-right" data-fb="›"></i><span aria-current="page">Halaman tidak ditemukan</span></nav>

<section class="pd-missing">
	<h1>404 &mdash; Halaman tidak ditemukan</h1>
	<p>Maaf, halaman yang kamu cari tidak ada atau sudah dipindahkan. Silakan kembali ke beranda atau lihat koleksi produk <?php echo html_escape($storeName); ?>.</p>
	<a href="<?php echo base_url(); ?>" class="btn-dark">Ke Beranda <span class="arrow"><i class="bi bi-arrow-up-right" data-fb="↗"></i></span></a>
	<a href="<?php echo base_url('produk'); ?>" class="btn-dark">Lihat Produk <span class="arrow"><i class="bi bi-arrow-up-right" data-fb="↗"></i></span></a>
</section>
</div>
