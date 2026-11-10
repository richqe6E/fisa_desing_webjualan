<?php defined('BASEPATH') OR exit('No direct script access allowed');

$this->load->view('admin/templates/head', array('title' => isset($title) ? $title : NULL));
?>
<div class="a-shell">

	<!-- Sidebar (desktop statis, mobile jadi drawer) -->
	<aside class="a-side" id="adminSidebar" aria-label="Navigasi admin">
		<div class="a-side-brand">
			<a class="a-brand" href="<?php echo base_url('admin/dashboard'); ?>">
<?php if ( ! empty($this->store->logo)): ?>
				<img src="<?php echo upload_asset_url($this->store->logo, 'logos'); ?>" alt="">
<?php else: ?>
				<span class="a-mark"><i class="bi bi-bag"></i></span>
<?php endif; ?>
				<span>
					<strong><?php echo html_escape($this->store->name ?? 'yStore'); ?></strong>
					<small>Panel Admin</small>
				</span>
			</a>
			<button type="button" class="a-side-close" id="sidebarClose" aria-label="Tutup menu"><i class="bi bi-x-lg"></i></button>
		</div>

		<nav class="a-side-nav">
			<a class="<?php echo active_admin('dashboard'); ?>" href="<?php echo base_url('admin/dashboard'); ?>">
				<i class="bi bi-speedometer2"></i><span>Dashboard</span>
			</a>
			<a class="<?php echo active_admin('products'); ?>" href="<?php echo base_url('admin/products'); ?>">
				<i class="bi bi-box-seam"></i><span>Produk</span>
			</a>
			<a class="<?php echo active_admin('categories'); ?>" href="<?php echo base_url('admin/categories'); ?>">
				<i class="bi bi-tags"></i><span>Kategori</span>
			</a>
			<a class="<?php echo active_admin('store'); ?>" href="<?php echo base_url('admin/store'); ?>">
				<i class="bi bi-shop"></i><span>Toko</span>
			</a>
			<a class="<?php echo active_admin('users'); ?>" href="<?php echo base_url('admin/users'); ?>">
				<i class="bi bi-people"></i><span>Pengguna</span>
			</a>
		</nav>

		<div class="a-side-foot">
			<div class="a-side-user">
				<span class="a-avatar"><?php echo html_escape(strtoupper(mb_substr((string) $this->session->userdata('admin_name'), 0, 1))); ?></span>
				<span>
					<strong><?php echo html_escape($this->session->userdata('admin_name')); ?></strong>
					<small>Administrator</small>
				</span>
			</div>
			<a class="a-logout" href="<?php echo base_url('admin/auth/logout'); ?>">
				<i class="bi bi-box-arrow-right"></i><span>Keluar</span>
			</a>
		</div>
	</aside>

	<!-- Konten -->
	<div class="a-main">

		<!-- Topbar mobile -->
		<header class="a-topbar">
			<button type="button" class="a-icon-btn" id="menuBtn" aria-label="Buka menu" aria-expanded="false" aria-controls="adminSidebar">
				<i class="bi bi-list"></i>
			</button>
			<span class="a-topbar-title"><?php echo html_escape($this->store->name ?? 'yStore'); ?></span>
		</header>

		<div class="a-wrap">
			<?php $this->load->view('admin/templates/flash'); ?>
