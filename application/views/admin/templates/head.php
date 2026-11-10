<?php defined('BASEPATH') OR exit('No direct script access allowed');

// Head halaman admin (dipakai templates/header.php dan login.php):
// font Urbanist, Tailwind + konfigurasi brand, Bootstrap Icons, admin.css.
$storeName = $this->store->name ?? 'yStore';
?>
<!DOCTYPE html>
<html lang="id">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title><?php echo isset($title) ? 'Admin &middot; ' . html_escape($title) . ' &middot; ' : 'Admin &middot; '; echo html_escape($storeName); ?></title>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Urbanist:wght@400;500;600;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
	<script src="https://cdn.tailwindcss.com"></script>
	<script>
	tailwind.config = {
		theme: {
			extend: {
				fontFamily: { sans: ['Urbanist', 'system-ui', 'sans-serif'] },
				colors: {
					ink: '#1b1b1b',
					muted: '#7a7a7a',
					soft: '#f6f6f6',
					line: '#dcdcdc',
					accent: '#e8a43a'
				}
			}
		}
	};
	</script>
	<link rel="stylesheet" href="<?php echo base_url('assets/admin/admin.css'); ?>">
</head>
<body class="a-admin">
