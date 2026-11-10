<?php defined('BASEPATH') OR exit('No direct script access allowed');

$storeName = $this->store->name ?? 'yStore';
$tagline   = $this->store->tagline ?? '';
$waNumber  = preg_replace('/[^0-9]/', '', (string) ($this->store->whatsapp ?? ''));

// Foto hero: produk terbaru yang bergambar, fallback foto Unsplash
$fallbackHero = 'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?auto=format&fit=crop&w=1400&h=800&q=75';
$fallbackCta  = 'https://images.unsplash.com/photo-1496747611176-843222e1e57c?auto=format&fit=crop&w=1800&h=700&q=75';
$withImages   = array_values(array_filter($products, fn ($p) => ! empty($p->image)));
// Judul hero (teks + 2 gambar pill) diatur dari admin: Kelola Toko > Judul Beranda.
// Teks kosong -> kembali ke teks bawaan; gambar kosong -> gambar tidak ditampilkan.
$heroLine1 = trim((string) ($this->store->hero_line1 ?? ''));
$heroLine2 = trim((string) ($this->store->hero_line2 ?? ''));
$heroPill1 = (string) ($this->store->hero_pill1 ?? '');
$heroPill2 = (string) ($this->store->hero_pill2 ?? '');
if ($heroLine1 === '')
{
	$heroLine1 = 'Tampil [gambar] Kekinian';
}
if ($heroLine2 === '')
{
	$heroLine2 = 'dengan [gambar] Harga Bersahabat';
}
// Urutan: hero besar = produk ke-1, mini kanan = ke-2 & ke-3, CTA = ke-4 (tidak boleh dobel).
$heroMain     = ! empty($withImages[0]) ? upload_asset_url($withImages[0]->image, 'products', $fallbackHero) : $fallbackHero;
$heroMinis    = array_slice($withImages, 1, 2);
$ctaImage     = ! empty($withImages[3]) ? upload_asset_url($withImages[3]->image, 'products', $fallbackCta) : $fallbackCta;
?>

<!-- Hero -->
<section class="hero container">
	<h1><span class="line"><span><?php echo hero_line($heroLine1, $heroPill1); ?></span></span>
		<span class="line"><span><?php echo hero_line($heroLine2, $heroPill2, TRUE); ?></span></span></h1>
	<div class="hero-grid">
		<div class="hero-main">
			<img width="900" height="560" src="<?php echo $heroMain; ?>" alt="<?php echo html_escape($storeName); ?>">
			<div class="notch tl reviews"><span class="avatars"><i></i><i></i><i></i><b>+<?php echo (int) $totalProducts; ?></b></span><small>Produk<br>tersedia</small></div>
			<div class="notch br"><a href="<?php echo base_url('produk'); ?>" class="btn-dark">Belanja Sekarang <span class="arrow"><i class="bi bi-arrow-up-right" data-fb="↗"></i></span></a></div>
		</div>
		<div class="hero-side">
<?php if ( ! empty($heroMinis)): ?>
<?php foreach ($heroMinis as $heroProduct): ?>
			<a class="mini" href="<?php echo base_url('produk/' . html_escape($heroProduct->slug)); ?>"><img width="300" height="200" src="<?php echo upload_asset_url($heroProduct->image, 'products'); ?>" alt="<?php echo html_escape($heroProduct->name); ?>"><div><span><?php echo html_escape($heroProduct->name); ?><small class="stars"><i class="bi bi-star-fill" data-fb="★"></i><i class="bi bi-star-fill" data-fb="★"></i><i class="bi bi-star-fill" data-fb="★"></i><i class="bi bi-star-fill" data-fb="★"></i><i class="bi bi-star-fill" data-fb="★"></i></small></span><strong><?php echo format_rupiah($heroProduct->price); ?></strong></div></a>
