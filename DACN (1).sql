-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: dacn
-- ------------------------------------------------------
-- Server version	8.0.31

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

--
-- Table structure for table `comment`
--

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

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (3,17,1,'2023-06-06 16:21:34','helllo boy ',0),(4,17,1,'2023-06-06 16:21:46','xin chào các men',0),(5,18,1,'2023-06-06 16:22:02','oiiiiii muối vẫn mặn',0),(6,19,2,'2023-06-06 16:22:26','aloooo cướp ',0),(9,22,2,'2023-06-18 10:06:43','abc bánh bèo',0),(12,22,2,'2023-06-20 18:24:23','abcd bánh bèoooo',0),(13,22,2,'2023-06-20 18:24:23','abc bánh bèo',0),(15,32,1,'2023-06-22 12:14:32','cEwrjandbhee ưu',0),(16,32,1,'2023-06-22 12:17:09','đt jk',0),(17,32,1,'2023-06-22 12:18:46','ksjsndjs',0),(18,32,1,'2023-06-22 12:21:02','kzogzkgzlh,LH,',0),(19,32,1,'2023-06-22 12:21:05','ueuueeuje',0),(20,32,1,'2023-06-22 12:21:16','riuur',0),(21,32,1,'2023-06-22 12:24:11','alo alo',0),(22,32,1,'2023-06-22 12:24:33','hello everyone ',0),(23,32,1,'2023-06-22 12:29:11','tôi là mật vụ áo đen',1),(24,32,1,'2023-06-22 12:33:54','alo bí ẩn là đây',1),(25,32,1,'2023-06-22 12:50:40','nNznsnsn',1),(26,32,2,'2023-06-22 12:53:42','alo tôi là người thứ 2',1);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hiddenpost`
--

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

--
-- Dumping data for table `hiddenpost`
--

LOCK TABLES `hiddenpost` WRITE;
/*!40000 ALTER TABLE `hiddenpost` DISABLE KEYS */;
INSERT INTO `hiddenpost` VALUES (1,17,1),(1,18,0),(1,19,1),(1,28,0),(1,29,1),(1,31,1),(1,36,1),(2,17,1);
/*!40000 ALTER TABLE `hiddenpost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `picture`
--

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

--
-- Dumping data for table `picture`
--

