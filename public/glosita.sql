-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 18-11-2022 a las 13:35:26
-- Versión del servidor: 10.3.34-MariaDB-0ubuntu0.20.04.1
-- Versión de PHP: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `admin_glosita`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alerts`
--

CREATE TABLE `alerts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position_lat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position_lng` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `isMarkers` tinyint(1) NOT NULL DEFAULT 1,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`, `isMarkers`, `logo`) VALUES
(1, 'date', '2022-11-14 20:13:43', '2022-11-14 20:13:43', 1, 'heart'),
(2, 'transport', '2022-11-14 20:13:43', '2022-11-14 20:13:43', 1, 'car'),
(3, 'rental', '2022-11-14 20:13:43', '2022-11-14 20:13:43', 1, 'house');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `filters`
--

CREATE TABLE `filters` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `dataname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `markers`
--

CREATE TABLE `markers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `info` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position_lat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position_lng` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `photos_count` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `filters` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `markers_photos`
--

CREATE TABLE `markers_photos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `marker_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_07_16_110744_add_metadata_users', 1),
(4, '2019_07_22_090113_add_metadata_users_email_verification', 1),
(5, '2019_08_05_134831_create_categories', 1),
(6, '2019_08_05_134841_create_tags', 1),
(7, '2019_08_05_135217_add_metadata_users_tag', 1),
(8, '2019_08_05_135348_add_metadata_users_category', 1),
(9, '2019_08_06_153818_add_metadata_user_buddies', 1),
(10, '2019_10_17_203224_add_metadata_users_avatar_changes', 1),
(11, '2019_10_31_084414_add_metadata_user_description', 1),
(12, '2019_11_20_082405_add_metadata_user_alias', 1),
(13, '2019_11_26_152400_create_markers_table', 1),
(14, '2019_12_05_130116_create_markers_photos_table', 1),
(15, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(16, '2019_12_30_104418_add_metadata_users_visibility', 1),
(17, '2020_01_02_135427_add_metadata_is_marker', 1),
(18, '2020_02_24_092102_add_metadata_logo_category_table', 1),
(19, '2020_02_24_133932_create_table_alerts', 1),
(20, '2020_02_25_111500_add_metadata_distance_filter_users', 1),
(21, '2020_03_03_095035_create_table_filters', 1),
(22, '2020_03_03_095124_add_metadata_markers', 1),
(23, '2020_04_21_145458_add_metadata_users_im_here', 1),
(24, '2020_04_28_100908_drop_users_tag', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('08ba56ffafd10bd510d928bde1bd5fd5d785d7464c9a0eb5ba1eb1541a7ad1f34a749a16a2e8da8e', 1, 1, 'Personal Access Token', '[]', 0, '2022-11-16 02:25:14', '2022-11-16 02:25:14', '2023-11-16 02:25:14'),
('13731d0aa059c258bc6cbf93759a6a118df8a7de3331824fce4c8f510f7fa7c2c554f6bed14294ec', 1, 1, 'Personal Access Token', '[]', 0, '2022-11-15 04:58:17', '2022-11-15 04:58:17', '2023-11-15 04:58:17'),
('159b1fb3650911f1e80430fcc58a0146923836db1ea60748c1700f3904015f925b4a06424da20a7b', 1, 1, 'Personal Access Token', '[]', 0, '2022-11-15 22:01:50', '2022-11-15 22:01:50', '2023-11-15 22:01:50'),
('2216cbf619184fc96abe99b9879f21b6565bea21d2170ecc8ff1d193847bb4a3d74d4e53aca1b057', 1, 1, 'Personal Access Token', '[]', 0, '2022-11-15 13:09:09', '2022-11-15 13:09:09', '2023-11-15 13:09:09'),
('31a4208ef1eb1f53e3ffe9dae496dd97b823bb467a0f3afee699aff7b344b702a48fcb95a5a8bd24', 8, 1, 'Personal Access Token', '[]', 0, '2022-11-16 02:02:54', '2022-11-16 02:02:54', '2023-11-16 02:02:54'),
('3c9442bfca10346633cb5b038c4f3910fe12c78ac4feb0a1ac6e27c1d9ebe20f3680261aa2715034', 9, 1, 'Personal Access Token', '[]', 0, '2022-11-16 02:56:46', '2022-11-16 02:56:46', '2023-11-16 02:56:46'),
('415ad476c9891dddf85974c89295735ea89dcc65e71247ccdba2c616f747c0637f249bf7f210ad9d', 9, 1, 'Personal Access Token', '[]', 0, '2022-11-16 02:42:43', '2022-11-16 02:42:43', '2023-11-16 02:42:43'),
('46d5bd4d328f5b58ac917103acc22ae71c535c8ad1aab7f65ae1b40c2d9ad2bd944fba6af0f00210', 8, 1, 'Personal Access Token', '[]', 0, '2022-11-16 02:04:03', '2022-11-16 02:04:03', '2023-11-16 02:04:03'),
('488028ef120539064a87d26788a179f7551bb42187fc0866546e9395364f9341ad6d77d2dfaea838', 11, 1, 'Personal Access Token', '[]', 0, '2022-11-16 11:25:31', '2022-11-16 11:25:31', '2023-11-16 11:25:31'),
('591dad6ed8d037c85222d7fba32c64ccb8957c659e805ea80b33eba8cc000979d03a6f15cbe097de', 1, 1, 'Personal Access Token', '[]', 0, '2022-11-15 04:00:36', '2022-11-15 04:00:36', '2023-11-15 04:00:36'),
('5b773edc559c038f74d68a0902c54b82390e2be8e90c970a921690d0ca98e02246bf415718aa1f1b', 10, 1, 'Personal Access Token', '[]', 0, '2022-11-16 11:21:07', '2022-11-16 11:21:07', '2023-11-16 11:21:07'),
('628e21cfc165a26b42dcba504953be390f27f1287ccc24915cfef9885b5fad006aeb0040869dd6a0', 1, 1, 'Personal Access Token', '[]', 0, '2022-11-15 11:13:00', '2022-11-15 11:13:00', '2023-11-15 11:13:00'),
('9ade713d44925055ebd619f61a77a3d5ba4d2312dfbf76ec93c4845d973a4d71a3081f7902d1cda8', 9, 1, 'Personal Access Token', '[]', 0, '2022-11-16 03:05:58', '2022-11-16 03:05:58', '2023-11-16 03:05:58'),
('ae6dd0c6a8a7aa4e8c97571a5bee09e449b7b1ef5d1a433db3a53ca22facb58546493d414b6fd2a6', 1, 1, 'Personal Access Token', '[]', 0, '2022-11-15 13:09:10', '2022-11-15 13:09:10', '2023-11-15 13:09:10'),
('b290baa4c13cdf489b8a624fe29692a504e82c1da66525d0614db224ce916ca4a534dab7488e6902', 9, 1, 'Personal Access Token', '[]', 0, '2022-11-16 02:08:29', '2022-11-16 02:08:29', '2023-11-16 02:08:29'),
('b4c4b6effcf6fa1862d3736c293055ae6ba6f584db7b66ff528a51c4d4a80c7cbc0887637052b3f2', 1, 1, 'Personal Access Token', '[]', 0, '2022-11-16 02:02:52', '2022-11-16 02:02:52', '2023-11-16 02:02:52'),
('c3bc7ef47cb6b4ba6fe6601800f6725511ee0ddc9520dde34b41c89d075cf875feaaa1c77fff3fe3', 1, 1, 'Personal Access Token', '[]', 0, '2022-11-16 02:24:09', '2022-11-16 02:24:09', '2023-11-16 02:24:09'),
('ca1e787c7791f6a94653401e12f9b0fbfa7a98e000eb2ebc0bffbf7bb37279f944eb8b889c19da74', 9, 1, 'Personal Access Token', '[]', 0, '2022-11-16 02:45:24', '2022-11-16 02:45:24', '2023-11-16 02:45:24'),
('d2172e99cff1f1defc4f826dd408084100c6b2294dd4b998e24d1cf435797bd0286d3d97cea52006', 8, 1, 'Personal Access Token', '[]', 0, '2022-11-16 02:41:36', '2022-11-16 02:41:36', '2023-11-16 02:41:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'IukW5O6kxubPzO30F19SFOLVMyhY8aYMb2LLAZq9', 'http://localhost', 1, 0, 0, '2022-11-15 04:00:12', '2022-11-15 04:00:12'),
(2, NULL, 'Laravel Password Grant Client', 'cC8C2Oe0Ra96BTTHDOHICUhhD1iWUBQgMtovppWI', 'http://localhost', 0, 1, 0, '2022-11-15 04:00:12', '2022-11-15 04:00:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2022-11-15 04:00:12', '2022-11-15 04:00:12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tags`
--

