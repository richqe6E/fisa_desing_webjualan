<?php defined('BASEPATH') OR exit('No direct script access allowed'); ?>

<?php $this->load->view('admin/templates/page_header'); ?>

<?php
// Judul beranda: teks + 2 gambar pill (dipakai untuk preview & nilai awal form)
$heroLine1 = trim((string) ($store->hero_line1 ?? ''));
$heroLine2 = trim((string) ($store->hero_line2 ?? ''));
$heroPill1 = trim((string) ($store->hero_pill1 ?? ''));
$heroPill2 = trim((string) ($store->hero_pill2 ?? ''));
?>

<?php if (validation_errors()): ?>
	<div class="a-alert a-alert-err" role="alert">
		<i class="bi bi-exclamation-circle"></i>
		<span><?php echo validation_errors(); ?></span>
	</div>
<?php endif; ?>

<?php echo form_open_multipart('admin/store'); ?>

<div class="a-card a-form-wide">

	<h2 class="a-card-title">Profil Toko</h2>

	<div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
		<div class="a-field">
			<label class="a-label" for="name">Nama Toko *</label>
			<input type="text" name="name" id="name" class="a-input" value="<?php echo set_value('name', $store->name ?? ''); ?>">
		</div>
		<div class="a-field">
			<label class="a-label" for="tagline">Tagline</label>
			<input type="text" name="tagline" id="tagline" class="a-input" value="<?php echo set_value('tagline', $store->tagline ?? ''); ?>">
		</div>
	</div>

	<div class="a-field">
		<label class="a-label" for="address">Alamat</label>
		<textarea name="address" id="address" rows="3" class="a-textarea"><?php echo set_value('address', $store->address ?? ''); ?></textarea>
	</div>

	<div class="a-field">
		<label class="a-label" for="about">Tentang Kami</label>
		<textarea name="about" id="about" rows="5" class="a-textarea"><?php echo set_value('about', $store->about ?? ''); ?></textarea>
		<p class="a-hint">Ditampilkan di halaman Tentang Kami.</p>
	</div>

	<h2 class="a-card-title a-sec">Judul Beranda</h2>

	<div class="a-field">
		<p class="a-hint">Judul besar halaman beranda, dua baris. Tulis <code>[gambar]</code> pada posisi gambar; bila gambarnya kosong, penanda itu otomatis dibuang dan kalimatnya disatukan.</p>
	</div>

	<div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
		<div class="a-field">
			<label class="a-label" for="hero_line1">Baris 1</label>
			<input type="text" name="hero_line1" id="hero_line1" class="a-input" maxlength="255" value="<?php echo html_escape(set_value('hero_line1', $heroLine1 !== '' ? $heroLine1 : 'Tampil [gambar] Kekinian')); ?>" placeholder="Tampil [gambar] Kekinian">
			<p class="a-hint">Kosongkan untuk kembali ke teks bawaan.</p>
		</div>
		<div class="a-field">
			<label class="a-label" for="hero_pill1">Gambar baris 1</label>
<?php if ($heroPill1 !== ''): ?>
			<div class="a-logo-preview">
				<img src="<?php echo html_escape(hero_image_url($heroPill1)); ?>" alt="Gambar judul baris 1">
				<span class="a-hint">Gambar saat ini</span>
			</div>
<?php endif; ?>
			<input type="file" name="hero_pill1" id="hero_pill1" accept="image/*" class="a-file">
<?php if ($heroPill1 !== ''): ?>
			<label class="a-check">
				<input type="checkbox" name="hero_pill1_clear" value="1"> Hapus gambar (judul tampil tanpa gambar)
			</label>