LOCK TABLES `picture` WRITE;
/*!40000 ALTER TABLE `picture` DISABLE KEYS */;
INSERT INTO `picture` VALUES ('058c337d-feeb-46c7-b39b-780780810f00','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687338614/DACN/28/058c337d-feeb-46c7-b39b-780780810f00.jpg','upload',28),('0965ed42-33c5-4b8b-b12d-9f068922f309','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687336379/DACN/27/0965ed42-33c5-4b8b-b12d-9f068922f309.jpg','upload',27),('09a26ea7-2e7d-4820-b6b0-b3d64d8c6639','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687332839/DACN/28/09a26ea7-2e7d-4820-b6b0-b3d64d8c6639.jpg','upload',28),('0c583674-2664-41d0-b12a-81f4c9c83730','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687419942/DACN/29/0c583674-2664-41d0-b12a-81f4c9c83730.jpg','upload',29),('0f94e87e-6b97-4e8e-b77f-a5e4d0b34d1e','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687351573/DACN/27/0f94e87e-6b97-4e8e-b77f-a5e4d0b34d1e.jpg','upload',27),('1819972c-5547-4f0e-9004-eee6b51ac319','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687419943/DACN/29/1819972c-5547-4f0e-9004-eee6b51ac319.jpg','upload',29),('1dcd9c5f-00c4-40fd-a867-1fb5df943969','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687422468/DACN/30/1dcd9c5f-00c4-40fd-a867-1fb5df943969.jpg','upload',30),('2ef6adf0-18da-42cf-92fc-cc07f5c9bec1','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687336314/DACN/27/2ef6adf0-18da-42cf-92fc-cc07f5c9bec1.jpg','upload',27),('2fadb577-fb27-487d-875b-a66aa8b1859c','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687486732/DACN/36/2fadb577-fb27-487d-875b-a66aa8b1859c.jpg','upload',36),('2fbe8a6d-149d-47be-920b-20a341b48a24','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687485781/DACN/34/2fbe8a6d-149d-47be-920b-20a341b48a24.jpg','upload',34),('3cc9e443-7522-44b7-b881-105551decffe','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687335995/DACN/28/3cc9e443-7522-44b7-b881-105551decffe.jpg','upload',28),('3ed3ffd1-f55b-4f9b-8573-590437959bd5','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687350884/DACN/28/3ed3ffd1-f55b-4f9b-8573-590437959bd5.jpg','upload',28),('4c74ec9e-c1c5-456a-abad-b969721969e3','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687486017/DACN/35/4c74ec9e-c1c5-456a-abad-b969721969e3.jpg','upload',35),('4f0978c0-9fcc-421c-a593-523ee04327a4','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687336375/DACN/27/4f0978c0-9fcc-421c-a593-523ee04327a4.jpg','upload',27),('4f2d1494-0d6f-4ec7-a554-2a9ca80a1a83','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687350883/DACN/28/4f2d1494-0d6f-4ec7-a554-2a9ca80a1a83.jpg','upload',28),('56325425-2fd9-4dd8-9140-9199a37527bc','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687424104/DACN/32/56325425-2fd9-4dd8-9140-9199a37527bc.jpg','upload',32),('57acda78-8353-4c21-a404-0690347b2966','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687422465/DACN/30/57acda78-8353-4c21-a404-0690347b2966.jpg','upload',30),('5b9003d5-77e1-4390-9c81-693e9a7824aa','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687423264/DACN/29/5b9003d5-77e1-4390-9c81-693e9a7824aa.jpg','upload',29),('6048381d-90b6-4652-aa00-a167f0a2df9b','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687422469/DACN/30/6048381d-90b6-4652-aa00-a167f0a2df9b.jpg','upload',30),('6711c6cb-9566-49f4-b5af-e1730f8cf325','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687336557/DACN/27/6711c6cb-9566-49f4-b5af-e1730f8cf325.jpg','upload',27),('6fb279dd-7e66-48f5-9eae-016a2ff3dcf6','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687423838/DACN/31/6fb279dd-7e66-48f5-9eae-016a2ff3dcf6.jpg','upload',31),('710b4eee-233d-4390-8a5e-917793aee28a','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687486020/DACN/35/710b4eee-233d-4390-8a5e-917793aee28a.jpg','upload',35),('79c6b4cb-ca07-4ced-8213-7f1b70a55e46','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687336377/DACN/27/79c6b4cb-ca07-4ced-8213-7f1b70a55e46.jpg','upload',27),('7e58ab32-e9ef-403e-9762-790e38a1ee67','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687335992/DACN/28/7e58ab32-e9ef-403e-9762-790e38a1ee67.jpg','upload',28),('7f8cf767-2475-402d-85a8-ddbb0338f05b','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687485785/DACN/34/7f8cf767-2475-402d-85a8-ddbb0338f05b.jpg','upload',34),('81c855e6-f6cb-462c-a686-0c5addefd38a','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687423668/DACN/29/81c855e6-f6cb-462c-a686-0c5addefd38a.jpg','upload',29),('8258969c-70f9-4c59-8b07-48956d278f20','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687338617/DACN/28/8258969c-70f9-4c59-8b07-48956d278f20.jpg','upload',28),('846adab5-43c3-406b-8b74-c4f97e4102d0','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687425829/DACN/32/846adab5-43c3-406b-8b74-c4f97e4102d0.jpg','upload',32),('869d8998-f74f-41b6-9e1e-631b02f73958','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687419941/DACN/29/869d8998-f74f-41b6-9e1e-631b02f73958.jpg','upload',29),('8f741a7d-f154-478a-b2ab-1949419a1c9d','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687336412/DACN/19/8f741a7d-f154-478a-b2ab-1949419a1c9d.jpg','upload',19),('91c6f23e-589e-48ff-861f-61cf5e4ffad0','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687335881/DACN/28/91c6f23e-589e-48ff-861f-61cf5e4ffad0.jpg','upload',28),('92b99574-5f27-46fe-9035-e72f4e57d1a2','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687485782/DACN/34/92b99574-5f27-46fe-9035-e72f4e57d1a2.jpg','upload',34),('941820bc-371a-4070-bce5-534f6dcfb363','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687336376/DACN/27/941820bc-371a-4070-bce5-534f6dcfb363.jpg','upload',27),('95e07cb9-ee8e-46dd-a20f-4c44e1d13bcd','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687425828/DACN/32/95e07cb9-ee8e-46dd-a20f-4c44e1d13bcd.jpg','upload',32),('9658a757-a794-4fcb-b40a-35c53d45c71a','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687336556/DACN/27/9658a757-a794-4fcb-b40a-35c53d45c71a.jpg','upload',27),('9bb1c1d2-e45b-43b1-a16d-d646423e924d','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687486734/DACN/36/9bb1c1d2-e45b-43b1-a16d-d646423e924d.jpg','upload',36),('a6c705ca-41e8-412b-8ec4-480e48878da9','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687486733/DACN/36/a6c705ca-41e8-412b-8ec4-480e48878da9.jpg','upload',36),('a9a0990d-29a2-4562-9099-1307c57febdb','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687422466/DACN/30/a9a0990d-29a2-4562-9099-1307c57febdb.jpg','upload',30),('b1870b0c-2cb5-4738-984e-ec36a0eaa1f6','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687338619/DACN/28/b1870b0c-2cb5-4738-984e-ec36a0eaa1f6.jpg','upload',28),('b3621fce-ec26-4a0b-8405-a39c2230a0aa','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687422466/DACN/30/b3621fce-ec26-4a0b-8405-a39c2230a0aa.jpg','upload',30),('b63a8760-857c-4c50-8f00-d788da856dd4','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687336559/DACN/27/b63a8760-857c-4c50-8f00-d788da856dd4.jpg','upload',27),('b907c18d-e68e-43e2-b78f-ee24c4856549','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687336410/DACN/19/b907c18d-e68e-43e2-b78f-ee24c4856549.jpg','upload',19),('ba6e3997-132d-4f6b-88a5-5d07bfd5ee8b','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687351571/DACN/27/ba6e3997-132d-4f6b-88a5-5d07bfd5ee8b.jpg','upload',27),('bb86d015-aec2-41de-993d-b73aa66b73cb','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687423669/DACN/29/bb86d015-aec2-41de-993d-b73aa66b73cb.jpg','upload',29),('be03ed1f-b4c3-49f6-bc0c-36470aa8fad7','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687425827/DACN/32/be03ed1f-b4c3-49f6-bc0c-36470aa8fad7.jpg','upload',32),('c271d3cd-4d60-40f1-9dd2-1ec5f0f20b29','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687485783/DACN/34/c271d3cd-4d60-40f1-9dd2-1ec5f0f20b29.jpg','upload',34),('c543b573-aff8-48f3-a2f1-b8e2a66e37da','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687422464/DACN/30/c543b573-aff8-48f3-a2f1-b8e2a66e37da.jpg','upload',30),('c7bfc8ce-599e-41ff-9150-51d2325524c1','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687338615/DACN/28/c7bfc8ce-599e-41ff-9150-51d2325524c1.jpg','upload',28),('c9a2c3c9-18d0-40de-bd95-839aeab04707','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687486737/DACN/36/c9a2c3c9-18d0-40de-bd95-839aeab04707.jpg','upload',36),('d6a5ff9e-91b0-457d-8785-b12b24d4d647','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687336558/DACN/27/d6a5ff9e-91b0-457d-8785-b12b24d4d647.jpg','upload',27),('defc9aef-c30f-4c92-a12d-e65e249ed12f','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687486738/DACN/36/defc9aef-c30f-4c92-a12d-e65e249ed12f.jpg','upload',36),('e29c87fa-ee98-4e2e-9e47-0e579da407d4','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687422467/DACN/30/e29c87fa-ee98-4e2e-9e47-0e579da407d4.jpg','upload',30),('e77a87bf-d73e-43a3-b2b1-2d44732b1352','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687338620/DACN/28/e77a87bf-d73e-43a3-b2b1-2d44732b1352.jpg','upload',28),('e852ffc1-432a-4bfd-872c-4e54b69be57d','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687336376/DACN/27/e852ffc1-432a-4bfd-872c-4e54b69be57d.jpg','upload',27),('eb1cd4e6-3962-4672-8de4-02f40fa7d619','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687335994/DACN/28/eb1cd4e6-3962-4672-8de4-02f40fa7d619.jpg','upload',28),('eb6b44ff-d8a0-41ec-8059-5f2edbd270e3','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687351572/DACN/27/eb6b44ff-d8a0-41ec-8059-5f2edbd270e3.jpg','upload',27),('ecfd1d77-b389-456f-b792-a5ee9717b15f','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687423746/DACN/29/ecfd1d77-b389-456f-b792-a5ee9717b15f.jpg','upload',29),('ede6b589-4f6b-4797-a944-45581413ebd9','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687424027/DACN/31/ede6b589-4f6b-4797-a944-45581413ebd9.jpg','upload',31),('ee6c1f2e-a7ea-461b-ac15-5e9c20c184f1','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687351570/DACN/27/ee6c1f2e-a7ea-461b-ac15-5e9c20c184f1.jpg','upload',27),('ef5d17b2-7319-4ae5-81f6-e277785f739c','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687338616/DACN/28/ef5d17b2-7319-4ae5-81f6-e277785f739c.jpg','upload',28),('ef952350-ad4a-48ed-a540-491b4824be95','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687335993/DACN/28/ef952350-ad4a-48ed-a540-491b4824be95.jpg','upload',28),('f905d0ef-b3f6-4c71-888d-543b3886de21','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687425826/DACN/32/f905d0ef-b3f6-4c71-888d-543b3886de21.jpg','upload',32),('fa2b299e-62e6-4798-93b3-ad75496b3db4','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687336380/DACN/27/fa2b299e-62e6-4798-93b3-ad75496b3db4.jpg','upload',27),('ff032ecd-9533-46bd-b127-74fcb7554f33','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687486735/DACN/36/ff032ecd-9533-46bd-b127-74fcb7554f33.jpg','upload',36),('l2pobhjwef09lmtwc3jx','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687170810/DACN/18/l2pobhjwef09lmtwc3jx.jpg','upload',18),('l9l1ftqn7baejklhjpjk','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687171706/DACN/22/l9l1ftqn7baejklhjpjk.png','upload',22),('rzlkyhrz5uvuaffldjoa','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687171165/DACN/19/rzlkyhrz5uvuaffldjoa.jpg','upload',19),('s39ouuke5rdhkwmqbv7x','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687170809/DACN/18/s39ouuke5rdhkwmqbv7x.png','upload',18),('uvjmiqdagldwvuz6l2xf','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687171164/DACN/19/uvjmiqdagldwvuz6l2xf.png','upload',19);
/*!40000 ALTER TABLE `picture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (17,2,'Con gà','ah','2023-06-21 11:58:53','hìugjjbhh','Chưa duyệt','Nhẹ','Cao','máy chiếu','Phòng 302C2',NULL,NULL),(18,1,'Con gà Khánh','ah','2023-06-02 17:07:00','hìugjjbhh','Chưa duyệt','Nặng','Bình Thường','bàn','hjkbg',NULL,NULL),(19,8,'Con gà Khánh','ah','2023-06-21 15:33:28','hìugjjbhh','Chưa duyệt','Nặng','Bình Thường','ghế','hjkbg',NULL,NULL),(22,1,'Con gà Khánh','ah','2023-06-22 14:15:44','hìugjjbhh','Hoàn thành','Nhẹ','Bình Thường','máy chiếu','phòng 302C2','2023-06-29 14:42:00','Hãy làm thật nhanh'),(25,1,'pllakasj','Rơm','2023-06-21 13:43:46','qnajaiajwnsksisj','Đang duyệt','Nhẹ','Cao','máy chiếu','Phòng 302C2',NULL,NULL),(27,1,'hhhhh','Rơm','2023-06-21 19:46:06','kkiuhgh','Hoàn thành','Bình Thường','Cao','máy chiếu','Phòng 202C2','2023-06-24 20:31:00',''),(28,2,'kkkkkk','Rơm','2023-06-21 19:34:40','mmmm','Đang duyệt','Nhẹ','Cao','máy chiếuuu','Phòng 203C2',NULL,NULL),(29,1,'alo alo 11222','Kaly','2023-06-22 15:49:02','aaâ','Đã duyệt','Nặng','Thấp','cái ghế','phòng 202C2','Invalid date',NULL),(30,1,'hôm nay cày post','Kaly','2023-06-22 15:27:40','mawibhw uh whs8ebhehejsis in bsjs','Hoàn thành','Nhẹ','Cao','camera','phòng 302C2','2023-06-24 16:43:00','Oke'),(31,1,'Nhất chi mai','Kaly','2023-06-22 18:07:35','wjwjwwnwnn','Hoàn thành','Nhẹ','Cao','chuột máy tính','phòng 302C2','2023-06-20 16:05:00','Siêu nhân sấm xét'),(32,1,'today ','Kaly','2023-06-22 18:09:44','âs','Đã duyệt','Nhẹ','Cao','cái ghế','phòng 302C2','2023-06-24 16:25:00','Abcd'),(33,2,'Phòng 202 có sự cố về bảng đen','Duy Khánh','2023-06-23 04:12:24','Bảng bị nhổ lên gập ghềnh, thầy cô và các bạn không thể ghi được ','Đã duyệt','Nặng','Bình Thường','bảng đen','phòng 202C2','2023-06-21 08:29:00','sự cố phải giải quyết trong tuàn này'),(34,2,'Máy chiếu trong phòng 202 bị hỏng','Duy Khánh','2023-06-23 09:02:53','máy chiếu trong phòng bị hỏng làm buổi thuyết trình của lớp không được như mong đợi','Chưa duyệt','Nặng','Thấp','máy chiếu','phòng 202C2',NULL,NULL),(35,2,'Mặt bàn phòng 102C2 bị hư hỏng nặng','Duy Khánh','2023-06-23 09:06:53','mặt bàn bị hư hỏng nặng lắm quá trình học tập cũng như ghi chép bị rất nhiều vấn đề. cho sinh viên ','Chưa duyệt','Nặng','Bình Thường','bàn học','phòng 102C2',NULL,NULL),(36,1,'chiếc ghế bị nhô đinh','Kaly','2023-06-23 09:18:33','xuất hiện những chiếc ghế bị nhô đinh, rất khó chịu khi ngồi, nên mong nhà trường giải quyết giúp tụi em','Chưa duyệt','Nhẹ','Cao','cái ghế','hội trường C1',NULL,NULL);
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `theuser`
--

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `theuser`
--

LOCK TABLES `theuser` WRITE;
/*!40000 ALTER TABLE `theuser` DISABLE KEYS */;
INSERT INTO `theuser` VALUES (1,'$2a$12$w1.q2gJoS8kXA/I7qzucy.P7nIGv4aFALeYxZtcamFiQXI26SafzO','6051071062','Kaly ','60@1234','CNTTK60 ','0777860489','2023-06-23 02:21:46','quận Tân Phú ','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687422047/DACN/USER/5ab170e6-ccb5-46e6-ba03-fad1b69d0f02.jpg',1,1),(2,'$2a$12$w1.q2gJoS8kXA/I7qzucy.P7nIGv4aFALeYxZtcamFiQXI26SafzO','6051071058','Duy Khánh','61@1234','CNTTK60 ','0339640248','2023-06-23 01:54:05','quận 9, TP thủ đức ','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687468204/DACN/USER/8420f7a8-08a2-4178-831c-33d68daa1f6d.jpg',1,2),(5,'$2a$12$w1.q2gJoS8kXA/I7qzucy.P7nIGv4aFALeYxZtcamFiQXI26SafzO','6051071068','Alice','62@1234','CNTTK60','0339640523','2023-06-23 01:44:43','quận 9','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687283740/DACN/23/70687023-1761-4e42-9168-2e0ea891b743.jpg',0,3),(6,'$2a$12$w1.q2gJoS8kXA/I7qzucy.P7nIGv4aFALeYxZtcamFiQXI26SafzO','6051071056','Phạm Minh','63@1234','CNTT','037878456','2023-06-23 01:45:52','quận 9','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687283740/DACN/23/70687023-1761-4e42-9168-2e0ea891b743.jpg',0,3),(7,'$2a$12$KullIftNY4UT0Lr8ME0WRumFzS909b12IbHds2hZXLiZd1TfKn4GW','5925648261','Nguyễn Linh','64@1234','CNTT','03965248617','2023-06-23 01:47:10','quận 9','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687283740/DACN/23/70687023-1761-4e42-9168-2e0ea891b743.jpg',1,3),(8,'$12$KullIftNY4UT0Lr8ME0WRumFzS909b12IbHds2hZXLiZd1TfKn4GW','5962405762','Phạm Kiếm','afb@maf','CNTT','0396485012','2023-06-23 01:48:17','Thủ Đức',NULL,1,3),(9,'$2a$10$pZ0R2Az0HFyQvLDZRPy9XOiJ30nowvhF5e.j.C45uQNRupotghSWu','123459789','Khánh','khanh@gmail.com','CNTT',NULL,'2023-06-23 01:50:05','Thủ Đức',NULL,1,3),(10,'$2a$10$4o1SJ1Ikb/8WWPPaioYuJOalj..qRbk0HDCywncZKCv0HY5q7UZM.','abcdefg','Khánh','abcd@ac','CNTT','033964','2023-06-22 16:48:35','quận 9','https://res.cloudinary.com/dkjd3g6t3/image/upload/v1687283740/DACN/23/70687023-1761-4e42-9168-2e0ea891b743.jpg',1,3),(11,'$2a$10$bR9LTWr1GOjK7tGjt7bN9uaPaPiqF1nvEV70yEn06oZ2/zFjsf0Ji','5760812048','Nguyễn Thành','kiempham1245@gmail.com','CNTT','0396246852','2023-06-23 01:49:46','quận 9',NULL,1,1),(12,'$2a$10$VZSKWrZANHzbEGsOMcPDy.DvxUC1NYyxR/Fif8shzzCMxfVoBLqru','AT123456','Nguyễn A','kiem@gmail.com','At16',NULL,NULL,NULL,NULL,1,3);
/*!40000 ALTER TABLE `theuser` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-23 11:51:38
