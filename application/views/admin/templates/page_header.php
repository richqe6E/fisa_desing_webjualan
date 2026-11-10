<?php defined('BASEPATH') OR exit('No direct script access allowed');

// Header halaman admin: judul + deskripsi opsional + tombol aksi opsional.
// Variabel dari controller: $title, $pageDesc?, $pageActionUrl?,
// $pageActionLabel?, $pageActionIcon?
?>
<div class="a-page-head">
	<div>
		<h1 class="a-page-title"><?php echo html_escape(isset($title) ? $title : ''); ?></h1>
		<?php if ( ! empty($pageDesc)): ?>
			<p class="a-page-desc"><?php echo html_escape($pageDesc); ?></p>
		<?php endif; ?>
	</div>
	<?php if ( ! empty($pageActionUrl)): ?>
		<a class="a-btn a-btn-ink" href="<?php echo html_escape($pageActionUrl); ?>">
			<i class="bi <?php echo html_escape(isset($pageActionIcon) && $pageActionIcon !== '' ? $pageActionIcon : 'bi-plus-lg'); ?>"></i>
			<?php echo html_escape(isset($pageActionLabel) ? $pageActionLabel : 'Tambah'); ?>
		</a>
	<?php endif; ?>
</div>
