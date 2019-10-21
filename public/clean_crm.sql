-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Окт 21 2019 г., 10:39
-- Версия сервера: 5.6.43-log
-- Версия PHP: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `clean_crm`
--

-- --------------------------------------------------------

--
-- Структура таблицы `clean_migrations`
--

CREATE TABLE `clean_migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `clean_migrations`
--

INSERT INTO `clean_migrations` (`id`, `migration`, `batch`) VALUES
(6, '2014_10_12_000000_create_users_table', 1),
(7, '2014_10_12_100000_create_password_resets_table', 1),
(8, '2016_05_13_060834_create_settings_table', 1),
(9, '2018_05_22_084901_create_todos_table', 1),
(10, '2019_10_19_060746_create_tasks_table', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `clean_password_resets`
--

CREATE TABLE `clean_password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `clean_settings`
--

CREATE TABLE `clean_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `option` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `clean_tasks`
--

CREATE TABLE `clean_tasks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `street` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `number_home` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `date_of_detection` date NOT NULL,
  `responsible` text COLLATE utf8_unicode_ci NOT NULL,
  `target_date` date NOT NULL,
  `correction_date` date DEFAULT NULL,
  `responsible_executor` text COLLATE utf8_unicode_ci,
  `conducted_work` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `clean_tasks`
--

INSERT INTO `clean_tasks` (`id`, `user_id`, `street`, `number_home`, `description`, `date_of_detection`, `responsible`, `target_date`, `correction_date`, `responsible_executor`, `conducted_work`, `created_at`, `updated_at`) VALUES
(1, 1, 'Горького', '24', 'Пакет на дереве', '2019-10-21', 'Сибгу им. Решетнева', '2019-10-24', NULL, NULL, NULL, '2019-10-20 22:59:13', '2019-10-20 22:59:13'),
(2, 1, 'Горького', '24', 'Пакет на дереве', '2019-10-20', 'Сибгу им. Решетнева', '2019-10-23', NULL, NULL, NULL, '2019-10-20 22:59:13', '2019-10-20 22:59:13'),
(3, 1, 'Горького', '24', 'Пакет на дереве', '2019-10-20', 'Сибгу им. Решетнева', '2019-10-23', NULL, NULL, NULL, '2019-10-20 22:59:13', '2019-10-20 22:59:13'),
(4, 1, 'Горького', '24', 'Пакет на дереве', '2019-10-20', 'Сибгу им. Решетнева', '2019-10-23', NULL, NULL, NULL, '2019-10-20 22:59:13', '2019-10-20 22:59:13'),
(5, 1, 'Горького', '24', 'Пакет на дереве', '2019-10-21', 'Сибгу им. Решетнева', '2019-10-24', NULL, NULL, NULL, '2019-10-20 22:59:13', '2019-10-20 22:59:13'),
(6, 1, 'Горького', '24', 'Пакет на дереве', '2019-10-20', 'Сибгу им. Решетнева', '2019-10-23', NULL, NULL, NULL, '2019-10-20 22:59:13', '2019-10-20 22:59:13'),
(7, 1, 'Горького', '24', 'Пакет на дереве', '2019-10-20', 'Сибгу им. Решетнева', '2019-10-23', NULL, NULL, NULL, '2019-10-20 22:59:13', '2019-10-20 22:59:13'),
(8, 1, 'Горького', '24', 'Пакет на дереве', '2019-10-20', 'Сибгу им. Решетнева', '2019-10-23', NULL, NULL, NULL, '2019-10-20 22:59:13', '2019-10-20 22:59:13'),
(9, 1, 'Горького', '24', 'Пакет на дереве', '2019-10-21', 'Сибгу им. Решетнева', '2019-10-24', NULL, NULL, NULL, '2019-10-20 22:59:13', '2019-10-20 22:59:13'),
(10, 1, 'Горького', '24', 'Пакет на дереве', '2019-10-21', 'Сибгу им. Решетнева', '2019-10-24', NULL, NULL, NULL, '2019-10-20 22:59:13', '2019-10-20 22:59:13'),
(11, 1, 'Горького', '24', 'Пакет на дереве', '2019-10-20', 'Сибгу им. Решетнева', '2019-10-23', NULL, NULL, NULL, '2019-10-20 22:59:13', '2019-10-20 22:59:13'),
(12, 1, 'Горького', '24', 'Пакет на дереве', '2019-10-20', 'Сибгу им. Решетнева', '2019-10-23', NULL, NULL, NULL, '2019-10-20 22:59:13', '2019-10-20 22:59:13'),
(13, 1, 'Горького', '24', 'Пакет на дереве', '2019-10-20', 'Сибгу им. Решетнева', '2019-10-23', NULL, NULL, NULL, '2019-10-20 22:59:13', '2019-10-20 22:59:13'),
(14, 1, 'Горького', '24', 'Пакет на дереве', '2019-10-20', 'Сибгу им. Решетнева', '2019-10-23', NULL, NULL, NULL, '2019-10-20 22:59:13', '2019-10-20 22:59:13'),
(15, 1, 'Горького', '24', 'Пакет на дереве', '2019-10-20', 'Сибгу им. Решетнева', '2019-10-23', NULL, NULL, NULL, '2019-10-20 22:59:13', '2019-10-20 22:59:13'),
(16, 1, 'Горького', '24', 'Пакет на дереве', '2019-10-20', 'Сибгу им. Решетнева', '2019-10-23', NULL, NULL, NULL, '2019-10-20 22:59:13', '2019-10-20 22:59:13');

-- --------------------------------------------------------

--
-- Структура таблицы `clean_todos`
--

CREATE TABLE `clean_todos` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `completed` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `clean_users`
--

CREATE TABLE `clean_users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `role` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'user',
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `clean_users`
--

INSERT INTO `clean_users` (`id`, `name`, `email`, `password`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Артышко А. А.', 'artyshko.andrey@gmail.com', '$2y$10$/.k7w7.PDeuEJkr6fvxEqeOiMhp2VZXICgsdY0pndmHegzbl9TSB2', 'admin', NULL, '2019-10-20 22:59:13', '2019-10-20 22:59:13');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `clean_migrations`
--
ALTER TABLE `clean_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `clean_password_resets`
--
ALTER TABLE `clean_password_resets`
  ADD KEY `password_resets_email_index` (`email`),
  ADD KEY `password_resets_token_index` (`token`);

--
-- Индексы таблицы `clean_settings`
--
ALTER TABLE `clean_settings`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `clean_tasks`
--
ALTER TABLE `clean_tasks`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `clean_todos`
--
ALTER TABLE `clean_todos`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `clean_users`
--
ALTER TABLE `clean_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `clean_migrations`
--
ALTER TABLE `clean_migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `clean_settings`
--
ALTER TABLE `clean_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `clean_tasks`
--
ALTER TABLE `clean_tasks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `clean_todos`
--
ALTER TABLE `clean_todos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `clean_users`
--
ALTER TABLE `clean_users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
