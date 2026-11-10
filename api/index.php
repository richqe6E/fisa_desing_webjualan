<?php
/**
 * Vercel Serverless Function Entrypoint untuk CodeIgniter 3
 */

// Ubah working directory ke root proyek agar pemanggilan system & application tepat
chdir(dirname(__DIR__));

// Diagnostic helper jika diakses dengan parameter ?diag=1
if (isset($_GET['diag'])) {
    header('Content-Type: text/plain');
    echo "=== PHP ENVIRONMENT ===\n";
    echo "PHP Version: " . PHP_VERSION . "\n";
    echo "Loaded Extensions:\n";
    foreach (['pdo', 'pdo_pgsql', 'pgsql', 'mysqli', 'pdo_mysql', 'curl', 'openssl', 'mbstring'] as $ext) {
        echo "  - $ext: " . (extension_loaded($ext) ? 'YES' : 'NO') . "\n";
    }

    echo "\n=== ENVIRONMENT VARIABLES ===\n";
    $dbUrl = getenv('DATABASE_URL') ?: (isset($_ENV['DATABASE_URL']) ? $_ENV['DATABASE_URL'] : (isset($_SERVER['DATABASE_URL']) ? $_SERVER['DATABASE_URL'] : ''));
    echo "DATABASE_URL: " . (!empty($dbUrl) ? 'SET' : 'NOT SET') . "\n";
    echo "APP_BASE_URL: " . (getenv('APP_BASE_URL') ?: 'NOT SET') . "\n";
    echo "SUPABASE_URL: " . (getenv('SUPABASE_URL') ?: 'NOT SET') . "\n";
    echo "SUPABASE_KEY: " . (getenv('SUPABASE_KEY') ?: 'NOT SET') . "\n";

    if (!empty($dbUrl)) {
        echo "\n=== TESTING DATABASE CONNECTION ===\n";

        $atPos = strrpos($dbUrl, '@');
        $schemePos = strpos($dbUrl, '://');
        if ($atPos !== FALSE && $schemePos !== FALSE && $schemePos < $atPos) {
            $prefix = substr($dbUrl, 0, $schemePos + 3);
            $credentials = substr($dbUrl, $schemePos + 3, $atPos - ($schemePos + 3));
            $rest = substr($dbUrl, $atPos);

            $credentialsSafe = str_replace(array('#', '?'), array('%23', '%3F'), $credentials);
            $dbUrl = $prefix . $credentialsSafe . $rest;
        }

        $parts = parse_url($dbUrl);
        $host = $parts['host'] ?? '';
        $port = $parts['port'] ?? 5432;
        $user = rawurldecode($parts['user'] ?? '');
        $pass = rawurldecode($parts['pass'] ?? '');
        $name = ltrim($parts['path'] ?? '', '/');

        echo "Host: $host\n";
        echo "Port: $port\n";
        echo "User: $user\n";
        echo "Database: $name\n";

        if (extension_loaded('pdo_pgsql')) {
            try {
                $dsn = "pgsql:host=$host;port=$port;dbname=$name;sslmode=require";
                $pdo = new PDO($dsn, $user, $pass, [
                    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_TIMEOUT => 5
                ]);
                $stmt = $pdo->query("SELECT count(*) FROM stores");
                echo "PDO PostgreSQL Connection: SUCCESS! (stores count: " . $stmt->fetchColumn() . ")\n";
            } catch (Exception $e) {
                echo "PDO PostgreSQL Connection FAILED: " . $e->getMessage() . "\n";
            }
        } elseif (function_exists('pg_connect')) {
            $connStr = "host=$host port=$port dbname=$name user=$user password=$pass sslmode=require";
            $conn = @pg_connect($connStr);
            if ($conn) {
                echo "pg_connect Connection: SUCCESS!\n";
            } else {
                echo "pg_connect Connection FAILED\n";
            }
        } else {
            echo "Neither pdo_pgsql nor pgsql extension is loaded!\n";
        }
    }
    exit;
}

// Normalisasi SCRIPT_NAME dan PHP_SELF agar routing URI CodeIgniter membaca path asli
if (isset($_SERVER['SCRIPT_NAME']) && strpos($_SERVER['SCRIPT_NAME'], '/api/index.php') !== false) {
    $_SERVER['SCRIPT_NAME'] = '/index.php';
}
if (isset($_SERVER['PHP_SELF']) && strpos($_SERVER['PHP_SELF'], '/api/index.php') !== false) {
    $_SERVER['PHP_SELF'] = '/index.php';
}

require __DIR__ . '/../index.php';
