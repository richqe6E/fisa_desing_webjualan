<?php defined('BASEPATH') OR exit('No direct script access allowed');

// DRAF: teks di bawah bersifat umum. Sesuaikan dengan kebijakan toko
// sebenarnya sebelum dipublikasikan, lalu perbarui $updated di Pages.php.

$storeName = $this->store->name ?? 'yStore';
$waNumber  = preg_replace('/[^0-9]/', '', (string) ($this->store->whatsapp ?? ''));

// Cetak satu bagian: label kecil di kiri, isi di kanan (grid .ab-lead)
$row = function ($label, $text) {
	echo '<div class="ab-lead" data-reveal><p class="ab-label">' . html_escape($label) . '</p><p>' . html_escape($text) . '</p></div>';
};
?>
<div class="container about-page">
<nav class="crumbs" aria-label="Breadcrumb"><a href="<?php echo base_url(); ?>">Beranda</a><i class="bi bi-chevron-right" data-fb="›"></i><span aria-current="page">Kebijakan Privasi</span></nav>

<h1 class="plist-title">Kebijakan Privasi</h1>
<p class="plist-sub">Bagaimana <?php echo html_escape($storeName); ?> mengumpulkan, memakai, dan melindungi datamu.</p>

<?php $row('Terakhir diperbarui', $updated); ?>
<?php $row('1. Data yang kami kumpulkan', 'Kami hanya mengumpulkan data yang diperlukan untuk memproses pesanan: nama, nomor telepon atau WhatsApp, dan alamat pengiriman yang kamu berikan saat checkout. Untuk keperluan statistik, kami juga mencatat kunjungan halaman secara umum (alamat IP dan jenis perangkat) tanpa menghubungkannya dengan identitasmu.'); ?>
<?php $row('2. Cara kami memakai data', 'Data pesanan dipakai untuk memproses, mengirim, dan menindaklanjuti pesanan, termasuk menjawab pertanyaanmu dan menangani klaim. Data kunjungan dipakai untuk melihat halaman yang paling banyak dibaca agar kami dapat memperbaiki situs ini.'); ?>
<?php $row('3. Keranjang belanja & cookie', 'Keranjang belanja disimpan di peramban kamu sendiri (localStorage) dan tidak dikirim ke server sampai kamu menekan tombol checkout. Situs ini memakai cookie untuk keamanan sesi dan token formulir; cookie tersebut tidak dipakai untuk melacak perilaku berbelanjamu di situs lain.'); ?>
<?php $row('4. Berbagi data ke pihak ketiga', 'Kami tidak menjual atau menyewakan datamu. Data pengiriman hanya dibagikan kepada jasa ekspedisi yang mengantar pesananmu, dan sebatas yang diperlukan untuk pengiriman.'); ?>
<?php $row('5. Penyimpanan & keamanan', 'Kami berusaha menjaga datamu dengan langkah keamanan yang wajar, seperti akses panel admin yang dibatasi dan kata sandi yang disimpan dalam bentuk terenkripsi. Meskipun demikian, tidak ada metode pengiriman atau penyimpanan data yang sepenuhnya bebas risiko di internet.'); ?>
<?php $row('6. Hak kamu', 'Kamu dapat meminta kami menampilkan, memperbaiki, atau menghapus data pesananmu dengan menghubungi kami. Selama pesanan masih dalam proses pengiriman, kami perlu menyimpan sebagian data hingga pesanan selesai.'); ?>
<?php $row('7. Perubahan kebijakan', 'Kebijakan ini dapat diperbarui sewaktu-waktu. Versi terbaru selalu ditampilkan di halaman ini, sehingga kamu dapat mengetahui data apa saja yang kami kelola.'); ?>

<div class="ab-lead" data-reveal>
	<p class="ab-label">8. Hubungi kami</p>
	<p>
		Pertanyaan tentang privasi dapat disampaikan lewat:
<?php if ($waNumber !== ''): ?>
		<br>WhatsApp: <a href="https://wa.me/<?php echo $waNumber; ?>" target="_blank" rel="noopener noreferrer"><?php echo html_escape($waNumber); ?></a>
<?php endif; ?>
	</p>
</div>
</div>