<?php endforeach; ?>
<?php else: ?>
			<a class="mini" href="<?php echo base_url('produk'); ?>"><img width="300" height="200" src="https://images.unsplash.com/photo-1434389677669-e08b4cac3105?auto=format&fit=crop&w=420&h=300&q=75" alt=""><div><span>Koleksi terbaru<small class="stars"><i class="bi bi-star-fill" data-fb="★"></i><i class="bi bi-star-fill" data-fb="★"></i><i class="bi bi-star-fill" data-fb="★"></i><i class="bi bi-star-fill" data-fb="★"></i><i class="bi bi-star-fill" data-fb="★"></i></small></span><strong><?php echo format_rupiah(0); ?></strong></div></a>
			<a class="mini" href="<?php echo base_url('produk'); ?>"><img width="300" height="200" src="https://images.unsplash.com/photo-1523381210434-271e8be1f52b?auto=format&fit=crop&w=420&h=300&q=75" alt=""><div><span>Lihat produk<small class="stars"><i class="bi bi-star-fill" data-fb="★"></i><i class="bi bi-star-fill" data-fb="★"></i><i class="bi bi-star-fill" data-fb="★"></i><i class="bi bi-star-fill" data-fb="★"></i><i class="bi bi-star-fill" data-fb="★"></i></small></span><strong><?php echo format_rupiah(0); ?></strong></div></a>
<?php endif; ?>
		</div>
	</div>
</section>

<!-- Statistik -->
<section class="stats container">
	<div data-reveal><b data-count="<?php echo (int) $totalProducts; ?>"><?php echo (int) $totalProducts; ?>+</b><p>Produk kekinian siap dipesan</p></div>
	<div data-reveal><b data-count="<?php echo (int) $totalCategories; ?>"><?php echo (int) $totalCategories; ?></b><p>Kategori pakaian yang tersedia</p></div>
	<div data-reveal><b data-count="<?php echo (int) $totalViews; ?>"><?php echo (int) $totalViews; ?></b><p>Total produk dilihat pengunjung</p></div>
</section>

<!-- Produk -->
<section id="products" class="container products">
	<h2 data-reveal>Produk <?php echo html_escape($storeName); ?></h2>
	<div class="tabs" id="tabs" data-reveal>
		<button class="active" aria-pressed="true" data-filter="all">Semua</button>
<?php foreach ($categories as $category): ?>
		<button aria-pressed="false" data-filter="<?php echo html_escape($category->slug); ?>"><?php echo html_escape($category->name); ?></button>
<?php endforeach; ?>
	</div>
	<div class="grid" id="grid"></div>
	<p id="empty" class="empty" role="status" hidden>Belum ada produk di kategori ini.</p>
	<a href="<?php echo base_url('produk'); ?>" class="btn-dark all-btn" data-reveal>Lihat semua produk <span class="arrow"><i class="bi bi-arrow-up-right" data-fb="↗"></i></span></a>
</section>

