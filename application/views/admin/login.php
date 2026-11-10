<?php defined('BASEPATH') OR exit('No direct script access allowed');

$this->load->view('admin/templates/head', array('title' => isset($title) ? $title : 'Login Admin'));
?>

<div class="a-login">
	<div class="a-login-card">

		<div class="a-login-brand">
<?php if ( ! empty($this->store->logo)): ?>
			<img src="<?php echo upload_asset_url($this->store->logo, 'logos'); ?>" alt="<?php echo html_escape($this->store->name ?? 'yStore'); ?>">
<?php else: ?>
			<span class="a-mark"><i class="bi bi-bag"></i></span>
<?php endif; ?>
			<div>
				<h1>Login Admin</h1>
				<p>Masuk untuk mengelola <?php echo html_escape($this->store->name ?? 'yStore'); ?></p>
			</div>
		</div>

<?php if (isset($error)): ?>
		<div class="a-alert a-alert-err" role="alert">
			<i class="bi bi-exclamation-circle"></i>
			<span><?php echo html_escape($error); ?></span>
		</div>
<?php endif; ?>

<?php if (isset($blocked) && $blocked): ?>
		<div class="a-alert a-alert-warn" role="alert">
			<i class="bi bi-exclamation-triangle"></i>
			<span>Terlalu banyak percobaan login gagal. Tunggu beberapa menit sebelum mencoba lagi.</span>
		</div>
<?php endif; ?>

		<?php $this->load->view('admin/templates/flash'); ?>

		<?php echo form_open('admin/auth/login'); ?>
			<div class="a-field">
				<label class="a-label" for="username">Username</label>
				<input type="text" name="username" id="username" class="a-input" value="<?php echo set_value('username'); ?>" placeholder="username Anda" autocomplete="username" required autofocus>
			</div>

			<div class="a-field">
				<label class="a-label" for="password">Password</label>
				<input type="password" name="password" id="password" class="a-input" placeholder="&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;" required>
			</div>

			<button type="submit" class="a-btn a-btn-ink a-btn-block a-btn-lg">
				<i class="bi bi-box-arrow-in-right"></i> Masuk
			</button>
		<?php echo form_close(); ?>

		<p class="a-login-foot">Panel khusus administrator &middot; aktivitas tercatat</p>

	</div>
</div>

</body>
</html>
