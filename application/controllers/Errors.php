<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * Handler 404 untuk rute yang tidak dikenali (dipetakan lewat
 * $route['404_override'] di application/config/routes.php).
 *
 * Halaman dirender memakai template situs publik supaya tampilannya seragam
 * dengan halaman lain (lihat MY_Controller::notFound()).
 */
class Errors extends MY_Controller {

	public function not_found()
	{
		$this->notFound();
	}
}
