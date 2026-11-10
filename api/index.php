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

// Bersihkan environment variables dari kutip, spasi, atau newline
foreach (array('SUPABASE_URL', 'SUPABASE_KEY', 'SUPABASE_BUCKET', 'APP_BASE_URL') as $k) {
    $v = getenv($k);
    if ($v === false || $v === '') {
        $v = isset($_ENV[$k]) ? $_ENV[$k] : (isset($_SERVER[$k]) ? $_SERVER[$k] : null);
    }
    if ($v !== null) {
        $vClean = trim((string) $v, "\"' \t\n\r\0\x0B");
        putenv("{$k}={$vClean}");
        $_ENV[$k] = $vClean;
        $_SERVER[$k] = $vClean;
    }
}

require __DIR__ . '/../index.php';
