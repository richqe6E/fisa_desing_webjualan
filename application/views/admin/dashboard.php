<?php defined('BASEPATH') OR exit('No direct script access allowed'); ?>

<?php $this->load->view('admin/templates/page_header'); ?>

<!-- Kartu statistik -->
<div class="grid grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
	<a class="a-stat" href="<?php echo base_url('admin/products'); ?>">
		<span class="a-stat-ic"><i class="bi bi-box-seam"></i></span>
		<span class="a-stat-body">
			<b><?php echo (int) $totalProducts; ?></b>
			<span class="a-stat-label">Produk</span>
		</span>
	</a>
	<a class="a-stat" href="<?php echo base_url('admin/categories'); ?>">
		<span class="a-stat-ic"><i class="bi bi-tags"></i></span>
		<span class="a-stat-body">
			<b><?php echo (int) $totalCategories; ?></b>
			<span class="a-stat-label">Kategori</span>
		</span>
	</a>
	<div class="a-stat">
		<span class="a-stat-ic"><i class="bi bi-people"></i></span>
		<span class="a-stat-body">
			<b><?php echo (int) $visitorsToday; ?></b>
			<span class="a-stat-label">Pengunjung Hari Ini</span>
		</span>
	</div>
	<div class="a-stat">
		<span class="a-stat-ic"><i class="bi bi-eye"></i></span>
		<span class="a-stat-body">
			<b><?php echo (int) $visitsTotal; ?></b>
			<span class="a-stat-label">Total Kunjungan</span>
		</span>
	</div>
</div>

<!-- Grafik kunjungan 7 hari -->
<div class="a-card mb-6">
	<h2 class="a-card-title">Kunjungan 7 Hari Terakhir</h2>
	<div class="a-chart">
		<canvas id="visitChart" aria-label="Grafik kunjungan 7 hari terakhir" role="img"></canvas>
	</div>
</div>

<!-- Top 5 produk terbanyak dilihat -->
<div class="a-card a-card-flush">
	<h2 class="a-card-title">Top 5 Produk Terbanyak Dilihat</h2>
<?php if (empty($topProducts)): ?>
	<div class="a-empty">
		<i class="bi bi-bar-chart"></i>
		<p>Belum ada data.</p>
	</div>
<?php else: ?>
	<div class="a-table-scroll">
		<table class="a-table">
			<thead>
				<tr>
					<th>Produk</th>
					<th class="a-num">Dilihat</th>
				</tr>
			</thead>
			<tbody>
<?php $no = 1; foreach ($topProducts as $p): ?>
				<tr>
					<td>
						<div class="flex items-center gap-3">
<?php if ($p->image): ?>
							<img class="a-thumb" src="<?php echo upload_asset_url($p->image, 'products'); ?>" alt="">
<?php else: ?>
							<span class="a-thumb-empty"><i class="bi bi-image"></i></span>
<?php endif; ?>
							<span>
								<span class="a-cell-main"><?php echo $no++; ?>. <?php echo html_escape($p->name); ?></span>
								<span class="a-cell-sub"><?php echo html_escape($p->category_name ?? '-'); ?> &middot; <?php echo format_rupiah($p->price); ?></span>
							</span>
						</div>
					</td>
					<td class="a-num"><strong><?php echo (int) $p->views; ?></strong></td>
				</tr>
<?php endforeach; ?>
			</tbody>
		</table>
	</div>
<?php endif; ?>
</div>