CREATE TABLE `tags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tags`
--

INSERT INTO `tags` (`id`, `name`, `category_id`, `created_at`, `updated_at`) VALUES
(1, 'Male', 1, '2022-11-14 20:17:43', '2022-11-14 20:17:43'),
(2, 'Female', 1, '2022-11-14 20:17:43', '2022-11-14 20:17:43'),
(3, '<25', 1, '2022-11-14 20:17:43', '2022-11-14 20:17:43'),
(4, '25-35', 1, '2022-11-14 20:17:43', '2022-11-14 20:17:43'),
(5, '35-45', 1, '2022-11-14 20:17:43', '2022-11-14 20:17:43'),
(6, '>45', 1, '2022-11-14 20:17:43', '2022-11-14 20:17:43'),
(7, 'bablacar', 2, '2022-11-14 20:17:43', '2022-11-14 20:17:43'),
(8, 'chalet', 3, '2022-11-14 20:17:43', '2022-11-14 20:17:43');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `surname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birthdate` date NOT NULL,
  `sex` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'male-default-img.png',
  `blocked_users` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `position_lat` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position_lng` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 0,
  `confirmed` tinyint(1) NOT NULL DEFAULT 0,
  `confirmation_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `buddies` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar_changes` bigint(20) NOT NULL DEFAULT 1,
  `description` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alias` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `visibility` tinyint(1) NOT NULL DEFAULT 0,
  `distance_filter` int(11) NOT NULL DEFAULT 1000,
  `im_here` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `name`, `surname`, `birthdate`, `sex`, `email`, `phone`, `photo`, `blocked_users`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`, `position_lat`, `position_lng`, `active`, `confirmed`, `confirmation_code`, `category_id`, `buddies`, `avatar_changes`, `description`, `alias`, `visibility`, `distance_filter`, `im_here`) VALUES
(1, 'Admin', 'Admin', '2022-11-14', 'male', 'admin@gmail.com', '123456789', 'male-default-img.png', NULL, NULL, '$2y$10$/JZUmePKC2mDo3oPriV.AeMPnkR69VjGIILyQE5yLHoapQ9Zexyl6', NULL, '2022-11-14 20:20:33', '2022-11-16 02:25:14', NULL, NULL, 1, 1, NULL, 1, NULL, 1, NULL, 'Admin', 1, 1000, '2022-11-14 20:20:33'),
(2, 'Gad', 'Arenas', '1991-04-23', 'male', 'wily28090@gmail.com', '5534281526', 'male-default-img.png', NULL, NULL, '$2y$10$KDQ79r5JSbXXYujCOAsAHuUIo36dolp8C69TawMERovqgbgBzttr.', NULL, '2022-11-16 01:19:44', '2022-11-16 01:19:44', NULL, NULL, 0, 0, 'qkhGn4EKV6Wxev7pA0ryo2ObdHiZJ3', 3, NULL, 1, 'Esta es una prueba', 'garenas', 0, 1000, NULL),
(3, 'Gad', 'Arenas', '1991-04-23', 'male', 'wily28091@gmail.com', '5534281526', 'male-default-img.png', NULL, NULL, '$2y$10$y/HMZxaBUxQVFqBhjRA2je5k7rcyIiPA.Ybmo9Xn3bHY2UObwNwai', NULL, '2022-11-16 01:24:22', '2022-11-16 01:24:22', NULL, NULL, 0, 0, 'Sf3pmvd086hoVGUIJs7ecH2kORZqrT', 3, NULL, 1, 'Esta es una prueba', 'garenas', 0, 1000, NULL),
(4, 'Gad', 'Arenas', '1991-04-23', 'male', 'wily28092@gmail.com', '5534281526', 'male-default-img.png', NULL, NULL, '$2y$10$s8oMHwfsT198tkbF/FWj.On9.zKe5iGm6oG/sYr01mcpeAiLUOOGq', NULL, '2022-11-16 01:24:43', '2022-11-16 01:24:43', NULL, NULL, 0, 0, 'E3FvdTP02x9mU5RBDH4O1aIgNlfLGi', 3, NULL, 1, 'Esta es una prueba', 'garenas', 0, 1000, NULL),
(5, 'Gad', 'Arenas', '1991-04-23', 'male', 'wily2809@gmail.com', '5534281526', 'male-default-img.png', NULL, NULL, '$2y$10$Cg7N.xXrDW9qDI1O7HDdgO1JSJJNIkYMFtSMYrpsQNo1BzmGtDVHm', NULL, '2022-11-16 01:25:45', '2022-11-16 01:25:45', NULL, NULL, 0, 0, 'aI5tu49ARYqUszNciodEFr8ywJKGBW', 3, NULL, 1, 'Esta es una prueba', 'garenas', 0, 1000, NULL),
(6, 'Gad', 'Arenas', '1991-04-23', 'male', 'wilianponce2809@gmail.com', '5534281526', 'male-default-img.png', NULL, NULL, '$2y$10$JtaKxVhWrxaHLgU/2rTQqu055hoi85N8RDjSH5KfGVGDisKFruK7q', NULL, '2022-11-16 01:27:06', '2022-11-16 01:27:06', NULL, NULL, 0, 0, '5ykbASGKaPhuLMxFgcvI0dirX71z2Y', 3, NULL, 1, 'Esta es una prueba', 'garenas', 0, 1000, NULL),
(7, 'Gad', 'Arenas', '1991-04-23', 'male', 'wily2809@hotmail.com', '5534281526', 'male-default-img.png', NULL, NULL, '$2y$10$aomBRqEjW48vnjYlpiQ6Ee8lv5Ue7s.lKgE1Xjy8qH.e2a.qK34nC', NULL, '2022-11-16 01:29:22', '2022-11-16 01:29:37', NULL, NULL, 0, 1, 'K0jSCQ1JpefkLGVh9T3WubnX7PgqUH', 3, NULL, 1, 'Esta es una prueba', 'garenas', 0, 1000, NULL),
(8, 'Gad', 'Arenas', '1991-04-23', 'male', 'g2@d.com', '3216549870', 'male-default-img.png', NULL, NULL, '$2y$10$Y5dOco6L/XuZC5.4V9hpfe4P2dbrtXkr/JcRAISU/aLDv3Sa7CNTG', NULL, '2022-11-16 01:31:14', '2022-11-16 02:41:39', '19.4247788', '-98.9521357', 1, 1, 'AMLYKuF1wXkros0EHz6V9BC4lvGZOe', 3, NULL, 1, 'Prueba registro edin', 'garenas', 0, 1000, '2022-11-16 02:41:38'),
(9, 'Gad', 'Arenad', '1991-05-23', 'male', 'g3@d.com', '1234567890', 'male-default-img.png', NULL, NULL, '$2y$10$/iU1uGt6IBzsYiYmP0sW9OU97gW9tE8EaKYNIBkYDtIr7vKcpewZK', NULL, '2022-11-16 01:36:17', '2022-11-16 03:06:20', '19.3492663', '-98.9854426', 1, 1, 'VMdFc2aKxAJvZlbrj0XpkT8fULInoS', 3, NULL, 1, 'Peueba', 'arenasgad', 0, 1000, '2022-11-16 02:56:49'),
(10, 'Juan', 'Rodríguez', '1984-11-16', 'male', 'jcr_bahia1@hotmail.com', '11223366', 'male-default-img.png', NULL, NULL, '$2y$10$5i1Zqb3pBTGIHKmIDEdkjOsDHMDicdoHZKH0.Jsa1qrl2hSF5XkIO', NULL, '2022-11-16 11:17:53', '2022-11-16 11:33:05', '39.4697587', '-0.3710009', 1, 1, 'nOYch0z5uW3QEM624DNbgeVkKZiJwI', 1, NULL, 1, 'Esto es un demo', 'juanjuan', 0, 1000, '2022-11-16 11:33:05'),
(11, 'Tony', 'Quvi', '1998-11-16', 'male', 'aquevi.duyal@gmail.com', '611600720', 'male-default-img.png', NULL, NULL, '$2y$10$M4EGwypvYWmoCTUJCw/A2.dfN9U7ZBma/CszrpS/JKIt0do0Dt0YS', NULL, '2022-11-16 11:20:57', '2022-11-17 12:34:09', '35.8867274', '-5.3487748', 1, 1, '1FvxyJe3GCl2fdKkZ6cHPaIR4zhsm7', 1, NULL, 1, 'Hola  mundo', 'Tony', 1, 1000, '2022-11-17 12:34:09');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alerts`
--
ALTER TABLE `alerts`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `filters`
--
ALTER TABLE `filters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `filters_category_id_foreign` (`category_id`);

--
-- Indices de la tabla `markers`
--
ALTER TABLE `markers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `markers_user_id_foreign` (`user_id`),
  ADD KEY `markers_category_id_foreign` (`category_id`);

--
-- Indices de la tabla `markers_photos`
--
ALTER TABLE `markers_photos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `markers_photos_marker_id_foreign` (`marker_id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indices de la tabla `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indices de la tabla `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`);

--
-- Indices de la tabla `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indices de la tabla `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tags_category_id_foreign` (`category_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_category_id_foreign` (`category_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alerts`
--
ALTER TABLE `alerts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `filters`
--
ALTER TABLE `filters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `markers`
--
ALTER TABLE `markers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `markers_photos`
--
ALTER TABLE `markers_photos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tags`
--
ALTER TABLE `tags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `filters`
--
ALTER TABLE `filters`
  ADD CONSTRAINT `filters_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `markers`
--
ALTER TABLE `markers`
  ADD CONSTRAINT `markers_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `markers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `markers_photos`
--
ALTER TABLE `markers_photos`
  ADD CONSTRAINT `markers_photos_marker_id_foreign` FOREIGN KEY (`marker_id`) REFERENCES `markers` (`id`);

--
-- Filtros para la tabla `tags`
--
ALTER TABLE `tags`
  ADD CONSTRAINT `tags_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
