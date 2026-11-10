/*
 * yStore — JS panel admin.
 * Saat ini hanya menangani drawer sidebar mobile
 * (buka/tutup via tombol, backdrop, dan tombol Esc).
 */
(function () {
	'use strict';

	var side = document.getElementById('adminSidebar');
	var openBtn = document.getElementById('menuBtn');
	var closeBtn = document.getElementById('sidebarClose');
	var backdrop = document.getElementById('sidebarBackdrop');

	if (!side) {
		return;
	}

	function open() {
		side.classList.add('is-open');
		if (backdrop) {
			backdrop.hidden = false;
		}
		if (openBtn) {
			openBtn.setAttribute('aria-expanded', 'true');
		}
		document.body.style.overflow = 'hidden';
	}

	function close() {
		side.classList.remove('is-open');
		if (backdrop) {
			backdrop.hidden = true;
		}
		if (openBtn) {
			openBtn.setAttribute('aria-expanded', 'false');
		}
		document.body.style.overflow = '';
	}

	if (openBtn) {
		openBtn.addEventListener('click', open);
	}
	if (closeBtn) {
		closeBtn.addEventListener('click', close);
	}
	if (backdrop) {
		backdrop.addEventListener('click', close);
	}

	document.addEventListener('keydown', function (e) {
		if (e.key === 'Escape' && side.classList.contains('is-open')) {
			close();
		}
	});

	// Tutup drawer setelah link navigasi diklik (pindah halaman)
	side.addEventListener('click', function (e) {
		if (e.target.closest('a')) {
			close();
		}
	});
})();
