<?php defined('BASEPATH') OR exit('No direct script access allowed'); ?>

<?php $this->load->view('admin/templates/page_header'); ?>

<?php if (validation_errors()): ?>
	<div class="a-alert a-alert-err" role="alert">
		<i class="bi bi-exclamation-circle"></i>
		<span><?php echo validation_errors(); ?></span>
	</div>
<?php endif; ?>

<?php echo form_open(isset($admin) && $admin !== NULL ? 'admin/users/edit/' . (int) $admin->id : 'admin/users/add'); ?>

<div class="a-card a-form-narrow">

	<div class="a-field">
		<label class="a-label" for="name">Nama *</label>
		<input type="text" name="name" id="name" class="a-input" value="<?php echo set_value('name', $admin->name ?? ''); ?>">
	</div>

	<div class="a-field">
		<label class="a-label" for="username">Username *</label>
		<input type="text" name="username" id="username" class="a-input" value="<?php echo set_value('username', $admin->username ?? ''); ?>" autocomplete="off">
		<p class="a-hint">Dipakai untuk login. Huruf/angka, tanda minus atau underscore; wajib unik.</p>
	</div>

	<div class="a-field">
		<label class="a-label" for="password">Password</label>
		<input type="password" name="password" id="password" class="a-input"
		       <?php echo (isset($admin) && $admin !== NULL) ? '' : 'required'; ?>>
		<p class="a-hint">
			<?php echo (isset($admin) && $admin !== NULL)
				? 'Minimal 8 karakter. Kosongkan untuk mempertahankan password lama.'
				: 'Minimal 8 karakter.'; ?>
		</p>
	</div>

	<div class="a-form-actions">
		<button type="submit" class="a-btn a-btn-ink"><i class="bi bi-check-lg"></i> Simpan</button>
		<a href="<?php echo base_url('admin/users'); ?>" class="a-btn a-btn-ghost">Batal</a>
	</div>

</div>

<?php echo form_close(); ?>
