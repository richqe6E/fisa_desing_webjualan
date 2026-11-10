<?php defined('BASEPATH') OR exit('No direct script access allowed'); ?>

<div class="container">
<nav class="crumbs" aria-label="Breadcrumb">
	<a href="<?php echo base_url(); ?>">Beranda</a><i class="bi bi-chevron-right" data-fb="›"></i><a href="<?php echo base_url('produk'); ?>">Produk</a><i class="bi bi-chevron-right" data-fb="›"></i><span id="crumbName" aria-current="page"></span>
</nav>

<!-- Detail produk dirender oleh assets/template/product.js dari endpoint JSON -->
<div id="pd" class="pd-grid"></div>

<section class="products related" id="relatedSec">
	<h2 data-reveal>Produk Terkait</h2>
	<div class="grid" id="related"></div>
</section>
</div>
