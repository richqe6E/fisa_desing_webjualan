<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * SEO: robots.txt dan sitemap.xml.
 *
 * Keduanya dibuat dinamis (bukan file statis) supaya selalu memakai alamat
 * situs yang benar dari base_url() dan sitemap ikut berubah begitu produk
 * ditambah/diubah dari panel admin.
 *
 * Sengaja tidak extends MY_Controller: permintaan robot/sitemap tidak perlu
 * dicatat sebagai kunjungan di visitor_logs (sama seperti endpoint Api).
 */
class Seo extends CI_Controller {

	// robots.txt
	public function robots()
	{
		$lines = array(
			'User-agent: *',
			'Allow: /',
			'Disallow: /admin',
			'Disallow: /api/',
			'',
			'Sitemap: ' . base_url('sitemap.xml'),
		);

		$this->output
			->set_content_type('text/plain', 'utf-8')
			->set_output(implode("\n", $lines) . "\n");
	}

	// sitemap.xml (semua produk aktif + halaman tetap)
	public function sitemap()
	{
		$this->load->model('Product_model');

		$urls = array(
			array('loc' => base_url(),                      'priority' => '1.0'),
			array('loc' => base_url('produk'),              'priority' => '0.9'),
			array('loc' => base_url('tentang'),             'priority' => '0.6'),
			array('loc' => base_url('syarat-ketentuan'),    'priority' => '0.3'),
			array('loc' => base_url('kebijakan-privasi'),   'priority' => '0.3'),
		);

		foreach ($this->Product_model->getProducts() as $product)
		{
			$ts = strtotime((string) $product->updated_at);

			$urls[] = array(
				'loc'      => base_url('produk/' . $product->slug),
				'lastmod'  => ($ts !== FALSE) ? date('Y-m-d', $ts) : NULL,
				'priority' => '0.8',
			);
		}

		$xml = '<?xml version="1.0" encoding="UTF-8"?>' . "\n"
			. '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' . "\n";

		foreach ($urls as $url)
		{
			$xml .= "\t<url>\n"
				. "\t\t<loc>" . html_escape($url['loc']) . "</loc>\n";

			if ( ! empty($url['lastmod']))
			{
				$xml .= "\t\t<lastmod>" . $url['lastmod'] . "</lastmod>\n";
			}

			$xml .= "\t\t<priority>" . $url['priority'] . "</priority>\n"
				. "\t</url>\n";
		}

		$xml .= '</urlset>';

		$this->output
			->set_content_type('application/xml', 'utf-8')
			->set_output($xml);
	}
}
