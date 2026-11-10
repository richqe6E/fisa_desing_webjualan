<?php
/**
 * Vercel Serverless Function Entrypoint untuk CodeIgniter 3
 */

// Ubah working directory ke root proyek agar pemanggilan system & application tepat
chdir(dirname(__DIR__));

// Normalisasi SCRIPT_NAME dan PHP_SELF agar routing URI CodeIgniter membaca path asli
if (isset($_SERVER['SCRIPT_NAME']) && strpos($_SERVER['SCRIPT_NAME'], '/api/index.php') !== false) {
    $_SERVER['SCRIPT_NAME'] = '/index.php';
}
if (isset($_SERVER['PHP_SELF']) && strpos($_SERVER['PHP_SELF'], '/api/index.php') !== false) {
    $_SERVER['PHP_SELF'] = '/index.php';
}

require __DIR__ . '/../index.php';
