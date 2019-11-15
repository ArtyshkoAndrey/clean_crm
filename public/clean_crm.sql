-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Ноя 15 2019 г., 14:10
-- Версия сервера: 5.7.25-log
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
  `path` json NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(3, '2016_01_15_105324_create_roles_table', 1),
(4, '2016_01_15_114412_create_role_user_table', 1),
(5, '2016_01_26_115212_create_permissions_table', 1),
(6, '2016_01_26_115523_create_permission_role_table', 1),
(7, '2016_02_09_132439_create_permission_user_table', 1),
(8, '2019_10_19_060746_create_tasks_table', 1),
(9, '2019_10_25_013238_create_responsibles_table', 1),
(10, '2019_10_25_015030_create_user_tasks_table', 1),
(11, '2019_10_25_033903_create_images_table', 1),
(12, '2019_10_25_033955_create_task_images_table', 1),
(13, '2019_11_07_103316_create_profiles_table', 1);

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
-- Структура таблицы `clean_permissions`
--

CREATE TABLE `clean_permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `clean_permissions`
--

INSERT INTO `clean_permissions` (`id`, `name`, `slug`, `description`, `model`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Can View Users', 'view.users', 'Can view users', 'Permission', '2019-11-13 11:03:53', '2019-11-13 11:03:53', NULL),
(2, 'Can Create Users', 'create.users', 'Can create new users', 'Permission', '2019-11-13 11:03:53', '2019-11-13 11:03:53', NULL),
(3, 'Can Edit Users', 'edit.users', 'Can edit users', 'Permission', '2019-11-13 11:03:53', '2019-11-13 11:03:53', NULL),
(4, 'Can Delete Users', 'delete.users', 'Can delete users', 'Permission', '2019-11-13 11:03:53', '2019-11-13 11:03:53', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `clean_permission_role`
--

CREATE TABLE `clean_permission_role` (
  `id` int(10) UNSIGNED NOT NULL,
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `clean_permission_role`
--

INSERT INTO `clean_permission_role` (`id`, `permission_id`, `role_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 1, '2019-11-13 11:03:53', '2019-11-13 11:03:53', NULL),
(2, 2, 1, '2019-11-13 11:03:53', '2019-11-13 11:03:53', NULL),
(3, 3, 1, '2019-11-13 11:03:53', '2019-11-13 11:03:53', NULL),
(4, 4, 1, '2019-11-13 11:03:53', '2019-11-13 11:03:53', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `clean_permission_user`
--

CREATE TABLE `clean_permission_user` (
  `id` int(10) UNSIGNED NOT NULL,
  `permission_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `clean_profiles`
--

CREATE TABLE `clean_profiles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `birthday` date NOT NULL,
  `avatar` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `clean_profiles`
--

INSERT INTO `clean_profiles` (`id`, `user_id`, `birthday`, `avatar`, `created_at`, `updated_at`) VALUES
(1, 1, '1998-12-24', 'https://sun9-49.userapi.com/c857132/v857132657/2d7ed/emmP4VZJXng.jpg', '2019-11-13 11:03:53', '2019-11-13 11:03:53');

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
(1, 'Отдел экономики и развития местного самоуправления', '2019-11-13 11:03:53', '2019-11-13 11:03:53'),
(2, 'Глухих Р.С.', '2019-11-13 11:03:53', '2019-11-13 11:03:53'),
(3, 'Отдел по землепользованию и благоустройству района', '2019-11-13 11:03:53', '2019-11-13 11:03:53'),
(4, 'Отдел жилищно-коммунального хозяйства', '2019-11-13 11:03:53', '2019-11-13 11:03:53');

-- --------------------------------------------------------

--
-- Структура таблицы `clean_roles`
--

CREATE TABLE `clean_roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `clean_roles`
--

INSERT INTO `clean_roles` (`id`, `name`, `slug`, `description`, `level`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Admin', 'admin', 'Admin Role', 5, '2019-11-13 11:03:53', '2019-11-13 11:03:53', NULL),
(2, 'User', 'user', 'User Role', 1, '2019-11-13 11:03:53', '2019-11-13 11:03:53', NULL),
(3, 'Unverified', 'unverified', 'Unverified Role', 0, '2019-11-13 11:03:53', '2019-11-13 11:03:53', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `clean_role_user`
--

CREATE TABLE `clean_role_user` (
  `id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
  `detection_date` date NOT NULL,
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

INSERT INTO `clean_tasks` (`id`, `user_id`, `name`, `street`, `number_home`, `description`, `detection_date`, `responsible_id`, `target_date`, `correction_date`, `responsible_executor`, `conducted_work`, `created_at`, `updated_at`) VALUES
(1, 1, 'Пакетик', 'Горького', '24', 'Пакет на дереве', '2019-10-21', 1, '2019-10-24', NULL, NULL, NULL, '2019-11-13 11:03:53', '2019-11-13 11:03:53');

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

-- --------------------------------------------------------

--
-- Структура таблицы `clean_users`
--

CREATE TABLE `clean_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `profile_id` int(11) DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `clean_users`
--

INSERT INTO `clean_users` (`id`, `name`, `email`, `password`, `profile_id`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Артышко А. А.', 'artyshko.andrey@gmail.com', '$2y$10$D3KzgC1TJoRzXVuFoRhWNumSc6BPYMZOtLXqe6ZJJYLt7X94oUyja', 1, NULL, '2019-11-13 11:03:53', '2019-11-13 11:03:53'),
(2, 'Миронов М. М.', 'artyshko.andrey1@gmail.com', '$2y$10$LEEaQHb0Uy27RXrRt4ie8.EbFsDCdSF0N8I7RAfQ0xLazXKOT.3JS', NULL, NULL, '2019-11-13 11:03:53', '2019-11-13 11:03:53');

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
(1, 1, 1, '2019-11-13 11:03:53', '2019-11-13 11:03:53'),
(2, 2, 1, '2019-11-13 11:03:53', '2019-11-13 11:03:53');

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
-- Индексы таблицы `clean_permissions`
--
ALTER TABLE `clean_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_slug_unique` (`slug`);

--
-- Индексы таблицы `clean_permission_role`
--
ALTER TABLE `clean_permission_role`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permission_role_permission_id_index` (`permission_id`),
  ADD KEY `permission_role_role_id_index` (`role_id`);

--
-- Индексы таблицы `clean_permission_user`
--
ALTER TABLE `clean_permission_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permission_user_permission_id_index` (`permission_id`),
  ADD KEY `permission_user_user_id_index` (`user_id`);

--
-- Индексы таблицы `clean_profiles`
--
ALTER TABLE `clean_profiles`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `clean_responsibles`
--
ALTER TABLE `clean_responsibles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `responsibles_name_unique` (`name`);

--
-- Индексы таблицы `clean_roles`
--
ALTER TABLE `clean_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_slug_unique` (`slug`);

--
-- Индексы таблицы `clean_role_user`
--
ALTER TABLE `clean_role_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_user_role_id_index` (`role_id`),
  ADD KEY `role_user_user_id_index` (`user_id`);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `clean_migrations`
--
ALTER TABLE `clean_migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT для таблицы `clean_permissions`
--
ALTER TABLE `clean_permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `clean_permission_role`
--
ALTER TABLE `clean_permission_role`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `clean_permission_user`
--
ALTER TABLE `clean_permission_user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `clean_profiles`
--
ALTER TABLE `clean_profiles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `clean_responsibles`
--
ALTER TABLE `clean_responsibles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `clean_roles`
--
ALTER TABLE `clean_roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `clean_role_user`
--
ALTER TABLE `clean_role_user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `clean_tasks`
--
ALTER TABLE `clean_tasks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `clean_task_images`
--
ALTER TABLE `clean_task_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `clean_users`
--
ALTER TABLE `clean_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `clean_user_tasks`
--
ALTER TABLE `clean_user_tasks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `clean_permission_role`
--
ALTER TABLE `clean_permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `clean_permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `clean_roles` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `clean_permission_user`
--
ALTER TABLE `clean_permission_user`
  ADD CONSTRAINT `permission_user_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `clean_permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `permission_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `clean_users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `clean_role_user`
--
ALTER TABLE `clean_role_user`
  ADD CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `clean_roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `clean_users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
