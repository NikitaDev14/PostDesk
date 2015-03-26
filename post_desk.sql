SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;


DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
`idCategory` int(6) NOT NULL,
  `Name` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

INSERT INTO `categories` (`idCategory`, `Name`) VALUES
(1, 'real estate'),
(2, 'transport'),
(3, 'electronics'),
(4, 'services');

DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
`idPost` int(6) NOT NULL,
  `idUser` int(6) NOT NULL,
  `idSubcategory` int(6) NOT NULL,
  `Text` text NOT NULL,
  `isHidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `subcategories`;
CREATE TABLE IF NOT EXISTS `subcategories` (
`idSubcategory` int(6) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `idCategory` int(6) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

INSERT INTO `subcategories` (`idSubcategory`, `Name`, `idCategory`) VALUES
(1, 'apartments for rent', 1),
(2, 'rooms for rent', 1),
(3, 'cars', 2),
(4, 'motorcycles', 2);

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
`idUser` int(6) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `SurName` varchar(50) NOT NULL,
  `Phone` varchar(13) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE `categories`
 ADD PRIMARY KEY (`idCategory`);

ALTER TABLE `posts`
 ADD PRIMARY KEY (`idPost`), ADD KEY `idSubcategory` (`idSubcategory`), ADD KEY `idUser` (`idUser`);

ALTER TABLE `subcategories`
 ADD PRIMARY KEY (`idSubcategory`), ADD KEY `idCategory` (`idCategory`);

ALTER TABLE `users`
 ADD PRIMARY KEY (`idUser`);


ALTER TABLE `categories`
MODIFY `idCategory` int(6) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
ALTER TABLE `posts`
MODIFY `idPost` int(6) NOT NULL AUTO_INCREMENT;
ALTER TABLE `subcategories`
MODIFY `idSubcategory` int(6) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
ALTER TABLE `users`
MODIFY `idUser` int(6) NOT NULL AUTO_INCREMENT;

ALTER TABLE `posts`
ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`idSubcategory`) REFERENCES `subcategories` (`idSubcategory`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `posts_ibfk_2` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUser`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `subcategories`
ADD CONSTRAINT `subcategories_ibfk_1` FOREIGN KEY (`idCategory`) REFERENCES `categories` (`idCategory`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
