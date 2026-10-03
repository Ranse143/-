-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Сен 04 2026 г., 12:51
-- Версия сервера: 5.7.39
-- Версия PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `test`
--

-- --------------------------------------------------------

--
-- Структура таблицы `cities`
--

CREATE TABLE `cities` (
  `city_id` int(11) NOT NULL,
  `city_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `cities`
--

INSERT INTO `cities` (`city_id`, `city_name`, `country_id`) VALUES
(1, 'Москва', 1),
(2, 'Санкт-Петербург', 1),
(3, 'Анталья', 2),
(4, 'Рим', 3),
(5, 'Париж', 4);

-- --------------------------------------------------------

--
-- Структура таблицы `countries`
--

CREATE TABLE `countries` (
  `country_id` int(11) NOT NULL,
  `country_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `countries`
--

INSERT INTO `countries` (`country_id`, `country_name`) VALUES
(1, 'Россия'),
(2, 'Турция'),
(3, 'Италия'),
(4, 'Франция');

-- --------------------------------------------------------

--
-- Структура таблицы `tourists`
--

CREATE TABLE `tourists` (
  `tourist_id` int(11) NOT NULL,
  `full_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `tourists`
--

INSERT INTO `tourists` (`tourist_id`, `full_name`, `phone`, `email`) VALUES
(1, 'Иванов Иван Иванович', '+79990000001', 'ivanov@mail.ru'),
(2, 'Петров Петр Петрович', '+79990000002', 'petrov@mail.ru'),
(3, 'Сидорова Анна Сергеевна', '+79990000003', 'sidorova@mail.ru');

-- --------------------------------------------------------

--
-- Структура таблицы `tours`
--

CREATE TABLE `tours` (
  `tour_id` int(11) NOT NULL,
  `tourist_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `tours`
--

INSERT INTO `tours` (`tour_id`, `tourist_id`, `city_id`, `type_id`, `start_date`, `end_date`, `price`) VALUES
(1, 1, 3, 1, '2026-06-10', '2026-06-20', '85000.00'),
(2, 2, 4, 2, '2026-07-05', '2026-07-12', '120000.00'),
(3, 3, 5, 3, '2026-08-15', '2026-08-22', '135000.00'),
(4, 1, 2, 2, '2026-09-01', '2026-09-07', '55000.00');

-- --------------------------------------------------------

--
-- Структура таблицы `tour_types`
--

CREATE TABLE `tour_types` (
  `type_id` int(11) NOT NULL,
  `type_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `tour_types`
--

INSERT INTO `tour_types` (`type_id`, `type_name`) VALUES
(1, 'Пляжный'),
(2, 'Экскурсионный'),
(3, 'Познавательный'),
(4, 'Горный');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`city_id`),
  ADD KEY `country_id` (`country_id`);

--
-- Индексы таблицы `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`country_id`);

--
-- Индексы таблицы `tourists`
--
ALTER TABLE `tourists`
  ADD PRIMARY KEY (`tourist_id`);

--
-- Индексы таблицы `tours`
--
ALTER TABLE `tours`
  ADD PRIMARY KEY (`tour_id`),
  ADD KEY `tourist_id` (`tourist_id`),
  ADD KEY `city_id` (`city_id`),
  ADD KEY `type_id` (`type_id`);

--
-- Индексы таблицы `tour_types`
--
ALTER TABLE `tour_types`
  ADD PRIMARY KEY (`type_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `cities`
--
ALTER TABLE `cities`
  MODIFY `city_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `countries`
--
ALTER TABLE `countries`
  MODIFY `country_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `tourists`
--
ALTER TABLE `tourists`
  MODIFY `tourist_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `tours`
--
ALTER TABLE `tours`
  MODIFY `tour_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `tour_types`
--
ALTER TABLE `tour_types`
  MODIFY `type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `cities`
--
ALTER TABLE `cities`
  ADD CONSTRAINT `cities_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`country_id`);

--
-- Ограничения внешнего ключа таблицы `tours`
--
ALTER TABLE `tours`
  ADD CONSTRAINT `tours_ibfk_1` FOREIGN KEY (`tourist_id`) REFERENCES `tourists` (`tourist_id`),
  ADD CONSTRAINT `tours_ibfk_2` FOREIGN KEY (`city_id`) REFERENCES `cities` (`city_id`),
  ADD CONSTRAINT `tours_ibfk_3` FOREIGN KEY (`type_id`) REFERENCES `tour_types` (`type_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