<!-- Kenapa memilih kami -->
<section id="about" class="container why">
	<div class="why-media" data-reveal>
		<div class="video"><img width="700" height="500" loading="lazy" src="https://images.unsplash.com/photo-1441986300917-64674bd600d8?auto=format&fit=crop&w=1200&h=860&q=75" alt="Koleksi <?php echo html_escape($storeName); ?>"><button class="play" id="playBtn" aria-label="Putar video"><i class="bi bi-play-fill" data-fb="▶"></i></button></div>
		<p>Kenali lebih dekat<br><?php echo html_escape($storeName); ?></p>
	</div>
	<div class="why-text" data-reveal>
		<h2>Kenapa Memilih Kami</h2>
		<p class="sub"><?php echo html_escape($tagline !== '' ? $tagline : 'Koleksi pakaian kekinian dengan harga bersahabat.'); ?></p>
		<div class="acc">
			<div class="acc-item"><button class="acc-head" id="ah1" aria-expanded="false" aria-controls="ab1"><span>Tentang kami</span><i class="bi bi-plus-lg" data-fb="+"></i></button><div class="acc-body" id="ab1" role="region" aria-labelledby="ah1"><p><?php echo html_escape($this->store->about ?? 'Deskripsi toko belum diisi.'); ?></p></div></div>
			<div class="acc-item open"><button class="acc-head" id="ah2" aria-expanded="true" aria-controls="ab2"><span>Kualitas bahan</span><i class="bi bi-x-lg" data-fb="×"></i></button><div class="acc-body" id="ab2" role="region" aria-labelledby="ah2"><p>Kami memilih bahan yang nyaman dan tahan lama untuk dipakai sehari-hari.</p></div></div>
			<div class="acc-item"><button class="acc-head" id="ah3" aria-expanded="false" aria-controls="ab3"><span>Harga bersahabat</span><i class="bi bi-plus-lg" data-fb="+"></i></button><div class="acc-body" id="ab3" role="region" aria-labelledby="ah3"><p>Harga langsung dari produsen tanpa perantara, untuk semua kalangan.</p></div></div>
			<div class="acc-item"><button class="acc-head" id="ah4" aria-expanded="false" aria-controls="ab4"><span>Layanan WhatsApp</span><i class="bi bi-plus-lg" data-fb="+"></i></button><div class="acc-body" id="ab4" role="region" aria-labelledby="ah4"><p>Pemesanan dan konsultasi cukup via WhatsApp, tanpa perlu membuat akun.</p></div></div>
		</div>
	</div>
</section>

<!-- CTA -->
<section id="store" class="container cta" data-reveal>
	<img width="1200" height="460" loading="lazy" src="<?php echo $ctaImage; ?>" alt="Koleksi <?php echo html_escape($storeName); ?>">
<?php if ($waNumber !== ''): ?>
	<div class="notch tr"><a href="https://wa.me/<?php echo $waNumber; ?>" class="btn-dark">Chat WhatsApp <span class="arrow"><i class="bi bi-arrow-up-right" data-fb="↗"></i></span></a></div>
<?php endif; ?>
	<div class="cta-text"><h2><?php echo html_escape($tagline !== '' ? $tagline : $storeName); ?></h2><a href="<?php echo base_url('produk'); ?>" class="btn-light">Lihat Produk</a></div>
</section>

<!-- Cara belanja -->
<section class="container steps" data-reveal>
	<h2>Cara Belanja di <?php echo html_escape($storeName); ?></h2>
	<div class="step-grid">
		<div class="step">
			<span class="step-num">1</span>
			<h3>Pilih produk</h3>
			<p>Jelajahi katalog, cek foto, harga, dan stok. Tambahkan favoritmu ke keranjang.</p>
		</div>
		<div class="step">
			<span class="step-num">2</span>
			<h3>Checkout via WhatsApp</h3>
			<p>Tekan tombol Checkout di keranjang — pesananmu otomatis tersusun rapi di WhatsApp.</p>
		</div>
		<div class="step">
			<span class="step-num">3</span>
			<h3>Bayar &amp; terima</h3>
			<p>Konfirmasi pesanan dengan admin, lalu tunggu pesanan sampai di depan pintumu.</p>
		</div>
	</div>
<?php if ($waNumber !== ''): ?>
	<a href="https://wa.me/<?php echo $waNumber; ?>" class="btn-dark" data-reveal>Belanja via WhatsApp <span class="arrow"><i class="bi bi-arrow-up-right" data-fb="↗"></i></span></a>
<?php endif; ?>
</section>

<!-- Dialog video -->
<dialog id="videoDialog" aria-label="Video <?php echo html_escape($storeName); ?>">
	<button class="vclose" id="vclose" aria-label="Tutup video"><i class="bi bi-x-lg" data-fb="×"></i></button>
	<!-- Ganti blok ini dengan <iframe src="URL_VIDEO" allowfullscreen></iframe> atau <video controls src="video.mp4"></video> -->
	<div class="vplace">Tempat video</div>
</dialog>
