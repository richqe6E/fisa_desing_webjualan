<?php defined('BASEPATH') OR exit('No direct script access allowed');

// Pesan flash (sukses/gagal) — dipakai header admin & halaman login.
?>
<?php if ($this->session->flashdata('message')): ?>
	<div class="a-alert a-alert-ok" role="status">
		<i class="bi bi-check-circle"></i>
		<span><?php echo html_escape($this->session->flashdata('message')); ?></span>
	</div>
<?php endif; ?>

<?php if ($this->session->flashdata('error')): ?>
	<div class="a-alert a-alert-err" role="alert">
		<i class="bi bi-exclamation-circle"></i>
		<span><?php echo html_escape($this->session->flashdata('error')); ?></span>
	</div>
<?php endif; ?>
