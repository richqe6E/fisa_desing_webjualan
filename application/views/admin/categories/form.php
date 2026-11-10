<?php defined('BASEPATH') OR exit('No direct script access allowed'); ?>

<?php $this->load->view('admin/templates/page_header'); ?>

<?php if (validation_errors()): ?>
	<div class="a-alert a-alert-err" role="alert">
		<i class="bi bi-exclamation-circle"></i>
		<span><?php echo validation_errors(); ?></span>
	</div>
<?php endif; ?>

<?php echo form_open(isset($category) && $category !== NULL ? 'admin/categories/edit/' . (int) $category->id : 'admin/categories/add'); ?>

<div class="a-card a-form-narrow">
	<div class="a-field">
		<label class="a-label" for="name">Nama Kategori *</label>
		<input type="text" name="name" id="name" class="a-input" value="<?php echo set_value('name', $category->name ?? ''); ?>">
	</div>

	<div class="a-field">
		<label class="a-label" for="slug">Slug</label>
		<input type="text" name="slug" id="slug" class="a-input" value="<?php echo set_value('slug', $category->slug ?? ''); ?>">
		<p class="a-hint">Kosongkan untuk dibuat otomatis dari nama. Slug harus unik.</p>
	</div>

	<div class="a-field">
		<label class="a-label" for="description">Deskripsi</label>
		<textarea name="description" id="description" rows="3" class="a-textarea"><?php echo set_value('description', $category->description ?? ''); ?></textarea>
	</div>

	<div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
		<div class="a-field">
			<label class="a-label" for="sort_order">Urutan</label>
			<input type="number" name="sort_order" id="sort_order" class="a-input" value="<?php echo set_value('sort_order', $category->sort_order ?? '0'); ?>">
			<p class="a-hint">Angka kecil tampil lebih dulu.</p>
		</div>
		<div class="a-field a-field-end">
			<label class="a-check">
				<input type="checkbox" name="is_active" value="1"
				       <?php echo set_checkbox('is_active', '1', ! isset($category) || (int) $category->is_active === 1); ?>>
				Kategori aktif
			</label>
		</div>
	</div>

	<div class="a-form-actions">
		<button type="submit" class="a-btn a-btn-ink"><i class="bi bi-check-lg"></i> Simpan</button>
		<a href="<?php echo base_url('admin/categories'); ?>" class="a-btn a-btn-ghost">Batal</a>
	</div>
</div>

<?php echo form_close(); ?>
