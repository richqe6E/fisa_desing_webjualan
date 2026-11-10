<?php defined('BASEPATH') OR exit('No direct script access allowed');

$storeName = $this->store->name ?? 'yStore';
$tagline   = (string) ($this->store->tagline ?? '');
$about     = (string) ($this->store->about ?? '');
$address   = (string) ($this->store->address ?? '');
$phone     = (string) ($this->store->phone ?? '');
$waNumber  = preg_replace('/[^0-9]/', '', (string) ($this->store->whatsapp ?? ''));

// Foto hero: gunakan banner kustom jika ada, fallback Unsplash
$aboutBanner = is_file(FCPATH . 'assets/uploads/banners/about-banner.jpg')
	? base_url('assets/uploads/banners/about-banner.jpg')
	: 'https://images.unsplash.com/photo-1445205170230-053b83016050?auto=format&fit=crop&w=1600&h=600&q=75';
?>
<div class="container about-page">
<nav class="crumbs" aria-label="Breadcrumb"><a href="<?php echo base_url(); ?>">Beranda</a><i class="bi bi-chevron-right" data-fb="›"></i><span aria-current="page">Tentang Kami</span></nav>

<h1 class="plist-title">Tentang Kami</h1>
<p class="plist-sub"><?php echo html_escape($tagline !== '' ? $tagline : 'Layanan percetakan & merchandise custom dengan harga bersahabat.'); ?></p>

<div class="ab-hero" data-reveal>
	<img width="1600" height="600" src="<?php echo $aboutBanner; ?>" alt="Koleksi <?php echo html_escape($storeName); ?>">
</div>

<div class="ab-lead" data-reveal>
	<p class="ab-label">Cerita kami</p>
	<p><?php echo html_escape($about !== '' ? $about : 'Deskripsi toko belum diisi.'); ?></p>
</div>

<section class="stats ab-sec">
	<div data-reveal><b data-count="<?php echo (int) $totalProducts; ?>"><?php echo (int) $totalProducts; ?>+</b><p>Produk custom siap dipesan</p></div>
	<div data-reveal><b data-count="<?php echo (int) $totalCategories; ?>"><?php echo (int) $totalCategories; ?></b><p>Kategori produk yang tersedia</p></div>
	<div data-reveal><b data-count="<?php echo (int) $totalViews; ?>"><?php echo (int) $totalViews; ?></b><p>Total produk dilihat pengunjung</p></div>
</section>

<?php if ($address !== '' || $phone !== '' || $waNumber !== ''): ?>
<section class="ab-sec">
	<div class="ab-head" data-reveal>
		<h2>Hubungi kami</h2>
		<p>Pemesanan dan konsultasi cukup lewat WhatsApp, tanpa perlu membuat akun.</p>
	</div>
	<div class="contact">
<?php if ($address !== ''): ?>
		<div class="cbox" data-reveal>
			<i class="bi bi-geo-alt" data-fb="⌖"></i>
			<h3>Alamat</h3>
			<p><?php echo html_escape($address); ?></p>
		</div>
<?php endif; ?>
<?php if ($phone !== ''): ?>
		<div class="cbox" data-reveal>
			<i class="bi bi-telephone" data-fb="☎"></i>
			<h3>Telepon</h3>
			<p><a href="tel:<?php echo html_escape(preg_replace('/[^0-9+]/', '', $phone)); ?>"><?php echo html_escape($phone); ?></a></p>
		</div>
<?php endif; ?>
<?php if ($waNumber !== ''): ?>
		<div class="cbox" data-reveal>
			<i class="bi bi-whatsapp" data-fb="✆"></i>
			<h3>WhatsApp</h3>
			<p><a href="https://wa.me/<?php echo $waNumber; ?>" target="_blank" rel="noopener"><?php echo html_escape($phone !== '' ? $phone : '+' . $waNumber); ?></a></p>
		</div>
<?php endif; ?>
	</div>
<?php if ($waNumber !== ''): ?>
	<div class="contact-cta" data-reveal>
		<a href="https://wa.me/<?php echo $waNumber; ?>" class="btn-dark">Chat WhatsApp <span class="arrow"><i class="bi bi-arrow-up-right" data-fb="↗"></i></span></a>
	</div>
<?php endif; ?>
</section>
<?php endif; ?>

</div>
