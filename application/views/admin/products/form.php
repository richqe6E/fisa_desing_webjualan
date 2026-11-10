<?php defined('BASEPATH') OR exit('No direct script access allowed');

$isEdit = isset($product) && $product !== NULL;
?>

<?php $this->load->view('admin/templates/page_header'); ?>

<?php if (validation_errors()): ?>
	<div class="a-alert a-alert-err" role="alert">
		<i class="bi bi-exclamation-circle"></i>
		<span><?php echo validation_errors(); ?></span>
	</div>
<?php endif; ?>

<?php echo form_open_multipart($isEdit ? 'admin/products/edit/' . (int) $product->id : 'admin/products/add'); ?>

<div class="grid grid-cols-1 lg:grid-cols-3 gap-6 items-start">

	<!-- Kolom utama -->
	<div class="a-stack">
		<div class="a-card">
			<h2 class="a-card-title">Informasi Produk</h2>

			<div class="a-field">
				<label class="a-label" for="name">Nama Produk *</label>
				<input type="text" name="name" id="name" class="a-input" value="<?php echo set_value('name', $product->name ?? ''); ?>">
			</div>

			<div class="a-field">
				<label class="a-label" for="slug">Slug</label>
				<input type="text" name="slug" id="slug" class="a-input" value="<?php echo set_value('slug', $product->slug ?? ''); ?>">
				<p class="a-hint">Kosongkan untuk dibuat otomatis dari nama (huruf kecil, dipisah tanda minus).</p>
			</div>

			<div class="a-field">
				<label class="a-label" for="description">Deskripsi</label>
				<textarea name="description" id="description" rows="7" class="a-textarea"><?php echo set_value('description', $product->description ?? ''); ?></textarea>
			</div>
		</div>

<?php if ($isEdit && ! empty($images)): ?>
		<div class="a-card">
			<h2 class="a-card-title">Galeri Produk</h2>
			<p class="a-hint">Centang gambar yang ingin dihapus, lalu tekan Simpan.</p>
			<div class="a-gallery">
				<?php foreach ($images as $img): ?>
					<span class="a-gallery-item">
						<img src="<?php echo upload_asset_url($img->file_name, 'products'); ?>" alt="">
						<label>
							<input type="checkbox" name="delete_images[]" value="<?php echo (int) $img->id; ?>">Hapus
						</label>
					</span>
				<?php endforeach; ?>
			</div>
		</div>
<?php endif; ?>

		<div class="a-card">
			<h2 class="a-card-title">Tambah Gambar</h2>
			<input type="file" name="images[]" accept="image/*" multiple class="a-file">
			<p class="a-hint">Bisa pilih beberapa gambar sekaligus untuk galeri.</p>
		</div>
	</div>

	<!-- Panel samping -->
	<div class="a-stack">
		<div class="a-card">
			<h2 class="a-card-title">Harga &amp; Stok</h2>

			<div class="a-field">
				<label class="a-label" for="category_id">Kategori *</label>
				<select name="category_id" id="category_id" class="a-select">
					<option value="">-- Pilih --</option>
					<?php foreach ($categories as $cat): ?>
						<?php $selected = $isEdit && (int) $product->category_id === (int) $cat->id; ?>
						<option value="<?php echo (int) $cat->id; ?>" <?php echo set_select('category_id', $cat->id, $selected); ?>>
							<?php echo html_escape($cat->name); ?>
						</option>
					<?php endforeach; ?>
				</select>
			</div>

			<div class="grid grid-cols-2 gap-4">
				<div class="a-field">
					<label class="a-label" for="price">Harga (Rp) *</label>
					<input type="number" name="price" id="price" min="0" step="0.01" class="a-input" value="<?php echo set_value('price', $product->price ?? ''); ?>">
				</div>
				<div class="a-field">
					<label class="a-label" for="stock">Stok *</label>
					<input type="number" name="stock" id="stock" min="0" class="a-input" value="<?php echo set_value('stock', $product->stock ?? ''); ?>">
				</div>
			</div>

			<label class="a-check">
				<input type="checkbox" name="is_active" value="1"
				       <?php echo set_checkbox('is_active', '1', ! $isEdit || (int) $product->is_active === 1); ?>>
				Produk aktif (ditampilkan di toko)
			</label>
		</div>

		<div class="a-card">
			<h2 class="a-card-title">Gambar Cover</h2>

			<?php if ($isEdit && $product->image): ?>
				<div class="a-logo-preview">
					<img src="<?php echo upload_asset_url($product->image, 'products'); ?>" alt="Cover">
					<span class="a-hint">Cover saat ini</span>
				</div>
			<?php endif; ?>

			<input type="file" name="image" id="image" accept="image/*" class="a-file">
			<p class="a-hint">JPG / PNG / GIF / WebP, maksimal 2 MB. Upload baru menggantikan cover lama.</p>
		</div>

		<div class="a-card">
			<div class="a-form-actions">
				<button type="submit" class="a-btn a-btn-ink a-btn-block"><i class="bi bi-check-lg"></i> Simpan</button>
			</div>
			<div class="a-form-actions">
				<a href="<?php echo base_url('admin/products'); ?>" class="a-btn a-btn-ghost a-btn-block">Batal</a>
			</div>
		</div>
	</div>

</div>

<?php echo form_close(); ?>
