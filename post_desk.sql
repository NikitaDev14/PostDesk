-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Мар 25 2015 г., 19:53
-- Версия сервера: 5.6.21
-- Версия PHP: 5.6.3

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `post_desk`
--

DELIMITER $$
--
-- Процедуры
--
DROP PROCEDURE IF EXISTS `getCategories`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getCategories`()
    READS SQL DATA
    DETERMINISTIC
SELECT Name FROM categories$$

DROP PROCEDURE IF EXISTS `getSubcategories`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSubcategories`(IN `cat` VARCHAR(50) CHARSET utf8)
    READS SQL DATA
    DETERMINISTIC
begin
    SELECT Name 
    FROM subcategories 
    WHERE idCategory = (SELECT idCategory FROM categories WHERE Name = cat);
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
`idCategory` int(6) NOT NULL,
  `Name` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Очистить таблицу перед добавлением данных `categories`
--

TRUNCATE TABLE `categories`;
--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`idCategory`, `Name`) VALUES
(1, 'real estate'),
(2, 'transport'),
(3, 'electronics'),
(4, 'services');

-- --------------------------------------------------------

--
-- Структура таблицы `subcategories`
--

DROP TABLE IF EXISTS `subcategories`;
CREATE TABLE IF NOT EXISTS `subcategories` (
`idSubcategory` int(6) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `idCategory` int(6) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Очистить таблицу перед добавлением данных `subcategories`
--

TRUNCATE TABLE `subcategories`;
--
-- Дамп данных таблицы `subcategories`
--

INSERT INTO `subcategories` (`idSubcategory`, `Name`, `idCategory`) VALUES
(1, 'apartments for rent', 1),
(2, 'rooms for rent', 1),
(3, 'cars', 2),
(4, 'motorcycles', 2);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `categories`
--
ALTER TABLE `categories`
 ADD PRIMARY KEY (`idCategory`);

--
-- Индексы таблицы `subcategories`
--
ALTER TABLE `subcategories`
 ADD PRIMARY KEY (`idSubcategory`), ADD KEY `idCategory` (`idCategory`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
MODIFY `idCategory` int(6) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT для таблицы `subcategories`
--
ALTER TABLE `subcategories`
MODIFY `idSubcategory` int(6) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;SET FOREIGN_KEY_CHECKS=1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
