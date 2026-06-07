-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: bike-rent-potepa-patla-bike-rent.f.aivencloud.com    Database: bike-rent
-- ------------------------------------------------------
-- Server version	8.4.8

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '4a80bdac-51fe-11f1-a02f-5a720ea74ca4:1-183,
e1b4976d-55c9-11f1-90f8-4616e74e22af:1-72';

--
-- Table structure for table `Bikes`
--

DROP TABLE IF EXISTS `Bikes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Bikes` (
  `BikeID` int NOT NULL AUTO_INCREMENT,
  `BrandID` int NOT NULL,
  `CategoryID` int NOT NULL,
  `Quantity` int NOT NULL,
  PRIMARY KEY (`BikeID`),
  KEY `BrandID` (`BrandID`),
  KEY `CategoryID` (`CategoryID`),
  CONSTRAINT `Bikes_ibfk_1` FOREIGN KEY (`BrandID`) REFERENCES `Brands` (`BrandID`),
  CONSTRAINT `Bikes_ibfk_2` FOREIGN KEY (`CategoryID`) REFERENCES `Categories` (`CategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bikes`
--

LOCK TABLES `Bikes` WRITE;
/*!40000 ALTER TABLE `Bikes` DISABLE KEYS */;
INSERT INTO `Bikes` VALUES (1,1,3,12),(2,3,2,7),(3,2,4,15),(4,4,4,9),(5,1,5,20),(6,2,4,11),(7,1,2,6),(8,3,2,14),(9,2,2,8),(10,2,1,5),(11,3,1,13),(12,3,3,10),(13,3,2,16),(14,3,1,4),(15,1,2,18),(16,1,2,4);
/*!40000 ALTER TABLE `Bikes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`avnadmin`@`%`*/ /*!50003 TRIGGER `AddBike_tr` BEFORE INSERT ON `Bikes` FOR EACH ROW BEGIN
    IF NOT EXISTS(SELECT 1 FROM Brands WHERE BrandID=NEW.BrandID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Podane BrandID nie istnieje';
    end if;

    IF NOT EXISTS(SELECT 1 FROM Categories WHERE CategoryID=NEW.CategoryID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Podane CategoryID nie istnieje';
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`avnadmin`@`%`*/ /*!50003 TRIGGER `AddQuantity_tr` BEFORE UPDATE ON `Bikes` FOR EACH ROW BEGIN
    IF (NEW.Quantity<0) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quantity nie mo┼╝e by─ç mniejsze od 0';
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Brands`
--

DROP TABLE IF EXISTS `Brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Brands` (
  `BrandID` int NOT NULL AUTO_INCREMENT,
  `BrandName` varchar(255) NOT NULL,
  PRIMARY KEY (`BrandID`),
  UNIQUE KEY `UQ_BrandName` (`BrandName`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Brands`
--

LOCK TABLES `Brands` WRITE;
/*!40000 ALTER TABLE `Brands` DISABLE KEYS */;
INSERT INTO `Brands` VALUES (1,'Kross'),(2,'Romet'),(4,'Superior'),(3,'Trek');
/*!40000 ALTER TABLE `Brands` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`avnadmin`@`%`*/ /*!50003 TRIGGER `AddBrand_tr` BEFORE INSERT ON `Brands` FOR EACH ROW BEGIN
    IF EXISTS(SELECT 1 FROM  Brands WHERE BrandName=NEW.BrandName) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Podany Brand ju┼╝ istnieje';
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Categories`
--

DROP TABLE IF EXISTS `Categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Categories` (
  `CategoryID` int NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(255) NOT NULL,
  PRIMARY KEY (`CategoryID`),
  UNIQUE KEY `UQ_CategoryName` (`CategoryName`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Categories`
--

LOCK TABLES `Categories` WRITE;
/*!40000 ALTER TABLE `Categories` DISABLE KEYS */;
INSERT INTO `Categories` VALUES (1,'City'),(4,'Electric'),(3,'Mountain'),(5,'Racing'),(2,'Touring');
/*!40000 ALTER TABLE `Categories` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`avnadmin`@`%`*/ /*!50003 TRIGGER `AddCategory_tr` BEFORE INSERT ON `Categories` FOR EACH ROW BEGIN
    IF EXISTS(SELECT 1 FROM Categories WHERE CategoryName=NEW.CategoryName) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Podane Category ju┼╝ istnieje';
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Customers`
--

DROP TABLE IF EXISTS `Customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customers` (
  `CustomerID` int NOT NULL AUTO_INCREMENT,
  `Firstname` varchar(255) NOT NULL,
  `Surrname` varchar(255) NOT NULL,
  `Phone` varchar(15) NOT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE KEY `UQ_Phone` (`Phone`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customers`
--

LOCK TABLES `Customers` WRITE;
/*!40000 ALTER TABLE `Customers` DISABLE KEYS */;
INSERT INTO `Customers` VALUES (1,'Robert','Kubica','+48278238482'),(2,'Grzegorz','Brzeczyszczykiewicz','+48328548322'),(3,'Anna','Kowalska','+48501234567'),(4,'Jan','Nowak','+48602345678'),(5,'Katarzyna','Wisniewska','+48703456789'),(6,'Piotr','Zielinski','+48804567890'),(7,'Agnieszka','Wojcik','+48905678901'),(8,'Michal','Kaminski','+48509876543'),(9,'Magdalena','Lewandowska','+48608765432'),(10,'Krzysztof','Dabrowski','+48707654321'),(11,'Tomasz','Jankowski','+48905432109'),(12,'Monika','Mazur','+48511223344'),(13,'Pawel','Kwiatkowski','+48622334455'),(14,'Joanna','Krawczyk','+48733445566');
/*!40000 ALTER TABLE `Customers` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`avnadmin`@`%`*/ /*!50003 TRIGGER `AddCustomer_tr` BEFORE INSERT ON `Customers` FOR EACH ROW BEGIN
    IF EXISTS (SELECT 1 FROM Customers WHERE Phone=NEW.Phone) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Dany numer telefonu ju┼╝ istnieje';
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `RentPriceHist`
--

DROP TABLE IF EXISTS `RentPriceHist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RentPriceHist` (
  `RentPriceHistID` int NOT NULL AUTO_INCREMENT,
  `BikeID` int NOT NULL,
  `HourlyPrice` int NOT NULL,
  `StartDate` date NOT NULL,
  `EndDate` date DEFAULT NULL,
  PRIMARY KEY (`RentPriceHistID`),
  KEY `BikeID` (`BikeID`),
  CONSTRAINT `RentPriceHist_ibfk_1` FOREIGN KEY (`BikeID`) REFERENCES `Bikes` (`BikeID`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RentPriceHist`
--

LOCK TABLES `RentPriceHist` WRITE;
/*!40000 ALTER TABLE `RentPriceHist` DISABLE KEYS */;
INSERT INTO `RentPriceHist` VALUES (1,1,18,'2025-01-01','2025-06-30'),(2,1,22,'2025-06-30',NULL),(3,2,14,'2025-01-01','2025-06-30'),(4,2,16,'2025-06-30',NULL),(5,3,25,'2025-01-01','2025-06-30'),(6,3,29,'2025-06-30',NULL),(7,4,27,'2025-01-01','2025-06-30'),(8,4,31,'2025-06-30',NULL),(9,5,11,'2025-01-01','2025-06-30'),(10,5,13,'2025-06-30',NULL),(11,6,26,'2025-01-01','2025-06-30'),(12,6,28,'2025-06-30',NULL),(13,7,16,'2025-01-01','2025-06-30'),(14,7,17,'2025-06-30',NULL),(15,8,15,'2025-01-01','2025-06-30'),(16,8,18,'2025-06-30',NULL),(17,9,16,'2025-01-01','2025-06-30'),(18,9,20,'2025-06-30',NULL),(19,10,32,'2025-01-01','2025-06-30'),(20,10,36,'2025-06-30',NULL),(21,11,34,'2025-01-01','2025-06-30'),(22,11,40,'2025-06-30',NULL),(23,12,20,'2025-01-01','2025-06-30'),(24,12,23,'2025-06-30',NULL),(25,13,19,'2025-01-01','2025-06-30'),(26,13,22,'2025-06-30',NULL),(27,14,38,'2025-01-01','2025-06-30'),(28,14,41,'2025-06-30',NULL),(29,15,17,'2025-01-01','2025-06-30'),(30,15,21,'2025-06-30',NULL),(31,16,50,'2026-06-07','2026-06-07'),(32,16,70,'2026-06-07',NULL);
/*!40000 ALTER TABLE `RentPriceHist` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`avnadmin`@`%`*/ /*!50003 TRIGGER `ChangeRentPrice_tr` BEFORE INSERT ON `RentPriceHist` FOR EACH ROW BEGIN
    IF NOT EXISTS(SELECT 1 FROM Bikes WHERE Bikes.BikeID = NEW.BikeID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Podany BikeID nie istnieje';
    END IF;

    IF (NEW.HourlyPrice <= 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nowy koszt wynaj─Öcia roweru musi by─ç wi─Ökszy od 0';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Rents`
--

DROP TABLE IF EXISTS `Rents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Rents` (
  `RentID` int NOT NULL AUTO_INCREMENT,
  `BikeID` int NOT NULL,
  `CustomerID` int NOT NULL,
  `RentDate` date NOT NULL,
  `ReturnDate` date DEFAULT NULL,
  PRIMARY KEY (`RentID`),
  KEY `BikeID` (`BikeID`),
  KEY `CustomerID` (`CustomerID`),
  CONSTRAINT `Rents_ibfk_1` FOREIGN KEY (`BikeID`) REFERENCES `Bikes` (`BikeID`),
  CONSTRAINT `Rents_ibfk_2` FOREIGN KEY (`CustomerID`) REFERENCES `Customers` (`CustomerID`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rents`
--

LOCK TABLES `Rents` WRITE;
/*!40000 ALTER TABLE `Rents` DISABLE KEYS */;
INSERT INTO `Rents` VALUES (1,1,1,'2025-01-03','2025-01-07'),(2,2,2,'2025-01-05','2025-01-12'),(3,3,3,'2025-01-10','2025-01-15'),(4,4,4,'2025-01-12','2025-01-20'),(5,5,5,'2025-01-15','2025-01-22'),(6,6,6,'2025-02-01','2025-02-09'),(7,7,7,'2025-02-03','2025-02-10'),(8,8,8,'2025-02-08','2025-02-18'),(9,9,9,'2025-02-10','2025-02-14'),(10,10,10,'2025-02-14','2025-02-21'),(11,11,11,'2025-03-01','2025-03-08'),(12,12,12,'2025-03-05','2025-03-11'),(13,13,13,'2025-03-10','2025-03-19'),(14,14,14,'2025-03-15','2025-03-18'),(15,15,1,'2025-03-20','2025-03-28'),(16,1,3,'2025-04-02','2025-04-09'),(17,2,5,'2025-04-05','2025-04-12'),(18,3,7,'2025-04-08','2025-04-15'),(19,4,9,'2025-04-10','2025-04-20'),(20,5,11,'2025-04-14','2025-04-21'),(21,6,2,'2025-05-01','2025-05-06'),(22,7,4,'2025-05-03','2025-05-09'),(23,8,6,'2025-05-05','2025-05-11'),(24,9,8,'2025-05-07','2025-05-13'),(25,10,10,'2025-05-09','2025-05-18'),(26,11,12,'2025-05-15','2025-05-22'),(27,12,14,'2025-05-20','2025-05-27'),(28,13,1,'2025-06-01','2025-06-07'),(29,14,2,'2025-06-03','2025-06-09'),(30,15,3,'2025-06-05','2025-06-12'),(31,1,1,'2026-05-10',NULL),(32,2,1,'2026-05-11',NULL),(33,5,1,'2026-05-12',NULL),(34,3,2,'2026-05-09',NULL),(35,4,2,'2026-05-10',NULL),(36,6,3,'2026-05-08',NULL),(37,7,4,'2026-05-13',NULL),(38,8,5,'2026-05-14',NULL),(39,9,6,'2026-05-15',NULL),(40,10,7,'2026-05-16',NULL),(41,11,8,'2026-05-17',NULL),(42,12,9,'2026-05-18',NULL),(43,13,10,'2026-05-19',NULL),(44,14,11,'2026-05-20',NULL),(45,15,12,'2026-05-21',NULL),(46,16,1,'2026-06-07','2026-06-07'),(47,16,2,'2026-06-07',NULL);
/*!40000 ALTER TABLE `Rents` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`avnadmin`@`%`*/ /*!50003 TRIGGER `AddRent_tr` BEFORE INSERT ON `Rents` FOR EACH ROW BEGIN
        DECLARE rents_count integer default 0;
        DECLARE current_quantity integer default 0;

        IF NOT EXISTS(SELECT 1 FROM Bikes WHERE Bikes.BikeID=NEW.BikeID) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT ='Podany BikeID nie istnieje';
        end if;

        IF NOT EXISTS(SELECT 1 FROM Customers WHERE Customers.CustomerID=NEW.CustomerID) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT ='Podany CustomerID nie istnieje';
        end if;

        SELECT Quantity INTO current_quantity FROM Bikes WHERE Bikes.BikeID=NEW.BikeID FOR UPDATE;

        IF current_quantity = 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT ='Roweru o podanym BikeID nie ma obecnie na stanie.';
        END IF;

        SELECT COUNT(*) INTO rents_count FROM Rents WHERE Rents.CustomerID=NEW.CustomerID AND Rents.ReturnDate IS NULL;
        IF rents_count>=5 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Nie mo┼╝na doda─ç rezerwacji, poniewa┼╝ klient o podanym CustomerID ma ju┼╝ 5 rezerwacji';
        end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`avnadmin`@`%`*/ /*!50003 TRIGGER `EndRent_tr` BEFORE UPDATE ON `Rents` FOR EACH ROW BEGIN
        IF NOT EXISTS(SELECT 1 FROM Rents WHERE RentID=NEW.RentID) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT ='Wypo┼╝yczenie o podanym RentID nie istnieje.';
        end if;

        IF (SELECT ReturnDate FROM Rents WHERE RentID=NEW.RentID) IS NOT NULL THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT ='Rower zosta┼é ju┼╝ zwr├│cony.';
        end if;
    end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `view_active_rents`
--

DROP TABLE IF EXISTS `view_active_rents`;
/*!50001 DROP VIEW IF EXISTS `view_active_rents`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_active_rents` AS SELECT 
 1 AS `CustomerName`,
 1 AS `RentID`,
 1 AS `BikeID`,
 1 AS `BrandName`,
 1 AS `RentDate`,
 1 AS `RentPrice`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_bestsellers`
--

DROP TABLE IF EXISTS `view_bestsellers`;
/*!50001 DROP VIEW IF EXISTS `view_bestsellers`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_bestsellers` AS SELECT 
 1 AS `BikeID`,
 1 AS `Brand`,
 1 AS `Category`,
 1 AS `Rents`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_bestselling_brands`
--

DROP TABLE IF EXISTS `view_bestselling_brands`;
/*!50001 DROP VIEW IF EXISTS `view_bestselling_brands`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_bestselling_brands` AS SELECT 
 1 AS `Brand`,
 1 AS `Rents`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_bike_stock`
--

DROP TABLE IF EXISTS `view_bike_stock`;
/*!50001 DROP VIEW IF EXISTS `view_bike_stock`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_bike_stock` AS SELECT 
 1 AS `BikeID`,
 1 AS `Brand`,
 1 AS `Category`,
 1 AS `Quantity`,
 1 AS `HourlyPrice`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_brands`
--

DROP TABLE IF EXISTS `view_brands`;
/*!50001 DROP VIEW IF EXISTS `view_brands`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_brands` AS SELECT 
 1 AS `BrandID`,
 1 AS `BrandName`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_categories`
--

DROP TABLE IF EXISTS `view_categories`;
/*!50001 DROP VIEW IF EXISTS `view_categories`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_categories` AS SELECT 
 1 AS `CategoryID`,
 1 AS `CategoryName`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_customers`
--

DROP TABLE IF EXISTS `view_customers`;
/*!50001 DROP VIEW IF EXISTS `view_customers`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_customers` AS SELECT 
 1 AS `CustomerID`,
 1 AS `Firstname`,
 1 AS `Surrname`,
 1 AS `Phone`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_hist_price`
--

DROP TABLE IF EXISTS `view_hist_price`;
/*!50001 DROP VIEW IF EXISTS `view_hist_price`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_hist_price` AS SELECT 
 1 AS `RentPriceHistID`,
 1 AS `BikeID`,
 1 AS `BrandName`,
 1 AS `HourlyPrice`,
 1 AS `StartDate`,
 1 AS `EndDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_hist_rents`
--

DROP TABLE IF EXISTS `view_hist_rents`;
/*!50001 DROP VIEW IF EXISTS `view_hist_rents`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_hist_rents` AS SELECT 
 1 AS `RentID`,
 1 AS `BikeID`,
 1 AS `BrandName`,
 1 AS `Firstname`,
 1 AS `Surrname`,
 1 AS `RentDate`,
 1 AS `ReturnDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_most_rented_category`
--

DROP TABLE IF EXISTS `view_most_rented_category`;
/*!50001 DROP VIEW IF EXISTS `view_most_rented_category`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_most_rented_category` AS SELECT 
 1 AS `Category`,
 1 AS `Rents`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'bike-rent'
--
/*!50003 DROP FUNCTION IF EXISTS `AvgBikeRentPrice_f` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER="avnadmin"@"%" FUNCTION "AvgBikeRentPrice_f"(bikeId_v int,startDate_v DATE,endDate_v DATE) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE avgPrice int;
    DECLARE numOfPrices int;
    DECLARE sumOfPrices int;

    IF endDate_v<startDate_v THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT ='Data ko┼äcowa musi by─ç p├│┼║niejsza od startowej';
    end if;

    IF NOT EXISTS (SELECT 1 FROM RentPriceHist WHERE BikeID=bikeId_v) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT ='Historia cen roweru o podanym id nie istnieje.';
    end if;

    SELECT SUM(RentPriceHist.HourlyPrice) ,COUNT(*) INTO sumOfPrices,numOfPrices
    FROM RentPriceHist
    WHERE BikeID=bikeId_v AND (StartDate <= endDate_v AND (EndDate >= startDate_v OR EndDate IS NULL));

    IF numOfPrices=0 THEN
        RETURN 0;
    end if;

    SET avgPrice=sumOfPrices/numOfPrices;

    RETURN avgPrice;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `Income_f` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER="avnadmin"@"%" FUNCTION "Income_f"(p_StartDate DATE, p_EndDate DATE) RETURNS decimal(10,2)
    READS SQL DATA
BEGIN
    DECLARE price DECIMAL(10,2);

    SELECT COALESCE(SUM(RentalPrice_f(RentID)), 0) INTO price FROM Rents
    WHERE RentDate BETWEEN p_StartDate AND p_EndDate;

    RETURN price;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `RentalPrice_f` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER="avnadmin"@"%" FUNCTION "RentalPrice_f"(
    p_RentID INT
) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE hourly_price INT;
    DECLARE rent_date DATE;
    DECLARE return_date DATE;

    SELECT HourlyPrice INTO hourly_price
    FROM RentPriceHist
    INNER JOIN Rents
    ON Rents.BikeID=RentPriceHist.BikeID
    WHERE RentID = p_RentID AND EndDate IS NULL LIMIT 1;

    SELECT RentDate,ReturnDate INTO rent_date,return_date FROM Rents
    WHERE RentID=p_RentID;


    RETURN (TIMESTAMPDIFF(
        HOUR,
        rent_date,
        IFNULL(return_date, NOW())
        )
        )*hourly_price;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddBike_p` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER="avnadmin"@"%" PROCEDURE "AddBike_p"(IN brandId_v int, IN categoryId_v int, IN hourly_price_v int, OUT bikeId_v INT)
BEGIN
     INSERT INTO Bikes(brandid, categoryid, quantity) VALUES (brandId_v,categoryId_v,0);
     SET bikeId_v =LAST_INSERT_ID();
     INSERT INTO RentPriceHist(BikeID, HourlyPrice, StartDate, EndDate)  VALUES(LAST_INSERT_ID(),hourly_price_v,CURRENT_DATE(),NULL);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddBrand_p` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER="avnadmin"@"%" PROCEDURE "AddBrand_p"(IN brandName_v varchar(255),OUT brandId_v INT)
BEGIN
    INSERT INTO Brands (BrandName)
VALUES (brandName_v);
    SET brandId_v=LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddCategory_p` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER="avnadmin"@"%" PROCEDURE "AddCategory_p"(IN categoryName_v varchar(255),OUT categoryId_v INT )
BEGIN
    INSERT INTO Categories (CategoryName)
VALUES (categoryName_v);
    SET categoryId_v=LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddCustomer_p` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER="avnadmin"@"%" PROCEDURE "AddCustomer_p"(IN firstname_v varchar(255), IN surrname_v varchar(255),
                                                   IN phone_v varchar(15), OUT customerId_v INT)
BEGIN
    INSERT INTO Customers(firstname, surrname,phone) VALUES(firstname_v,surrname_v,phone_v);
    SET customerId_v=LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddQuantity_p` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER="avnadmin"@"%" PROCEDURE "AddQuantity_p"(
    IN quantity_v INT,
    IN bikeID_v INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM Bikes WHERE BikeID = bikeID_v) THEN
        UPDATE Bikes
        SET Quantity = Quantity+quantity_v
        WHERE BikeID = bikeID_v;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nie ma takiego BikeID';
    end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddRent_p` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER="avnadmin"@"%" PROCEDURE "AddRent_p"(IN bike_id_v int, IN customer_id_v int,OUT rentId_v INT)
BEGIN
    INSERT INTO Rents(bikeid, customerid, rentdate, returndate)  VALUES(bike_id_v,customer_id_v,NOW(),NULL);
    SET rentId_v=LAST_INSERT_ID();
    CALL AddQuantity_p(-1,bike_id_v);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ChangeRentPrice_p` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER="avnadmin"@"%" PROCEDURE "ChangeRentPrice_p"(IN bike_id_v INT, IN hourly_price_v INT, OUT rentPriceId_v INT)
BEGIN
    UPDATE RentPriceHist
    SET EndDate = CURRENT_DATE()
    WHERE BikeID = bike_id_v AND EndDate IS NULL;

    INSERT INTO RentPriceHist(BikeID, HourlyPrice, StartDate, EndDate)
    VALUES (bike_id_v, hourly_price_v, CURRENT_DATE(), NULL);

    SET rentPriceId_v = LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CurrentRentsForCustomer_p` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER="avnadmin"@"%" PROCEDURE "CurrentRentsForCustomer_p"(customerId_v int)
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Customers WHERE CustomerID=customerId_v) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT ='Customer o podanym id nie istnieje.';
    end if;

    SELECT RentID,BikeID,RentDate,ReturnDate
    FROM Rents
    WHERE Rents.CustomerID=customerId_v;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EndRent_p` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER="avnadmin"@"%" PROCEDURE "EndRent_p"(rent_id_v integer)
BEGIN
    UPDATE Rents
    SET ReturnDate=NOW()
    WHERE Rents.RentID=rent_id_v;

    CALL AddQuantity_p(1,(SELECT BikeID FROM Rents WHERE RentID=rent_id_v));
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FilterBike_p` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER="avnadmin"@"%" PROCEDURE "FilterBike_p"(categoryName_v VARCHAR(255),brandName_v VARCHAR(255))
BEGIN
    IF NOT EXISTS(SELECT 1 FROM Categories WHERE CategoryName=categoryName_v) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT ='Podane categoryName nie istnieje.';
    end if;

    IF NOT EXISTS(SELECT 1 FROM Brands WHERE BrandName=brandName_v) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT ='Podane brandName nie istnieje.';
    end if;

    SELECT Bikes.BikeID,Bikes.Quantity
    FROM Bikes
    INNER JOIN Brands ON Bikes.BrandID = Brands.BrandID
    INNER JOIN Categories ON Bikes.CategoryID = Categories.CategoryID
    WHERE Brands.BrandName LIKE brandName_v AND Categories.CategoryName LIKE categoryName_v;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `FilterCustomer_p` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI,STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER="avnadmin"@"%" PROCEDURE "FilterCustomer_p"(IN customerPhone_v varchar(255))
BEGIN
    SELECT Firstname,Surrname,Phone
    FROM Customers
    WHERE Phone LIKE customerPhone_v;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `view_active_rents`
--

/*!50001 DROP VIEW IF EXISTS `view_active_rents`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`avnadmin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_active_rents` AS select concat(`c`.`Firstname`,' ',`c`.`Surrname`) AS `CustomerName`,`r`.`RentID` AS `RentID`,`r`.`BikeID` AS `BikeID`,`b`.`BrandName` AS `BrandName`,`r`.`RentDate` AS `RentDate`,`RentalPrice_f`(`r`.`RentID`) AS `RentPrice` from (((`Rents` `r` left join `Customers` `c` on((`r`.`CustomerID` = `c`.`CustomerID`))) left join `Bikes` `bi` on((`r`.`BikeID` = `bi`.`BikeID`))) join `Brands` `b` on((`bi`.`BrandID` = `b`.`BrandID`))) where (`r`.`ReturnDate` is null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_bestsellers`
--

/*!50001 DROP VIEW IF EXISTS `view_bestsellers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`avnadmin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_bestsellers` AS select `Rents`.`BikeID` AS `BikeID`,`Brands`.`BrandName` AS `Brand`,`Categories`.`CategoryName` AS `Category`,count(`Rents`.`RentID`) AS `Rents` from (((`Rents` join `Bikes` on((`Rents`.`BikeID` = `Bikes`.`BikeID`))) join `Brands` on((`Bikes`.`BrandID` = `Brands`.`BrandID`))) join `Categories` on((`Bikes`.`CategoryID` = `Categories`.`CategoryID`))) group by `Rents`.`BikeID` order by count(`Rents`.`RentID`) desc limit 10 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_bestselling_brands`
--

/*!50001 DROP VIEW IF EXISTS `view_bestselling_brands`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`avnadmin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_bestselling_brands` AS select `Brands`.`BrandName` AS `Brand`,count(`Rents`.`RentID`) AS `Rents` from ((`Rents` join `Bikes` on((`Rents`.`BikeID` = `Bikes`.`BikeID`))) join `Brands` on((`Bikes`.`BrandID` = `Brands`.`BrandID`))) group by `Bikes`.`BrandID` order by count(`Rents`.`RentID`) desc limit 2 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_bike_stock`
--

/*!50001 DROP VIEW IF EXISTS `view_bike_stock`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`avnadmin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_bike_stock` AS select `Bikes`.`BikeID` AS `BikeID`,`Brands`.`BrandName` AS `Brand`,`Categories`.`CategoryName` AS `Category`,`Bikes`.`Quantity` AS `Quantity`,(select `RentPriceHist`.`HourlyPrice` from `RentPriceHist` where ((`RentPriceHist`.`BikeID` = `Bikes`.`BikeID`) and (`RentPriceHist`.`EndDate` is null))) AS `HourlyPrice` from ((`Bikes` join `Brands` on((`Bikes`.`BrandID` = `Brands`.`BrandID`))) join `Categories` on((`Bikes`.`CategoryID` = `Categories`.`CategoryID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_brands`
--

/*!50001 DROP VIEW IF EXISTS `view_brands`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`avnadmin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_brands` AS select `Brands`.`BrandID` AS `BrandID`,`Brands`.`BrandName` AS `BrandName` from `Brands` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_categories`
--

/*!50001 DROP VIEW IF EXISTS `view_categories`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`avnadmin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_categories` AS select `Categories`.`CategoryID` AS `CategoryID`,`Categories`.`CategoryName` AS `CategoryName` from `Categories` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_customers`
--

/*!50001 DROP VIEW IF EXISTS `view_customers`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`avnadmin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_customers` AS select `Customers`.`CustomerID` AS `CustomerID`,`Customers`.`Firstname` AS `Firstname`,`Customers`.`Surrname` AS `Surrname`,`Customers`.`Phone` AS `Phone` from `Customers` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_hist_price`
--

/*!50001 DROP VIEW IF EXISTS `view_hist_price`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`avnadmin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_hist_price` AS select `RentPriceHist`.`RentPriceHistID` AS `RentPriceHistID`,`Bikes`.`BikeID` AS `BikeID`,`Brands`.`BrandName` AS `BrandName`,`RentPriceHist`.`HourlyPrice` AS `HourlyPrice`,`RentPriceHist`.`StartDate` AS `StartDate`,`RentPriceHist`.`EndDate` AS `EndDate` from ((`RentPriceHist` join `Bikes` on((`RentPriceHist`.`BikeID` = `Bikes`.`BikeID`))) join `Brands` on((`Bikes`.`BrandID` = `Brands`.`BrandID`))) where (`RentPriceHist`.`EndDate` is not null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_hist_rents`
--

/*!50001 DROP VIEW IF EXISTS `view_hist_rents`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`avnadmin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_hist_rents` AS select `Rents`.`RentID` AS `RentID`,`Rents`.`BikeID` AS `BikeID`,`Brands`.`BrandName` AS `BrandName`,`Customers`.`Firstname` AS `Firstname`,`Customers`.`Surrname` AS `Surrname`,`Rents`.`RentDate` AS `RentDate`,`Rents`.`ReturnDate` AS `ReturnDate` from (((`Rents` join `Customers` on((`Rents`.`CustomerID` = `Customers`.`CustomerID`))) join `Bikes` on((`Rents`.`BikeID` = `Bikes`.`BikeID`))) join `Brands` on((`Bikes`.`BikeID` = `Brands`.`BrandID`))) where (`Rents`.`ReturnDate` is not null) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_most_rented_category`
--

/*!50001 DROP VIEW IF EXISTS `view_most_rented_category`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`avnadmin`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_most_rented_category` AS select `Categories`.`CategoryName` AS `Category`,count(`Rents`.`RentID`) AS `Rents` from ((`Rents` join `Bikes` on((`Rents`.`BikeID` = `Bikes`.`BikeID`))) join `Categories` on((`Bikes`.`CategoryID` = `Categories`.`CategoryID`))) group by `Bikes`.`CategoryID` order by count(`Rents`.`RentID`) desc limit 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-07 13:41:30