<?php endif; ?>
			<p class="a-hint">JPG / PNG / GIF / WebP, maksimal 2 MB. Foto dipotong setengah lingkaran (pil), jadi sebaiknya landscape. Upload baru menggantikan gambar lama.</p>
		</div>
	</div>

	<div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
		<div class="a-field">
			<label class="a-label" for="hero_line2">Baris 2</label>
			<input type="text" name="hero_line2" id="hero_line2" class="a-input" maxlength="255" value="<?php echo html_escape(set_value('hero_line2', $heroLine2 !== '' ? $heroLine2 : 'dengan [gambar] Harga Bersahabat')); ?>" placeholder="dengan [gambar] Harga Bersahabat">
			<p class="a-hint">Kosongkan untuk kembali ke teks bawaan.</p>
		</div>
		<div class="a-field">
			<label class="a-label" for="hero_pill2">Gambar baris 2</label>
<?php if ($heroPill2 !== ''): ?>
			<div class="a-logo-preview">
				<img src="<?php echo html_escape(hero_image_url($heroPill2)); ?>" alt="Gambar judul baris 2">
				<span class="a-hint">Gambar saat ini</span>
			</div>
<?php endif; ?>
			<input type="file" name="hero_pill2" id="hero_pill2" accept="image/*" class="a-file">
<?php if ($heroPill2 !== ''): ?>
			<label class="a-check">
				<input type="checkbox" name="hero_pill2_clear" value="1"> Hapus gambar (judul tampil tanpa gambar)
			</label>
<?php endif; ?>
			<p class="a-hint">JPG / PNG / GIF / WebP, maksimal 2 MB. Foto dipotong setengah lingkaran (pil), jadi sebaiknya landscape. Upload baru menggantikan gambar lama.</p>
		</div>
	</div>

	<h2 class="a-card-title a-sec">Kontak &amp; Checkout</h2>

	<div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
		<div class="a-field">
			<label class="a-label" for="phone">Telepon</label>
			<input type="text" name="phone" id="phone" class="a-input" value="<?php echo set_value('phone', $store->phone ?? ''); ?>">
		</div>
		<div class="a-field">
			<label class="a-label" for="whatsapp">WhatsApp (Checkout)</label>
			<input type="text" name="whatsapp" id="whatsapp" class="a-input" value="<?php echo set_value('whatsapp', $store->whatsapp ?? ''); ?>" placeholder="mis. 6281234567890">
			<p class="a-hint">Angka saja, diawali kode negara. Pelanggan diarahkan ke nomor ini saat checkout.</p>
		</div>
	</div>

	<h2 class="a-card-title a-sec">Sosial Media</h2>

	<div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
		<div class="a-field">
			<label class="a-label" for="instagram">Instagram</label>
			<input type="text" name="instagram" id="instagram" class="a-input" value="<?php echo set_value('instagram', $store->instagram ?? ''); ?>" placeholder="mis. @ystore atau https://instagram.com/ystore">
			<p class="a-hint">Kosongkan bila belum ada; tautannya otomatis disembunyikan di footer.</p>
		</div>
		<div class="a-field">
			<label class="a-label" for="facebook">Facebook</label>
			<input type="text" name="facebook" id="facebook" class="a-input" value="<?php echo set_value('facebook', $store->facebook ?? ''); ?>" placeholder="mis. ystore.id atau https://facebook.com/ystore.id">
			<p class="a-hint">Boleh nama pengguna saja (tanpa @) atau URL lengkap.</p>
		</div>
	</div>

	<h2 class="a-card-title a-sec">Logo</h2>

	<div class="a-field">
<?php if ( ! empty($store->logo)): ?>
		<div class="a-logo-preview">
			<img src="<?php echo upload_asset_url($store->logo, 'logos'); ?>" alt="Logo">
			<span class="a-hint">Logo saat ini</span>
		</div>
<?php endif; ?>
		<input type="file" name="logo" id="logo" accept="image/*" class="a-file">
		<p class="a-hint">JPG / PNG / GIF / WebP, maksimal 2 MB. Upload baru menggantikan logo lama.</p>
	</div>

	<div class="a-form-actions">
		<button type="submit" class="a-btn a-btn-ink"><i class="bi bi-check-lg"></i> Simpan</button>
		<a href="<?php echo base_url('admin/store'); ?>" class="a-btn a-btn-ghost">Batal</a>
	</div>

</div>

<?php echo form_close(); ?>
