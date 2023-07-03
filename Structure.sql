CREATE DATABASE DACN;
USE DACN;
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idPost` int DEFAULT NULL,
  `idUser` int DEFAULT NULL,
  `dateComment` varchar(20) DEFAULT NULL,
  `noidungComment` varchar(200) DEFAULT NULL,
  `isAnDanh` int DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idUserCmt` (`idUser`),
  KEY `idPostCmt` (`idPost`),
  CONSTRAINT `idPost_post_key` FOREIGN KEY (`idPost`) REFERENCES `post` (`id`),
  CONSTRAINT `idUser_theuser_key` FOREIGN KEY (`idUser`) REFERENCES `theuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `hiddenpost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hiddenpost` (
  `idUser` int NOT NULL,
  `idPost` int NOT NULL,
  `favorite` int DEFAULT NULL,
  PRIMARY KEY (`idUser`,`idPost`),
  KEY `hiddenpost_ibfk_2` (`idPost`),
  CONSTRAINT `hiddenpost_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `theuser` (`id`),
  CONSTRAINT `hiddenpost_ibfk_2` FOREIGN KEY (`idPost`) REFERENCES `post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `picture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `picture` (
  `id` varchar(50) NOT NULL,
  `url` varchar(200) NOT NULL,
  `contentType` varchar(20) NOT NULL,
  `idPost` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `idPost` (`idPost`),
  CONSTRAINT `picture_ibfk_1` FOREIGN KEY (`idPost`) REFERENCES `post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idUser` int NOT NULL,
  `tieudePost` varchar(100) DEFAULT NULL,
  `nguoiguiPost` varchar(50) DEFAULT NULL,
  `datePost` varchar(20) DEFAULT NULL,
  `noidungPost` varchar(200) DEFAULT NULL,
  `trangThai` varchar(50) DEFAULT 'Chưa duyệt',
  `mdHuHong` varchar(50) DEFAULT NULL,
  `mdCanThiet` varchar(50) DEFAULT NULL,
  `thietBi` varchar(50) DEFAULT NULL,
  `diachi` varchar(100) DEFAULT NULL,
  `thoiHan` varchar(20) DEFAULT NULL,
  `ghiChu` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idUser` (`idUser`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `theuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `theuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `theuser` (
  `id` int NOT NULL AUTO_INCREMENT,
  `passwordUser` varchar(500) NOT NULL,
  `mssvUser` varchar(15) NOT NULL,
  `nameUser` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `emailUser` varchar(100) NOT NULL,
  `lopUser` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `sdtUser` varchar(15) DEFAULT NULL,
  `dateUser` varchar(20) DEFAULT NULL,
  `diachiUser` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `avatarUser` varchar(500) DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1',
  `rule` int NOT NULL DEFAULT '3',
  PRIMARY KEY (`id`),
  UNIQUE KEY `emailUser_UNIQUE` (`emailUser`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));