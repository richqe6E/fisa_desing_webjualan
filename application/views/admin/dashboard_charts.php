<?php defined('BASEPATH') OR exit('No direct script access allowed');

// Grafik batang kunjungan 7 hari (Chart.js CDN, hanya dimuat di dashboard).
?>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
<script>
(function () {
	'use strict';

	var el = document.getElementById('visitChart');
	if (!el || typeof Chart === 'undefined') {
		return;
	}

	var ink = '#1b1b1b';
	var muted = '#7a7a7a';

	new Chart(el, {
		type: 'bar',
		data: {
			labels: <?php echo json_encode(array_values($chartLabels)); ?>,
			datasets: [{
				label: 'Kunjungan',
				data: <?php echo json_encode(array_values($chartValues)); ?>,
				backgroundColor: ink,
				hoverBackgroundColor: '#e8a43a',
				borderRadius: 9,
				maxBarThickness: 46
			}]
		},
		options: {
			responsive: true,
			maintainAspectRatio: false,
			plugins: {
				legend: { display: false },
				tooltip: {
					displayColors: false,
					callbacks: {
						label: function (ctx) {
							return ctx.parsed.y + ' kunjungan';
						}
					}
				}
			},
			scales: {
				y: {
					beginAtZero: true,
					ticks: {
						precision: 0,
						color: muted,
						font: { family: 'Urbanist' }
					},
					grid: { color: '#ececec' },
					border: { display: false }
				},
				x: {
					ticks: { color: muted, font: { family: 'Urbanist' } },
					grid: { display: false },
					border: { display: false }
				}
			}
		}
	});
})();
</script>
