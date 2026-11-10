<?php defined('BASEPATH') OR exit('No direct script access allowed');

$storeName = $this->store->name ?? 'yStore';
$waNumber  = preg_replace('/[^0-9]/', '', (string) ($this->store->whatsapp ?? ''));
$flash     = $this->session->flashdata('message') ?: $this->session->flashdata('error');

// Sosmed: kosong = tautan (dan kolomnya) disembunyikan
$instagram = social_url($this->store->instagram ?? '', 'instagram.com');
$facebook  = social_url($this->store->facebook ?? '', 'facebook.com');
?>
</main>

<footer id="footer" class="footer">
	<div class="container fgrid<?php echo ($instagram === '' && $facebook === '') ? ' fgrid-3' : ''; ?>">
		<div class="fcol fbrand">
			<a href="<?php echo base_url(); ?>" class="logo flogo"><svg class="logo-mark" viewBox="0 0 24 24" width="26" height="26" fill="currentColor"><path d="M12 0c1 6.5 5.500 11 12 12-6.500 1-11 5.500-12 12-1-6.500-5.500-11-12-12C6.500 11 11 6.500 12 0z"/></svg><?php echo html_escape($storeName); ?></a>
<?php if ( ! empty($this->store->about)): ?>
			<span><?php echo html_escape($this->store->about); ?></span>
<?php endif; ?>
		</div>
		<div class="fcol"><h4>Menu</h4><a href="<?php echo base_url('produk'); ?>">Produk</a><a href="<?php echo base_url('tentang'); ?>">Tentang Kami</a></div>
		<div class="fcol"><h4>Hubungi Kami</h4>
<?php if ( ! empty($this->store->address)): ?>
			<span><?php echo html_escape($this->store->address); ?></span>
<?php endif; ?>
<?php if ( ! empty($this->store->phone)): ?>
			<span><?php echo html_escape($this->store->phone); ?></span>
<?php endif; ?>
<?php if ($waNumber !== ''): ?>
			<a href="https://wa.me/<?php echo $waNumber; ?>" class="u">WhatsApp</a>
<?php endif; ?>
		</div>
<?php if ($instagram !== '' || $facebook !== ''): ?>
		<div class="fcol"><h4>Sosial</h4>
<?php if ($instagram !== ''): ?>
			<a href="<?php echo html_escape($instagram); ?>" target="_blank" rel="noopener noreferrer">Instagram</a>
<?php endif; ?>
<?php if ($facebook !== ''): ?>
			<a href="<?php echo html_escape($facebook); ?>" target="_blank" rel="noopener noreferrer">Facebook</a>
<?php endif; ?>
		</div>
<?php endif; ?>
	</div>
	<div class="container fbot"><small>&copy; <?php echo date('Y') . ' ' . html_escape($storeName); ?></small><span><a href="<?php echo base_url('syarat-ketentuan'); ?>">Syarat &amp; Ketentuan</a><a href="<?php echo base_url('kebijakan-privasi'); ?>">Kebijakan Privasi</a></span></div>
</footer>

<!-- Panel keranjang (sisi kanan) -->
<dialog id="cartDialog" aria-labelledby="cartTitle">
	<div class="cart-head"><h3 id="cartTitle">Keranjang <span id="cartQty">(0)</span></h3><button id="cartClose" class="cart-x" aria-label="Tutup keranjang"><i class="bi bi-x-lg" data-fb="×"></i></button></div>
	<ul id="cartList" class="cart-list"></ul>
	<div id="cartEmpty" class="cart-empty"><i class="bi bi-bag" data-fb="🛒"></i><p>Keranjang masih kosong.</p><a href="<?php echo base_url('produk'); ?>" class="btn-dark" id="cartShop">Lihat produk</a></div>
	<div id="cartFoot" class="cart-foot" hidden>
		<div class="cart-total"><span>Total</span><strong id="cartTotal">Rp 0</strong></div>
		<button class="btn-dark cart-checkout" id="cartCheckout">Checkout <span class="arrow"><i class="bi bi-arrow-up-right" data-fb="↗"></i></span></button>
		<button class="cart-clear" id="cartClear">Kosongkan keranjang</button>
	</div>
</dialog>
<div id="toast" class="toast" role="status" aria-live="polite"></div>

<script src="<?php echo base_url('assets/template/products.js'); ?>"></script>
<?php if (isset($page_script) && $page_script !== ''): ?>
<script src="<?php echo base_url(html_escape($page_script)); ?>"></script>
<?php endif; ?>
<script src="<?php echo base_url('assets/template/script.js'); ?>"></script>
<?php if ($flash !== '' && $flash !== NULL): ?>
<script>if (window.toast) { toast(<?php echo json_encode((string) $flash, JSON_UNESCAPED_UNICODE); ?>); }</script>
<?php endif; ?>

</body>
</html>
