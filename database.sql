-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 15 Okt 2026 pada 12.01
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ystore`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `admins`
--

CREATE TABLE `admins` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `admins`
--

INSERT INTO `admins` (`id`, `name`, `username`, `password`, `last_login`, `created_at`, `updated_at`) VALUES
(1, 'Admin yStore', 'admin', '$2y$10$x/0bsxlX/4QBzqATabWEcu8P7bCCRdJoSbFea.Cgn4OKkgEy6MyCa', '2026-10-15 07:40:04', '2026-10-04 09:42:19', '2026-10-15 12:40:04');

-- --------------------------------------------------------

--
-- Struktur dari tabel `categories`
--

CREATE TABLE `categories` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `description`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Pria', 'pria', 'Pakaian pria casual dan semi-formal', 1, 1, '2026-10-04 09:42:19', '2026-10-04 09:42:19'),
(2, 'Wanita', 'wanita', 'Pakaian wanita harian dan acara', 2, 1, '2026-10-04 09:42:19', '2026-10-04 09:42:19'),
(3, 'Anak-anak', 'anak-anak', 'Pakaian anak yang nyaman dan aman', 3, 1, '2026-10-04 09:42:19', '2026-10-04 09:42:19');

-- --------------------------------------------------------

--
-- Struktur dari tabel `login_attempts`
--

CREATE TABLE `login_attempts` (
  `id` int(11) UNSIGNED NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `attempted_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `products`
--

