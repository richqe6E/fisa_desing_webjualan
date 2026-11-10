<?php defined('BASEPATH') OR exit('No direct script access allowed'); ?>

<?php $this->load->view('admin/templates/page_header'); ?>

<?php if (empty($admins)): ?>
	<div class="a-empty">
		<i class="bi bi-people"></i>
		<p>Belum ada pengguna.</p>
		<a class="a-btn a-btn-ink" href="<?php echo base_url('admin/users/add'); ?>"><i class="bi bi-plus-lg"></i> Tambah Pengguna</a>
	</div>
<?php else: ?>
	<div class="a-table-wrap">
		<div class="a-table-scroll">
			<table class="a-table">
				<thead>
					<tr>
						<th>Nama</th>
						<th>Username</th>
						<th>Login Terakhir</th>
						<th class="a-num">Aksi</th>
					</tr>
				</thead>
				<tbody>
					<?php foreach ($admins as $a): ?>
						<tr>
							<td>
								<div class="flex items-center gap-3">
									<span class="a-avatar"><?php echo html_escape(strtoupper(mb_substr((string) $a->name, 0, 1))); ?></span>
									<span class="block">
										<span class="a-cell-main"><?php echo html_escape($a->name); ?></span>
										<?php if ((int) $a->id === (int) $this->session->userdata('admin_id')): ?>
											<span class="a-badge a-badge-ink a-badge-below">Anda</span>
										<?php endif; ?>
									</span>
								</div>
							</td>
							<td><span class="a-code"><?php echo html_escape($a->username); ?></span></td>
							<td class="whitespace-nowrap"><?php echo format_waktu($a->last_login); ?></td>
							<td class="a-num">
								<span class="a-actions">
									<a class="a-btn-icon" href="<?php echo base_url('admin/users/edit/' . (int) $a->id); ?>" title="Edit" aria-label="Edit <?php echo html_escape($a->name); ?>"><i class="bi bi-pencil-square"></i></a>
									<button form="delete-<?php echo (int) $a->id; ?>"
									        class="a-btn-icon is-danger"
									        title="Hapus" aria-label="Hapus <?php echo html_escape($a->name); ?>"
									        onclick="return confirm('Hapus pengguna ini?')"><i class="bi bi-trash"></i></button>
									<?php echo form_open('admin/users/delete/' . (int) $a->id, array('id' => 'delete-' . (int) $a->id, 'class' => 'hidden')); ?>
									<?php echo form_close(); ?>
								</span>
							</td>
						</tr>
					<?php endforeach; ?>
				</tbody>
			</table>
		</div>
	</div>
<?php endif; ?>
