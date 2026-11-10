<?php defined('BASEPATH') OR exit('No direct script access allowed'); ?>

<?php $this->load->view('admin/templates/page_header'); ?>

<?php if (empty($products)): ?>
	<div class="a-empty">
		<i class="bi bi-box-seam"></i>
		<p>Belum ada produk.</p>
		<a class="a-btn a-btn-ink" href="<?php echo base_url('admin/products/add'); ?>"><i class="bi bi-plus-lg"></i> Tambah Produk</a>
	</div>
<?php else: ?>
	<div class="a-table-wrap">
		<div class="a-table-scroll">
			<table class="a-table">
				<thead>
					<tr>
						<th>Gambar</th>
						<th>Nama</th>
						<th>Kategori</th>
						<th>Harga</th>
						<th>Stok</th>
						<th>Dilihat</th>
						<th>Status</th>
						<th class="a-num">Aksi</th>
					</tr>
				</thead>
				<tbody>
					<?php foreach ($products as $p): ?>
						<tr>
							<td>
								<?php if ($p->image): ?>
									<img class="a-thumb" src="<?php echo base_url('assets/uploads/products/' . html_escape($p->image)); ?>" alt="">
								<?php else: ?>
									<span class="a-thumb-empty"><i class="bi bi-image"></i></span>
								<?php endif; ?>
							</td>
							<td>
								<span class="a-cell-main"><?php echo html_escape($p->name); ?></span>
								<span class="a-cell-sub">/<?php echo html_escape($p->slug); ?></span>
							</td>
							<td><?php echo html_escape($p->category_name ?? '-'); ?></td>
							<td class="whitespace-nowrap"><?php echo format_rupiah($p->price); ?></td>
							<td><?php echo (int) $p->stock; ?></td>
							<td><?php echo (int) $p->views; ?></td>
							<td>
								<?php if ((int) $p->is_active === 1): ?>
									<span class="a-badge a-badge-ok"><i class="bi bi-check-circle"></i>Aktif</span>
								<?php else: ?>
									<span class="a-badge a-badge-off">Nonaktif</span>
								<?php endif; ?>
							</td>
							<td class="a-num">
								<span class="a-actions">
									<a class="a-btn-icon" href="<?php echo base_url('admin/products/edit/' . (int) $p->id); ?>" title="Edit" aria-label="Edit <?php echo html_escape($p->name); ?>"><i class="bi bi-pencil-square"></i></a>
									<button form="delete-<?php echo (int) $p->id; ?>"
									        class="a-btn-icon is-danger"
									        title="Hapus" aria-label="Hapus <?php echo html_escape($p->name); ?>"
									        onclick="return confirm('Hapus produk ini beserta gambarnya?')"><i class="bi bi-trash"></i></button>
									<?php echo form_open('admin/products/delete/' . (int) $p->id, array('id' => 'delete-' . (int) $p->id, 'class' => 'hidden')); ?>
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