CREATE TABLE `products` (
  `id` int(11) UNSIGNED NOT NULL,
  `category_id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `image` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `views` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `slug`, `description`, `price`, `stock`, `image`, `is_active`, `views`, `created_at`, `updated_at`) VALUES
(1, 1, 'Kaos Oversize Premium', 'kaos-oversize-premium', 'Kaos oversize berbahan cotton combed 30s, potongan longgar dan nyaman dipakai sehari-hari. Tersedia dalam beberapa pilihan warna netral.', 79000.00, 50, 'kaos-oversize-premium-1.jpg', 1, 12, '2026-10-12 04:31:17', '2026-10-15 13:42:35'),
(2, 1, 'Kaos Polos Lengan Pendek', 'kaos-polos-lengan-pendek', 'Kaos polos basic dengan jahitan rapi, bahan serap keringat dan awet meskipun dicuci berkali-kali.', 65000.00, 60, 'kaos-polos-lengan-pendek-1.jpg', 1, 3, '2026-10-12 04:32:17', '2026-10-13 14:10:22'),
(3, 1, 'Kemeja Lengan Pendek', 'kemeja-lengan-pendek', 'Kemeja casual berbahan katun lembut, cocok untuk harian maupun semi-formal.', 129000.00, 30, 'kemeja-lengan-pendek-1.jpg', 1, 2, '2026-10-12 04:33:17', '2026-10-15 12:33:43'),
(4, 1, 'Kemeja Kerja Katun', 'kemeja-kerja-katun', 'Kemeja kerja rapi berbahan katun stretch, nyaman dipakai seharian di kantor.', 149000.00, 25, 'kemeja-kerja-katun-1.jpg', 1, 2, '2026-10-12 04:34:17', '2026-10-15 16:32:41'),
(5, 1, 'Jaket Denim Pria', 'jaket-denim-pria', 'Jaket denim klasik dengan jahitan kuat, cocok untuk gaya street maupun kasual.', 249000.00, 20, 'jaket-denim-pria-1.jpg', 1, 10, '2026-10-12 04:35:17', '2026-10-15 16:12:50'),
(6, 1, 'Hoodie Fleece Hangat', 'hoodie-fleece-hangat', 'Hoodie berbahan fleece lembut, hangat untuk cuaca sejuk dan dilengkapi saku kanggung.', 179000.00, 35, 'hoodie-fleece-hangat-1.jpg', 1, 2, '2026-10-12 04:36:17', '2026-10-15 16:12:18'),
(7, 2, 'Dress Floral Musim Panas', 'dress-floral-musim-panas', 'Dress motif floral dengan potongan A-line, ringan dan menyerap keringat.', 149000.00, 25, 'dress-floral-musim-panas-1.jpg', 1, 0, '2026-10-12 04:37:17', '2026-10-12 04:49:17'),
(8, 2, 'Blouse Ruffle', 'blouse-ruffle', 'Blouse aksen ruffle di lengan, tampilan feminine dan elegan untuk berbagai acara.', 119000.00, 20, 'blouse-ruffle-1.jpg', 1, 1, '2026-10-12 04:38:17', '2026-10-15 16:11:33'),
(9, 2, 'Gaun Pesta Elegan', 'gaun-pesta-elegan', 'Gaun pesta panjang dengan detail kain mengalir, tampilan mewah untuk acara spesial.', 229000.00, 15, 'gaun-pesta-elegan-1.jpg', 1, 0, '2026-10-12 04:39:17', '2026-10-12 04:49:17'),
(10, 2, 'Dress Kasual Summer', 'dress-kasual-summer', 'Dress kasual berpotongan lurus, mudah dipadukan dengan sandal maupun sepatu.', 139000.00, 28, 'dress-kasual-summer-1.jpg', 1, 0, '2026-10-12 04:40:17', '2026-10-12 04:49:17'),
(11, 2, 'Maxi Dress', 'maxi-dress', 'Maxi dress dengan kain jatuh lurus, nyaman dan sopan untuk berbagai kesempatan.', 169000.00, 22, 'maxi-dress-1.jpg', 1, 0, '2026-10-12 04:41:17', '2026-10-12 04:49:17'),
(12, 2, 'Outfit Wanita Kasual', 'outfit-wanita-kasual', 'Padu padan atasan dan bawahan kasual, tampilan simpel namun tetap stylish.', 189000.00, 18, '104ffd367ffd532b69523d3ad63be5a0.jpg', 1, 0, '2026-10-12 04:42:17', '2026-10-12 05:07:06'),
(13, 3, 'Kaos Anak Karakter', 'kaos-anak-karakter', 'Kaos anak dengan motif karakter favorit, bahan lembut dan aman untuk kulit anak.', 59000.00, 40, 'b3c62e3cb7392f7120b2e8a4ca155180.jpg', 1, 2, '2026-10-12 04:43:17', '2026-10-13 08:07:14'),
(14, 3, 'Baju Bayi Lengan Panjang', 'baju-bayi-lengan-panjang', 'Baju bayi berbahan cotton halus, lembut dan nyaman untuk kulit sensitif bayi.', 55000.00, 45, 'a135b11e7d5258301b1e7441b1ce9364.jpg', 1, 0, '2026-10-12 04:44:17', '2026-10-12 05:07:41'),
(15, 3, 'Kaos Anak Kasual', 'kaos-anak-kasual', 'Kaos anak casual berbahan cotton combed, nyaman dipakai untuk bermain.', 49000.00, 50, 'fa7c1d53352c2fa54024ff2d4d2d0db9.jpg', 1, 1, '2026-10-12 04:45:17', '2026-10-12 05:06:29'),
(16, 3, 'Setelan Anak', 'setelan-anak', 'Setelan anak lengkap dengan bahan adem, cocok untuk acara keluarga dan sekolah.', 99000.00, 30, 'setelan-anak-1.jpg', 1, 9, '2026-10-12 04:46:17', '2026-10-13 14:33:26'),
(17, 3, 'Celana Pendek Anak', 'celana-pendek-anak', 'Celana pendek anak berbahan katun stretch, nyaman untuk aktivitas harian.', 75000.00, 35, '520e776fb074dd77fdc6449e3e828cb8.jpg', 1, 8, '2026-10-12 04:47:17', '2026-10-15 16:32:50'),
(18, 3, 'Kaos Bayi Motif', 'kaos-bayi-motif', 'Kaos bayi dengan motif lucu, bahan lembut dan mudah dicuci.', 45000.00, 55, '342328386b6be9d1c782858648930e55.jpg', 1, 2, '2026-10-12 04:48:17', '2026-10-13 10:40:19');

-- --------------------------------------------------------

--
-- Struktur dari tabel `product_images`
--

CREATE TABLE `product_images` (
  `id` int(11) UNSIGNED NOT NULL,
  `product_id` int(11) UNSIGNED NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `file_name`, `sort_order`, `created_at`) VALUES
(1, 1, 'kaos-oversize-premium-2.jpg', 1, '2026-10-12 03:26:52'),
(2, 1, 'kaos-oversize-premium-3.jpg', 2, '2026-10-12 03:26:52'),
(3, 2, 'kaos-polos-lengan-pendek-2.jpg', 1, '2026-10-12 03:26:52'),
(4, 2, 'kaos-polos-lengan-pendek-3.jpg', 2, '2026-10-12 03:26:52'),
(5, 3, 'kemeja-lengan-pendek-2.jpg', 1, '2026-10-12 03:26:52'),
(6, 3, 'kemeja-lengan-pendek-3.jpg', 2, '2026-10-12 03:26:52'),
(7, 4, 'kemeja-kerja-katun-2.jpg', 1, '2026-10-12 03:26:52'),
(8, 4, 'kemeja-kerja-katun-3.jpg', 2, '2026-10-12 03:26:52'),
(9, 5, 'jaket-denim-pria-2.jpg', 1, '2026-10-12 03:26:52'),
(10, 5, 'jaket-denim-pria-3.jpg', 2, '2026-10-12 03:26:52'),
(11, 6, 'hoodie-fleece-hangat-2.jpg', 1, '2026-10-12 03:26:52'),
(12, 6, 'hoodie-fleece-hangat-3.jpg', 2, '2026-10-12 03:26:52'),
(13, 7, 'dress-floral-musim-panas-2.jpg', 1, '2026-10-12 03:26:52'),
(14, 7, 'dress-floral-musim-panas-3.jpg', 2, '2026-10-12 03:26:52'),
(15, 8, 'blouse-ruffle-2.jpg', 1, '2026-10-12 03:26:52'),
(16, 8, 'blouse-ruffle-3.jpg', 2, '2026-10-12 03:26:52'),
(17, 9, 'gaun-pesta-elegan-2.jpg', 1, '2026-10-12 03:26:52'),
(18, 9, 'gaun-pesta-elegan-3.jpg', 2, '2026-10-12 03:26:52'),
(19, 10, 'dress-kasual-summer-2.jpg', 1, '2026-10-12 03:26:52'),
(20, 10, 'dress-kasual-summer-3.jpg', 2, '2026-10-12 03:26:52'),
(21, 11, 'maxi-dress-2.jpg', 1, '2026-10-12 03:26:52'),
(22, 11, 'maxi-dress-3.jpg', 2, '2026-10-12 03:26:52'),
(23, 12, 'outfit-wanita-kasual-2.jpg', 1, '2026-10-12 03:26:52'),
(24, 12, 'outfit-wanita-kasual-3.jpg', 2, '2026-10-12 03:26:52'),
(25, 13, 'kaos-anak-karakter-2.jpg', 1, '2026-10-12 03:26:52'),
(26, 13, 'kaos-anak-karakter-3.jpg', 2, '2026-10-12 03:26:52'),
(27, 14, 'baju-bayi-lengan-panjang-2.jpg', 1, '2026-10-12 03:26:52'),
(28, 14, 'baju-bayi-lengan-panjang-3.jpg', 2, '2026-10-12 03:26:52'),
(29, 15, 'kaos-anak-kasual-2.jpg', 1, '2026-10-12 03:26:52'),
(30, 15, 'kaos-anak-kasual-3.jpg', 2, '2026-10-12 03:26:52'),
(31, 16, 'setelan-anak-2.jpg', 1, '2026-10-12 03:26:52'),
(32, 16, 'setelan-anak-3.jpg', 2, '2026-10-12 03:26:52'),
(33, 17, 'celana-pendek-anak-2.jpg', 1, '2026-10-12 03:26:52'),
(34, 17, 'celana-pendek-anak-3.jpg', 2, '2026-10-12 03:26:52'),
(35, 18, 'kaos-bayi-motif-2.jpg', 1, '2026-10-12 03:26:52'),
(36, 18, 'kaos-bayi-motif-3.jpg', 2, '2026-10-12 03:26:52');

-- --------------------------------------------------------

--
-- Struktur dari tabel `stores`
--

CREATE TABLE `stores` (
  `id` int(11) UNSIGNED NOT NULL DEFAULT 1,
  `name` varchar(100) NOT NULL,
  `tagline` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `whatsapp` varchar(30) DEFAULT NULL COMMENT 'angka saja, diawali kode negara, mis. 6281234567890',
  `about` text DEFAULT NULL,
  `hero_line1` varchar(255) DEFAULT NULL COMMENT 'teks judul beranda baris 1, penanda [gambar]',
  `hero_line2` varchar(255) DEFAULT NULL COMMENT 'teks judul beranda baris 2, penanda [gambar]',
  `hero_pill1` varchar(255) DEFAULT NULL COMMENT 'gambar judul 1: nama file di assets/uploads/hero/ atau URL http(s); kosong = tanpa gambar',
  `hero_pill2` varchar(255) DEFAULT NULL COMMENT 'gambar judul 2: sama seperti hero_pill1',
  `logo` varchar(255) DEFAULT NULL,
  `instagram` varchar(255) DEFAULT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `stores`
--

INSERT INTO `stores` (`id`, `name`, `tagline`, `address`, `phone`, `whatsapp`, `about`, `hero_line1`, `hero_line2`, `hero_pill1`, `hero_pill2`, `logo`, `instagram`, `facebook`, `created_at`, `updated_at`) VALUES
(1, 'yStore', 'Koleksi pakaian kekinian, harga ramah kantong', 'Jl. Alamat lengkap No.123, Makassar, Sulawesi Selatan', '0411-0123456', '6281234567890', 'yStore adalah toko online pakaian dengan koleksi pria, wanita, dan anak-anak. Kami mengutamakan kualitas bahan, harga ramah kantong, dan layanan cepat lewat WhatsApp.', 'Tampilan [gambar] Kekinian', 'dengan [gambar] Harga Bersahabat', '1c973eac6a907d234592d925188b6c17.jpg', 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?auto=format&fit=crop&w=220&h=88&q=75', '77adf89785afd16673a4c7efb13e06f5.png', '', '', '2026-10-04 09:42:19', '2026-10-15 16:27:31');

-- --------------------------------------------------------

--
-- Struktur dari tabel `visitor_logs`
--

CREATE TABLE `visitor_logs` (
  `id` int(11) UNSIGNED NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `page_url` varchar(255) NOT NULL,
  `visited_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `visitor_logs`
--

INSERT INTO `visitor_logs` (`id`, `ip_address`, `user_agent`, `page_url`, `visited_at`) VALUES
(1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-04 04:49:02'),
(2, '::1', 'curl/8.21.0', '', '2026-10-04 04:49:54'),
(3, '::1', 'curl/8.21.0', 'produk', '2026-10-04 04:49:54'),
(4, '::1', 'curl/8.21.0', 'produk/kaos-oversize-premium', '2026-10-04 04:49:54'),
(5, '::1', 'curl/8.21.0', 'tentang', '2026-10-04 04:49:54'),
(6, '::1', 'curl/8.21.0', 'keranjang', '2026-10-04 04:49:54'),
(7, '::1', 'curl/8.21.0', 'cart/checkout', '2026-10-04 04:49:54'),
(8, '::1', 'curl/8.21.0', 'produk/page/2', '2026-10-04 04:49:54'),
(9, '::1', 'curl/8.21.0', '', '2026-10-04 04:50:31'),
(10, '::1', 'curl/8.21.0', '', '2026-10-04 04:50:31'),
(11, '::1', 'curl/8.21.0', '', '2026-10-04 04:51:24'),
(12, '::1', 'curl/8.21.0', 'produk', '2026-10-04 04:51:25'),
(13, '::1', 'curl/8.21.0', 'produk/kaos-oversize-premium', '2026-10-04 04:51:25'),
(14, '::1', 'curl/8.21.0', 'tentang', '2026-10-04 04:51:25'),
(15, '::1', 'curl/8.21.0', 'keranjang', '2026-10-04 04:51:25'),
(16, '::1', 'curl/8.21.0', 'produk/page/2', '2026-10-04 04:51:25'),
(17, '::1', 'curl/8.21.0', '', '2026-10-04 04:51:25'),
(18, '::1', 'curl/8.21.0', 'produk/kaos-oversize-premium', '2026-10-04 04:55:59'),
(19, '::1', 'curl/8.21.0', 'cart/add', '2026-10-04 04:55:59'),
(20, '::1', 'curl/8.21.0', 'keranjang', '2026-10-04 04:55:59'),
(21, '::1', 'curl/8.21.0', 'cart/checkout', '2026-10-04 04:55:59'),
(22, '::1', 'curl/8.21.0', 'cart/checkout', '2026-10-04 04:55:59'),
(23, '::1', 'curl/8.21.0', 'produk', '2026-10-04 04:56:03'),
(24, '::1', 'curl/8.21.0', 'produk', '2026-10-04 04:56:28'),
(25, '::1', 'curl/8.21.0', 'produk', '2026-10-04 04:57:16'),
(26, '::1', 'curl/8.21.0', 'produk', '2026-10-04 04:58:10'),
(27, '::1', 'curl/8.21.0', 'produk', '2026-10-04 05:00:11'),
(28, '::1', 'curl/8.21.0', 'produk', '2026-10-04 05:00:34'),
(29, '::1', 'curl/8.21.0', 'produk', '2026-10-04 05:03:07'),
(30, '::1', 'curl/8.21.0', '', '2026-10-04 05:04:25'),
(31, '::1', 'curl/8.21.0', 'produk', '2026-10-04 05:04:25'),
(32, '::1', 'curl/8.21.0', 'produk/kaos-oversize-premium', '2026-10-04 05:04:25'),
(33, '::1', 'curl/8.21.0', 'tentang', '2026-10-04 05:04:26'),
(34, '::1', 'curl/8.21.0', 'keranjang', '2026-10-04 05:04:26'),
(35, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-04 05:14:16'),
(36, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-04 05:14:21'),
(37, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-04 05:14:23'),
(38, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'keranjang', '2026-10-04 05:14:26'),
(39, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-04 05:14:28'),
(40, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-04 05:15:58'),
(41, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-04 05:16:01'),
(42, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-04 05:16:03'),
(43, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kaos-oversize-premium', '2026-10-04 05:16:04'),
(44, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'cart/add', '2026-10-04 05:16:10'),
(45, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'keranjang', '2026-10-04 05:16:10'),
(46, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'cart/checkout', '2026-10-04 05:16:15'),
(47, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'keranjang', '2026-10-04 05:16:24'),
(48, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-04 05:16:26'),
(49, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-04 05:16:27'),
(50, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-04 05:16:28'),
(51, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-04 05:16:29'),
(52, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-04 05:16:29'),
(53, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-04 05:16:30'),
(54, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-04 05:17:15'),
(55, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-04 05:17:16'),
(56, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-04 05:17:16'),
(57, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-04 05:17:19'),
(58, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-04 05:17:56'),
(59, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kaos-oversize-premium', '2026-10-04 05:17:57'),
(60, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-04 05:18:10'),
(61, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-04 05:18:13'),
(62, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-04 05:18:14'),
(63, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-04 05:18:15'),
(64, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-04 05:18:15'),
(65, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-04 05:18:16'),
(66, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-04 05:18:16'),
(67, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-07 22:29:41'),
(68, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kemeja-lengan-pendek', '2026-10-07 22:29:45'),
(69, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-07 22:29:51'),
(70, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-07 22:29:54'),
(71, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-07 22:29:55'),
(72, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-08 05:03:06'),
(73, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-08 05:03:11'),
(74, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-08 05:03:13'),
(75, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-08 05:03:14'),
(76, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-08 05:03:14'),
(77, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-08 05:03:15'),
(78, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-08 05:03:16'),
(79, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'keranjang', '2026-10-08 05:03:17'),
(80, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-08 05:03:18'),
(81, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-08 05:03:18'),
(82, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-08 05:03:19'),
(83, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'keranjang', '2026-10-08 05:03:19'),
(84, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-08 05:03:20'),
(85, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-08 05:03:21'),
(86, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-08 05:03:22'),
(87, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-08 05:03:49'),
(88, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kaos-oversize-premium', '2026-10-08 05:03:50'),
(89, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'cart/add', '2026-10-08 05:03:51'),
(90, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'keranjang', '2026-10-08 05:03:51'),
(91, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-08 05:03:55'),
(92, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kemeja-lengan-pendek', '2026-10-08 05:03:56'),
(93, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'cart/add', '2026-10-08 05:03:57'),
(94, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'keranjang', '2026-10-08 05:03:57'),
(95, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'cart/checkout', '2026-10-08 05:03:58'),
(96, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'keranjang', '2026-10-08 05:04:00'),
(97, '::1', 'curl/8.21.0', '', '2026-10-08 09:19:04'),
(98, '::1', 'curl/8.21.0', '', '2026-10-08 09:19:12'),
(99, '::1', 'curl/8.21.0', 'produk', '2026-10-08 09:19:12'),
(100, '::1', 'curl/8.21.0', 'produk/kaos-oversize-premium', '2026-10-08 09:19:12'),
(101, '::1', 'curl/8.21.0', 'tentang', '2026-10-08 09:19:12'),
(102, '::1', 'curl/8.21.0', '', '2026-10-08 09:19:22'),
(103, '::1', 'curl/8.21.0', '', '2026-10-08 09:19:22'),
(104, '::1', 'curl/8.21.0', '', '2026-10-08 09:19:22'),
(105, '::1', 'curl/8.21.0', 'produk', '2026-10-08 09:19:22'),
(106, '::1', 'curl/8.21.0', 'produk/kaos-oversize-premium', '2026-10-08 09:19:22'),
(107, '::1', 'curl/8.21.0', 'produk/kaos-oversize-premium', '2026-10-08 09:19:23'),
(108, '::1', 'curl/8.21.0', 'produk', '2026-10-08 09:19:23'),
(109, '::1', 'curl/8.21.0', 'keranjang', '2026-10-08 09:21:40'),
(110, '::1', 'curl/8.21.0', 'produk/slug-tidak-ada', '2026-10-08 09:21:40'),
(111, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-08 09:22:28'),
(112, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kemeja-lengan-pendek', '2026-10-08 09:22:45'),
(113, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kemeja-lengan-pendek', '2026-10-08 09:22:51'),
(114, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-08 09:22:55'),
(115, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-08 09:23:07'),
(116, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-08 09:23:08'),
(117, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-08 09:23:13'),
(118, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-08 10:21:20'),
(119, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-08 10:21:23'),
(120, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-08 10:21:33'),
(121, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-08 10:22:46'),
(122, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-08 10:22:56'),
(123, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kemeja-lengan-pendek', '2026-10-08 10:22:58'),
(124, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-08 10:24:02'),
(125, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-08 10:24:56'),
(126, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-08 10:25:23'),
(127, '::1', 'curl/8.21.0', '', '2026-10-08 10:26:02'),
(128, '::1', 'curl/8.21.0', 'produk', '2026-10-08 10:26:02'),
(129, '::1', 'curl/8.21.0', 'produk/kaos-oversize-premium', '2026-10-08 10:26:02'),
(130, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-08 10:28:20'),
(131, '::1', 'curl/8.21.0', '', '2026-10-08 10:28:55'),
(132, '::1', 'curl/8.21.0', '', '2026-10-08 10:28:55'),
(133, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-08 10:33:44'),
(134, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-08 10:33:48'),
(135, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-08 10:34:37'),
(136, '::1', 'curl/8.21.0', '', '2026-10-08 10:40:35'),
(137, '::1', 'curl/8.21.0', '', '2026-10-08 10:40:35'),
(138, '::1', 'curl/8.21.0', 'tentang', '2026-10-08 10:40:36'),
(139, '::1', 'curl/8.21.0', 'tentang', '2026-10-08 10:40:36'),
(140, '::1', 'curl/8.21.0', 'keranjang', '2026-10-08 10:40:36'),
(141, '::1', 'curl/8.21.0', 'produk', '2026-10-08 10:40:36'),
(142, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-08 10:44:08'),
(143, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-08 10:44:09'),
(144, '::1', 'curl/8.21.0', '', '2026-10-08 10:46:04'),
(145, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 21:40:35'),
(146, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 21:40:58'),
(147, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 21:41:03'),
(148, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 21:41:22'),
(149, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kaos-oversize-premium', '2026-10-11 21:41:31'),
(150, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 21:41:34'),
(151, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kemeja-lengan-pendek', '2026-10-11 21:41:40'),
(152, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-11 21:41:48'),
(153, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 21:41:54'),
(154, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 21:53:42'),
(155, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:00:28'),
(156, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:19:46'),
(157, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:19:51'),
(158, '::1', 'curl/8.21.0', '', '2026-10-11 22:28:54'),
(159, '::1', 'curl/8.21.0', 'produk', '2026-10-11 22:28:55'),
(160, '::1', 'curl/8.21.0', 'produk/kaos-oversize-premium', '2026-10-11 22:28:55'),
(161, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:30:05'),
(162, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 22:30:53'),
(163, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:31:17'),
(164, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kaos-oversize-premium', '2026-10-11 22:31:24'),
(165, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:31:26'),
(166, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 22:31:43'),
(167, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:31:46'),
(168, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-11 22:31:49'),
(169, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 22:31:50'),
(170, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 22:32:02'),
(171, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 22:32:27'),
(172, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:32:46'),
(173, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kaos-polos-lengan-pendek', '2026-10-11 22:33:03'),
(174, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:33:08'),
(175, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kemeja-kerja-katun', '2026-10-11 22:33:11'),
(176, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:33:13'),
(177, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:33:42'),
(178, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 22:33:56'),
(179, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:34:53'),
(180, '::1', 'curl/8.21.0', 'produk', '2026-10-11 22:43:50'),
(181, '::1', 'curl/8.21.0', 'produk/page/2', '2026-10-11 22:43:51'),
(182, '::1', 'curl/8.21.0', 'produk/page/999', '2026-10-11 22:43:52'),
(183, '::1', 'curl/8.21.0', 'produk', '2026-10-11 22:43:52'),
(184, '::1', 'curl/8.21.0', 'produk/page/2', '2026-10-11 22:43:52'),
(185, '::1', 'curl/8.21.0', 'produk', '2026-10-11 22:44:51'),
(186, '::1', 'curl/8.21.0', 'produk', '2026-10-11 22:44:51'),
(187, '::1', 'curl/8.21.0', 'produk', '2026-10-11 22:46:16'),
(188, '::1', 'curl/8.21.0', 'produk/page/2', '2026-10-11 22:46:17'),
(189, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 22:52:58'),
(190, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:53:18'),
(191, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 22:53:38'),
(192, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:53:40'),
(193, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:54:09'),
(194, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:57:04'),
(195, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:57:37'),
(196, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 22:57:52'),
(197, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 22:58:07'),
(198, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 22:58:07'),
(199, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 22:58:08'),
(200, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 22:58:08'),
(201, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 22:58:08'),
(202, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 22:58:08'),
(203, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:58:12'),
(204, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:58:12'),
(205, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:58:12'),
(206, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:58:12'),
(207, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:58:12'),
(208, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 22:58:39'),
(209, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:58:41'),
(210, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-11 22:59:12'),
(211, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 22:59:13'),
(212, '::1', 'curl/8.21.0', '', '2026-10-11 22:59:14'),
(213, '::1', 'curl/8.21.0', 'produk', '2026-10-11 22:59:14'),
(214, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-11 22:59:14'),
(215, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 22:59:15'),
(216, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 22:59:20'),
(217, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 22:59:50'),
(218, '::1', 'curl/8.21.0', '', '2026-10-11 23:03:11'),
(219, '::1', 'curl/8.21.0', 'produk', '2026-10-11 23:03:11'),
(220, '::1', 'curl/8.21.0', 'produk/kaos-oversize-premium', '2026-10-11 23:03:11'),
(221, '::1', 'curl/8.21.0', 'tentang', '2026-10-11 23:03:11'),
(222, '::1', 'curl/8.21.0', '', '2026-10-11 23:03:11'),
(223, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:04:11'),
(224, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:14:03'),
(225, '::1', 'curl/8.21.0', '', '2026-10-11 23:27:34'),
(226, '::1', 'curl/8.21.0', '', '2026-10-11 23:27:34'),
(227, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:30:31'),
(228, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:30:41'),
(229, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:30:47'),
(230, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:30:48'),
(231, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:38:51'),
(232, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:39:12'),
(233, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:39:18'),
(234, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:42:54'),
(235, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:48:28'),
(236, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:48:45'),
(237, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:48:48'),
(238, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 23:49:01'),
(239, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:49:04'),
(240, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:50:45'),
(241, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:50:48'),
(242, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:53:03'),
(243, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-11 23:53:12'),
(244, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/celana-pendek-anak', '2026-10-11 23:53:21'),
(245, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:53:25'),
(246, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:57:49'),
(247, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:58:42'),
(248, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kaos-bayi-motif', '2026-10-11 23:58:52'),
(249, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:59:07'),
(250, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/setelan-anak', '2026-10-11 23:59:10'),
(251, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-11 23:59:35'),
(252, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-12 00:00:54'),
(253, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-12 00:00:59'),
(254, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-12 00:01:24'),
(255, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-12 00:01:29'),
(256, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-12 00:01:53'),
(257, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-12 00:02:05'),
(258, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/hoodie-fleece-hangat', '2026-10-12 00:03:06'),
(259, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-12 00:03:25'),
(260, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kaos-anak-kasual', '2026-10-12 00:03:49'),
(261, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-12 00:04:01'),
(262, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-12 00:05:23'),
(263, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-12 00:07:45'),
(264, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-12 00:08:00'),
(265, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-12 00:08:03'),
(266, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-12 00:08:51'),
(267, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-12 00:09:25'),
(268, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/celana-pendek-anak', '2026-10-12 00:09:47'),
(269, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-12 00:10:00'),
(270, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-12 00:10:09'),
(271, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-12 00:11:15'),
(272, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-12 00:11:16'),
(273, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-12 00:12:07'),
(274, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-12 00:47:41'),
(275, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/setelan-anak', '2026-10-12 00:47:50'),
(276, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-12 00:47:52'),
(277, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/celana-pendek-anak', '2026-10-12 00:47:57'),
(278, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-12 00:48:04'),
(279, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-12 00:48:13'),
(280, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 01:42:15'),
(281, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/celana-pendek-anak', '2026-10-13 01:42:29'),
(282, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 01:42:57'),
(283, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/setelan-anak', '2026-10-13 01:42:59'),
(284, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 01:43:14'),
(285, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kaos-polos-lengan-pendek', '2026-10-13 01:55:34'),
(286, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 01:56:40'),
(287, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 01:57:42'),
(288, '::1', 'curl/8.21.0', '', '2026-10-13 02:04:00'),
(289, '::1', 'curl/8.21.0', '', '2026-10-13 02:04:43'),
(290, '::1', 'curl/8.21.0', 'tentang', '2026-10-13 02:12:57'),
(291, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 02:22:02'),
(292, '::1', 'curl/8.21.0', 'tentang', '2026-10-13 02:46:12'),
(293, '::1', 'curl/8.21.0', '', '2026-10-13 02:46:26'),
(294, '::1', 'curl/8.21.0', 'produk', '2026-10-13 02:46:26'),
(295, '::1', 'curl/8.21.0', 'tentang', '2026-10-13 02:46:26'),
(296, '::1', 'curl/8.21.0', 'produk/kaos-oversize-premium', '2026-10-13 02:46:26'),
(297, '::1', 'curl/8.21.0', 'tentang', '2026-10-13 02:51:36'),
(298, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 02:55:37'),
(299, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 02:55:38'),
(300, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 02:56:16'),
(301, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 02:59:01'),
(302, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 03:00:23'),
(303, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 03:00:30'),
(304, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 03:01:09'),
(305, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 03:01:32'),
(306, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 03:01:35'),
(307, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/celana-pendek-anak', '2026-10-13 03:01:37'),
(308, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 03:01:38'),
(309, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 03:01:41'),
(310, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 03:01:44'),
(311, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 03:01:56'),
(312, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 03:02:19'),
(313, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 03:02:22'),
(314, '::1', 'curl/8.21.0', '', '2026-10-13 03:02:36'),
(315, '::1', 'curl/8.21.0', '', '2026-10-13 03:02:37'),
(316, '::1', 'curl/8.21.0', '', '2026-10-13 03:02:43'),
(317, '::1', 'curl/8.21.0', 'produk', '2026-10-13 03:02:43'),
(318, '::1', 'curl/8.21.0', 'tentang', '2026-10-13 03:02:43'),
(319, '::1', 'curl/8.21.0', 'tentang', '2026-10-13 03:02:44'),
(320, '::1', 'curl/8.21.0', 'tentang', '2026-10-13 03:02:44'),
(321, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 03:02:56'),
(322, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/celana-pendek-anak', '2026-10-13 03:02:57'),
(323, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 03:03:07'),
(324, '::1', 'curl/8.21.0', 'tentang', '2026-10-13 03:04:07'),
(325, '::1', 'curl/8.21.0', '', '2026-10-13 03:04:08'),
(326, '::1', 'curl/8.21.0', 'produk', '2026-10-13 03:04:08'),
(327, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/celana-pendek-anak', '2026-10-13 03:06:56'),
(328, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 03:06:59'),
(329, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kaos-anak-karakter', '2026-10-13 03:07:01'),
(330, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kaos-anak-karakter', '2026-10-13 03:07:14'),
(331, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 03:07:16'),
(332, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 03:08:23'),
(333, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 03:09:03'),
(334, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 03:35:48'),
(335, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 03:35:49'),
(336, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 03:38:10'),
(337, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 03:38:56'),
(338, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 03:38:57'),
(339, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 03:38:58'),
(340, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 03:39:34'),
(341, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 03:39:57'),
(342, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 03:40:32'),
(343, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 03:40:35'),
(344, '::1', 'curl/8.21.0', '', '2026-10-13 03:45:29'),
(345, '::1', 'curl/8.21.0', 'tentang', '2026-10-13 03:45:29'),
(346, '::1', 'curl/8.21.0', '', '2026-10-13 03:45:29'),
(347, '::1', 'curl/8.21.0', 'tentang', '2026-10-13 03:45:29'),
(348, '::1', 'curl/8.21.0', '', '2026-10-13 03:45:56'),
(349, '::1', 'curl/8.21.0', '', '2026-10-13 03:46:15'),
(350, '::1', 'curl/8.21.0', 'tentang', '2026-10-13 03:46:16'),
(351, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 04:00:34'),
(352, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 04:00:39'),
(353, '::1', 'curl/8.21.0', 'tentang', '2026-10-13 04:05:47'),
(354, '::1', 'curl/8.21.0', 'tentang', '2026-10-13 04:05:58'),
(355, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 04:06:39'),
(356, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 04:06:50'),
(357, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 04:06:59'),
(358, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 04:07:22'),
(359, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 04:07:23'),
(360, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 04:07:24'),
(361, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 04:10:33'),
(362, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 04:10:43'),
(363, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 04:12:28'),
(364, '::1', 'curl/8.21.0', '', '2026-10-13 05:14:49'),
(365, '::1', 'curl/8.21.0', '', '2026-10-13 05:20:38'),
(366, '::1', 'curl/8.21.0', 'produk', '2026-10-13 05:20:38'),
(367, '::1', 'curl/8.21.0', 'tentang', '2026-10-13 05:20:38'),
(368, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 05:27:03'),
(369, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 05:27:42'),
(370, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 05:31:21'),
(371, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 05:32:42'),
(372, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 05:32:43'),
(373, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 05:32:43'),
(374, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 05:32:43'),
(375, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 05:32:43'),
(376, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 05:32:43'),
(377, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 05:33:09'),
(378, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 05:33:12'),
(379, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 05:37:30'),
(380, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 05:38:05'),
(381, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 05:38:18'),
(382, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 05:38:39');
INSERT INTO `visitor_logs` (`id`, `ip_address`, `user_agent`, `page_url`, `visited_at`) VALUES
(383, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 05:38:41'),
(384, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 05:38:44'),
(385, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 05:38:56'),
(386, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 05:39:11'),
(387, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/setelan-anak', '2026-10-13 05:39:27'),
(388, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 05:39:43'),
(389, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 05:40:13'),
(390, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kaos-bayi-motif', '2026-10-13 05:40:19'),
(391, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 05:40:25'),
(392, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 08:15:09'),
(393, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 08:15:24'),
(394, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 08:16:27'),
(395, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 08:18:55'),
(396, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 08:19:09'),
(397, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 08:20:51'),
(398, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 08:22:07'),
(399, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 08:23:36'),
(400, '::1', 'curl/8.21.0', '', '2026-10-13 08:37:02'),
(401, '::1', 'curl/8.21.0', '', '2026-10-13 08:38:11'),
(402, '::1', 'curl/8.21.0', '', '2026-10-13 08:38:31'),
(403, '::1', 'curl/8.21.0', '', '2026-10-13 08:38:42'),
(404, '::1', 'curl/8.21.0', '', '2026-10-13 08:40:14'),
(405, '::1', 'curl/8.21.0', '', '2026-10-13 08:40:14'),
(406, '::1', 'curl/8.21.0', 'tentang', '2026-10-13 08:40:14'),
(407, '::1', 'curl/8.21.0', 'produk', '2026-10-13 08:40:14'),
(408, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 08:40:47'),
(409, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 08:42:03'),
(410, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-13 08:42:14'),
(411, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 08:42:17'),
(412, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 08:43:36'),
(413, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 08:43:37'),
(414, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 08:43:37'),
(415, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 08:43:37'),
(416, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 08:43:38'),
(417, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 08:43:38'),
(418, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 08:43:46'),
(419, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 08:43:48'),
(420, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 08:44:59'),
(421, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:01:56'),
(422, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:02:19'),
(423, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:02:49'),
(424, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:03:12'),
(425, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 09:04:03'),
(426, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:04:39'),
(427, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:04:52'),
(428, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:04:53'),
(429, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:04:53'),
(430, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:04:54'),
(431, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:04:54'),
(432, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:04:54'),
(433, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:04:59'),
(434, '::1', 'curl/8.21.0', '', '2026-10-13 09:10:21'),
(435, '::1', 'curl/8.21.0', 'produk', '2026-10-13 09:10:22'),
(436, '::1', 'curl/8.21.0', 'produk/kaos-polos-lengan-pendek', '2026-10-13 09:10:22'),
(437, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:10:40'),
(438, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:10:59'),
(439, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:11:48'),
(440, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 09:11:52'),
(441, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:20:52'),
(442, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-13 09:21:37'),
(443, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:22:41'),
(444, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:23:33'),
(445, '::1', 'curl/8.21.0', '', '2026-10-13 09:26:48'),
(446, '::1', 'curl/8.21.0', 'produk', '2026-10-13 09:26:49'),
(447, '::1', 'curl/8.21.0', 'tentang', '2026-10-13 09:26:49'),
(448, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:33:16'),
(449, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:33:18'),
(450, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:33:19'),
(451, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:33:19'),
(452, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:33:19'),
(453, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:33:19'),
(454, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:33:19'),
(455, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/setelan-anak', '2026-10-13 09:33:26'),
(456, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/setelan-anak', '2026-10-13 09:33:26'),
(457, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/setelan-anak', '2026-10-13 09:33:26'),
(458, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/setelan-anak', '2026-10-13 09:33:26'),
(459, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/setelan-anak', '2026-10-13 09:33:26'),
(460, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:33:36'),
(461, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:33:36'),
(462, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:33:36'),
(463, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:33:36'),
(464, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 09:33:36'),
(465, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 10:01:35'),
(466, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-13 10:02:41'),
(467, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-14 06:52:10'),
(468, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-14 06:52:26'),
(469, '::1', 'curl/8.21.0', '', '2026-10-14 06:58:50'),
(470, '::1', 'curl/8.21.0', 'produk', '2026-10-14 06:58:50'),
(471, '::1', 'curl/8.21.0', '', '2026-10-14 06:58:50'),
(472, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-14 06:59:12'),
(473, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 07:01:15'),
(474, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 07:01:47'),
(475, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 07:02:19'),
(476, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 07:02:33'),
(477, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 07:02:35'),
(478, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 07:02:37'),
(479, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 07:03:06'),
(480, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 07:03:56'),
(481, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 07:04:02'),
(482, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 07:04:04'),
(483, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 07:04:06'),
(484, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 07:04:08'),
(485, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 07:04:10'),
(486, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 07:04:24'),
(487, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-14 07:04:50'),
(488, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-14 07:05:01'),
(489, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-14 07:05:10'),
(490, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-14 07:05:48'),
(491, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-14 07:12:33'),
(492, '::1', 'curl/8.21.0', '', '2026-10-14 07:35:25'),
(493, '::1', 'curl/8.21.0', '', '2026-10-14 07:35:25'),
(494, '::1', 'curl/8.21.0', '', '2026-10-14 07:35:25'),
(495, '127.0.0.1', 'curl/8.21.0', '', '2026-10-14 07:35:34'),
(496, '127.0.0.1', 'curl/8.21.0', '', '2026-10-14 07:35:34'),
(497, '127.0.0.1', 'curl/8.21.0', '', '2026-10-14 07:35:46'),
(498, '127.0.0.1', 'curl/8.21.0', '', '2026-10-14 07:36:01'),
(499, '127.0.0.1', 'curl/8.21.0', '', '2026-10-14 07:36:01'),
(500, '::1', 'curl/8.21.0', '', '2026-10-14 07:36:01'),
(501, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-14 07:43:16'),
(502, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-14 07:53:07'),
(503, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'kjk', '2026-10-14 07:53:08'),
(504, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-14 07:53:15'),
(505, '::1', 'curl/8.21.0', '', '2026-10-14 07:56:39'),
(506, '::1', 'curl/8.21.0', 'produk', '2026-10-14 07:56:39'),
(507, '::1', 'curl/8.21.0', 'tentang', '2026-10-14 07:56:39'),
(508, '::1', 'curl/8.21.0', 'produk/kaos-oversize-premium', '2026-10-14 07:56:39'),
(509, '::1', 'curl/8.21.0', 'produk/kategori-ngawur', '2026-10-14 07:56:39'),
(510, '::1', 'curl/8.21.0', 'syarat-ketentuan', '2026-10-14 07:56:39'),
(511, '::1', 'curl/8.21.0', 'kebijakan-privasi', '2026-10-14 07:56:40'),
(512, '::1', 'curl/8.21.0', 'halaman-ngawur-xyz', '2026-10-14 07:56:40'),
(513, '::1', 'curl/8.21.0', 'halaman-ngawur-xyz', '2026-10-14 07:56:50'),
(514, '::1', 'curl/8.21.0', 'produk/slug-yang-tidak-ada', '2026-10-14 07:56:50'),
(515, '::1', 'curl/8.21.0', 'produk/slug-yang-tidak-ada', '2026-10-14 07:56:51'),
(516, '::1', 'curl/8.21.0', '', '2026-10-14 07:57:29'),
(517, '::1', 'curl/8.21.0', 'produk/jaket-denim-pria', '2026-10-14 07:57:29'),
(518, '::1', 'curl/8.21.0', '', '2026-10-14 07:57:29'),
(519, '::1', 'curl/8.21.0', '', '2026-10-14 07:58:46'),
(520, '::1', 'curl/8.21.0', '', '2026-10-14 07:58:53'),
(521, '::1', 'curl/8.21.0', '', '2026-10-14 07:58:53'),
(522, '::1', 'curl/8.21.0', '', '2026-10-14 07:59:44'),
(523, '::1', 'curl/8.21.0', '', '2026-10-14 07:59:49'),
(524, '::1', 'curl/8.21.0', '', '2026-10-14 07:59:53'),
(525, '::1', 'curl/8.21.0', '', '2026-10-14 07:59:58'),
(526, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 08:00:43'),
(527, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 08:00:45'),
(528, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 08:00:46'),
(529, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 08:00:48'),
(530, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 08:00:50'),
(531, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 08:01:08'),
(532, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 08:01:10'),
(533, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 08:01:12'),
(534, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 08:01:14'),
(535, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 08:01:16'),
(536, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 08:01:17'),
(537, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 08:01:19'),
(538, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 08:01:21'),
(539, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 08:01:33'),
(540, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 08:01:35'),
(541, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 08:01:37'),
(542, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 08:01:38'),
(543, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 08:01:52'),
(544, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-14 08:01:55'),
(545, '::1', 'curl/8.21.0', '', '2026-10-14 08:03:53'),
(546, '::1', 'curl/8.21.0', 'produk', '2026-10-14 08:03:53'),
(547, '::1', 'curl/8.21.0', 'produk/page/2', '2026-10-14 08:03:53'),
(548, '::1', 'curl/8.21.0', 'produk/jaket-denim-pria', '2026-10-14 08:03:53'),
(549, '::1', 'curl/8.21.0', 'produk', '2026-10-14 08:03:53'),
(550, '::1', 'curl/8.21.0', 'tentang', '2026-10-14 08:03:53'),
(551, '::1', 'curl/8.21.0', 'syarat-ketentuan', '2026-10-14 08:03:54'),
(552, '::1', 'curl/8.21.0', 'kebijakan-privasi', '2026-10-14 08:03:54'),
(553, '::1', 'curl/8.21.0', 'admin/halaman-ngawur', '2026-10-14 08:03:54'),
(554, '::1', 'curl/8.21.0', '404-xyz', '2026-10-14 08:03:54'),
(555, '::1', 'curl/8.21.0', 'syarat-ketentuan', '2026-10-14 08:04:01'),
(556, '::1', 'curl/8.21.0', 'kebijakan-privasi', '2026-10-14 08:04:01'),
(557, '::1', 'curl/8.21.0', 'tentang', '2026-10-14 08:04:01'),
(558, '::1', 'curl/8.21.0', 'syarat-ketentuan', '2026-10-14 08:04:01'),
(559, '::1', 'curl/8.21.0', '', '2026-10-14 08:04:48'),
(560, '::1', 'curl/8.21.0', 'produk', '2026-10-14 08:04:48'),
(561, '::1', 'curl/8.21.0', 'produk', '2026-10-14 08:04:48'),
(562, '::1', 'curl/8.21.0', 'produk/jaket-denim-pria', '2026-10-14 08:04:48'),
(563, '::1', 'curl/8.21.0', 'tentang', '2026-10-14 08:04:48'),
(564, '::1', 'curl/8.21.0', 'halaman-ngawur', '2026-10-14 08:04:48'),
(565, '::1', 'curl/8.21.0', 'produk', '2026-10-14 08:04:49'),
(566, '::1', 'curl/8.21.0', 'produk', '2026-10-14 08:04:49'),
(567, '::1', 'curl/8.21.0', '', '2026-10-14 08:05:06'),
(568, '::1', 'curl/8.21.0', 'produk', '2026-10-14 08:05:07'),
(569, '::1', 'curl/8.21.0', 'produk/jaket-denim-pria', '2026-10-14 08:05:07'),
(570, '::1', 'curl/8.21.0', 'tentang', '2026-10-14 08:05:07'),
(571, '::1', 'curl/8.21.0', 'syarat-ketentuan', '2026-10-14 08:05:07'),
(572, '::1', 'curl/8.21.0', 'kebijakan-privasi', '2026-10-14 08:05:07'),
(573, '::1', 'curl/8.21.0', 'halaman-ngawur', '2026-10-14 08:05:07'),
(574, '::1', 'curl/8.21.0', '', '2026-10-14 08:07:15'),
(575, '::1', 'curl/8.21.0', 'produk', '2026-10-14 08:07:15'),
(576, '::1', 'curl/8.21.0', '', '2026-10-14 08:07:15'),
(577, '::1', 'curl/8.21.0', '', '2026-10-14 08:08:09'),
(578, '::1', 'curl/8.21.0', 'produk', '2026-10-14 08:08:09'),
(579, '::1', 'curl/8.21.0', 'produk/jaket-denim-pria', '2026-10-14 08:08:09'),
(580, '::1', 'curl/8.21.0', 'tentang', '2026-10-14 08:08:09'),
(581, '::1', 'curl/8.21.0', 'syarat-ketentuan', '2026-10-14 08:08:09'),
(582, '::1', 'curl/8.21.0', 'kebijakan-privasi', '2026-10-14 08:08:09'),
(583, '::1', 'curl/8.21.0', 'halaman-ngawur', '2026-10-14 08:08:09'),
(584, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-14 08:13:20'),
(585, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-14 08:13:38'),
(586, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-14 08:13:40'),
(587, '::1', 'curl/8.21.0', 'assets/uploads/products/kaos-oversize-premium-1.jpg', '2026-10-14 08:14:57'),
(588, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-14 08:19:37'),
(589, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 07:19:15'),
(590, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/jaket-denim-pria', '2026-10-15 07:33:20'),
(591, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kemeja-lengan-pendek', '2026-10-15 07:33:33'),
(592, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kemeja-lengan-pendek', '2026-10-15 07:33:43'),
(593, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-15 07:33:46'),
(594, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 07:33:49'),
(595, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-15 07:34:47'),
(596, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-15 07:37:44'),
(597, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 08:03:53'),
(598, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 08:04:52'),
(599, '::1', 'curl/8.21.0', 'produk/kaos-oversize-premium', '2026-10-15 08:21:43'),
(600, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 08:22:35'),
(601, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk/kaos-oversize-premium', '2026-10-15 08:22:35'),
(602, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 08:23:34'),
(603, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 08:25:06'),
(604, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 08:26:06'),
(605, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 08:26:55'),
(606, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 08:26:56'),
(607, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kaos-oversize-premium', '2026-10-15 08:27:06'),
(608, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 08:27:11'),
(609, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kaos-oversize-premium', '2026-10-15 08:27:20'),
(610, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 08:27:29'),
(611, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 08:32:27'),
(612, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 08:32:28'),
(613, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk/kaos-oversize-premium', '2026-10-15 08:32:28'),
(614, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk/kaos-oversize-premium', '2026-10-15 08:40:05'),
(615, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 08:40:38'),
(616, '::1', 'curl/8.21.0', 'produk/kaos-oversize-premium', '2026-10-15 08:42:35'),
(617, '::1', 'curl/8.21.0', '', '2026-10-15 08:42:35'),
(618, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 08:43:36'),
(619, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-15 08:43:42'),
(620, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 09:24:48'),
(621, '::1', 'curl/8.21.0', '', '2026-10-15 09:38:25'),
(622, '::1', 'curl/8.21.0', 'produk', '2026-10-15 09:38:25'),
(623, '::1', 'curl/8.21.0', 'produk/page/2', '2026-10-15 09:38:25'),
(624, '::1', 'curl/8.21.0', 'produk/page/99', '2026-10-15 09:38:25'),
(625, '::1', 'curl/8.21.0', 'produk', '2026-10-15 09:38:25'),
(626, '::1', 'curl/8.21.0', 'produk', '2026-10-15 09:38:26'),
(627, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-15 09:46:23'),
(628, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 09:46:25'),
(629, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 09:46:25'),
(630, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk/page/undefined', '2026-10-15 09:46:26'),
(631, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 09:46:26'),
(632, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 09:46:26'),
(633, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 09:46:26'),
(634, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 09:46:26'),
(635, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 09:46:27'),
(636, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 09:46:27'),
(637, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk/jaket-denim-pria', '2026-10-15 09:46:27'),
(638, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 09:46:28'),
(639, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-15 09:47:03'),
(640, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 09:47:04'),
(641, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 09:47:04'),
(642, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk/page/undefined', '2026-10-15 09:47:04'),
(643, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 09:47:04'),
(644, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 09:47:04'),
(645, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 09:47:05'),
(646, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 09:47:05'),
(647, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 09:47:05'),
(648, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 09:47:05'),
(649, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk/jaket-denim-pria', '2026-10-15 09:47:05'),
(650, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 09:47:06'),
(651, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 09:49:25'),
(652, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 09:49:26'),
(653, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-15 09:49:27'),
(654, '::1', 'curl/8.21.0', '', '2026-10-15 09:53:49'),
(655, '::1', 'curl/8.21.0', 'produk', '2026-10-15 09:53:49'),
(656, '::1', 'curl/8.21.0', 'produk/page/2', '2026-10-15 09:53:49'),
(657, '::1', 'curl/8.21.0', 'tentang', '2026-10-15 09:53:49'),
(658, '::1', 'curl/8.21.0', 'syarat-ketentuan', '2026-10-15 09:53:49'),
(659, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-15 10:00:45'),
(660, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 10:00:46'),
(661, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 10:00:47'),
(662, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk/page/undefined', '2026-10-15 10:00:47'),
(663, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 10:00:47'),
(664, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 10:00:47'),
(665, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 10:00:48'),
(666, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 10:00:48'),
(667, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 10:00:48'),
(668, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 10:00:48'),
(669, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk/jaket-denim-pria', '2026-10-15 10:00:48'),
(670, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 10:00:49'),
(671, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 10:23:41'),
(672, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 10:23:46'),
(673, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 10:24:00'),
(674, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/page/undefined', '2026-10-15 10:24:02'),
(675, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/page/2', '2026-10-15 10:24:05'),
(676, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 10:24:10'),
(677, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/page/undefined', '2026-10-15 10:24:13'),
(678, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 10:24:16'),
(679, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 10:24:23'),
(680, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 10:24:26'),
(681, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/page/undefined', '2026-10-15 10:32:12'),
(682, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 10:32:36'),
(683, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 10:32:38'),
(684, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 10:32:41'),
(685, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/page/undefined', '2026-10-15 10:32:46'),
(686, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 11:01:55'),
(687, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 11:01:58'),
(688, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/page/undefined', '2026-10-15 11:02:00'),
(689, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 11:02:02'),
(690, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 11:03:01'),
(691, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 11:03:35'),
(692, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'tentang', '2026-10-15 11:03:36'),
(693, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 11:05:57'),
(694, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/page/undefined', '2026-10-15 11:06:00'),
(695, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 11:06:27'),
(696, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/page/undefined', '2026-10-15 11:06:30'),
(697, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk/page/2', '2026-10-15 11:06:46'),
(698, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 11:06:49'),
(699, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 11:06:51'),
(700, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk/page/undefined', '2026-10-15 11:06:51'),
(701, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/page/2', '2026-10-15 11:10:08'),
(702, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 11:10:10'),
(703, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/page/undefined', '2026-10-15 11:10:13'),
(704, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'undefined', '2026-10-15 11:10:15'),
(705, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 11:10:17'),
(706, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/page/undefined', '2026-10-15 11:10:19'),
(707, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/page/2', '2026-10-15 11:10:28'),
(708, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 11:10:30'),
(709, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 11:10:38'),
(710, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/page/undefined', '2026-10-15 11:10:41'),
(711, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/page/2', '2026-10-15 11:10:44'),
(712, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/blouse-ruffle', '2026-10-15 11:11:33'),
(713, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 11:11:41'),
(714, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk/page/2', '2026-10-15 11:12:04'),
(715, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 11:12:07'),
(716, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 11:12:08'),
(717, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 11:12:09'),
(718, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/hoodie-fleece-hangat', '2026-10-15 11:12:18'),
(719, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', '', '2026-10-15 11:12:45'),
(720, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 11:12:47'),
(721, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 11:12:50'),
(722, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk/jaket-denim-pria', '2026-10-15 11:12:50'),
(723, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 11:12:51'),
(724, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 11:15:12'),
(725, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 11:15:14'),
(726, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 11:20:52'),
(727, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 11:27:33'),
(728, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 11:29:39'),
(729, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk', '2026-10-15 11:31:57'),
(730, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 11:32:35'),
(731, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/kemeja-kerja-katun', '2026-10-15 11:32:41'),
(732, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 11:32:48'),
(733, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', 'produk/celana-pendek-anak', '2026-10-15 11:32:50'),
(734, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/154.0.0.0 Safari/537.36', '', '2026-10-15 11:33:11');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indeks untuk tabel `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indeks untuk tabel `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ip_attempted` (`ip_address`,`attempted_at`);

--
-- Indeks untuk tabel `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `category_active` (`category_id`,`is_active`);

--
-- Indeks untuk tabel `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indeks untuk tabel `stores`
--
ALTER TABLE `stores`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `visitor_logs`
--
ALTER TABLE `visitor_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `visited_at` (`visited_at`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT untuk tabel `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT untuk tabel `visitor_logs`
--
ALTER TABLE `visitor_logs`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=735;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
