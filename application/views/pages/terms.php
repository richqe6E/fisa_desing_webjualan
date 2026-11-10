<?php defined('BASEPATH') OR exit('No direct script access allowed');

// DRAF: teks di bawah bersifat umum. Sesuaikan dengan kebijakan toko
// sebenarnya sebelum dipublikasikan, lalu perbarui $updated di Pages.php.

$storeName = $this->store->name ?? 'yStore';
$address   = trim((string) ($this->store->address ?? ''));
$phone     = trim((string) ($this->store->phone ?? ''));
$waNumber  = preg_replace('/[^0-9]/', '', (string) ($this->store->whatsapp ?? ''));

// Cetak satu bagian: label kecil di kiri, isi di kanan (grid .ab-lead)
$row = function ($label, $text) {
	echo '<div class="ab-lead" data-reveal><p class="ab-label">' . html_escape($label) . '</p><p>' . html_escape($text) . '</p></div>';
};
?>
<div class="container about-page">
<nav class="crumbs" aria-label="Breadcrumb"><a href="<?php echo base_url(); ?>">Beranda</a><i class="bi bi-chevron-right" data-fb="›"></i><span aria-current="page">Syarat &amp; Ketentuan</span></nav>

<h1 class="plist-title">Syarat &amp; Ketentuan</h1>
<p class="plist-sub">Aturan yang berlaku saat kamu berbelanja di <?php echo html_escape($storeName); ?>.</p>

<?php $row('Terakhir diperbarui', $updated); ?>
<?php $row('1. Ketentuan umum', 'Dengan mengakses situs ini dan melakukan pemesanan, kamu dianggap telah membaca dan menyetujui syarat dan ketentuan berikut. Syarat ini dapat berubah sewaktu-waktu; versi terbaru selalu ditampilkan di halaman ini.'); ?>
<?php $row('2. Pemesanan', 'Pesanan dibuat melalui keranjang di situs ini, lalu dikonfirmasi lewat WhatsApp. Pesanan dianggap sah setelah kami membalas dan mengonfirmasi ketersediaan stok, ukuran, warna, serta biaya pengiriman. Kami berhak menolak atau membatalkan pesanan bila data yang diberikan tidak lengkap atau tidak dapat diverifikasi.'); ?>
<?php $row('3. Harga & pembayaran', 'Semua harga ditampilkan dalam Rupiah dan belum termasuk biaya pengiriman, kecuali dinyatakan lain. Harga dapat berubah tanpa pemberitahuan sebelumnya; harga yang berlaku adalah harga pada saat pesanan dikonfirmasi. Pembayaran dilakukan melalui metode yang kami sebutkan saat konfirmasi pesanan.'); ?>
<?php $row('4. Pengiriman', 'Pesanan dikirim melalui jasa ekspedisi yang tersedia. Estimasi waktu pengiriman bergantung pada tujuan dan jasa pengiriman yang dipilih, sehingga di luar kendali kami. Pastikan alamat dan nomor telepon yang diberikan benar dan lengkap.'); ?>
<?php $row('5. Pengembalian & penukaran', 'Klaim barang rusak, salah kirim, atau tidak sesuai dapat diajukan maksimal 2x24 jam setelah paket diterima, dengan menyertakan foto atau video paket. Produk yang diklaim harus dalam kondisi belum dipakai dan label masih menempel. Biaya pengiriman untuk penukaran akibat kesalahan kami ditanggung oleh kami; sebaliknya, biaya pengiriman akibat kesalahan pembeli ditanggung pembeli.'); ?>
<?php $row('6. Produk & ketersediaan', 'Kami berusaha menampilkan warna dan detail produk seakurat mungkin, namun perbedaan tampilan warna di layar dapat terjadi. Stok dapat berubah setiap saat; bila produk yang dipesan kosong, kami akan menawarkan alternatif atau pengembalian dana.'); ?>

<div class="ab-lead" data-reveal>
	<p class="ab-label">7. Hubungi kami</p>
	<p>
		Bila ada pertanyaan tentang syarat dan ketentuan ini, hubungi kami:
<?php if ($waNumber !== ''): ?>
		<br>WhatsApp: <a href="https://wa.me/<?php echo $waNumber; ?>" target="_blank" rel="noopener noreferrer"><?php echo html_escape($waNumber); ?></a>
<?php endif; ?>
<?php if ($phone !== ''): ?>
		<br>Telepon: <?php echo html_escape($phone); ?>
<?php endif; ?>
<?php if ($address !== ''): ?>
		<br>Alamat: <?php echo nl2br(html_escape($address)); ?>
<?php endif; ?>
	</p>
</div>
</div>
