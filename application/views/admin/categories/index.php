<?php defined('BASEPATH') OR exit('No direct script access allowed'); ?>

<?php $this->load->view('admin/templates/page_header'); ?>

<?php if (empty($categories)): ?>
	<div class="a-empty">
		<i class="bi bi-tags"></i>
		<p>Belum ada kategori.</p>
		<a class="a-btn a-btn-ink" href="<?php echo base_url('admin/categories/add'); ?>"><i class="bi bi-plus-lg"></i> Tambah Kategori</a>
	</div>
<?php else: ?>
	<div class="a-table-wrap">
		<div class="a-table-scroll">
			<table class="a-table">
				<thead>
					<tr>
						<th>Nama</th>
						<th>Slug</th>
						<th>Produk</th>
						<th>Urutan</th>
						<th>Status</th>
						<th class="a-num">Aksi</th>
					</tr>
				</thead>
				<tbody>
					<?php foreach ($categories as $c): ?>
						<tr>
							<td>
								<span class="a-cell-main"><?php echo html_escape($c->name); ?></span>
								<?php if ( ! empty($c->description)): ?>
									<span class="a-cell-sub"><?php echo html_escape(mb_strimwidth($c->description, 0, 70, '…')); ?></span>
								<?php endif; ?>
							</td>
							<td><span class="a-code">/<?php echo html_escape($c->slug); ?></span></td>
							<td><?php echo isset($productCounts[(int) $c->id]) ? $productCounts[(int) $c->id] : 0; ?></td>
							<td><?php echo (int) $c->sort_order; ?></td>
							<td>
								<?php if ((int) $c->is_active === 1): ?>
									<span class="a-badge a-badge-ok"><i class="bi bi-check-circle"></i>Aktif</span>
								<?php else: ?>
									<span class="a-badge a-badge-off">Nonaktif</span>
								<?php endif; ?>
							</td>
							<td class="a-num">
								<span class="a-actions">
									<a class="a-btn-icon" href="<?php echo base_url('admin/categories/edit/' . (int) $c->id); ?>" title="Edit" aria-label="Edit <?php echo html_escape($c->name); ?>"><i class="bi bi-pencil-square"></i></a>
									<button form="delete-<?php echo (int) $c->id; ?>"
									        class="a-btn-icon is-danger"
									        title="Hapus" aria-label="Hapus <?php echo html_escape($c->name); ?>"
									        onclick="return confirm('Hapus kategori ini?')"><i class="bi bi-trash"></i></button>
									<?php echo form_open('admin/categories/delete/' . (int) $c->id, array('id' => 'delete-' . (int) $c->id, 'class' => 'hidden')); ?>
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
