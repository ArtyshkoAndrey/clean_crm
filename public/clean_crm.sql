-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Окт 25 2019 г., 10:27
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
-- Структура таблицы `clean_images`
--

CREATE TABLE `clean_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `path` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `clean_images`
--

INSERT INTO `clean_images` (`id`, `path`, `created_at`, `updated_at`) VALUES
(1, '\"{\\\"file\\\":\\\"\\\\\\/images\\\\\\/tasks\\\\\\/123.jpg\\\",\\\"type\\\":\\\"type\\\\\\/jpg\\\",\\\"size\\\":324422,\\\"name\\\":\\\"123.jpg\\\"}\"', '2019-10-24 23:24:09', '2019-10-24 23:24:09');

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
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_10_19_060746_create_tasks_table', 1),
(4, '2019_10_25_013238_create_responsibles_table', 1),
(5, '2019_10_25_015030_create_user_tasks_table', 1),
(6, '2019_10_25_033903_create_images_table', 2),
(7, '2019_10_25_033955_create_task_images_table', 2);

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
-- Структура таблицы `clean_responsibles`
--

CREATE TABLE `clean_responsibles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `clean_responsibles`
--

INSERT INTO `clean_responsibles` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Отдел экономики и развития местного самоуправления', '2019-10-24 18:59:02', '2019-10-24 18:59:02'),
(2, 'Глухих Р.С.', '2019-10-24 18:59:02', '2019-10-24 18:59:02'),
(3, 'Отдел по землепользованию и благоустройству района', '2019-10-24 18:59:02', '2019-10-24 18:59:02'),
(4, 'Отдел жилищно-коммунального хозяйства', '2019-10-24 18:59:02', '2019-10-24 18:59:02'),
(5, 'GHbdtn', '2019-10-24 20:34:33', '2019-10-24 20:34:33'),
(6, 'Как дела', '2019-10-24 20:34:49', '2019-10-24 20:34:49'),
(7, 'Сибгу им. Решетнева', '2019-10-24 20:34:56', '2019-10-24 20:34:56'),
(8, 'УК ЖСК', '2019-10-24 20:35:02', '2019-10-24 20:35:02'),
(9, 'Привет', '2019-10-24 20:35:29', '2019-10-24 20:35:29'),
(10, 'Пока', '2019-10-24 21:18:55', '2019-10-24 21:18:55');

-- --------------------------------------------------------

--
-- Структура таблицы `clean_tasks`
--

CREATE TABLE `clean_tasks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `street` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `number_home` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `date_of_detection` date NOT NULL,
  `responsible_id` int(11) NOT NULL,
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

INSERT INTO `clean_tasks` (`id`, `user_id`, `name`, `street`, `number_home`, `description`, `date_of_detection`, `responsible_id`, `target_date`, `correction_date`, `responsible_executor`, `conducted_work`, `created_at`, `updated_at`) VALUES
(1, 1, 'Пакетик', 'Горького', '24', 'Пакет на дереве', '2019-10-21', 1, '2019-10-24', NULL, NULL, NULL, '2019-10-24 18:59:02', '2019-10-24 18:59:02');

-- --------------------------------------------------------

--
-- Структура таблицы `clean_task_images`
--

CREATE TABLE `clean_task_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `task_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `clean_task_images`
--

INSERT INTO `clean_task_images` (`id`, `task_id`, `image_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2019-10-24 17:00:00', '2019-10-24 17:00:00');

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
(1, 'Артышко А. А.', 'artyshko.andrey@gmail.com', '$2y$10$qcS6N20sCHZs2WcN1xlG8egaPknw/1rTx5s9JAuLVImbDfRNmEjy2', 'admin', NULL, '2019-10-24 18:59:02', '2019-10-24 18:59:02'),
(2, 'Миронов М. М.', 'artyshko.andrey1@gmail.com', '$2y$10$A6ozsMz.s9BOO/J1D9ypHeC6d7MWygI6G1SiEGH0rUDiNvbtgydLu', 'admin', NULL, '2019-10-24 18:59:02', '2019-10-24 18:59:02');

-- --------------------------------------------------------

--
-- Структура таблицы `clean_user_tasks`
--

CREATE TABLE `clean_user_tasks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `clean_user_tasks`
--

INSERT INTO `clean_user_tasks` (`id`, `user_id`, `task_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2019-10-24 18:59:02', '2019-10-24 18:59:02'),
(2, 2, 1, '2019-10-24 18:59:02', '2019-10-24 18:59:02');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `clean_images`
--
ALTER TABLE `clean_images`
  ADD PRIMARY KEY (`id`);

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
-- Индексы таблицы `clean_responsibles`
--
ALTER TABLE `clean_responsibles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `responsibles_name_unique` (`name`);

--
-- Индексы таблицы `clean_tasks`
--
ALTER TABLE `clean_tasks`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `clean_task_images`
--
ALTER TABLE `clean_task_images`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `clean_users`
--
ALTER TABLE `clean_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Индексы таблицы `clean_user_tasks`
--
ALTER TABLE `clean_user_tasks`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `clean_images`
--
ALTER TABLE `clean_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `clean_migrations`
--
ALTER TABLE `clean_migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `clean_responsibles`
--
ALTER TABLE `clean_responsibles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `clean_tasks`
--
ALTER TABLE `clean_tasks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `clean_task_images`
--
ALTER TABLE `clean_task_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `clean_users`
--
ALTER TABLE `clean_users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `clean_user_tasks`
--
ALTER TABLE `clean_user_tasks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
