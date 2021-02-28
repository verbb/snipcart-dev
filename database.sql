-- MySQL dump 10.13  Distrib 8.0.22, for Linux (x86_64)
--
-- Host: localhost    Database: snipcart
-- ------------------------------------------------------
-- Server version	8.0.22

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

--
-- Table structure for table `assetindexdata`
--

DROP TABLE IF EXISTS `assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assetindexdata` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int NOT NULL,
  `uri` text,
  `size` bigint unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ktvcwzryoncmcgfeotzaeogxgjyknimynsqi` (`sessionId`,`volumeId`),
  KEY `idx_prmxmddgnnmrpoxoccnjhpwmedhwaiynrrkf` (`volumeId`),
  CONSTRAINT `fk_gqwizbprhqgqhtczibeysflecwwvttbmgtxi` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assetindexdata`
--

LOCK TABLES `assetindexdata` WRITE;
/*!40000 ALTER TABLE `assetindexdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `assetindexdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assets` (
  `id` int NOT NULL,
  `volumeId` int DEFAULT NULL,
  `folderId` int NOT NULL,
  `uploaderId` int DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int unsigned DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `size` bigint unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_togjeugjioepjqscgdvkzpmuzzxrwhnnfolb` (`filename`,`folderId`),
  KEY `idx_fnuuxcytbmjsxamhyuohyzafvmufhnbzrvij` (`folderId`),
  KEY `idx_vvfzcyaszczirgaskdtvufktrczwvhzusnkf` (`volumeId`),
  KEY `fk_qjssnyvbwinmdivqiidwbzkxuoycjtpiizze` (`uploaderId`),
  CONSTRAINT `fk_eddtrhzizfhvyzmpopjscnowsztdeiyihdkt` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_pdsyhqavgreaflgwjugojkhrfexjcojmrztx` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_qjssnyvbwinmdivqiidwbzkxuoycjtpiizze` FOREIGN KEY (`uploaderId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_zqpaesrbevanliarlaxidulwqrjbhkutalwl` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assettransformindex`
--

DROP TABLE IF EXISTS `assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assettransformindex` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assetId` int NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `error` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_elawbcbmouyjvjxevsgmischbkgltqdpxuzi` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assettransformindex`
--

LOCK TABLES `assettransformindex` WRITE;
/*!40000 ALTER TABLE `assettransformindex` DISABLE KEYS */;
/*!40000 ALTER TABLE `assettransformindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assettransforms`
--

DROP TABLE IF EXISTS `assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assettransforms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int unsigned DEFAULT NULL,
  `height` int unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_xjnjqlqeynshjjjmmpagewokxmzxpniqbcwe` (`name`),
  KEY `idx_isybyxaozukrqzlllnwtchujwywkyrqqltsx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL,
  `groupId` int NOT NULL,
  `parentId` int DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_dxhkqxsmwxxazdscjacdtdwvmuwjlhhszhtb` (`groupId`),
  KEY `fk_nvdqoqlknzgtufsdmuojiemublrzjyunstro` (`parentId`),
  CONSTRAINT `fk_bpgzmymwcvifclwmqwdxxfnriyiqqqhpfdpy` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_nvdqoqlknzgtufsdmuojiemublrzjyunstro` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_qsvmqjspvhmstgrfbmnjbsxsweugjcnavutv` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorygroups`
--

DROP TABLE IF EXISTS `categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorygroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_twzcybydejvgtqynkyxhrwdlyxtudcobtjns` (`name`),
  KEY `idx_nwewiaukgwtnyriwftbrvsnffzdlpwxdjicz` (`handle`),
  KEY `idx_demqrfclajmpfftmuypmbxvxhbjmfkejzgjp` (`structureId`),
  KEY `idx_tgkgzcgrrfdbgyzgginsbfmzlfsuknvxrhep` (`fieldLayoutId`),
  KEY `idx_nclrdfaumafyytbitomxvgnsxgvaqywagpwi` (`dateDeleted`),
  CONSTRAINT `fk_ijpaxbxtxmtojkxjdfemxqaorbactgavomub` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_zgtdytjdhqvylmmrnuvwnnsazthstoiaqjya` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorygroups_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `siteId` int NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_blrckzscofddaecihelpqhqsrjaljmpvklcf` (`groupId`,`siteId`),
  KEY `idx_yeclmiwphgngibnugrocrqzhkgdtjjifrxfq` (`siteId`),
  CONSTRAINT `fk_cqdygxoendlqhoeabvlvuxadqgqcmtbaywag` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_oaxhmitjdpapyuekjjzlymvgzulycrumwuhc` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `changedattributes`
--

DROP TABLE IF EXISTS `changedattributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `changedattributes` (
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`attribute`),
  KEY `idx_auwqknczdncceobofrpgpwivrgllhzaztukq` (`elementId`,`siteId`,`dateUpdated`),
  KEY `fk_jtmlkfqjcefvpipvymltrdiqkojnmxwybgzh` (`siteId`),
  KEY `fk_zmimlqjmnvkksuttlolmcgavfhtaqojumcff` (`userId`),
  CONSTRAINT `fk_jtmlkfqjcefvpipvymltrdiqkojnmxwybgzh` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_srcdtpkicgupukfkzmthxjbavsffhgnfrysi` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_zmimlqjmnvkksuttlolmcgavfhtaqojumcff` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `changedattributes`
--

LOCK TABLES `changedattributes` WRITE;
/*!40000 ALTER TABLE `changedattributes` DISABLE KEYS */;
INSERT INTO `changedattributes` VALUES (1,2,'firstName','2021-02-28 19:58:34',0,1),(1,2,'lastName','2021-02-28 19:58:34',0,1),(1,2,'lastPasswordChangeDate','2021-02-28 19:59:00',0,1),(1,2,'password','2021-02-28 19:59:00',0,1);
/*!40000 ALTER TABLE `changedattributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `changedfields`
--

DROP TABLE IF EXISTS `changedfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `changedfields` (
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `fieldId` int NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`fieldId`),
  KEY `idx_eiyftefjcnmfqetewqgtrlujoibqhgqcftji` (`elementId`,`siteId`,`dateUpdated`),
  KEY `fk_bqgedaeoseteycftymtuxbkjldwrsuaokzmd` (`siteId`),
  KEY `fk_veewxvngbtviphdktcinhtdpenjnunqkpmta` (`fieldId`),
  KEY `fk_gxibxrbgnflmzteodjrsdsfpxgodvjxhdwal` (`userId`),
  CONSTRAINT `fk_bqgedaeoseteycftymtuxbkjldwrsuaokzmd` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_gxibxrbgnflmzteodjrsdsfpxgodvjxhdwal` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_mfvsqwobwfkgnmbgippsaqcrjxskbnclkgal` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_veewxvngbtviphdktcinhtdpenjnunqkpmta` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `changedfields`
--

LOCK TABLES `changedfields` WRITE;
/*!40000 ALTER TABLE `changedfields` DISABLE KEYS */;
/*!40000 ALTER TABLE `changedfields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_productOptions` text,
  `field_productDescription` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_pyvzjjperpwomhkrjikummiohhweyhzggopc` (`elementId`,`siteId`),
  KEY `idx_tqrssoyfhxwtctdekmrpqzbzwfzwhdxwcmgn` (`siteId`),
  KEY `idx_jiugrxgxgdyfzzxxnxgmlyvojevmafmdnmql` (`title`),
  CONSTRAINT `fk_ivxxxnqnmmzquwnvnxziortpcryxirlwpgkd` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_jlapceeooppgckbsdwpzploungnrwcjntvoa` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
INSERT INTO `content` VALUES (1,1,2,NULL,'2021-02-28 19:57:15','2021-02-28 19:58:59','76290a89-b3f6-4fb0-b8e3-6be69e3501a0',NULL,NULL),(2,2,2,'Infinity Gauntlet','2021-02-28 19:57:43','2021-02-28 19:57:43','430174ed-d2b5-4429-b76c-b53e0415f489','[{\"col1\":\"\",\"col2\":\"\"}]','**Not sold as a pair!** Get them talking and show off your gems as you embody death throughout the universe with swagger.'),(3,3,2,'Infinity Gauntlet','2021-02-28 19:57:43','2021-02-28 19:57:43','5434d1b1-a1b0-40db-a5f0-f1bae9c9908b','[{\"col1\":\"\",\"col2\":\"\"}]','**Not sold as a pair!** Get them talking and show off your gems as you embody death throughout the universe with swagger.'),(4,4,2,'Lembas Bread','2021-02-28 19:57:43','2021-02-28 19:57:43','f4b3d8cf-74ad-49cc-adc8-d7259481622f','[{\"col1\":\"\",\"col2\":\"\"}]','Very filling and packs well for a long hike.'),(5,5,2,'Lembas Bread','2021-02-28 19:57:43','2021-02-28 19:57:43','bca83b5a-a514-4532-91f3-03ed9b094a05','[{\"col1\":\"\",\"col2\":\"\"}]','Very filling and packs well for a long hike.'),(6,6,2,'Dragon Egg','2021-02-28 19:57:43','2021-02-28 19:57:43','dd52ea37-62e1-4311-af9e-fa5198198a26','[{\"col1\":\"\",\"col2\":\"\"}]','Makes a great wedding gift that\'ll definitely get you noticed. Store in fireplace or similar location for maximum fun.'),(7,7,2,'Dragon Egg','2021-02-28 19:57:43','2021-02-28 19:57:43','11e8ab08-6968-455d-9ebf-aa40a3601238','[{\"col1\":\"\",\"col2\":\"\"}]','Makes a great wedding gift that\'ll definitely get you noticed. Store in fireplace or similar location for maximum fun.'),(8,8,2,'Dark Matter','2021-02-28 19:57:43','2021-02-28 19:57:43','4929706a-8e90-4bd8-8992-b8a22106c3e3','[{\"col1\":\"\",\"col2\":\"\"}]','Always in demand. **Customer must arrange for own shipping and storage.**'),(9,9,2,'Dark Matter','2021-02-28 19:57:43','2021-02-28 19:57:43','435556fe-cb34-4c84-8c8a-d2ef0a0868bb','[{\"col1\":\"\",\"col2\":\"\"}]','Always in demand. **Customer must arrange for own shipping and storage.**'),(10,10,2,'Oathkeeper','2021-02-28 19:57:43','2021-02-28 19:57:43','be1e6627-6439-4652-821e-964c949430ef','[{\"col1\":\"\",\"col2\":\"\"}]','Training and well-developed core strength strongly recommended. Product is not a toy.'),(11,11,2,'Oathkeeper','2021-02-28 19:57:44','2021-02-28 19:57:44','163f2c07-1d1c-41a0-b46b-15b36288907a','[{\"col1\":\"\",\"col2\":\"\"}]','Training and well-developed core strength strongly recommended. Product is not a toy.'),(12,12,2,'Hand of the King Brooch','2021-02-28 19:57:44','2021-02-28 19:57:44','b902c6a9-60a3-419d-8f10-d7d0f94ddff2','[{\"col1\":\"\",\"col2\":\"\"}]','Looks great and cleans easily. Great for re-gifting.'),(13,13,2,'Hand of the King Brooch','2021-02-28 19:57:44','2021-02-28 19:57:44','0f548463-ca5f-4f4e-a606-7c36a16ec15a','[{\"col1\":\"\",\"col2\":\"\"}]','Looks great and cleans easily. Great for re-gifting.'),(14,14,2,'Laser Sword','2021-02-28 19:57:44','2021-02-28 19:57:44','cde1c6e2-3cb4-41b1-9e38-a67203b92ed8','[{\"col1\":null,\"col2\":null},{\"col1\":null,\"col2\":null},{\"col1\":null,\"col2\":null}]','Stand out in a world of blasters with this ancient future weapon. Check back, new models added all the time!'),(15,15,2,'Laser Sword','2021-02-28 19:57:44','2021-02-28 19:57:44','0876dfb6-ca81-4cb1-a051-91ef40ed7a24','[{\"col1\":null,\"col2\":null},{\"col1\":null,\"col2\":null},{\"col1\":null,\"col2\":null}]','Stand out in a world of blasters with this ancient future weapon. Check back, new models added all the time!'),(16,16,2,'Elemental Stones','2021-02-28 19:57:44','2021-02-28 19:57:44','0a0b70bf-6a44-40dc-ac63-936bbaf0534e','[{\"col1\":null,\"col2\":null},{\"col1\":null,\"col2\":null},{\"col1\":null,\"col2\":null},{\"col1\":null,\"col2\":null}]','All the fun delivered to your door; no multipass required!'),(17,17,2,'Elemental Stones','2021-02-28 19:57:44','2021-02-28 19:57:44','99fbcac1-3e2a-4b96-a146-21c3d91c85c9','[{\"col1\":null,\"col2\":null},{\"col1\":null,\"col2\":null},{\"col1\":null,\"col2\":null},{\"col1\":null,\"col2\":null}]','All the fun delivered to your door; no multipass required!'),(18,18,2,'Glow Pole Umbrella','2021-02-28 19:57:44','2021-02-28 19:57:44','92086ff3-ae75-44c5-a60d-0ff4e1e39ce0','[{\"col1\":\"\",\"col2\":\"\"}]','No teardrops in the rain with this stylish umbrella! Stay dry and well-lit. Batteries not included, requires four AA or Nexus 6 Thunderbolt port.'),(19,19,2,'Glow Pole Umbrella','2021-02-28 19:57:44','2021-02-28 19:57:44','909e4db6-27f4-4974-8062-3b0f31792a4f','[{\"col1\":\"\",\"col2\":\"\"}]','No teardrops in the rain with this stylish umbrella! Stay dry and well-lit. Batteries not included, requires four AA or Nexus 6 Thunderbolt port.'),(20,20,2,'Spa Packages','2021-02-28 19:57:44','2021-02-28 19:57:44','c2d28c9a-41d5-4ebc-9a0b-5bbf4e1849c6',NULL,NULL),(21,24,2,'Spa Packages','2021-02-28 19:57:45','2021-02-28 19:57:45','8d294ca2-3bea-47c9-81c0-410a7ffa13d7',NULL,NULL);
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craftidtokens`
--

DROP TABLE IF EXISTS `craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `craftidtokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_grhtzuibeforvvnrpgqorprutskibcctloyu` (`userId`),
  CONSTRAINT `fk_grhtzuibeforvvnrpgqorprutskibcctloyu` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deprecationerrors`
--

DROP TABLE IF EXISTS `deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deprecationerrors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint unsigned DEFAULT NULL,
  `message` text,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_thhyqrvibtvijbxhniykwtujmucpntaxcowx` (`key`,`fingerprint`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
INSERT INTO `deprecationerrors` VALUES (1,'siteUrl','/home/vagrant/sites/snipcart-dev/vendor/yiisoft/yii2/base/BaseObject.php:109','2021-02-28 19:59:25','/home/vagrant/sites/snipcart-dev/vendor/yiisoft/yii2/base/BaseObject.php',109,'The `siteUrl` config setting has been deprecated. You can set your site’s Base URL setting on a per-environment basis using an alias or environment variable. See [Environmental Configuration](https://craftcms.com/docs/3.x/config/#environmental-configuration) for more info.','[{\"objectClass\":\"craft\\\\services\\\\Deprecator\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/craftcms/cms/src/config/GeneralConfig.php\",\"line\":1800,\"class\":\"craft\\\\services\\\\Deprecator\",\"method\":\"log\",\"args\":\"\\\"siteUrl\\\", \\\"The `siteUrl` config setting has been deprecated. You can set yo...\\\"\"},{\"objectClass\":\"craft\\\\config\\\\GeneralConfig\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/yiisoft/yii2/base/BaseObject.php\",\"line\":109,\"class\":\"craft\\\\config\\\\GeneralConfig\",\"method\":\"init\",\"args\":null},{\"objectClass\":\"craft\\\\config\\\\GeneralConfig\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/craftcms/cms/src/config/GeneralConfig.php\",\"line\":1690,\"class\":\"yii\\\\base\\\\BaseObject\",\"method\":\"__construct\",\"args\":\"[\\\"useEmailAsUsername\\\" => true, \\\"defaultWeekStartDay\\\" => 0, \\\"enableCsrfProtection\\\" => true, \\\"omitScriptNameInUrls\\\" => true, ...]\"},{\"objectClass\":\"craft\\\\config\\\\GeneralConfig\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/craftcms/cms/src/services/Config.php\",\"line\":100,\"class\":\"craft\\\\config\\\\GeneralConfig\",\"method\":\"__construct\",\"args\":\"[\\\"useEmailAsUsername\\\" => true, \\\"defaultWeekStartDay\\\" => 0, \\\"enableCsrfProtection\\\" => true, \\\"omitScriptNameInUrls\\\" => true, ...]\"},{\"objectClass\":\"craft\\\\services\\\\Config\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/craftcms/cms/src/services/Config.php\",\"line\":168,\"class\":\"craft\\\\services\\\\Config\",\"method\":\"getConfigSettings\",\"args\":\"\\\"general\\\"\"},{\"objectClass\":\"craft\\\\services\\\\Config\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/craftcms/cms/src/log/Dispatcher.php\",\"line\":87,\"class\":\"craft\\\\services\\\\Config\",\"method\":\"getGeneral\",\"args\":null},{\"objectClass\":\"craft\\\\log\\\\Dispatcher\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/craftcms/cms/src/log/Dispatcher.php\",\"line\":29,\"class\":\"craft\\\\log\\\\Dispatcher\",\"method\":\"_devModeLogging\",\"args\":null},{\"objectClass\":\"craft\\\\log\\\\Dispatcher\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/yiisoft/yii2/base/BaseObject.php\",\"line\":109,\"class\":\"craft\\\\log\\\\Dispatcher\",\"method\":\"init\",\"args\":null},{\"objectClass\":\"craft\\\\log\\\\Dispatcher\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/yiisoft/yii2/log/Dispatcher.php\",\"line\":90,\"class\":\"yii\\\\base\\\\BaseObject\",\"method\":\"__construct\",\"args\":\"[]\"},{\"objectClass\":\"craft\\\\log\\\\Dispatcher\",\"file\":null,\"line\":null,\"class\":\"yii\\\\log\\\\Dispatcher\",\"method\":\"__construct\",\"args\":\"[]\"},{\"objectClass\":\"ReflectionClass\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/yiisoft/yii2/di/Container.php\",\"line\":412,\"class\":\"ReflectionClass\",\"method\":\"newInstanceArgs\",\"args\":\"[[]]\"},{\"objectClass\":\"yii\\\\di\\\\Container\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/yiisoft/yii2/di/Container.php\",\"line\":171,\"class\":\"yii\\\\di\\\\Container\",\"method\":\"build\",\"args\":\"\\\"craft\\\\log\\\\Dispatcher\\\", [], []\"},{\"objectClass\":\"yii\\\\di\\\\Container\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/yiisoft/yii2/BaseYii.php\",\"line\":365,\"class\":\"yii\\\\di\\\\Container\",\"method\":\"get\",\"args\":\"\\\"craft\\\\log\\\\Dispatcher\\\", [], []\"},{\"objectClass\":null,\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/yiisoft/yii2/di/ServiceLocator.php\",\"line\":137,\"class\":\"yii\\\\BaseYii\",\"method\":\"createObject\",\"args\":\"[]\"},{\"objectClass\":\"craft\\\\console\\\\Application\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/yiisoft/yii2/base/Module.php\",\"line\":748,\"class\":\"yii\\\\di\\\\ServiceLocator\",\"method\":\"get\",\"args\":\"\\\"log\\\", true\"},{\"objectClass\":\"craft\\\\console\\\\Application\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/craftcms/cms/src/console/Application.php\",\"line\":158,\"class\":\"yii\\\\base\\\\Module\",\"method\":\"get\",\"args\":\"\\\"log\\\", true\"},{\"objectClass\":\"craft\\\\console\\\\Application\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/yiisoft/yii2/base/Application.php\",\"line\":514,\"class\":\"craft\\\\console\\\\Application\",\"method\":\"get\",\"args\":\"\\\"log\\\"\"},{\"objectClass\":\"craft\\\\console\\\\Application\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/craftcms/cms/src/base/ApplicationTrait.php\",\"line\":1410,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"getLog\",\"args\":null},{\"objectClass\":\"craft\\\\console\\\\Application\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/craftcms/cms/src/console/Application.php\",\"line\":46,\"class\":\"craft\\\\console\\\\Application\",\"method\":\"_preInit\",\"args\":null},{\"objectClass\":\"craft\\\\console\\\\Application\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/yiisoft/yii2/base/BaseObject.php\",\"line\":109,\"class\":\"craft\\\\console\\\\Application\",\"method\":\"init\",\"args\":null},{\"objectClass\":\"craft\\\\console\\\\Application\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/yiisoft/yii2/base/Application.php\",\"line\":212,\"class\":\"yii\\\\base\\\\BaseObject\",\"method\":\"__construct\",\"args\":\"[\\\"env\\\" => \\\"dev\\\", \\\"components\\\" => [\\\"config\\\" => craft\\\\services\\\\Config, \\\"api\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Api\\\"], \\\"assets\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Assets\\\"], \\\"assetIndexer\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\AssetIndexer\\\"], ...], \\\"id\\\" => \\\"CraftCMS\\\", \\\"name\\\" => \\\"Craft CMS\\\", ...]\"},{\"objectClass\":\"craft\\\\console\\\\Application\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/yiisoft/yii2/console/Application.php\",\"line\":90,\"class\":\"yii\\\\base\\\\Application\",\"method\":\"__construct\",\"args\":\"[\\\"env\\\" => \\\"dev\\\", \\\"components\\\" => [\\\"config\\\" => craft\\\\services\\\\Config, \\\"api\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Api\\\"], \\\"assets\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Assets\\\"], \\\"assetIndexer\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\AssetIndexer\\\"], ...], \\\"id\\\" => \\\"CraftCMS\\\", \\\"name\\\" => \\\"Craft CMS\\\", ...]\"},{\"objectClass\":\"craft\\\\console\\\\Application\",\"file\":null,\"line\":null,\"class\":\"yii\\\\console\\\\Application\",\"method\":\"__construct\",\"args\":\"[\\\"vendorPath\\\" => \\\"/home/vagrant/sites/snipcart-dev/vendor\\\", \\\"env\\\" => \\\"dev\\\", \\\"components\\\" => [\\\"config\\\" => craft\\\\services\\\\Config, \\\"api\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Api\\\"], \\\"assets\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Assets\\\"], \\\"assetIndexer\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\AssetIndexer\\\"], ...], \\\"id\\\" => \\\"CraftCMS\\\", ...]\"},{\"objectClass\":\"ReflectionClass\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/yiisoft/yii2/di/Container.php\",\"line\":420,\"class\":\"ReflectionClass\",\"method\":\"newInstanceArgs\",\"args\":\"[[\\\"vendorPath\\\" => \\\"/home/vagrant/sites/snipcart-dev/vendor\\\", \\\"env\\\" => \\\"dev\\\", \\\"components\\\" => [\\\"config\\\" => craft\\\\services\\\\Config, \\\"api\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Api\\\"], \\\"assets\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Assets\\\"], \\\"assetIndexer\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\AssetIndexer\\\"], ...], \\\"id\\\" => \\\"CraftCMS\\\", ...]]\"},{\"objectClass\":\"yii\\\\di\\\\Container\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/yiisoft/yii2/di/Container.php\",\"line\":171,\"class\":\"yii\\\\di\\\\Container\",\"method\":\"build\",\"args\":\"\\\"craft\\\\console\\\\Application\\\", [], [\\\"vendorPath\\\" => \\\"/home/vagrant/sites/snipcart-dev/vendor\\\", \\\"env\\\" => \\\"dev\\\", \\\"components\\\" => [\\\"config\\\" => craft\\\\services\\\\Config, \\\"api\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Api\\\"], \\\"assets\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Assets\\\"], \\\"assetIndexer\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\AssetIndexer\\\"], ...], \\\"id\\\" => \\\"CraftCMS\\\", ...]\"},{\"objectClass\":\"yii\\\\di\\\\Container\",\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/yiisoft/yii2/BaseYii.php\",\"line\":365,\"class\":\"yii\\\\di\\\\Container\",\"method\":\"get\",\"args\":\"\\\"craft\\\\console\\\\Application\\\", [], [\\\"vendorPath\\\" => \\\"/home/vagrant/sites/snipcart-dev/vendor\\\", \\\"env\\\" => \\\"dev\\\", \\\"components\\\" => [\\\"config\\\" => craft\\\\services\\\\Config, \\\"api\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Api\\\"], \\\"assets\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Assets\\\"], \\\"assetIndexer\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\AssetIndexer\\\"], ...], \\\"id\\\" => \\\"CraftCMS\\\", ...]\"},{\"objectClass\":null,\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/craftcms/cms/bootstrap/bootstrap.php\",\"line\":246,\"class\":\"yii\\\\BaseYii\",\"method\":\"createObject\",\"args\":\"[\\\"vendorPath\\\" => \\\"/home/vagrant/sites/snipcart-dev/vendor\\\", \\\"env\\\" => \\\"dev\\\", \\\"components\\\" => [\\\"config\\\" => craft\\\\services\\\\Config, \\\"api\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Api\\\"], \\\"assets\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\Assets\\\"], \\\"assetIndexer\\\" => [\\\"class\\\" => \\\"craft\\\\services\\\\AssetIndexer\\\"], ...], \\\"id\\\" => \\\"CraftCMS\\\", ...]\"},{\"objectClass\":null,\"file\":\"/home/vagrant/sites/snipcart-dev/vendor/craftcms/cms/bootstrap/console.php\",\"line\":51,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/home/vagrant/sites/snipcart-dev/vendor/craftcms/cms/bootstrap/b...\\\"\"},{\"objectClass\":null,\"file\":\"/home/vagrant/sites/snipcart-dev/craft\",\"line\":21,\"class\":null,\"method\":\"require\",\"args\":\"\\\"/home/vagrant/sites/snipcart-dev/vendor/craftcms/cms/bootstrap/c...\\\"\"}]','2021-02-28 19:59:29','2021-02-28 19:59:29','8bf76f21-6222-41ff-8245-7e43d2bf126a');
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drafts`
--

DROP TABLE IF EXISTS `drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drafts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sourceId` int DEFAULT NULL,
  `creatorId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `trackChanges` tinyint(1) NOT NULL DEFAULT '0',
  `dateLastMerged` datetime DEFAULT NULL,
  `saved` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_jhelwtpklmxmfuvajsjfirvpndpmiaqodttb` (`saved`),
  KEY `fk_izfzyiuuyxqlmhjivfwaaejawetbgmwiukox` (`creatorId`),
  KEY `fk_zknkonosqzoivzwhhnyiinasgvafvzalcsab` (`sourceId`),
  CONSTRAINT `fk_izfzyiuuyxqlmhjivfwaaejawetbgmwiukox` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_zknkonosqzoivzwhhnyiinasgvafvzalcsab` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drafts`
--

LOCK TABLES `drafts` WRITE;
/*!40000 ALTER TABLE `drafts` DISABLE KEYS */;
/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elementindexsettings`
--

DROP TABLE IF EXISTS `elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elementindexsettings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_twougpaduixsniiznyudikyuqrzfqxxmyvjy` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `draftId` int DEFAULT NULL,
  `revisionId` int DEFAULT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_bbuaoiofjbudpeubfnfldsiikwugtidpejak` (`dateDeleted`),
  KEY `idx_sckyvgphvesefpvkrrnaatpihhgowioxivbq` (`fieldLayoutId`),
  KEY `idx_xrtxgxttxjaohfkhohgeudxovczojphnwjxu` (`type`),
  KEY `idx_hifpzpnipjjxkshwbvdnwnolubhtrghhsjwl` (`enabled`),
  KEY `idx_rumynbxovmyatxqtsaayfecqxifygzqjhden` (`archived`,`dateCreated`),
  KEY `idx_rsedyplgwoifdyjsxdvhwlprejettsllxfyj` (`archived`,`dateDeleted`,`draftId`,`revisionId`),
  KEY `fk_gxtfnbccslwpixrqkmgosostctahhhdqtmwf` (`draftId`),
  KEY `fk_ipcwwtponuhjeylmzbzmybntrryueesamsgw` (`revisionId`),
  CONSTRAINT `fk_gxtfnbccslwpixrqkmgosostctahhhdqtmwf` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_ipcwwtponuhjeylmzbzmybntrryueesamsgw` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rufevcrfyabyyoiqtriythqyestjvdwjgijc` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
INSERT INTO `elements` VALUES (1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2021-02-28 19:57:15','2021-02-28 19:58:59',NULL,'1cb605a7-959f-45e2-9fa7-ef42926ef392'),(2,NULL,NULL,4,'craft\\elements\\Entry',1,0,'2021-02-28 19:57:43','2021-02-28 19:57:43',NULL,'c939c2eb-13a6-47f7-bed2-c7eb0134a210'),(3,NULL,1,4,'craft\\elements\\Entry',1,0,'2021-02-28 19:57:43','2021-02-28 19:57:43',NULL,'27876f75-5329-4b13-8a1b-daffd46ded0d'),(4,NULL,NULL,4,'craft\\elements\\Entry',1,0,'2021-02-28 19:57:43','2021-02-28 19:57:43',NULL,'925cd826-66a5-4b48-acf6-24c8cab99492'),(5,NULL,2,4,'craft\\elements\\Entry',1,0,'2021-02-28 19:57:43','2021-02-28 19:57:43',NULL,'b80be5a3-22b2-4a8b-8b6c-2b3d7ceb471b'),(6,NULL,NULL,4,'craft\\elements\\Entry',1,0,'2021-02-28 19:57:43','2021-02-28 19:57:43',NULL,'27d42214-19be-4b72-aafa-16ae3612895c'),(7,NULL,3,4,'craft\\elements\\Entry',1,0,'2021-02-28 19:57:43','2021-02-28 19:57:43',NULL,'91f64523-4444-488f-b373-058acaa8e0a4'),(8,NULL,NULL,4,'craft\\elements\\Entry',1,0,'2021-02-28 19:57:43','2021-02-28 19:57:43',NULL,'9e0b6a1c-f740-405d-a1e6-93068aebad2f'),(9,NULL,4,4,'craft\\elements\\Entry',1,0,'2021-02-28 19:57:43','2021-02-28 19:57:43',NULL,'0cd58da6-3a2d-473f-a318-2d4f0098a4f6'),(10,NULL,NULL,4,'craft\\elements\\Entry',1,0,'2021-02-28 19:57:43','2021-02-28 19:57:43',NULL,'74dc427a-82d1-49de-ac1f-177bf626458a'),(11,NULL,5,4,'craft\\elements\\Entry',1,0,'2021-02-28 19:57:43','2021-02-28 19:57:43',NULL,'81796973-0935-41bd-ab9d-e67e9dbbee8d'),(12,NULL,NULL,4,'craft\\elements\\Entry',1,0,'2021-02-28 19:57:44','2021-02-28 19:57:44',NULL,'adaff4eb-43ce-4c63-a998-dd2b6285ba5a'),(13,NULL,6,4,'craft\\elements\\Entry',1,0,'2021-02-28 19:57:44','2021-02-28 19:57:44',NULL,'9a1a2aff-2270-4f99-abd6-09bad11fdfa8'),(14,NULL,NULL,4,'craft\\elements\\Entry',1,0,'2021-02-28 19:57:44','2021-02-28 19:57:44',NULL,'ef996931-12ed-46a0-9aa6-ebcc84d1b8b6'),(15,NULL,7,4,'craft\\elements\\Entry',1,0,'2021-02-28 19:57:44','2021-02-28 19:57:44',NULL,'9efc44e9-0304-4e6e-9fe6-6537f1a83890'),(16,NULL,NULL,4,'craft\\elements\\Entry',1,0,'2021-02-28 19:57:44','2021-02-28 19:57:44',NULL,'ef51fe46-1868-4e02-97c1-744ed6c437d7'),(17,NULL,8,4,'craft\\elements\\Entry',1,0,'2021-02-28 19:57:44','2021-02-28 19:57:44',NULL,'4b9bc46c-6c2e-47f1-925f-b2e8a8b6ab55'),(18,NULL,NULL,4,'craft\\elements\\Entry',1,0,'2021-02-28 19:57:44','2021-02-28 19:57:44',NULL,'54769194-0bb0-4eb3-9441-75e897a564cf'),(19,NULL,9,4,'craft\\elements\\Entry',1,0,'2021-02-28 19:57:44','2021-02-28 19:57:44',NULL,'e40d8458-e288-40cb-927c-a544f74cbe88'),(20,NULL,NULL,3,'craft\\elements\\Entry',1,0,'2021-02-28 19:57:44','2021-02-28 19:57:44',NULL,'30d9a37d-3447-4fad-937c-8db6c5a6e8fa'),(21,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2021-02-28 19:57:44','2021-02-28 19:57:44',NULL,'13da89be-bc00-4a90-8d8d-1d86fd7ec52d'),(22,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2021-02-28 19:57:45','2021-02-28 19:57:45',NULL,'a0b9048d-62d9-467a-8d11-510cfbbe4d2a'),(23,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2021-02-28 19:57:45','2021-02-28 19:57:45',NULL,'3b4ae5db-fadc-475f-98da-4bcfaf456444'),(24,NULL,10,3,'craft\\elements\\Entry',1,0,'2021-02-28 19:57:44','2021-02-28 19:57:44',NULL,'fc35c58b-a211-4f5b-b2d3-59520004baeb'),(25,NULL,NULL,2,'craft\\elements\\MatrixBlock',1,0,'2021-02-28 19:57:45','2021-02-28 19:57:44',NULL,'1213d8e1-3da3-488d-b17c-ff5ac5b524dc'),(26,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2021-02-28 19:57:45','2021-02-28 19:57:45',NULL,'ef414e5f-e951-4add-a422-12c8cc7e195f'),(27,NULL,NULL,1,'craft\\elements\\MatrixBlock',1,0,'2021-02-28 19:57:45','2021-02-28 19:57:45',NULL,'817e7a64-188d-4683-a8fd-27522546ce5f');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elements_sites`
--

DROP TABLE IF EXISTS `elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elements_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_jmnijszqkxtvgwizugdnvvwkkfdungliiyap` (`elementId`,`siteId`),
  KEY `idx_wieopjgmfluutefthtntcwdkaupipjokutyy` (`siteId`),
  KEY `idx_znwaejiymtytlldpxfewcbvepcixwsbgkqsf` (`slug`,`siteId`),
  KEY `idx_ubanjycwkculbhgwqkhymkxrgptykykxvagc` (`enabled`),
  KEY `idx_dompxxjcfufzplswpnehilfzheanjzvmunxk` (`uri`,`siteId`),
  CONSTRAINT `fk_nrxihllmbnmymeevownksdwpowtwvcdngxal` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_pjecmfqtckaozrghcnydujmpxdoenvwwmmpc` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
INSERT INTO `elements_sites` VALUES (1,1,2,NULL,NULL,1,'2021-02-28 19:57:15','2021-02-28 19:57:15','20a9f8bf-768a-48bc-9fc8-699d6fa4ce14'),(2,2,2,'infinity-gauntlet','products/infinity-gauntlet',1,'2021-02-28 19:57:43','2021-02-28 19:57:43','bbcce553-01d2-44e8-ba94-c6eb96f0c988'),(3,3,2,'infinity-gauntlet','products/infinity-gauntlet',1,'2021-02-28 19:57:43','2021-02-28 19:57:43','dc6da5c6-6c46-4213-a064-917afc909097'),(4,4,2,'lembas-bread','products/lembas-bread',1,'2021-02-28 19:57:43','2021-02-28 19:57:43','f7faeddc-f0ad-4bfd-a560-cc22732cb94e'),(5,5,2,'lembas-bread','products/lembas-bread',1,'2021-02-28 19:57:43','2021-02-28 19:57:43','0c2754ab-3760-4ee9-a05d-f092e95da8af'),(6,6,2,'dragon-egg','products/dragon-egg',1,'2021-02-28 19:57:43','2021-02-28 19:57:43','99064881-8cdd-4f8c-bdd4-07cc204b1fb4'),(7,7,2,'dragon-egg','products/dragon-egg',1,'2021-02-28 19:57:43','2021-02-28 19:57:43','3abec5b0-63af-4be1-aa2b-fdd77f376800'),(8,8,2,'dark-matter','products/dark-matter',1,'2021-02-28 19:57:43','2021-02-28 19:57:43','abf61067-82cb-4f94-9642-cb61e16f4026'),(9,9,2,'dark-matter','products/dark-matter',1,'2021-02-28 19:57:43','2021-02-28 19:57:43','73a45974-598b-4fcf-96b4-89d4de94a07d'),(10,10,2,'oathkeeper','products/oathkeeper',1,'2021-02-28 19:57:43','2021-02-28 19:57:43','feb8aecd-3576-4f99-965e-29717862be3d'),(11,11,2,'oathkeeper','products/oathkeeper',1,'2021-02-28 19:57:44','2021-02-28 19:57:44','5e5cc893-44db-40b0-a376-310c7e5f9ab3'),(12,12,2,'hand-of-king-brooch','products/hand-of-king-brooch',1,'2021-02-28 19:57:44','2021-02-28 19:57:44','47425c11-3c81-447e-9532-192c2cf0d7db'),(13,13,2,'hand-of-king-brooch','products/hand-of-king-brooch',1,'2021-02-28 19:57:44','2021-02-28 19:57:44','a878e3f0-758f-437e-8944-06a1cc3ae650'),(14,14,2,'laser-sword','products/laser-sword',1,'2021-02-28 19:57:44','2021-02-28 19:57:44','04bed040-2044-410b-badf-cc8a2159a9b4'),(15,15,2,'laser-sword','products/laser-sword',1,'2021-02-28 19:57:44','2021-02-28 19:57:44','9497c2ed-0900-4acf-ad30-ec385dd15f92'),(16,16,2,'elemental-stone','products/elemental-stone',1,'2021-02-28 19:57:44','2021-02-28 19:57:44','98d5eaff-2e97-4a13-92c4-4a3e3c0ace1a'),(17,17,2,'elemental-stone','products/elemental-stone',1,'2021-02-28 19:57:44','2021-02-28 19:57:44','cb02a964-0d43-43c9-ac6a-bf708652a17b'),(18,18,2,'glow-pole-umbrella','products/glow-pole-umbrella',1,'2021-02-28 19:57:44','2021-02-28 19:57:44','3be3a1fb-c2c0-4b91-97c0-76aa0635766a'),(19,19,2,'glow-pole-umbrella','products/glow-pole-umbrella',1,'2021-02-28 19:57:44','2021-02-28 19:57:44','af6b5f6e-a4b9-44eb-984e-356f881169b9'),(20,20,2,'spa-packages','products/spa-packages',1,'2021-02-28 19:57:44','2021-02-28 19:57:44','88c4f67f-8d43-4d92-b6bb-8c0c55751481'),(21,21,2,NULL,NULL,1,'2021-02-28 19:57:44','2021-02-28 19:57:44','dedc804d-4c61-4d5a-b012-421be9daada6'),(22,22,2,NULL,NULL,1,'2021-02-28 19:57:45','2021-02-28 19:57:45','c58f0c22-e629-4452-bc03-13ce1e1e279e'),(23,23,2,NULL,NULL,1,'2021-02-28 19:57:45','2021-02-28 19:57:45','fb463826-7b6f-4a30-a188-1fe32722ca4f'),(24,24,2,'spa-packages','products/spa-packages',1,'2021-02-28 19:57:45','2021-02-28 19:57:45','31284716-1795-443b-a536-e4a9ff6265ea'),(25,25,2,NULL,NULL,1,'2021-02-28 19:57:45','2021-02-28 19:57:45','f1baaddf-43bb-40aa-af09-be0fd59076c7'),(26,26,2,NULL,NULL,1,'2021-02-28 19:57:45','2021-02-28 19:57:45','f6286d75-eeba-4a3f-ab97-3eeba39d2f7c'),(27,27,2,NULL,NULL,1,'2021-02-28 19:57:45','2021-02-28 19:57:45','5ee0e592-3070-4467-8480-c89e3e08b59e');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entries` (
  `id` int NOT NULL,
  `sectionId` int NOT NULL,
  `parentId` int DEFAULT NULL,
  `typeId` int NOT NULL,
  `authorId` int DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_micmgzqptmeateveutzzmsbfmouoazraopbx` (`postDate`),
  KEY `idx_cyrgthcsqxfhlnheddglxzqjbemszxzlpyiv` (`expiryDate`),
  KEY `idx_nngggzcvsytoluybvsjibcptihpthlmkygdq` (`authorId`),
  KEY `idx_npquvtbtsgkvrinyfxppndupnlrgykidtwob` (`sectionId`),
  KEY `idx_ljpfebpxfunuaxmjgokmkuwfguwzprtnftoq` (`typeId`),
  KEY `fk_zpuexntevimppusmorqoibkybbrwyntgaiue` (`parentId`),
  CONSTRAINT `fk_iqqldcgdryrrcnwdohfcyyiosiubxvrzicws` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_kyixkxaeiohsbwchasajnbssodfmqbemxdyr` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_nycnueeaxwofpxfmgxiooqkkhnklznhefvbu` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_zpuexntevimppusmorqoibkybbrwyntgaiue` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_ztdqocepowoujweobmtaloyxgastpfmlqzbj` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
INSERT INTO `entries` VALUES (2,1,NULL,2,NULL,'2021-02-28 19:57:00',NULL,NULL,'2021-02-28 19:57:43','2021-02-28 19:57:43','b79adf52-3ddd-41fd-9246-48d5a9e6028e'),(3,1,NULL,2,NULL,'2021-02-28 19:57:00',NULL,NULL,'2021-02-28 19:57:43','2021-02-28 19:57:43','3c8cbedf-83c3-4526-ac7c-e0a791d4ba76'),(4,1,NULL,2,NULL,'2021-02-28 19:57:00',NULL,NULL,'2021-02-28 19:57:43','2021-02-28 19:57:43','de53ccb8-80e9-4580-a6d5-c3a981b50292'),(5,1,NULL,2,NULL,'2021-02-28 19:57:00',NULL,NULL,'2021-02-28 19:57:43','2021-02-28 19:57:43','080e9ac4-d59f-414b-bcf8-46c16e2d716d'),(6,1,NULL,2,NULL,'2021-02-28 19:57:00',NULL,NULL,'2021-02-28 19:57:43','2021-02-28 19:57:43','0f476b38-909e-4056-9ca4-c42f76647983'),(7,1,NULL,2,NULL,'2021-02-28 19:57:00',NULL,NULL,'2021-02-28 19:57:43','2021-02-28 19:57:43','791ea427-96b1-4fe8-b011-9a3fa7e1c5a9'),(8,1,NULL,2,NULL,'2021-02-28 19:57:00',NULL,NULL,'2021-02-28 19:57:43','2021-02-28 19:57:43','7c9a5889-c9cb-432a-8f1b-7763dffa1c51'),(9,1,NULL,2,NULL,'2021-02-28 19:57:00',NULL,NULL,'2021-02-28 19:57:43','2021-02-28 19:57:43','3ab4de1c-5e3f-4d74-bfad-2d9c8624c5be'),(10,1,NULL,2,NULL,'2021-02-28 19:57:00',NULL,NULL,'2021-02-28 19:57:43','2021-02-28 19:57:43','1223decb-ec24-4681-8aa5-d308176160cf'),(11,1,NULL,2,NULL,'2021-02-28 19:57:00',NULL,NULL,'2021-02-28 19:57:44','2021-02-28 19:57:44','2993e143-7ea9-40b6-b441-5ffdb4417252'),(12,1,NULL,2,NULL,'2021-02-28 19:57:00',NULL,NULL,'2021-02-28 19:57:44','2021-02-28 19:57:44','a6ed69b3-e4b7-4874-80f3-da4730458027'),(13,1,NULL,2,NULL,'2021-02-28 19:57:00',NULL,NULL,'2021-02-28 19:57:44','2021-02-28 19:57:44','761f662f-82d2-4fd4-b425-21e5a275532a'),(14,1,NULL,2,NULL,'2021-02-28 19:57:00',NULL,NULL,'2021-02-28 19:57:44','2021-02-28 19:57:44','6d1a996b-e9dc-4040-88bc-a9e8e1cbf3f1'),(15,1,NULL,2,NULL,'2021-02-28 19:57:00',NULL,NULL,'2021-02-28 19:57:44','2021-02-28 19:57:44','8ea5638b-7318-466e-8cda-0ced9232b959'),(16,1,NULL,2,NULL,'2021-02-28 19:57:00',NULL,NULL,'2021-02-28 19:57:44','2021-02-28 19:57:44','d7fe9134-5d70-4fec-b68c-2997e6c8c807'),(17,1,NULL,2,NULL,'2021-02-28 19:57:00',NULL,NULL,'2021-02-28 19:57:44','2021-02-28 19:57:44','f31a7b8f-b02b-4ab7-ad6f-53c774f10ba9'),(18,1,NULL,2,NULL,'2021-02-28 19:57:00',NULL,NULL,'2021-02-28 19:57:44','2021-02-28 19:57:44','f5df8a4e-e1a3-4ea2-bf83-2a375a0053f1'),(19,1,NULL,2,NULL,'2021-02-28 19:57:00',NULL,NULL,'2021-02-28 19:57:44','2021-02-28 19:57:44','30122d3b-d2c9-4669-8c41-63e1c02900a5'),(20,1,NULL,1,NULL,'2021-02-28 19:57:00',NULL,NULL,'2021-02-28 19:57:44','2021-02-28 19:57:44','ab278652-c2f6-4e06-b3cf-fd52cebb30ab'),(24,1,NULL,1,NULL,'2021-02-28 19:57:00',NULL,NULL,'2021-02-28 19:57:45','2021-02-28 19:57:45','64c37642-1a4a-4bab-98b7-662aec0e4c11');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrytypes`
--

DROP TABLE IF EXISTS `entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrytypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sectionId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleTranslationMethod` varchar(255) NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text,
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_xwtmfpszmkbvhvdoyquypwlbuzavyhbldsiu` (`name`,`sectionId`),
  KEY `idx_otnzxmxpnrdxxfmewzpevzxadnlnqyoieesk` (`handle`,`sectionId`),
  KEY `idx_nepkrewymikotdbfhhbdowuezniddokwzdjy` (`sectionId`),
  KEY `idx_puewqxsilwcznlpfcsbsgvsdpokyeygvsrxm` (`fieldLayoutId`),
  KEY `idx_fvzmsjygtsnsnfjxlbhodokytafjeoewuqii` (`dateDeleted`),
  CONSTRAINT `fk_gshxahfjbpnilmiuxzycslyxgbumsaqldnnt` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_zvdhsywykuvavlldvtuegzfduejqlaxyxmtq` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
INSERT INTO `entrytypes` VALUES (1,1,3,'Complex Products','complexProducts',1,'site',NULL,NULL,2,'2021-02-28 19:57:15','2021-02-28 19:57:15',NULL,'047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc'),(2,1,4,'Products','products',1,'site',NULL,NULL,1,'2021-02-28 19:57:15','2021-02-28 19:57:15',NULL,'e0433a5c-bd50-4ba7-9d0c-ed1873de08c1');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldgroups`
--

DROP TABLE IF EXISTS `fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fieldgroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_uudplnwcwmcmopzzfrcjbrpilltptujoljfq` (`name`),
  KEY `idx_rhiacbvqdlxqvoqyeifsuobknzntbhlhtkzj` (`dateDeleted`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
INSERT INTO `fieldgroups` VALUES (1,'Common','2021-02-28 19:57:14','2021-02-28 19:57:14',NULL,'8d3cabd4-1037-4e8e-8417-8b6361290ec6');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldlayoutfields`
--

DROP TABLE IF EXISTS `fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fieldlayoutfields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `layoutId` int NOT NULL,
  `tabId` int NOT NULL,
  `fieldId` int NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_fyuojjynpitqbmcaqkfxdzcvrdfxjychtfmd` (`layoutId`,`fieldId`),
  KEY `idx_zxegwwmpodnthyxrqvszysqqvqtfdvzueons` (`sortOrder`),
  KEY `idx_lskvomoyfzwgvpddlkjwhvehnraystoetflp` (`tabId`),
  KEY `idx_brgasxgcdehnvqshqriaetahnrvdvogttobh` (`fieldId`),
  CONSTRAINT `fk_cvlwobnriinpnwwemdyjtqfnupqzkqtoxrlx` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_motcbfirryftiwxsdyrbjcpkkfsawevaouba` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_tnpbijpshgpgzilqxortoywbyvwhjtnieiep` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
INSERT INTO `fieldlayoutfields` VALUES (4,1,3,6,0,0,'2021-02-28 19:57:15','2021-02-28 19:57:15','707c3166-a5e7-40fd-ae64-b92921a08a4b'),(5,1,3,5,0,1,'2021-02-28 19:57:15','2021-02-28 19:57:15','750c42a8-6533-4516-b5e6-efeed3509c99'),(6,3,4,3,0,1,'2021-02-28 19:57:15','2021-02-28 19:57:15','1b58e500-746c-4d45-b655-070659778480'),(7,4,5,2,0,1,'2021-02-28 19:57:15','2021-02-28 19:57:15','2f2f1a6b-9587-4bef-9ccb-bb3cda0a5fe6'),(8,4,5,1,0,2,'2021-02-28 19:57:15','2021-02-28 19:57:15','a8a944e5-6d62-462b-8d9e-64eb0f2281b3'),(9,4,5,4,0,3,'2021-02-28 19:57:15','2021-02-28 19:57:15','37c125e5-6a83-4801-a4f4-6b61523a3858'),(10,2,6,7,0,0,'2021-02-28 19:57:15','2021-02-28 19:57:15','9d50262d-c98d-4337-8f77-f371de876fd5');
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldlayouts`
--

DROP TABLE IF EXISTS `fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fieldlayouts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_uibgswbbvajqotjcvaidnfrapzdxmahdfwhn` (`dateDeleted`),
  KEY `idx_zlrzdzcldygeijwuiirufexcjlsleqfswzqc` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
INSERT INTO `fieldlayouts` VALUES (1,'craft\\elements\\MatrixBlock','2021-02-28 19:57:14','2021-02-28 19:57:14',NULL,'4461f21f-abb8-4816-8013-0f3970460f78'),(2,'craft\\elements\\MatrixBlock','2021-02-28 19:57:14','2021-02-28 19:57:14',NULL,'b8ebab1f-4c19-49a3-b626-7262a082aecd'),(3,'craft\\elements\\Entry','2021-02-28 19:57:15','2021-02-28 19:57:15',NULL,'f4b7056c-37a5-4cfd-8100-2c32150ae1ab'),(4,'craft\\elements\\Entry','2021-02-28 19:57:15','2021-02-28 19:57:15',NULL,'2f1f4698-bc5b-4efe-90d5-ee8186714f55');
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldlayouttabs`
--

DROP TABLE IF EXISTS `fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fieldlayouttabs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `layoutId` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `elements` text,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_iyddtvaoycvsiusmebqxsbqalsmsldauqbkk` (`sortOrder`),
  KEY `idx_ucmhmkvyqajzxsgobdijlskkvrabjnukzrri` (`layoutId`),
  CONSTRAINT `fk_ozoqdlrawzvhmzqbpvqhsccjzelbhcrhbtua` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
INSERT INTO `fieldlayouttabs` VALUES (3,1,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"c7fd47c1-7147-466b-9710-16b4d5d9c0e2\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"97134205-e4b8-4169-a51b-ca23329ec35a\"}]',1,'2021-02-28 19:57:14','2021-02-28 19:57:14','5c90b07c-9c11-4a70-9cd5-d3401f1bf3a2'),(4,3,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"f7f5703c-a5d1-4ece-81f6-cd69aacba8cb\"}]',1,'2021-02-28 19:57:15','2021-02-28 19:57:15','1b5e240d-6286-4872-b9a2-80b596ff8cb8'),(5,4,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\EntryTitleField\",\"autocomplete\":false,\"class\":null,\"size\":null,\"name\":null,\"autocorrect\":true,\"autocapitalize\":true,\"disabled\":false,\"readonly\":false,\"title\":null,\"placeholder\":null,\"step\":null,\"min\":null,\"max\":null,\"requirable\":false,\"id\":null,\"containerAttributes\":[],\"inputContainerAttributes\":[],\"labelAttributes\":[],\"orientation\":null,\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"width\":100},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"2eb8dccb-b22e-43c9-be2d-d3f76a3856c1\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"eff3417c-3955-4de7-a137-b7a99e365c5c\"},{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73\"}]',1,'2021-02-28 19:57:15','2021-02-28 19:57:15','2e7f8f9a-7dca-455b-b311-3752da1eb5ca'),(6,2,'Content','[{\"type\":\"craft\\\\fieldlayoutelements\\\\CustomField\",\"label\":null,\"instructions\":null,\"tip\":null,\"warning\":null,\"required\":false,\"width\":100,\"fieldUid\":\"6884bf14-6cfc-4f23-ac2f-3702687f8602\"}]',1,'2021-02-28 19:57:15','2021-02-28 19:57:15','d28c1cb7-8349-4667-a7cf-9285b13dde1f');
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ysxthrcpepuxbaqwnkyemzegrgnfzzzxpqoc` (`handle`,`context`),
  KEY `idx_lcjwxvoadrrjqkmsuvxhlsbsigawbujzenjh` (`groupId`),
  KEY `idx_lzjvxtwwrmvmmvfrfhsbtridxtzyslwpaxby` (`context`),
  CONSTRAINT `fk_kepqznxijboleiyzepyvzidghqfqevbpsiuw` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
INSERT INTO `fields` VALUES (1,1,'Product Options','productOptions','global','',0,'none',NULL,'craft\\fields\\Table','{\"addRowLabel\":\"Add a row\",\"columnType\":\"text\",\"columns\":{\"col1\":{\"heading\":\"Option\",\"handle\":\"name\",\"width\":\"\",\"type\":\"singleline\"},\"col2\":{\"heading\":\"Value\",\"handle\":\"price\",\"width\":\"\",\"type\":\"singleline\"}},\"defaults\":[{\"col1\":\"\",\"col2\":\"\"}],\"maxRows\":\"\",\"minRows\":\"\"}','2021-02-28 19:57:14','2021-02-28 19:57:14','eff3417c-3955-4de7-a137-b7a99e365c5c'),(2,1,'Product Description','productDescription','global','',0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\",\"uiMode\":\"normal\"}','2021-02-28 19:57:14','2021-02-28 19:57:14','2eb8dccb-b22e-43c9-be2d-d3f76a3856c1'),(3,1,'Page Blocks','pageBlocks','global','',0,'site',NULL,'craft\\fields\\Matrix','{\"contentTable\":\"{{%matrixcontent_pageblocks}}\",\"maxBlocks\":\"\",\"minBlocks\":\"\",\"propagationMethod\":\"all\"}','2021-02-28 19:57:14','2021-02-28 19:57:14','f7f5703c-a5d1-4ece-81f6-cd69aacba8cb'),(4,1,'Product Details','productDetails','global','',0,'none',NULL,'fostercommerce\\snipcart\\fields\\ProductDetails','{\"defaultDimensionsUnit\":\"centimeters\",\"defaultHeight\":\"\",\"defaultLength\":\"\",\"defaultShippable\":\"1\",\"defaultTaxable\":\"1\",\"defaultWeight\":\"\",\"defaultWeightUnit\":\"grams\",\"defaultWidth\":\"\",\"displayInventory\":\"1\",\"displayShippableSwitch\":\"1\",\"displayTaxableSwitch\":\"1\",\"skuDefault\":\"\"}','2021-02-28 19:57:14','2021-02-28 19:57:14','83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73'),(5,NULL,'Product Info','productInfo','matrixBlockType:db133a46-b847-4150-a31b-741c83c342a5','',0,'none',NULL,'fostercommerce\\snipcart\\fields\\ProductDetails','{\"defaultDimensionsUnit\":\"centimeters\",\"defaultHeight\":\"\",\"defaultLength\":\"\",\"defaultShippable\":\"1\",\"defaultTaxable\":\"1\",\"defaultWeight\":\"\",\"defaultWeightUnit\":\"grams\",\"defaultWidth\":\"\",\"displayInventory\":\"1\",\"displayShippableSwitch\":\"1\",\"displayTaxableSwitch\":\"1\",\"skuDefault\":\"\"}','2021-02-28 19:57:14','2021-02-28 19:57:14','97134205-e4b8-4169-a51b-ca23329ec35a'),(6,NULL,'Product Name','productName','matrixBlockType:db133a46-b847-4150-a31b-741c83c342a5','',0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\",\"uiMode\":\"normal\"}','2021-02-28 19:57:14','2021-02-28 19:57:14','c7fd47c1-7147-466b-9710-16b4d5d9c0e2'),(7,NULL,'Heading','heading','matrixBlockType:a4e5c444-dfe0-4cc9-81d2-385dca72e446','',0,'none',NULL,'craft\\fields\\PlainText','{\"byteLimit\":null,\"charLimit\":null,\"code\":\"\",\"columnType\":null,\"initialRows\":\"4\",\"multiline\":\"\",\"placeholder\":\"\",\"uiMode\":\"normal\"}','2021-02-28 19:57:14','2021-02-28 19:57:14','6884bf14-6cfc-4f23-ac2f-3702687f8602');
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalsets`
--

DROP TABLE IF EXISTS `globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `globalsets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_anbpxbaaopnsphoqvmeymeyednhgonfbvtwk` (`name`),
  KEY `idx_styoblpzjqjtytcixxqtkmgxeqjyyzmvpvwn` (`handle`),
  KEY `idx_cfasitwmavxjcmbnpjvxtknqbhvzixmbccrt` (`fieldLayoutId`),
  CONSTRAINT `fk_oinnkezjqsgtiflrctklcmzaidcawvzplpna` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_yoxtvunqrujxzjynfwnqhubrcfgiivbartqj` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gqlschemas`
--

DROP TABLE IF EXISTS `gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gqlschemas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text,
  `isPublic` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gqlschemas`
--

LOCK TABLES `gqlschemas` WRITE;
/*!40000 ALTER TABLE `gqlschemas` DISABLE KEYS */;
INSERT INTO `gqlschemas` VALUES (1,'Dev Schema','[\"sections.8e737589-250f-4c64-baa3-bc9a444cb243:read\",\"entrytypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1:read\",\"entrytypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc:read\"]',0,'2021-02-28 19:57:14','2021-02-28 19:57:14','e8ef8494-36a9-4ecc-b0b8-33bdc34343ae'),(2,'Public Schema','[\"sections.8e737589-250f-4c64-baa3-bc9a444cb243:read\",\"entrytypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1:read\",\"entrytypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc:read\"]',1,'2021-02-28 19:57:14','2021-02-28 19:57:14','ce2b6eb1-d61e-44e6-bd0b-dce122ce1433');
/*!40000 ALTER TABLE `gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gqltokens`
--

DROP TABLE IF EXISTS `gqltokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gqltokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `schemaId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_cctktuguunglcizxylmcxjafbtadllpmzbwr` (`accessToken`),
  UNIQUE KEY `idx_dmqohcuilgbngtdlastqkkxqzaetynmvsflb` (`name`),
  KEY `fk_xvdmyiqvvrmpsmfvbwjagtqfthnjzoyithhq` (`schemaId`),
  CONSTRAINT `fk_xvdmyiqvvrmpsmfvbwjagtqfthnjzoyithhq` FOREIGN KEY (`schemaId`) REFERENCES `gqlschemas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gqltokens`
--

LOCK TABLES `gqltokens` WRITE;
/*!40000 ALTER TABLE `gqltokens` DISABLE KEYS */;
INSERT INTO `gqltokens` VALUES (1,'Public Token','__PUBLIC__',0,NULL,NULL,2,'2021-02-28 19:57:15','2021-02-28 19:57:15','c8bd5c99-3222-4a48-a3cb-da77a5dd7d13');
/*!40000 ALTER TABLE `gqltokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `configVersion` char(12) NOT NULL DEFAULT '000000000000',
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
INSERT INTO `info` VALUES (1,'3.6.7','3.6.4',0,'zszdxmqepeii','hfkeewoliqrz','2021-02-28 19:57:13','2021-02-28 19:57:45','5cdd75cd-5a04-4745-bf61-df24b3414984');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matrixblocks` (
  `id` int NOT NULL,
  `ownerId` int NOT NULL,
  `fieldId` int NOT NULL,
  `typeId` int NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_uwneojfsrtdtipbcwidcwirnusbkicdwrkfl` (`ownerId`),
  KEY `idx_yrugyqmipspjomfwmopituptfzvrxpuhukci` (`fieldId`),
  KEY `idx_olaaxtjrprhvinrkhmsgjezwpuejlypayrvd` (`typeId`),
  KEY `idx_tgbcofnjqulonlkyveqpxmozawdpkojlajvw` (`sortOrder`),
  CONSTRAINT `fk_hbauczqnaqnvshvdhtxycmhnblxafijzumxn` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_isybyszjlruvjaifhwopxxjvjrrlieucensr` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_lpajmikbuvqszxnkukpnnmnozxymghmsiwyy` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rzhcipxpvpfjpfsqywcaditgjayugqgqrvdy` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
INSERT INTO `matrixblocks` VALUES (21,20,3,2,1,NULL,'2021-02-28 19:57:44','2021-02-28 19:57:44','6c9e5cc5-27db-4a6b-8752-8e9062265f73'),(22,20,3,1,2,NULL,'2021-02-28 19:57:45','2021-02-28 19:57:45','ab860175-c266-4d48-ab5a-c3ac6ce655ac'),(23,20,3,1,3,NULL,'2021-02-28 19:57:45','2021-02-28 19:57:45','12ccf408-ed7c-45a0-9cf0-06e8189af2e3'),(25,24,3,2,1,NULL,'2021-02-28 19:57:45','2021-02-28 19:57:45','16cae488-1275-41c3-80d9-29f448e8baa9'),(26,24,3,1,2,NULL,'2021-02-28 19:57:45','2021-02-28 19:57:45','cef3462a-a542-4590-8756-b322383b372d'),(27,24,3,1,3,NULL,'2021-02-28 19:57:45','2021-02-28 19:57:45','1fe10036-07c3-48b5-8cfc-df4db4446ff0');
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrixblocktypes`
--

DROP TABLE IF EXISTS `matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matrixblocktypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldId` int NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_eaxuhwozzfxxrkdsowtixmelebglfrcybmxw` (`name`,`fieldId`),
  KEY `idx_qaqxsoyufzsmventeatfxshqdzybdfpnrvzg` (`handle`,`fieldId`),
  KEY `idx_zujqrpnhhgpbzrskmfofmyenxvyzoyzttyth` (`fieldId`),
  KEY `idx_zxdbkstmnozmrtasrmtogovlhdlprdovmisk` (`fieldLayoutId`),
  CONSTRAINT `fk_ascvgwhiipjgsejmyrhgepbbaxxuzltbxnac` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_kaxfhjjwqjiijmrchvpzehmpxtonnqgfxznt` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
INSERT INTO `matrixblocktypes` VALUES (1,3,1,'Product','product',2,'2021-02-28 19:57:14','2021-02-28 19:57:14','db133a46-b847-4150-a31b-741c83c342a5'),(2,3,2,'Heading','heading',1,'2021-02-28 19:57:14','2021-02-28 19:57:14','a4e5c444-dfe0-4cc9-81d2-385dca72e446');
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrixcontent_pageblocks`
--

DROP TABLE IF EXISTS `matrixcontent_pageblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matrixcontent_pageblocks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `siteId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_product_productName` text,
  `field_heading_heading` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_unwxnkjukowmnwslimreslcgqbznkghxovex` (`elementId`,`siteId`),
  KEY `fk_ibvdhigkygckdrceosurlkraaueohkwrqqhn` (`siteId`),
  CONSTRAINT `fk_ibvdhigkygckdrceosurlkraaueohkwrqqhn` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_kdxcvjoyqmfzxvffzoaveivkruzswraqaydl` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrixcontent_pageblocks`
--

LOCK TABLES `matrixcontent_pageblocks` WRITE;
/*!40000 ALTER TABLE `matrixcontent_pageblocks` DISABLE KEYS */;
INSERT INTO `matrixcontent_pageblocks` VALUES (1,21,2,'2021-02-28 19:57:44','2021-02-28 19:57:44','1fa84340-0489-42c1-89c9-d594d4ccebb5',NULL,'Spa Options'),(2,22,2,'2021-02-28 19:57:45','2021-02-28 19:57:45','ee29bf01-3e19-4a5f-888f-7d153ac06b80','Economy',NULL),(3,23,2,'2021-02-28 19:57:45','2021-02-28 19:57:45','5c484d07-84ae-4131-b5fa-f1ab1a6cfcde','Deluxe',NULL),(4,25,2,'2021-02-28 19:57:45','2021-02-28 19:57:45','3903e508-121a-4896-9a40-fc9de3ee491a',NULL,'Spa Options'),(5,26,2,'2021-02-28 19:57:45','2021-02-28 19:57:45','bd794ab2-c4f1-4db9-aa58-076102690f54','Economy',NULL),(6,27,2,'2021-02-28 19:57:45','2021-02-28 19:57:45','284d0f5a-222f-4cac-afc0-1d8987f34d57','Deluxe',NULL);
/*!40000 ALTER TABLE `matrixcontent_pageblocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `track` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_umirfpbawcicdlfsiobuqtfxnkqidotvkjbp` (`track`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'plugin:snipcart','Install','2021-02-28 19:57:14','2021-02-28 19:57:14','2021-02-28 19:57:14','712d73a7-29b2-4085-8047-a7d0a3e4b2c7'),(2,'plugin:snipcart','m190304_034411_allow_null_sku','2021-02-28 19:57:14','2021-02-28 19:57:14','2021-02-28 19:57:14','dd2c9cba-d4b6-49cb-bf23-8ec167821467'),(3,'plugin:snipcart','m200616_222231_float_to_decimal','2021-02-28 19:57:14','2021-02-28 19:57:14','2021-02-28 19:57:14','00716b78-e01d-421a-b16d-645197f5d088'),(4,'plugin:snipcart','m200921_165936_webhook_types','2021-02-28 19:57:14','2021-02-28 19:57:14','2021-02-28 19:57:14','044d6cdb-1798-49b5-b2e4-d8d4212552d7'),(5,'plugin:snipcart','m210122_204103_update_namespace','2021-02-28 19:57:14','2021-02-28 19:57:14','2021-02-28 19:57:14','7c8070e0-ba6e-4cb2-a9e3-a2474d6b8ec6'),(6,'craft','Install','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','43d8e5ed-ff58-4181-8556-270dd0767a0e'),(7,'craft','m150403_183908_migrations_table_changes','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','017cad72-e322-4757-95ad-79309b752497'),(8,'craft','m150403_184247_plugins_table_changes','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','90fff157-1522-488c-85dd-d15d0ab7ce6d'),(9,'craft','m150403_184533_field_version','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','97e28f47-1c22-443f-8bab-92898cd83fcb'),(10,'craft','m150403_184729_type_columns','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','d6f63d13-9b58-4076-8912-209777d1d266'),(11,'craft','m150403_185142_volumes','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','d2aeb1e3-4104-4566-9141-ca941157f2e6'),(12,'craft','m150428_231346_userpreferences','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','c607f724-5d75-4876-9f43-ae42424464cd'),(13,'craft','m150519_150900_fieldversion_conversion','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','9ae82d6f-4f86-47c9-93bb-8b6665b8944f'),(14,'craft','m150617_213829_update_email_settings','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','c97189d5-7acf-41f7-b6cc-db550e2441ca'),(15,'craft','m150721_124739_templatecachequeries','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','6fc1aaa7-ebd1-4dcc-9010-9e29610d94ae'),(16,'craft','m150724_140822_adjust_quality_settings','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','a41d4c5e-daf4-4585-a5c2-688e972290e8'),(17,'craft','m150815_133521_last_login_attempt_ip','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','fe0351a0-2ad5-4366-8672-05c121ce5dec'),(18,'craft','m151002_095935_volume_cache_settings','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','3066ba5a-e8b8-44f4-b2d1-ed8266c1ea4a'),(19,'craft','m151005_142750_volume_s3_storage_settings','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','f69e4789-65c1-48d9-b7dc-be73fb7df6d1'),(20,'craft','m151016_133600_delete_asset_thumbnails','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','3709688b-975c-4de8-90ef-d828e1ef786c'),(21,'craft','m151209_000000_move_logo','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','9dcfb8fd-7e2e-46e5-a6fa-6404670b83c2'),(22,'craft','m151211_000000_rename_fileId_to_assetId','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','c1bf1478-dff7-4d55-b8c9-875aee287361'),(23,'craft','m151215_000000_rename_asset_permissions','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','d12a8447-0940-49d0-9416-d8771b61a100'),(24,'craft','m160707_000001_rename_richtext_assetsource_setting','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','8fb9c306-0d62-44fb-b01f-1e4eee69e541'),(25,'craft','m160708_185142_volume_hasUrls_setting','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','9488b0f4-4bc1-48c8-9821-e399afa4d44d'),(26,'craft','m160714_000000_increase_max_asset_filesize','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','ed98d1a0-e459-453a-a77c-4974091ea030'),(27,'craft','m160727_194637_column_cleanup','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','f7554cd8-a7e1-45b9-b3cd-d81eddf27b61'),(28,'craft','m160804_110002_userphotos_to_assets','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','a40baaaf-87d7-4a8a-a92a-0a6042fba20f'),(29,'craft','m160807_144858_sites','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','c7b5f520-7215-40d9-b255-ab7435d7b1ab'),(30,'craft','m160829_000000_pending_user_content_cleanup','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','746930ad-1567-4630-abe1-67d34e7fb580'),(31,'craft','m160830_000000_asset_index_uri_increase','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','a22627a8-ff79-4fb4-bb47-330a67a56ff5'),(32,'craft','m160912_230520_require_entry_type_id','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','81a1cddd-9264-4b04-abdd-53fef68f1fd2'),(33,'craft','m160913_134730_require_matrix_block_type_id','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','b886e638-a048-4f21-82c5-697ec9f959a7'),(34,'craft','m160920_174553_matrixblocks_owner_site_id_nullable','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','c4bf7e69-ba98-4c8d-91eb-86693cea22aa'),(35,'craft','m160920_231045_usergroup_handle_title_unique','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','9874c650-98d1-4e9d-96de-2802690e4d94'),(36,'craft','m160925_113941_route_uri_parts','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','c925acd2-5b51-439d-9607-90038cc9448b'),(37,'craft','m161006_205918_schemaVersion_not_null','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','53b1321b-b257-4b8d-b585-60ea9f8523ab'),(38,'craft','m161007_130653_update_email_settings','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','1578d8be-d738-46ca-9b85-7b38fd91090f'),(39,'craft','m161013_175052_newParentId','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','fef00cf3-290e-4ea0-99ff-354f224bf269'),(40,'craft','m161021_102916_fix_recent_entries_widgets','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','c65d8107-03eb-4bee-8a64-aff31c1f107a'),(41,'craft','m161021_182140_rename_get_help_widget','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','aba96b21-cdd8-4cc3-90e6-6b84b7d3569c'),(42,'craft','m161025_000000_fix_char_columns','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','84920f43-c898-4a75-aa84-6e869ae20907'),(43,'craft','m161029_124145_email_message_languages','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','c04b558b-04e7-4c87-883c-689478b4264d'),(44,'craft','m161108_000000_new_version_format','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','7faa58a7-2671-432b-bdfe-a28cf58f7732'),(45,'craft','m161109_000000_index_shuffle','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','01e8ecc0-45e8-4617-8117-7986cf867d9f'),(46,'craft','m161122_185500_no_craft_app','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','36bd1b31-f527-41c3-a497-904721ba77b3'),(47,'craft','m161125_150752_clear_urlmanager_cache','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','868233e6-2284-4a64-8f7c-acd32e8a9288'),(48,'craft','m161220_000000_volumes_hasurl_notnull','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','3e9636f7-1008-4bed-bc7c-25f9d164a40d'),(49,'craft','m170114_161144_udates_permission','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','b3c10b71-26bd-470c-9087-1fc91a204488'),(50,'craft','m170120_000000_schema_cleanup','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','27e3a3f0-589b-4fad-995d-8b4201df8a64'),(51,'craft','m170126_000000_assets_focal_point','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','56e3b76f-0843-4083-9eb4-c050145b6bce'),(52,'craft','m170206_142126_system_name','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','cc4756c1-00e9-4e42-b578-22118c7cec21'),(53,'craft','m170217_044740_category_branch_limits','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','c386cda0-0431-4eaf-b105-2f0b43be8afa'),(54,'craft','m170217_120224_asset_indexing_columns','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','73cc11d3-93f2-4173-8471-c4498c15362a'),(55,'craft','m170223_224012_plain_text_settings','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','b6c97063-5e43-4283-9fe0-75a1ab9b45a0'),(56,'craft','m170227_120814_focal_point_percentage','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','b0da3a47-88c0-4a4a-8d0e-836e43f7aa4f'),(57,'craft','m170228_171113_system_messages','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','5b749f7b-ec0c-40cb-8edd-64ba32c1eb68'),(58,'craft','m170303_140500_asset_field_source_settings','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','1be94301-4fed-44f2-9aef-4bd4073a5d1f'),(59,'craft','m170306_150500_asset_temporary_uploads','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','dc0afe0e-b681-4795-b233-2ac30a27523e'),(60,'craft','m170523_190652_element_field_layout_ids','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','6abbfa99-1c6a-4ea6-8ba3-d87e72ebfa9a'),(61,'craft','m170621_195237_format_plugin_handles','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','c8d09e8e-8fc0-404f-b652-8cd52104ffe5'),(62,'craft','m170630_161027_deprecation_line_nullable','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','ff91fbe9-1945-40dd-bd32-8b9702a6bd0f'),(63,'craft','m170630_161028_deprecation_changes','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','5e62b36b-afc4-4b1f-bfa1-6a1e6f118c9b'),(64,'craft','m170703_181539_plugins_table_tweaks','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','ed2960f0-2889-4253-8527-00745b225891'),(65,'craft','m170704_134916_sites_tables','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','6919cb96-4692-4cc8-9ebc-70d7f0f5d44d'),(66,'craft','m170706_183216_rename_sequences','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','03d4c8c8-4504-4e3a-9791-f9ac5d9d5f05'),(67,'craft','m170707_094758_delete_compiled_traits','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','d8300d39-a02d-4a4d-a138-9c2354ef15ab'),(68,'craft','m170731_190138_drop_asset_packagist','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','a7f0f8d7-f4ec-4e72-b501-c1e90b8c498d'),(69,'craft','m170810_201318_create_queue_table','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','c04f1f48-59d4-4c34-9d00-f0697468172a'),(70,'craft','m170903_192801_longblob_for_queue_jobs','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','42ee64ed-9675-4805-ba45-fd006517844b'),(71,'craft','m170914_204621_asset_cache_shuffle','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','fffe1f96-50ca-45a2-8e71-e5865416e876'),(72,'craft','m171011_214115_site_groups','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','9840ae81-743b-4db4-a2af-fec0daa32888'),(73,'craft','m171012_151440_primary_site','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','4c250a90-92ce-419a-a7b0-1ef67f37580e'),(74,'craft','m171013_142500_transform_interlace','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','0a0277a4-3840-42c2-872b-961a1b7921ce'),(75,'craft','m171016_092553_drop_position_select','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','5b30d219-a581-40eb-9f14-caa3bd1708cf'),(76,'craft','m171016_221244_less_strict_translation_method','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','78ec2675-e108-4555-84ba-cfb943aebd3a'),(77,'craft','m171107_000000_assign_group_permissions','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','16c1054c-8b27-4932-8f92-68950a2527cb'),(78,'craft','m171117_000001_templatecache_index_tune','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','a961b621-345c-4d7f-909c-7ce8946474f3'),(79,'craft','m171126_105927_disabled_plugins','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','f1ed921d-30a5-4c65-ad99-aa7b3e059566'),(80,'craft','m171130_214407_craftidtokens_table','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','0c9f63f8-8882-410b-a44d-88a436e9d55d'),(81,'craft','m171202_004225_update_email_settings','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','a30ee00a-1c3e-4054-9496-5afe840876d8'),(82,'craft','m171204_000001_templatecache_index_tune_deux','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','31f6a71d-e0db-4b1e-8442-1d76756a688b'),(83,'craft','m171205_130908_remove_craftidtokens_refreshtoken_column','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','ebcae930-d81a-4719-995d-96696c44d803'),(84,'craft','m171218_143135_longtext_query_column','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','e95a5b11-c8e7-4a0c-b33d-e18652015f2b'),(85,'craft','m171231_055546_environment_variables_to_aliases','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','e84fe442-18b9-4be2-a9e0-a4520fad98ee'),(86,'craft','m180113_153740_drop_users_archived_column','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','f6a5df26-beb9-4aa5-948c-5bada1defa15'),(87,'craft','m180122_213433_propagate_entries_setting','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','77a30641-1b62-4837-b93d-22162da1044d'),(88,'craft','m180124_230459_fix_propagate_entries_values','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','3a98b8a3-64e4-41c5-91c9-229c8f820b11'),(89,'craft','m180128_235202_set_tag_slugs','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','69aabb2f-acf7-4af0-abc0-68f421fe9e53'),(90,'craft','m180202_185551_fix_focal_points','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','3125afd3-700e-44eb-b30a-30fec87812d1'),(91,'craft','m180217_172123_tiny_ints','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','8a4ee771-6fc9-4982-bd0c-4b01f6edeabe'),(92,'craft','m180321_233505_small_ints','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','f9682e06-5adc-42ca-b850-47d6941e1d69'),(93,'craft','m180404_182320_edition_changes','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','5b49af93-b1ab-45f0-80fb-f83fa7ee5706'),(94,'craft','m180411_102218_fix_db_routes','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','2e17a13a-3b61-4974-bc4e-a18f9373575b'),(95,'craft','m180416_205628_resourcepaths_table','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','0c63e01e-acaa-4b1c-8a4f-bcbe3072d2f4'),(96,'craft','m180418_205713_widget_cleanup','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','6d1b59d7-4ed6-4572-a22b-72c4b7b67d04'),(97,'craft','m180425_203349_searchable_fields','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','34416660-0dd2-4ac2-9a62-0368f6dbdda3'),(98,'craft','m180516_153000_uids_in_field_settings','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','69fdb383-9479-484f-97a5-c917d7e1187e'),(99,'craft','m180517_173000_user_photo_volume_to_uid','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','d2a1add0-6d78-41c0-b4ee-2aa4c0a94ebe'),(100,'craft','m180518_173000_permissions_to_uid','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','b5422ef7-da15-4e05-bb13-62b4c4cd3ea8'),(101,'craft','m180520_173000_matrix_context_to_uids','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','a350d666-053b-43ac-bfd5-0765a7bffac1'),(102,'craft','m180521_172900_project_config_table','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','a5c21077-3bb7-47e0-b305-0b08518c032b'),(103,'craft','m180521_173000_initial_yml_and_snapshot','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','1632f94f-a9a5-4d1b-9767-c422bbe6b6d7'),(104,'craft','m180731_162030_soft_delete_sites','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','6c96a78e-8285-4a28-8089-b250830d932c'),(105,'craft','m180810_214427_soft_delete_field_layouts','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','9d6096ca-8fcc-4a54-bfbc-07bcf12b5d10'),(106,'craft','m180810_214439_soft_delete_elements','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','da546e04-a94b-485b-8049-52f19d1aca0b'),(107,'craft','m180824_193422_case_sensitivity_fixes','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','ed26cee9-6395-4712-9031-e2198c42f07c'),(108,'craft','m180901_151639_fix_matrixcontent_tables','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','803343bf-8346-42c8-af46-3f16731946ed'),(109,'craft','m180904_112109_permission_changes','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','10a6ce58-9dc0-45fe-9445-5405adfada31'),(110,'craft','m180910_142030_soft_delete_sitegroups','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','02396bbb-1143-4694-9727-c4233ae3d170'),(111,'craft','m181011_160000_soft_delete_asset_support','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','e1a9dabe-bb60-47f2-8907-6e5a4fb5754f'),(112,'craft','m181016_183648_set_default_user_settings','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','23389e8a-8e52-4a96-b13c-62f69fa19174'),(113,'craft','m181017_225222_system_config_settings','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','06a2126f-0926-433e-9a17-edcf5120e99b'),(114,'craft','m181018_222343_drop_userpermissions_from_config','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','f42b0c30-adcd-46ee-a5e9-f2988907a543'),(115,'craft','m181029_130000_add_transforms_routes_to_config','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','4fd82c10-0f65-42ac-b780-146595cb8f3e'),(116,'craft','m181112_203955_sequences_table','2021-02-28 19:57:15','2021-02-28 19:57:15','2021-02-28 19:57:15','719b447c-8273-4d0e-9364-9e4dfc348e94'),(117,'craft','m181121_001712_cleanup_field_configs','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','94af5d9f-9473-4b46-b8b8-900d31093279'),(118,'craft','m181128_193942_fix_project_config','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','0c31890f-7305-4248-be2a-d760aaa853c5'),(119,'craft','m181130_143040_fix_schema_version','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','6049f713-0346-4cea-be60-ad5594efb503'),(120,'craft','m181211_143040_fix_entry_type_uids','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','93bb4768-f717-40fd-abc4-7866ecd1fb7e'),(121,'craft','m181217_153000_fix_structure_uids','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','e25f695d-4ebe-4e31-ada5-110891fadf9c'),(122,'craft','m190104_152725_store_licensed_plugin_editions','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','b899f853-3d58-47a0-b1e4-9c6b325cce9a'),(123,'craft','m190108_110000_cleanup_project_config','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','e06b458b-7a8f-4ae8-84b3-26e4b68ab1fc'),(124,'craft','m190108_113000_asset_field_setting_change','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','078ee2cf-fbbf-4d55-9d50-ba109f646544'),(125,'craft','m190109_172845_fix_colspan','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','3ef01429-dcea-4f2f-aeb0-1acd0a406cf3'),(126,'craft','m190110_150000_prune_nonexisting_sites','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','acd761b5-a5ac-4ba8-b3b5-22c158a85912'),(127,'craft','m190110_214819_soft_delete_volumes','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','019b6f15-a8c1-4176-822c-3e2549c4fc1b'),(128,'craft','m190112_124737_fix_user_settings','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','d86c589e-ebd7-45da-955f-d7e6767f9fe9'),(129,'craft','m190112_131225_fix_field_layouts','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','83fef7a3-571a-47b5-817c-6cc12e7ac94b'),(130,'craft','m190112_201010_more_soft_deletes','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','5b7290e8-eca9-4422-a479-718a574f6ff4'),(131,'craft','m190114_143000_more_asset_field_setting_changes','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','2a8e02a0-856c-4ef2-8c0e-2c08948e71ff'),(132,'craft','m190121_120000_rich_text_config_setting','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','71e9403f-3046-4898-8c45-420b34b1aba3'),(133,'craft','m190125_191628_fix_email_transport_password','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','36b455fe-bfe3-435b-9738-ff7759bf9795'),(134,'craft','m190128_181422_cleanup_volume_folders','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','352969f4-e385-4db3-b128-f7f680a1e579'),(135,'craft','m190205_140000_fix_asset_soft_delete_index','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','0d5917b6-6479-4459-b376-769c7babc7be'),(136,'craft','m190218_143000_element_index_settings_uid','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','c0e36c24-f998-494c-a82e-4a811b869cac'),(137,'craft','m190312_152740_element_revisions','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','16c477e2-38cf-4452-9fd4-e6788a402a7f'),(138,'craft','m190327_235137_propagation_method','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','ee0a6cbb-a9ec-4af4-98e7-03b2607f2710'),(139,'craft','m190401_223843_drop_old_indexes','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','da9af096-ddd5-4498-96c2-ac7231c4d9be'),(140,'craft','m190416_014525_drop_unique_global_indexes','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','b315fb65-996e-41f5-8240-5be2537b5911'),(141,'craft','m190417_085010_add_image_editor_permissions','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','6606c75f-bb31-46a6-80c5-2df915a88add'),(142,'craft','m190502_122019_store_default_user_group_uid','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','dc0fdba2-b747-45ba-9d01-886100da0c68'),(143,'craft','m190504_150349_preview_targets','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','0ebea5ff-da19-4152-b6cc-a52d4cb2c811'),(144,'craft','m190516_184711_job_progress_label','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','2ddec332-92d0-4b39-8bda-656d4d912c67'),(145,'craft','m190523_190303_optional_revision_creators','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','55edf24a-102d-44b1-840a-263d362dc5bc'),(146,'craft','m190529_204501_fix_duplicate_uids','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','dfffad27-f100-4065-8e02-e748809a9f99'),(147,'craft','m190605_223807_unsaved_drafts','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','8b51b0f5-b84f-41dc-9633-eb92ee42a79a'),(148,'craft','m190607_230042_entry_revision_error_tables','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','34309005-5384-4b25-8dfe-582e68d1dd97'),(149,'craft','m190608_033429_drop_elements_uid_idx','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','61913c05-66c9-4fef-ad87-b6ab0d9a31f9'),(150,'craft','m190617_164400_add_gqlschemas_table','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','aaca62c9-a684-48b5-8792-f6d43799fd22'),(151,'craft','m190624_234204_matrix_propagation_method','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','1dfb35a4-8b36-4d85-b63f-00716db8c22f'),(152,'craft','m190711_153020_drop_snapshots','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','e52c4586-fe04-4f5f-8817-7e095f4b7c4f'),(153,'craft','m190712_195914_no_draft_revisions','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','8172fef0-087d-4c7c-87d3-5780f4115ae6'),(154,'craft','m190723_140314_fix_preview_targets_column','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','3d4886d6-d6c3-44d7-87bc-f97c1ff3492c'),(155,'craft','m190820_003519_flush_compiled_templates','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','14b7b42e-fe58-40b7-8571-f57fe8fb1e6e'),(156,'craft','m190823_020339_optional_draft_creators','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','6d621f6e-0239-444f-908c-82b4c5810580'),(157,'craft','m190913_152146_update_preview_targets','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','31aefdae-3b68-4c7e-81b4-1c707be89023'),(158,'craft','m191107_122000_add_gql_project_config_support','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','13dc0a6e-4857-45ac-b78f-58df26c24122'),(159,'craft','m191204_085100_pack_savable_component_settings','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','454a6ee2-c01c-4e39-aa1c-b9dc389bf0c9'),(160,'craft','m191206_001148_change_tracking','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','08891201-a059-452e-8e2d-51219722db91'),(161,'craft','m191216_191635_asset_upload_tracking','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','576d649b-a765-49b3-a9db-7f6112bd3f25'),(162,'craft','m191222_002848_peer_asset_permissions','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','e40396fa-ad6c-4466-a723-f16e23b45bd6'),(163,'craft','m200127_172522_queue_channels','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','83f7fc3d-7900-454f-a4d6-1a20d7088d40'),(164,'craft','m200211_175048_truncate_element_query_cache','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','cf97138a-e386-424f-a64e-086d9b1d9be0'),(165,'craft','m200213_172522_new_elements_index','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','9fd30871-30a7-4b8e-99f9-d7c6bb476a88'),(166,'craft','m200228_195211_long_deprecation_messages','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','aebae752-ea8c-432f-9d79-d58ef6f5f2fa'),(167,'craft','m200306_054652_disabled_sites','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','24700a5b-6abc-40f1-8ba0-3bbf7ef770b8'),(168,'craft','m200522_191453_clear_template_caches','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','b001ec5c-5ff2-4cc5-a5d0-2bcd2e11638b'),(169,'craft','m200606_231117_migration_tracks','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','0547bdf4-54f1-4dcd-84b2-a444281e639d'),(170,'craft','m200619_215137_title_translation_method','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','1d48246d-fd7a-4c1b-afda-a44bd9491792'),(171,'craft','m200620_005028_user_group_descriptions','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','f8c42f9c-cf89-4a55-b9bc-ca5b90a223f0'),(172,'craft','m200620_230205_field_layout_changes','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','338c2880-c0ef-46b9-befd-112e5141ecb3'),(173,'craft','m200625_131100_move_entrytypes_to_top_project_config','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','4218a452-6826-4702-8e8f-20903fa7c905'),(174,'craft','m200629_112700_remove_project_config_legacy_files','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','531027b5-f367-4e04-a1b2-a19539d52264'),(175,'craft','m200630_183000_drop_configmap','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','5fcc514a-53a8-4f3b-b751-b7f06e9ee7c5'),(176,'craft','m200715_113400_transform_index_error_flag','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','6a99cc4c-3dd4-4541-9cc9-8bef525682a6'),(177,'craft','m200716_110900_replace_file_asset_permissions','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','94cea4bb-ef51-472a-9109-74cb2e89690c'),(178,'craft','m200716_153800_public_token_settings_in_project_config','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','59fdf725-2a56-49d5-b6e4-04ec31985bf3'),(179,'craft','m200720_175543_drop_unique_constraints','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','1cad083d-622c-4417-80f0-3eae43e5dfbc'),(180,'craft','m200825_051217_project_config_version','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','9b1ea961-aad1-479c-8e53-5d852d114a78'),(181,'craft','m201116_190500_asset_title_translation_method','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','bba14174-ca2e-426c-af61-0428048e6f4d'),(182,'craft','m201124_003555_plugin_trials','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','ec119c65-89ba-431a-ac79-4aa6f1630e7b'),(183,'craft','m210209_135503_soft_delete_field_groups','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','edc1e7cf-72ad-4640-b5cc-35e23976bf66'),(184,'craft','m210212_223539_delete_invalid_drafts','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','f97c3e04-c25f-48f4-8870-01cfdb7f7cc9'),(185,'craft','m210214_202731_track_saved_drafts','2021-02-28 19:57:16','2021-02-28 19:57:16','2021-02-28 19:57:16','bddad4fe-b0b2-44c3-b86d-a4eeb006fca2'),(186,'content','m190212_225156_test_products','2021-02-28 19:57:44','2021-02-28 19:57:44','2021-02-28 19:57:44','b3b051b9-0fb4-4fcc-b32e-8ffba3227378'),(187,'content','m190526_215430_test_matrix_products','2021-02-28 19:57:45','2021-02-28 19:57:45','2021-02-28 19:57:45','d5e935f8-3dd4-4070-9c81-1e942bd3275c');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plugins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','trial','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_fwtuzanyzxnlsagyqoedfmgzxctuksopvssy` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
INSERT INTO `plugins` VALUES (1,'snipcart','1.5.1.1','1.0.10','unknown',NULL,'2021-02-28 19:57:13','2021-02-28 19:57:13','2021-02-28 19:57:13','70523a32-99e4-4f71-8c13-1bc97e007b37');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectconfig`
--

DROP TABLE IF EXISTS `projectconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `projectconfig` (
  `path` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectconfig`
--

LOCK TABLES `projectconfig` WRITE;
/*!40000 ALTER TABLE `projectconfig` DISABLE KEYS */;
INSERT INTO `projectconfig` VALUES ('dateModified','1614542235'),('email.fromEmail','\"engineering@fostercommerce.com\"'),('email.fromName','\"Snipcart Dev\"'),('email.transportType','\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.autocapitalize','true'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.autocomplete','false'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.autocorrect','true'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.class','null'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.disabled','false'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.id','null'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.instructions','null'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.label','null'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.max','null'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.min','null'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.name','null'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.orientation','null'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.placeholder','null'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.readonly','false'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.requirable','false'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.size','null'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.step','null'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.tip','null'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.title','null'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.warning','null'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.0.width','100'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.1.fieldUid','\"f7f5703c-a5d1-4ece-81f6-cd69aacba8cb\"'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.1.instructions','null'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.1.label','null'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.1.required','false'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.1.tip','null'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.1.warning','null'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.elements.1.width','100'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.name','\"Content\"'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.fieldLayouts.f4b7056c-37a5-4cfd-8100-2c32150ae1ab.tabs.0.sortOrder','1'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.handle','\"complexProducts\"'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.hasTitleField','true'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.name','\"Complex Products\"'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.section','\"8e737589-250f-4c64-baa3-bc9a444cb243\"'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.sortOrder','2'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.titleFormat','null'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.titleTranslationKeyFormat','null'),('entryTypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc.titleTranslationMethod','\"site\"'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.autocapitalize','true'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.autocomplete','false'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.autocorrect','true'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.class','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.disabled','false'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.id','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.instructions','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.label','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.max','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.min','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.name','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.orientation','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.placeholder','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.readonly','false'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.requirable','false'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.size','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.step','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.tip','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.title','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\EntryTitleField\"'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.warning','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.0.width','100'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.1.fieldUid','\"2eb8dccb-b22e-43c9-be2d-d3f76a3856c1\"'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.1.instructions','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.1.label','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.1.required','false'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.1.tip','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.1.warning','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.1.width','100'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.2.fieldUid','\"eff3417c-3955-4de7-a137-b7a99e365c5c\"'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.2.instructions','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.2.label','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.2.required','false'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.2.tip','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.2.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.2.warning','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.2.width','100'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.3.fieldUid','\"83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73\"'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.3.instructions','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.3.label','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.3.required','false'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.3.tip','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.3.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.3.warning','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.elements.3.width','100'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.name','\"Content\"'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.fieldLayouts.2f1f4698-bc5b-4efe-90d5-ee8186714f55.tabs.0.sortOrder','1'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.handle','\"products\"'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.hasTitleField','true'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.name','\"Products\"'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.section','\"8e737589-250f-4c64-baa3-bc9a444cb243\"'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.sortOrder','1'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.titleFormat','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.titleTranslationKeyFormat','null'),('entryTypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1.titleTranslationMethod','\"site\"'),('fieldGroups.8d3cabd4-1037-4e8e-8417-8b6361290ec6.name','\"Common\"'),('fields.2eb8dccb-b22e-43c9-be2d-d3f76a3856c1.contentColumnType','\"text\"'),('fields.2eb8dccb-b22e-43c9-be2d-d3f76a3856c1.fieldGroup','\"8d3cabd4-1037-4e8e-8417-8b6361290ec6\"'),('fields.2eb8dccb-b22e-43c9-be2d-d3f76a3856c1.handle','\"productDescription\"'),('fields.2eb8dccb-b22e-43c9-be2d-d3f76a3856c1.instructions','\"\"'),('fields.2eb8dccb-b22e-43c9-be2d-d3f76a3856c1.name','\"Product Description\"'),('fields.2eb8dccb-b22e-43c9-be2d-d3f76a3856c1.searchable','false'),('fields.2eb8dccb-b22e-43c9-be2d-d3f76a3856c1.settings.byteLimit','null'),('fields.2eb8dccb-b22e-43c9-be2d-d3f76a3856c1.settings.charLimit','null'),('fields.2eb8dccb-b22e-43c9-be2d-d3f76a3856c1.settings.code','\"\"'),('fields.2eb8dccb-b22e-43c9-be2d-d3f76a3856c1.settings.columnType','null'),('fields.2eb8dccb-b22e-43c9-be2d-d3f76a3856c1.settings.initialRows','\"4\"'),('fields.2eb8dccb-b22e-43c9-be2d-d3f76a3856c1.settings.multiline','\"\"'),('fields.2eb8dccb-b22e-43c9-be2d-d3f76a3856c1.settings.placeholder','\"\"'),('fields.2eb8dccb-b22e-43c9-be2d-d3f76a3856c1.settings.uiMode','\"normal\"'),('fields.2eb8dccb-b22e-43c9-be2d-d3f76a3856c1.translationKeyFormat','null'),('fields.2eb8dccb-b22e-43c9-be2d-d3f76a3856c1.translationMethod','\"none\"'),('fields.2eb8dccb-b22e-43c9-be2d-d3f76a3856c1.type','\"craft\\\\fields\\\\PlainText\"'),('fields.83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73.contentColumnType','\"string\"'),('fields.83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73.fieldGroup','\"8d3cabd4-1037-4e8e-8417-8b6361290ec6\"'),('fields.83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73.handle','\"productDetails\"'),('fields.83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73.instructions','\"\"'),('fields.83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73.name','\"Product Details\"'),('fields.83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73.searchable','false'),('fields.83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73.settings.defaultDimensionsUnit','\"centimeters\"'),('fields.83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73.settings.defaultHeight','\"\"'),('fields.83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73.settings.defaultLength','\"\"'),('fields.83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73.settings.defaultShippable','\"1\"'),('fields.83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73.settings.defaultTaxable','\"1\"'),('fields.83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73.settings.defaultWeight','\"\"'),('fields.83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73.settings.defaultWeightUnit','\"grams\"'),('fields.83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73.settings.defaultWidth','\"\"'),('fields.83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73.settings.displayInventory','\"1\"'),('fields.83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73.settings.displayShippableSwitch','\"1\"'),('fields.83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73.settings.displayTaxableSwitch','\"1\"'),('fields.83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73.settings.skuDefault','\"\"'),('fields.83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73.translationKeyFormat','null'),('fields.83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73.translationMethod','\"none\"'),('fields.83ea9cdc-c4be-4c53-b40f-1d1e75f9ff73.type','\"fostercommerce\\\\snipcart\\\\fields\\\\ProductDetails\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.contentColumnType','\"text\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.fieldGroup','\"8d3cabd4-1037-4e8e-8417-8b6361290ec6\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.handle','\"productOptions\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.instructions','\"\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.name','\"Product Options\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.searchable','false'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.addRowLabel','\"Add a row\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.columns.__assoc__.0.0','\"col1\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.columns.__assoc__.0.1.__assoc__.0.0','\"heading\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.columns.__assoc__.0.1.__assoc__.0.1','\"Option\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.columns.__assoc__.0.1.__assoc__.1.0','\"handle\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.columns.__assoc__.0.1.__assoc__.1.1','\"name\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.columns.__assoc__.0.1.__assoc__.2.0','\"width\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.columns.__assoc__.0.1.__assoc__.2.1','\"\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.columns.__assoc__.0.1.__assoc__.3.0','\"type\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.columns.__assoc__.0.1.__assoc__.3.1','\"singleline\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.columns.__assoc__.1.0','\"col2\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.columns.__assoc__.1.1.__assoc__.0.0','\"heading\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.columns.__assoc__.1.1.__assoc__.0.1','\"Value\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.columns.__assoc__.1.1.__assoc__.1.0','\"handle\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.columns.__assoc__.1.1.__assoc__.1.1','\"price\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.columns.__assoc__.1.1.__assoc__.2.0','\"width\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.columns.__assoc__.1.1.__assoc__.2.1','\"\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.columns.__assoc__.1.1.__assoc__.3.0','\"type\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.columns.__assoc__.1.1.__assoc__.3.1','\"singleline\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.columnType','\"text\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.defaults.0.__assoc__.0.0','\"col1\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.defaults.0.__assoc__.0.1','\"\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.defaults.0.__assoc__.1.0','\"col2\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.defaults.0.__assoc__.1.1','\"\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.maxRows','\"\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.settings.minRows','\"\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.translationKeyFormat','null'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.translationMethod','\"none\"'),('fields.eff3417c-3955-4de7-a137-b7a99e365c5c.type','\"craft\\\\fields\\\\Table\"'),('fields.f7f5703c-a5d1-4ece-81f6-cd69aacba8cb.contentColumnType','\"string\"'),('fields.f7f5703c-a5d1-4ece-81f6-cd69aacba8cb.fieldGroup','\"8d3cabd4-1037-4e8e-8417-8b6361290ec6\"'),('fields.f7f5703c-a5d1-4ece-81f6-cd69aacba8cb.handle','\"pageBlocks\"'),('fields.f7f5703c-a5d1-4ece-81f6-cd69aacba8cb.instructions','\"\"'),('fields.f7f5703c-a5d1-4ece-81f6-cd69aacba8cb.name','\"Page Blocks\"'),('fields.f7f5703c-a5d1-4ece-81f6-cd69aacba8cb.searchable','false'),('fields.f7f5703c-a5d1-4ece-81f6-cd69aacba8cb.settings.contentTable','\"{{%matrixcontent_pageblocks}}\"'),('fields.f7f5703c-a5d1-4ece-81f6-cd69aacba8cb.settings.maxBlocks','\"\"'),('fields.f7f5703c-a5d1-4ece-81f6-cd69aacba8cb.settings.minBlocks','\"\"'),('fields.f7f5703c-a5d1-4ece-81f6-cd69aacba8cb.settings.propagationMethod','\"all\"'),('fields.f7f5703c-a5d1-4ece-81f6-cd69aacba8cb.translationKeyFormat','null'),('fields.f7f5703c-a5d1-4ece-81f6-cd69aacba8cb.translationMethod','\"site\"'),('fields.f7f5703c-a5d1-4ece-81f6-cd69aacba8cb.type','\"craft\\\\fields\\\\Matrix\"'),('graphql.publicToken.enabled','false'),('graphql.publicToken.expiryDate','null'),('graphql.schemas.ce2b6eb1-d61e-44e6-bd0b-dce122ce1433.isPublic','true'),('graphql.schemas.ce2b6eb1-d61e-44e6-bd0b-dce122ce1433.name','\"Public Schema\"'),('graphql.schemas.ce2b6eb1-d61e-44e6-bd0b-dce122ce1433.scope.0','\"sections.8e737589-250f-4c64-baa3-bc9a444cb243:read\"'),('graphql.schemas.ce2b6eb1-d61e-44e6-bd0b-dce122ce1433.scope.1','\"entrytypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1:read\"'),('graphql.schemas.ce2b6eb1-d61e-44e6-bd0b-dce122ce1433.scope.2','\"entrytypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc:read\"'),('graphql.schemas.e8ef8494-36a9-4ecc-b0b8-33bdc34343ae.isPublic','false'),('graphql.schemas.e8ef8494-36a9-4ecc-b0b8-33bdc34343ae.name','\"Dev Schema\"'),('graphql.schemas.e8ef8494-36a9-4ecc-b0b8-33bdc34343ae.scope.0','\"sections.8e737589-250f-4c64-baa3-bc9a444cb243:read\"'),('graphql.schemas.e8ef8494-36a9-4ecc-b0b8-33bdc34343ae.scope.1','\"entrytypes.e0433a5c-bd50-4ba7-9d0c-ed1873de08c1:read\"'),('graphql.schemas.e8ef8494-36a9-4ecc-b0b8-33bdc34343ae.scope.2','\"entrytypes.047ec4b6-3ea6-4bbd-83bd-6af055a3a7cc:read\"'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.field','\"f7f5703c-a5d1-4ece-81f6-cd69aacba8cb\"'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fieldLayouts.b8ebab1f-4c19-49a3-b626-7262a082aecd.tabs.0.elements.0.fieldUid','\"6884bf14-6cfc-4f23-ac2f-3702687f8602\"'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fieldLayouts.b8ebab1f-4c19-49a3-b626-7262a082aecd.tabs.0.elements.0.instructions','null'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fieldLayouts.b8ebab1f-4c19-49a3-b626-7262a082aecd.tabs.0.elements.0.label','null'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fieldLayouts.b8ebab1f-4c19-49a3-b626-7262a082aecd.tabs.0.elements.0.required','false'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fieldLayouts.b8ebab1f-4c19-49a3-b626-7262a082aecd.tabs.0.elements.0.tip','null'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fieldLayouts.b8ebab1f-4c19-49a3-b626-7262a082aecd.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fieldLayouts.b8ebab1f-4c19-49a3-b626-7262a082aecd.tabs.0.elements.0.warning','null'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fieldLayouts.b8ebab1f-4c19-49a3-b626-7262a082aecd.tabs.0.elements.0.width','100'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fieldLayouts.b8ebab1f-4c19-49a3-b626-7262a082aecd.tabs.0.name','\"Content\"'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fieldLayouts.b8ebab1f-4c19-49a3-b626-7262a082aecd.tabs.0.sortOrder','1'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fields.6884bf14-6cfc-4f23-ac2f-3702687f8602.contentColumnType','\"text\"'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fields.6884bf14-6cfc-4f23-ac2f-3702687f8602.fieldGroup','null'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fields.6884bf14-6cfc-4f23-ac2f-3702687f8602.handle','\"heading\"'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fields.6884bf14-6cfc-4f23-ac2f-3702687f8602.instructions','\"\"'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fields.6884bf14-6cfc-4f23-ac2f-3702687f8602.name','\"Heading\"'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fields.6884bf14-6cfc-4f23-ac2f-3702687f8602.searchable','false'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fields.6884bf14-6cfc-4f23-ac2f-3702687f8602.settings.byteLimit','null'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fields.6884bf14-6cfc-4f23-ac2f-3702687f8602.settings.charLimit','null'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fields.6884bf14-6cfc-4f23-ac2f-3702687f8602.settings.code','\"\"'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fields.6884bf14-6cfc-4f23-ac2f-3702687f8602.settings.columnType','null'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fields.6884bf14-6cfc-4f23-ac2f-3702687f8602.settings.initialRows','\"4\"'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fields.6884bf14-6cfc-4f23-ac2f-3702687f8602.settings.multiline','\"\"'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fields.6884bf14-6cfc-4f23-ac2f-3702687f8602.settings.placeholder','\"\"'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fields.6884bf14-6cfc-4f23-ac2f-3702687f8602.settings.uiMode','\"normal\"'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fields.6884bf14-6cfc-4f23-ac2f-3702687f8602.translationKeyFormat','null'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fields.6884bf14-6cfc-4f23-ac2f-3702687f8602.translationMethod','\"none\"'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.fields.6884bf14-6cfc-4f23-ac2f-3702687f8602.type','\"craft\\\\fields\\\\PlainText\"'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.handle','\"heading\"'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.name','\"Heading\"'),('matrixBlockTypes.a4e5c444-dfe0-4cc9-81d2-385dca72e446.sortOrder','1'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.field','\"f7f5703c-a5d1-4ece-81f6-cd69aacba8cb\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fieldLayouts.4461f21f-abb8-4816-8013-0f3970460f78.tabs.0.elements.0.fieldUid','\"c7fd47c1-7147-466b-9710-16b4d5d9c0e2\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fieldLayouts.4461f21f-abb8-4816-8013-0f3970460f78.tabs.0.elements.0.instructions','null'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fieldLayouts.4461f21f-abb8-4816-8013-0f3970460f78.tabs.0.elements.0.label','null'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fieldLayouts.4461f21f-abb8-4816-8013-0f3970460f78.tabs.0.elements.0.required','false'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fieldLayouts.4461f21f-abb8-4816-8013-0f3970460f78.tabs.0.elements.0.tip','null'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fieldLayouts.4461f21f-abb8-4816-8013-0f3970460f78.tabs.0.elements.0.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fieldLayouts.4461f21f-abb8-4816-8013-0f3970460f78.tabs.0.elements.0.warning','null'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fieldLayouts.4461f21f-abb8-4816-8013-0f3970460f78.tabs.0.elements.0.width','100'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fieldLayouts.4461f21f-abb8-4816-8013-0f3970460f78.tabs.0.elements.1.fieldUid','\"97134205-e4b8-4169-a51b-ca23329ec35a\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fieldLayouts.4461f21f-abb8-4816-8013-0f3970460f78.tabs.0.elements.1.instructions','null'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fieldLayouts.4461f21f-abb8-4816-8013-0f3970460f78.tabs.0.elements.1.label','null'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fieldLayouts.4461f21f-abb8-4816-8013-0f3970460f78.tabs.0.elements.1.required','false'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fieldLayouts.4461f21f-abb8-4816-8013-0f3970460f78.tabs.0.elements.1.tip','null'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fieldLayouts.4461f21f-abb8-4816-8013-0f3970460f78.tabs.0.elements.1.type','\"craft\\\\fieldlayoutelements\\\\CustomField\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fieldLayouts.4461f21f-abb8-4816-8013-0f3970460f78.tabs.0.elements.1.warning','null'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fieldLayouts.4461f21f-abb8-4816-8013-0f3970460f78.tabs.0.elements.1.width','100'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fieldLayouts.4461f21f-abb8-4816-8013-0f3970460f78.tabs.0.name','\"Content\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fieldLayouts.4461f21f-abb8-4816-8013-0f3970460f78.tabs.0.sortOrder','1'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.97134205-e4b8-4169-a51b-ca23329ec35a.contentColumnType','\"string\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.97134205-e4b8-4169-a51b-ca23329ec35a.fieldGroup','null'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.97134205-e4b8-4169-a51b-ca23329ec35a.handle','\"productInfo\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.97134205-e4b8-4169-a51b-ca23329ec35a.instructions','\"\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.97134205-e4b8-4169-a51b-ca23329ec35a.name','\"Product Info\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.97134205-e4b8-4169-a51b-ca23329ec35a.searchable','false'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.97134205-e4b8-4169-a51b-ca23329ec35a.settings.defaultDimensionsUnit','\"centimeters\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.97134205-e4b8-4169-a51b-ca23329ec35a.settings.defaultHeight','\"\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.97134205-e4b8-4169-a51b-ca23329ec35a.settings.defaultLength','\"\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.97134205-e4b8-4169-a51b-ca23329ec35a.settings.defaultShippable','\"1\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.97134205-e4b8-4169-a51b-ca23329ec35a.settings.defaultTaxable','\"1\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.97134205-e4b8-4169-a51b-ca23329ec35a.settings.defaultWeight','\"\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.97134205-e4b8-4169-a51b-ca23329ec35a.settings.defaultWeightUnit','\"grams\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.97134205-e4b8-4169-a51b-ca23329ec35a.settings.defaultWidth','\"\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.97134205-e4b8-4169-a51b-ca23329ec35a.settings.displayInventory','\"1\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.97134205-e4b8-4169-a51b-ca23329ec35a.settings.displayShippableSwitch','\"1\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.97134205-e4b8-4169-a51b-ca23329ec35a.settings.displayTaxableSwitch','\"1\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.97134205-e4b8-4169-a51b-ca23329ec35a.settings.skuDefault','\"\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.97134205-e4b8-4169-a51b-ca23329ec35a.translationKeyFormat','null'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.97134205-e4b8-4169-a51b-ca23329ec35a.translationMethod','\"none\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.97134205-e4b8-4169-a51b-ca23329ec35a.type','\"fostercommerce\\\\snipcart\\\\fields\\\\ProductDetails\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.c7fd47c1-7147-466b-9710-16b4d5d9c0e2.contentColumnType','\"text\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.c7fd47c1-7147-466b-9710-16b4d5d9c0e2.fieldGroup','null'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.c7fd47c1-7147-466b-9710-16b4d5d9c0e2.handle','\"productName\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.c7fd47c1-7147-466b-9710-16b4d5d9c0e2.instructions','\"\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.c7fd47c1-7147-466b-9710-16b4d5d9c0e2.name','\"Product Name\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.c7fd47c1-7147-466b-9710-16b4d5d9c0e2.searchable','false'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.c7fd47c1-7147-466b-9710-16b4d5d9c0e2.settings.byteLimit','null'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.c7fd47c1-7147-466b-9710-16b4d5d9c0e2.settings.charLimit','null'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.c7fd47c1-7147-466b-9710-16b4d5d9c0e2.settings.code','\"\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.c7fd47c1-7147-466b-9710-16b4d5d9c0e2.settings.columnType','null'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.c7fd47c1-7147-466b-9710-16b4d5d9c0e2.settings.initialRows','\"4\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.c7fd47c1-7147-466b-9710-16b4d5d9c0e2.settings.multiline','\"\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.c7fd47c1-7147-466b-9710-16b4d5d9c0e2.settings.placeholder','\"\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.c7fd47c1-7147-466b-9710-16b4d5d9c0e2.settings.uiMode','\"normal\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.c7fd47c1-7147-466b-9710-16b4d5d9c0e2.translationKeyFormat','null'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.c7fd47c1-7147-466b-9710-16b4d5d9c0e2.translationMethod','\"none\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.fields.c7fd47c1-7147-466b-9710-16b4d5d9c0e2.type','\"craft\\\\fields\\\\PlainText\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.handle','\"product\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.name','\"Product\"'),('matrixBlockTypes.db133a46-b847-4150-a31b-741c83c342a5.sortOrder','2'),('plugins.snipcart.edition','\"standard\"'),('plugins.snipcart.enabled','true'),('plugins.snipcart.licenseKey','\"MQ3MAC5BAFX41SCC90KZ4POD\"'),('plugins.snipcart.schemaVersion','\"1.0.10\"'),('plugins.snipcart.settings.cacheDurationLimit','\"300\"'),('plugins.snipcart.settings.cacheResponses','\"\"'),('plugins.snipcart.settings.customerNotificationEmailTemplate','\"\"'),('plugins.snipcart.settings.defaultCurrency','\"usd\"'),('plugins.snipcart.settings.enabledCurrencies.0','\"usd\"'),('plugins.snipcart.settings.logCustomRates','\"\"'),('plugins.snipcart.settings.logWebhookRequests','\"\"'),('plugins.snipcart.settings.notificationEmails','\"\"'),('plugins.snipcart.settings.notificationEmailTemplate','\"\"'),('plugins.snipcart.settings.orderCommentsFieldName','\"\"'),('plugins.snipcart.settings.orderGiftNoteFieldName','\"\"'),('plugins.snipcart.settings.providerSettings.__assoc__.0.0','\"shipStation\"'),('plugins.snipcart.settings.providerSettings.__assoc__.0.1.__assoc__.0.0','\"apiKey\"'),('plugins.snipcart.settings.providerSettings.__assoc__.0.1.__assoc__.0.1','\"\"'),('plugins.snipcart.settings.providerSettings.__assoc__.0.1.__assoc__.1.0','\"apiSecret\"'),('plugins.snipcart.settings.providerSettings.__assoc__.0.1.__assoc__.1.1','\"\"'),('plugins.snipcart.settings.providerSettings.__assoc__.0.1.__assoc__.2.0','\"defaultCarrierCode\"'),('plugins.snipcart.settings.providerSettings.__assoc__.0.1.__assoc__.2.1','\"\"'),('plugins.snipcart.settings.providerSettings.__assoc__.0.1.__assoc__.3.0','\"defaultPackageCode\"'),('plugins.snipcart.settings.providerSettings.__assoc__.0.1.__assoc__.3.1','\"\"'),('plugins.snipcart.settings.providerSettings.__assoc__.0.1.__assoc__.4.0','\"defaultCountry\"'),('plugins.snipcart.settings.providerSettings.__assoc__.0.1.__assoc__.4.1','\"\"'),('plugins.snipcart.settings.providerSettings.__assoc__.0.1.__assoc__.5.0','\"defaultOrderConfirmation\"'),('plugins.snipcart.settings.providerSettings.__assoc__.0.1.__assoc__.5.1','\"none\"'),('plugins.snipcart.settings.providerSettings.__assoc__.0.1.__assoc__.6.0','\"defaultWarehouseId\"'),('plugins.snipcart.settings.providerSettings.__assoc__.0.1.__assoc__.6.1','\"\"'),('plugins.snipcart.settings.providerSettings.__assoc__.0.1.__assoc__.7.0','\"enableShippingRates\"'),('plugins.snipcart.settings.providerSettings.__assoc__.0.1.__assoc__.7.1','\"\"'),('plugins.snipcart.settings.providerSettings.__assoc__.0.1.__assoc__.8.0','\"sendCompletedOrders\"'),('plugins.snipcart.settings.providerSettings.__assoc__.0.1.__assoc__.8.1','\"\"'),('plugins.snipcart.settings.publicApiKey','\"$SNIPCART_PUBLIC_API_KEY\"'),('plugins.snipcart.settings.publicTestApiKey','\"$SNIPCART_PUBLIC_API_KEY\"'),('plugins.snipcart.settings.reduceQuantitiesOnOrder','\"\"'),('plugins.snipcart.settings.reFeedAttemptWindow','15'),('plugins.snipcart.settings.secretApiKey','\"$SNIPCART_SECRET_API_KEY\"'),('plugins.snipcart.settings.secretTestApiKey','\"$SNIPCART_SECRET_API_KEY\"'),('plugins.snipcart.settings.sendCustomerOrderNotificationEmail','\"\"'),('plugins.snipcart.settings.sendOrderNotificationEmail','\"\"'),('plugins.snipcart.settings.sendTestModeEmail','\"\"'),('plugins.snipcart.settings.shipFromAddress.__assoc__.0.0','\"name\"'),('plugins.snipcart.settings.shipFromAddress.__assoc__.0.1','\"\"'),('plugins.snipcart.settings.shipFromAddress.__assoc__.1.0','\"companyName\"'),('plugins.snipcart.settings.shipFromAddress.__assoc__.1.1','\"\"'),('plugins.snipcart.settings.shipFromAddress.__assoc__.2.0','\"address1\"'),('plugins.snipcart.settings.shipFromAddress.__assoc__.2.1','\"\"'),('plugins.snipcart.settings.shipFromAddress.__assoc__.3.0','\"address2\"'),('plugins.snipcart.settings.shipFromAddress.__assoc__.3.1','\"\"'),('plugins.snipcart.settings.shipFromAddress.__assoc__.4.0','\"city\"'),('plugins.snipcart.settings.shipFromAddress.__assoc__.4.1','\"\"'),('plugins.snipcart.settings.shipFromAddress.__assoc__.5.0','\"province\"'),('plugins.snipcart.settings.shipFromAddress.__assoc__.5.1','\"\"'),('plugins.snipcart.settings.shipFromAddress.__assoc__.6.0','\"postalCode\"'),('plugins.snipcart.settings.shipFromAddress.__assoc__.6.1','\"\"'),('plugins.snipcart.settings.shipFromAddress.__assoc__.7.0','\"country\"'),('plugins.snipcart.settings.shipFromAddress.__assoc__.7.1','\"\"'),('plugins.snipcart.settings.shipFromAddress.__assoc__.8.0','\"phone\"'),('plugins.snipcart.settings.shipFromAddress.__assoc__.8.1','\"\"'),('plugins.snipcart.settings.shipFromAddress.__assoc__.9.0','\"email\"'),('plugins.snipcart.settings.shipFromAddress.__assoc__.9.1','\"\"'),('plugins.snipcart.settings.testMode','\"1\"'),('sections.8e737589-250f-4c64-baa3-bc9a444cb243.enableVersioning','true'),('sections.8e737589-250f-4c64-baa3-bc9a444cb243.handle','\"products\"'),('sections.8e737589-250f-4c64-baa3-bc9a444cb243.name','\"Products\"'),('sections.8e737589-250f-4c64-baa3-bc9a444cb243.previewTargets.0.__assoc__.0.0','\"label\"'),('sections.8e737589-250f-4c64-baa3-bc9a444cb243.previewTargets.0.__assoc__.0.1','\"Primary entry page\"'),('sections.8e737589-250f-4c64-baa3-bc9a444cb243.previewTargets.0.__assoc__.1.0','\"urlFormat\"'),('sections.8e737589-250f-4c64-baa3-bc9a444cb243.previewTargets.0.__assoc__.1.1','\"{url}\"'),('sections.8e737589-250f-4c64-baa3-bc9a444cb243.previewTargets.0.__assoc__.2.0','\"refresh\"'),('sections.8e737589-250f-4c64-baa3-bc9a444cb243.previewTargets.0.__assoc__.2.1','\"1\"'),('sections.8e737589-250f-4c64-baa3-bc9a444cb243.propagationMethod','\"none\"'),('sections.8e737589-250f-4c64-baa3-bc9a444cb243.siteSettings.280fceb8-a5d2-4c0b-9ee5-1ab5d6de749b.enabledByDefault','true'),('sections.8e737589-250f-4c64-baa3-bc9a444cb243.siteSettings.280fceb8-a5d2-4c0b-9ee5-1ab5d6de749b.hasUrls','true'),('sections.8e737589-250f-4c64-baa3-bc9a444cb243.siteSettings.280fceb8-a5d2-4c0b-9ee5-1ab5d6de749b.template','\"products/_entry\"'),('sections.8e737589-250f-4c64-baa3-bc9a444cb243.siteSettings.280fceb8-a5d2-4c0b-9ee5-1ab5d6de749b.uriFormat','\"other/products/{slug}\"'),('sections.8e737589-250f-4c64-baa3-bc9a444cb243.siteSettings.353b994a-9997-4f98-b31f-a963cf7671f8.enabledByDefault','true'),('sections.8e737589-250f-4c64-baa3-bc9a444cb243.siteSettings.353b994a-9997-4f98-b31f-a963cf7671f8.hasUrls','true'),('sections.8e737589-250f-4c64-baa3-bc9a444cb243.siteSettings.353b994a-9997-4f98-b31f-a963cf7671f8.template','\"products/_entry\"'),('sections.8e737589-250f-4c64-baa3-bc9a444cb243.siteSettings.353b994a-9997-4f98-b31f-a963cf7671f8.uriFormat','\"products/{slug}\"'),('sections.8e737589-250f-4c64-baa3-bc9a444cb243.type','\"channel\"'),('siteGroups.7c59e003-25ea-4bac-9467-fb0ebd1b9cf6.name','\"Snipcart Dev\"'),('sites.280fceb8-a5d2-4c0b-9ee5-1ab5d6de749b.baseUrl','null'),('sites.280fceb8-a5d2-4c0b-9ee5-1ab5d6de749b.enabled','true'),('sites.280fceb8-a5d2-4c0b-9ee5-1ab5d6de749b.handle','\"snipcartDevOtherSite\"'),('sites.280fceb8-a5d2-4c0b-9ee5-1ab5d6de749b.hasUrls','false'),('sites.280fceb8-a5d2-4c0b-9ee5-1ab5d6de749b.language','\"en-US\"'),('sites.280fceb8-a5d2-4c0b-9ee5-1ab5d6de749b.name','\"Snipcart Dev Other Site\"'),('sites.280fceb8-a5d2-4c0b-9ee5-1ab5d6de749b.primary','false'),('sites.280fceb8-a5d2-4c0b-9ee5-1ab5d6de749b.siteGroup','\"7c59e003-25ea-4bac-9467-fb0ebd1b9cf6\"'),('sites.280fceb8-a5d2-4c0b-9ee5-1ab5d6de749b.sortOrder','2'),('sites.353b994a-9997-4f98-b31f-a963cf7671f8.baseUrl','\"$PRIMARY_SITE_URL\"'),('sites.353b994a-9997-4f98-b31f-a963cf7671f8.enabled','true'),('sites.353b994a-9997-4f98-b31f-a963cf7671f8.handle','\"default\"'),('sites.353b994a-9997-4f98-b31f-a963cf7671f8.hasUrls','true'),('sites.353b994a-9997-4f98-b31f-a963cf7671f8.language','\"en-US\"'),('sites.353b994a-9997-4f98-b31f-a963cf7671f8.name','\"Snipcart Dev\"'),('sites.353b994a-9997-4f98-b31f-a963cf7671f8.primary','true'),('sites.353b994a-9997-4f98-b31f-a963cf7671f8.siteGroup','\"7c59e003-25ea-4bac-9467-fb0ebd1b9cf6\"'),('sites.353b994a-9997-4f98-b31f-a963cf7671f8.sortOrder','1'),('system.edition','\"pro\"'),('system.live','true'),('system.name','\"Snipcart Dev\"'),('system.schemaVersion','\"3.6.4\"'),('system.timeZone','\"America/Los_Angeles\"'),('users.allowPublicRegistration','false'),('users.defaultGroup','null'),('users.photoSubpath','null'),('users.photoVolumeUid','null'),('users.requireEmailVerification','true');
/*!40000 ALTER TABLE `projectconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `queue` (
  `id` int NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int NOT NULL,
  `ttr` int NOT NULL,
  `delay` int NOT NULL DEFAULT '0',
  `priority` int unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int DEFAULT NULL,
  `progress` smallint NOT NULL DEFAULT '0',
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `idx_bawdygjnbqtsvussibtjtjkhspqewmyoyiud` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `idx_lnwyoxdrfszudmguqxintnamzjmlaciqpjtk` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relations`
--

DROP TABLE IF EXISTS `relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldId` int NOT NULL,
  `sourceId` int NOT NULL,
  `sourceSiteId` int DEFAULT NULL,
  `targetId` int NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_zempztarpfuwszqswdkprvhdffotahicmmvh` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `idx_hizsusxydmqdccfrsfbceasowrusxwsssubd` (`sourceId`),
  KEY `idx_sqewynprrzklxoradppwwglulutbtvulzzfl` (`targetId`),
  KEY `idx_ewyfctnwegilgzyzzhhewvwuhzdajyttclme` (`sourceSiteId`),
  CONSTRAINT `fk_ebgkdapbnoiaccukizuaftizlbvikummscfj` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_puutsjgoxmudmwzjwjalybnrjeywkegutesl` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_rwoyyffnqpnizhwinysrozgzdgroxfnkihys` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_zepctofffuxjgbkfmwdlqxnlyyjspjlpptgr` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resourcepaths`
--

DROP TABLE IF EXISTS `resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resourcepaths`
--

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;
INSERT INTO `resourcepaths` VALUES ('11757db','@craft/web/assets/dashboard/dist'),('1a1054a8','@craft/web/assets/edituser/dist'),('24685786','@bower/jquery/dist'),('29c00f13','@lib/jquery.payment'),('35e7a0fb','@lib/velocity'),('47414c54','@craft/web/assets/craftsupport/dist'),('4f47fb99','@craft/web/assets/login/dist'),('71997b17','@lib/axios'),('78547110','@craft/web/assets/feed/dist'),('7b4e3b5e','@lib/jquery-ui'),('809c88e8','@lib/fabric'),('95da5cd6','@lib/garnishjs'),('a20e8d4c','@craft/web/assets/userpermissions/dist'),('a6674b50','@lib/d3'),('a8c26b01','@lib/picturefill'),('af6657c3','@lib/jquery-touch-events'),('b02a6aff','@lib/fileupload'),('bc8955e8','@lib/iframe-resizer'),('bf8fc73','@lib/element-resize-detector'),('de57f833','@craft/web/assets/recententries/dist'),('e0edba5d','@craft/web/assets/updateswidget/dist'),('f6d0020f','@lib/xregexp'),('fa9363cc','@craft/web/assets/cp/dist'),('fcbc4685','@lib/selectize');
/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `revisions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sourceId` int NOT NULL,
  `creatorId` int DEFAULT NULL,
  `num` int NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_nhaiatqpcitbuptujyhspcmtbrjqnwmtgsih` (`sourceId`,`num`),
  KEY `fk_jcjofcaizqjfrusmkytjmisxteipygtgtaol` (`creatorId`),
  CONSTRAINT `fk_anljpeclfyopfaewroluuevturadofmaxidp` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_jcjofcaizqjfrusmkytjmisxteipygtgtaol` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
INSERT INTO `revisions` VALUES (1,2,NULL,1,NULL),(2,4,NULL,1,NULL),(3,6,NULL,1,NULL),(4,8,NULL,1,NULL),(5,10,NULL,1,NULL),(6,12,NULL,1,NULL),(7,14,NULL,1,NULL),(8,16,NULL,1,NULL),(9,18,NULL,1,NULL),(10,20,NULL,1,NULL);
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `searchindex` (
  `elementId` int NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int NOT NULL,
  `siteId` int NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `idx_fusrdzonyghcwwdcebdsvuupajksoxsklain` (`keywords`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
INSERT INTO `searchindex` VALUES (1,'email',0,2,' engineering fostercommerce com '),(1,'firstname',0,2,''),(1,'fullname',0,2,''),(1,'lastname',0,2,''),(1,'slug',0,2,''),(1,'username',0,2,' engineering fostercommerce com '),(2,'slug',0,2,' infinity gauntlet '),(2,'title',0,2,' infinity gauntlet '),(4,'slug',0,2,' lembas bread '),(4,'title',0,2,' lembas bread '),(6,'slug',0,2,' dragon egg '),(6,'title',0,2,' dragon egg '),(8,'slug',0,2,' dark matter '),(8,'title',0,2,' dark matter '),(10,'slug',0,2,' oathkeeper '),(10,'title',0,2,' oathkeeper '),(12,'slug',0,2,' hand of king brooch '),(12,'title',0,2,' hand of the king brooch '),(14,'slug',0,2,' laser sword '),(14,'title',0,2,' laser sword '),(16,'slug',0,2,' elemental stone '),(16,'title',0,2,' elemental stones '),(18,'slug',0,2,' glow pole umbrella '),(18,'title',0,2,' glow pole umbrella '),(20,'slug',0,2,' spa packages '),(20,'title',0,2,' spa packages '),(21,'slug',0,2,''),(22,'slug',0,2,''),(23,'slug',0,2,''),(25,'slug',0,2,''),(26,'slug',0,2,''),(27,'slug',0,2,'');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_kfgzvyprrbfwdsqwdrzvijfzxfjtfmosiltk` (`handle`),
  KEY `idx_pcoftydgoifjxlvpibyfhjhwnnxocgptjgzn` (`name`),
  KEY `idx_oxjijkqfrtvkqkjmixyqadegeqovvdplikbw` (`structureId`),
  KEY `idx_yspubifugkghlzclkcjljindammmjgazvgwp` (`dateDeleted`),
  CONSTRAINT `fk_dcyxamsujjseegfccapkhpsepnxdbgbjximr` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (1,NULL,'Products','products','channel',1,'none','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\",\"refresh\":\"1\"}]','2021-02-28 19:57:14','2021-02-28 19:57:14',NULL,'8e737589-250f-4c64-baa3-bc9a444cb243');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sections_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sectionId` int NOT NULL,
  `siteId` int NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_drmplylecyfjfgmfuubhbcurwgfksehblchw` (`sectionId`,`siteId`),
  KEY `idx_awzkwkncsrykaxildhvxublvdqttklqbbgoe` (`siteId`),
  CONSTRAINT `fk_kjtuezsvfvnrovrxqesasbepcnmqarpdxjji` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rppsqbinxoygxoyzgtwyttkhbspmdgregsnu` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
INSERT INTO `sections_sites` VALUES (1,1,1,1,'other/products/{slug}','products/_entry',1,'2021-02-28 19:57:14','2021-02-28 19:57:14','6f66a25c-cc06-49b6-abb4-a536515cd7d0'),(2,1,2,1,'products/{slug}','products/_entry',1,'2021-02-28 19:57:14','2021-02-28 19:57:14','9e11af94-f56a-4dbf-abb3-fc5a7b5f2d42');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_wbcpbeuvfqvpalmqvxujrkkduajgymknmbtg` (`uid`),
  KEY `idx_jpjavxqqauqxjkxqifddjlpjtvvcjhavwish` (`token`),
  KEY `idx_mcombkkimaycgzrkporsxynytxdoesqozrev` (`dateUpdated`),
  KEY `idx_vdibtcaivfhkeezzlcllzvmvwsepwlmacqzf` (`userId`),
  CONSTRAINT `fk_ljbmrevsmhnwdkfgzmbqrxouynlpscgqliun` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (4,1,'BLCUvfdYhgbnFfrjISaVCqoKxlCcX7NdhehywPZyp97lMGITQ1igW_YSYSjJwANKJD-usgO9Hew-jFysvnmKsRrFSqF7Rl4gM3ap','2021-02-28 19:59:10','2021-02-28 19:59:13','3ff0e353-67ac-4dbf-bad3-a878c29fa815');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shunnedmessages`
--

DROP TABLE IF EXISTS `shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shunnedmessages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ezfcsigcfctifvxaxrjljchfuztzymdxmlwh` (`userId`,`message`),
  CONSTRAINT `fk_vcuytoanpkllxeivutfqyizsztvefhrxztmn` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sitegroups`
--

DROP TABLE IF EXISTS `sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sitegroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_iwujxinhiliwnvzimdrkkrlcmomxcgbhstuv` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
INSERT INTO `sitegroups` VALUES (1,'Snipcart Dev','2021-02-28 19:57:13','2021-02-28 19:57:13',NULL,'7c59e003-25ea-4bac-9467-fb0ebd1b9cf6');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_glpwndwqfxbvgcpykyuvrecszgfooqwsjxaw` (`dateDeleted`),
  KEY `idx_hnmsiwakaggldxmnjuylfwlsblkjnidqpmxg` (`handle`),
  KEY `idx_zjphcwupflecahtdgjxxhkqfueqihixipzyw` (`sortOrder`),
  KEY `fk_exqffvfuocebwloxcudlnrrxnoxiuphibnue` (`groupId`),
  CONSTRAINT `fk_exqffvfuocebwloxcudlnrrxnoxiuphibnue` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
INSERT INTO `sites` VALUES (1,1,0,1,'Snipcart Dev Other Site','snipcartDevOtherSite','en-US',0,NULL,2,'2021-02-28 19:57:13','2021-02-28 19:57:13',NULL,'280fceb8-a5d2-4c0b-9ee5-1ab5d6de749b'),(2,1,1,1,'Snipcart Dev','default','en-US',1,'$PRIMARY_SITE_URL',1,'2021-02-28 19:57:13','2021-02-28 19:57:13',NULL,'353b994a-9997-4f98-b31f-a963cf7671f8');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `snipcart_product_details`
--

DROP TABLE IF EXISTS `snipcart_product_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `snipcart_product_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `elementId` int NOT NULL,
  `fieldId` int NOT NULL,
  `siteId` int DEFAULT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `price` decimal(14,2) unsigned DEFAULT NULL,
  `shippable` tinyint(1) DEFAULT NULL,
  `taxable` tinyint(1) DEFAULT NULL,
  `weight` decimal(12,2) unsigned DEFAULT NULL,
  `weightUnit` enum('grams','ounces','pounds') DEFAULT NULL,
  `length` decimal(12,2) unsigned DEFAULT NULL,
  `width` decimal(12,2) unsigned DEFAULT NULL,
  `height` decimal(12,2) unsigned DEFAULT NULL,
  `dimensionsUnit` enum('centimeters','inches') DEFAULT NULL,
  `inventory` int DEFAULT NULL,
  `customOptions` longtext,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ykaalsaheasywqppxwqqkyriuwfulbyguotn` (`elementId`),
  KEY `idx_nogmbqzutorbwpneavlboecnzfozwxwjiypm` (`fieldId`),
  KEY `idx_gxcmuhmvwaydtsclbxhesyqlqcxdtqoeczut` (`siteId`),
  CONSTRAINT `fk_fhlqrnfrajvagilkmdxiirnxvbrzxidafjgf` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_fwvkiexjzlhsqbcjpzarxzphxwvrwdwrxtwu` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_uropkybktxrionqmkysymljqkaqsrwtzitdk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snipcart_product_details`
--

LOCK TABLES `snipcart_product_details` WRITE;
/*!40000 ALTER TABLE `snipcart_product_details` DISABLE KEYS */;
INSERT INTO `snipcart_product_details` VALUES (1,2,4,2,'infinity-gauntlet',499.98,1,1,3.00,'pounds',14.00,8.00,8.00,'inches',1,'[]','2021-02-28 19:57:43','2021-02-28 19:57:43','2c6781c9-57c2-4b27-bb74-e19ed474ed29'),(2,3,4,2,'infinity-gauntlet',499.98,1,1,3.00,'pounds',14.00,8.00,8.00,'inches',1,'[]','2021-02-28 19:57:43','2021-02-28 19:57:43','e5efc582-a55c-4dd9-8578-13e2b36e5295'),(3,4,4,2,'lembas-bread',8.99,1,0,1.00,'pounds',6.00,6.00,2.00,'inches',200,'[]','2021-02-28 19:57:43','2021-02-28 19:57:43','12a08b78-94e8-445e-86b5-3163cd76ab6f'),(4,5,4,2,'lembas-bread',8.99,1,0,1.00,'pounds',6.00,6.00,2.00,'inches',200,'[]','2021-02-28 19:57:43','2021-02-28 19:57:43','866877ea-d0b0-42f7-b76c-57958cb7da74'),(5,6,4,2,'dragon-egg',9999.99,1,1,1.00,'pounds',6.00,6.00,2.00,'inches',3,'[]','2021-02-28 19:57:43','2021-02-28 19:57:43','7ab7e9e8-801f-46c1-9de6-d03777e473a4'),(6,7,4,2,'dragon-egg',9999.99,1,1,1.00,'pounds',6.00,6.00,2.00,'inches',3,'[]','2021-02-28 19:57:43','2021-02-28 19:57:43','08ac8fd9-b923-4495-8a12-381b9946c6ae'),(7,8,4,2,'dark-matter',99999.98,0,1,999999.00,'pounds',1.00,1.00,1.00,'inches',6,'[]','2021-02-28 19:57:43','2021-02-28 19:57:43','8529f1e8-0056-41a1-8084-bc35f778ec8a'),(8,9,4,2,'dark-matter',99999.98,0,1,999999.00,'pounds',1.00,1.00,1.00,'inches',6,'[]','2021-02-28 19:57:43','2021-02-28 19:57:43','24894943-974a-481f-a085-0505b1c7cca3'),(9,10,4,2,'oathkeeper',2899.98,1,1,12.00,'pounds',1.00,1.00,1.00,'inches',3,'[]','2021-02-28 19:57:43','2021-02-28 19:57:43','754d9981-f418-4122-80b5-0355bbb9fb4c'),(10,11,4,2,'oathkeeper',2899.98,1,1,12.00,'pounds',1.00,1.00,1.00,'inches',3,'[]','2021-02-28 19:57:44','2021-02-28 19:57:44','d20d8af3-24c7-4fae-8ac4-3699a8491cfd'),(11,12,4,2,'hand-of-king-brooch',14.99,1,1,1.00,'pounds',5.00,1.00,1.00,'inches',100,'[]','2021-02-28 19:57:44','2021-02-28 19:57:44','b8dbab57-ab33-4085-86ae-5e7465ec2b06'),(12,13,4,2,'hand-of-king-brooch',14.99,1,1,1.00,'pounds',5.00,1.00,1.00,'inches',100,'[]','2021-02-28 19:57:44','2021-02-28 19:57:44','da139fe8-ed9b-4b8b-baf5-6e9f649f2216'),(13,14,4,2,'laser-sword',499.99,1,1,2.00,'pounds',11.00,2.00,2.00,'inches',1,'[]','2021-02-28 19:57:44','2021-02-28 19:57:44','0f5f838a-39b8-4813-871e-e6d27f78f67e'),(14,15,4,2,'laser-sword',499.99,1,1,2.00,'pounds',11.00,2.00,2.00,'inches',1,'[]','2021-02-28 19:57:44','2021-02-28 19:57:44','0870634b-584a-41e7-9cf2-fc012c160b61'),(15,16,4,2,'elemental-stone',89.99,1,1,6.00,'pounds',12.00,5.00,5.00,'inches',60,'[]','2021-02-28 19:57:44','2021-02-28 19:57:44','d1aaa788-4f9d-4224-bd53-5975c6f83605'),(16,17,4,2,'elemental-stone',89.99,1,1,6.00,'pounds',12.00,5.00,5.00,'inches',60,'[]','2021-02-28 19:57:44','2021-02-28 19:57:44','a16692bf-dbbf-4d4f-b809-76b8955ab955'),(17,18,4,2,'glow-pole-umbrella',34.99,1,1,1.00,'pounds',36.00,3.00,3.00,'inches',100,'[]','2021-02-28 19:57:44','2021-02-28 19:57:44','667f509e-c76a-4d83-a9e9-7e5b5436d2ba'),(18,19,4,2,'glow-pole-umbrella',34.99,1,1,1.00,'pounds',36.00,3.00,3.00,'inches',100,'[]','2021-02-28 19:57:44','2021-02-28 19:57:44','24f2ef2c-ad60-48a6-9c2d-101a36cdb0e0'),(19,22,5,2,'economy',100.00,0,1,NULL,NULL,NULL,NULL,NULL,NULL,100,'[]','2021-02-28 19:57:45','2021-02-28 19:57:45','240dd2b0-5324-4412-9054-282321074017'),(20,23,5,2,'deluxe',849.99,0,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'[]','2021-02-28 19:57:45','2021-02-28 19:57:45','5f6207c1-574e-41bf-8cc7-34d0d0159a18'),(21,26,5,2,'economy',100.00,0,1,NULL,NULL,NULL,NULL,NULL,NULL,100,'[]','2021-02-28 19:57:45','2021-02-28 19:57:45','5c3b0ad8-cfdc-4307-93b0-8f2370e9d96f'),(22,27,5,2,'deluxe',849.99,0,1,NULL,NULL,NULL,NULL,NULL,NULL,0,'[]','2021-02-28 19:57:45','2021-02-28 19:57:45','1cf5be68-9ccd-49a6-9d43-4237a92dfe8e');
/*!40000 ALTER TABLE `snipcart_product_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `snipcart_shipping_quotes`
--

DROP TABLE IF EXISTS `snipcart_shipping_quotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `snipcart_shipping_quotes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `siteId` int DEFAULT NULL,
  `token` text,
  `body` mediumtext,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_jievdwgbhqvouhevnemuqscyfbzaiqcycxod` (`siteId`),
  CONSTRAINT `fk_qzbepdkrrkyunbdkwidwjqjpzqwqdptsujnp` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snipcart_shipping_quotes`
--

LOCK TABLES `snipcart_shipping_quotes` WRITE;
/*!40000 ALTER TABLE `snipcart_shipping_quotes` DISABLE KEYS */;
/*!40000 ALTER TABLE `snipcart_shipping_quotes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `snipcart_webhook_log`
--

DROP TABLE IF EXISTS `snipcart_webhook_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `snipcart_webhook_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `siteId` int DEFAULT NULL,
  `type` enum('order.completed','shippingrates.fetch','order.status.changed','order.paymentStatus.changed','order.trackingNumber.changed','subscription.created','subscription.cancelled','subscription.paused','subscription.resumed','subscription.invoice.created','taxes.calculate','customauth:customer_updated','order.refund.created','order.notification.created') DEFAULT NULL,
  `mode` enum('live','test') DEFAULT NULL,
  `body` longtext,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_rspdynnbeprqsidihyydcspqjvbpzlijzhpq` (`siteId`),
  CONSTRAINT `fk_dtbardbvwesicomoiayuiejyjhveotwjehwj` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snipcart_webhook_log`
--

LOCK TABLES `snipcart_webhook_log` WRITE;
/*!40000 ALTER TABLE `snipcart_webhook_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `snipcart_webhook_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `structureelements`
--

DROP TABLE IF EXISTS `structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `structureelements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `structureId` int NOT NULL,
  `elementId` int DEFAULT NULL,
  `root` int unsigned DEFAULT NULL,
  `lft` int unsigned NOT NULL,
  `rgt` int unsigned NOT NULL,
  `level` smallint unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_oviewnfbuuychevfnewuwaeokauggthxsluk` (`structureId`,`elementId`),
  KEY `idx_mchaftwwivpqqrdeivhmsgztkxwgqqdnnkmq` (`root`),
  KEY `idx_nwcagpakcqevmomvqafixsrxqgekfbyqcwgm` (`lft`),
  KEY `idx_yvlnyvrwludiiquzurxwzdesejjdigmwbexz` (`rgt`),
  KEY `idx_ohrxduclxlcxsrowfllpwmzjkwfviwojtlhj` (`level`),
  KEY `idx_shzrxlodvwuspbzomsbkhrymfayxbuwennfx` (`elementId`),
  CONSTRAINT `fk_bgxpdandxiphuauptdhlzqpdryreyrzzjmlg` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_gbdyoxazovfhhqlllozmxbeltebwlcimzmbx` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `structures`
--

DROP TABLE IF EXISTS `structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `structures` (
  `id` int NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_ytrxwctchqbdsxvumcrqydxivqeuutcllzam` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `systemmessages`
--

DROP TABLE IF EXISTS `systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `systemmessages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ierhhamszwradyqabaxslgtgljmenyisggsq` (`key`,`language`),
  KEY `idx_awpplroptaaqyqeularhnijewisjntkjotuh` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taggroups`
--

DROP TABLE IF EXISTS `taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taggroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_gbyxsmryayutexrhotrerhvbqhubcsbdofys` (`name`),
  KEY `idx_wpsubzilgyerxvnvwtzqkvizbwsscnmswcom` (`handle`),
  KEY `idx_pfpwxdlebtkduxvvxyjuagehzpsuqwvjtooo` (`dateDeleted`),
  KEY `fk_rheqruclcopjbiilvcjghanolngykkdqelia` (`fieldLayoutId`),
  CONSTRAINT `fk_rheqruclcopjbiilvcjghanolngykkdqelia` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` int NOT NULL,
  `groupId` int NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_wqpdcmrwzszrdzaoyxphwaadovphdzukdnwy` (`groupId`),
  CONSTRAINT `fk_gkykvtcbranqgwfvtzigrrhuhrdtnwqwnpnx` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wbmjvjsltbruywsrzxzysgdmfuydbjczfzmj` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatecacheelements`
--

DROP TABLE IF EXISTS `templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `templatecacheelements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cacheId` int NOT NULL,
  `elementId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_nsncktbzgrmekldnhbvjacylngkidebvmkcj` (`cacheId`),
  KEY `idx_uvojpqqgktgkpmwyrvrnofxfhtnfvxzswfev` (`elementId`),
  CONSTRAINT `fk_csygjiihseozxvgcbmyvzcjlkmvlgtjqfntl` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rtsfekmbadsppigoxllkymlnsgyuyrfeexxi` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatecacheelements`
--

LOCK TABLES `templatecacheelements` WRITE;
/*!40000 ALTER TABLE `templatecacheelements` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatecacheelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatecachequeries`
--

DROP TABLE IF EXISTS `templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `templatecachequeries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cacheId` int NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ejcakcjosxkzngvaznhjkdmybtjwvmkoptbv` (`cacheId`),
  KEY `idx_xoelflfeswkkjgtudgvkoxgoeyezjqdpoksf` (`type`),
  CONSTRAINT `fk_ikcmvjlmrbcjjsfpoyhywcavzozadhtyflti` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatecachequeries`
--

LOCK TABLES `templatecachequeries` WRITE;
/*!40000 ALTER TABLE `templatecachequeries` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatecachequeries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatecaches`
--

DROP TABLE IF EXISTS `templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `templatecaches` (
  `id` int NOT NULL AUTO_INCREMENT,
  `siteId` int NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_eqaijinymzzidvxcygpcbcniqgxhlgiecewr` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `idx_ryxxammoxxxktgnkdqsspzvsivzfkkgjcoik` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `idx_jgaqcruhkkttlebljnznemsfvxsqqlmmnboe` (`siteId`),
  CONSTRAINT `fk_eusarwfgwqkzkfrqgccvfbbsacbkjtgunxkc` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatecaches`
--

LOCK TABLES `templatecaches` WRITE;
/*!40000 ALTER TABLE `templatecaches` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatecaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint unsigned DEFAULT NULL,
  `usageCount` tinyint unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_eqapyjveixhxwqlkjaesjldwpthfezcpjigp` (`token`),
  KEY `idx_subwnanffqvtnrhsbgectiwidmtjdffaynxj` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usergroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `description` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_hhsedlzumuxmreaquvvzehswykzttpmtrghc` (`handle`),
  KEY `idx_gtyyduobrnlbxafxqseenzaldgzdugnqkbky` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergroups_users`
--

DROP TABLE IF EXISTS `usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usergroups_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `groupId` int NOT NULL,
  `userId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_zmiosfkskpdpuymgholzizgkqqslftvsdhfh` (`groupId`,`userId`),
  KEY `idx_dgwhfxbhnespjxdpwuplzdopvmqlbhmwizfl` (`userId`),
  CONSTRAINT `fk_drhudzevcalhwmtpcexqnnnbbwbycxfrmdjm` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rblvjxzwmwpljfcpqcuxqlcdqttihzsjdeee` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userpermissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_nnuyravdgvotieyddsyirjpsytjlcbwsxtkt` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermissions_usergroups`
--

DROP TABLE IF EXISTS `userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userpermissions_usergroups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permissionId` int NOT NULL,
  `groupId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_optfmkekpyixppqbzdeuivkqdghxgbihtgwx` (`permissionId`,`groupId`),
  KEY `idx_mwbvsajlgpjekbzdxxtrdhxbwkitftgwhgdg` (`groupId`),
  CONSTRAINT `fk_jftdtcnmpydqtgiiqgskfvzdvmmmjsdzrqpc` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_wwyfftbjbhqydurmzzinkdcxswiutuvsiqlj` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermissions_users`
--

DROP TABLE IF EXISTS `userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userpermissions_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `permissionId` int NOT NULL,
  `userId` int NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ojuwlunmsthrynpgtkzdpsqjrmqyqqbdkbwr` (`permissionId`,`userId`),
  KEY `idx_nsnaaxtgtbfoisbuitlmdhmtlelggriockjp` (`userId`),
  CONSTRAINT `fk_bquycyhhfznojfmlbogkykanfxkhwfdvitmw` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_kcoqilksptsnlzbgivrmtwxhkbacbspfisem` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userpreferences` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `fk_qxaoahxyfbliphpuojyluluvtzicbkmajyrt` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
INSERT INTO `userpreferences` VALUES (1,'{\"language\":\"en-US\",\"locale\":null,\"weekStartDay\":\"0\",\"useShapes\":false,\"underlineLinks\":false,\"showFieldHandles\":false,\"enableDebugToolbarForSite\":false,\"enableDebugToolbarForCp\":false,\"showExceptionView\":false,\"profileTemplates\":false}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_mihzjlbiafgxurnlnqdkthgltvqnmpworrmx` (`uid`),
  KEY `idx_tzcqkdsftkscawcwevpfyrhgsfatpolpfsom` (`verificationCode`),
  KEY `idx_ghilmdrccgzaeahygopywsbtlwjetumymsgw` (`email`),
  KEY `idx_onurcmmkaqfpmhyarxtyerruilyrpcmnioaq` (`username`),
  KEY `fk_ndlsqbefzupbchrepjjigqpimugnrgdpgexg` (`photoId`),
  CONSTRAINT `fk_ndlsqbefzupbchrepjjigqpimugnrgdpgexg` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_vcezrjcxsphoikggcmfrguaewiahxlzheumt` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'engineering@fostercommerce.com',NULL,'','','engineering@fostercommerce.com','$2y$13$soGM4JDUQQ5fJkVq380fCOOi6R.wOWqnqoNdk4f.cBvBvJlyKxPpS',1,0,0,0,'2021-02-28 19:59:10',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2021-02-28 19:59:00','2021-02-28 19:57:15','2021-02-28 19:59:10','f80b3f04-daea-4bfa-b62f-23953fef71db');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volumefolders`
--

DROP TABLE IF EXISTS `volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `volumefolders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parentId` int DEFAULT NULL,
  `volumeId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_educcnozwjhrdtldfhqnufaphabjjyhihjiq` (`name`,`parentId`,`volumeId`),
  KEY `idx_ebhkrbhmsjhygemyyumhfejhehthrjrogarz` (`parentId`),
  KEY `idx_pouaszncaxvkziechjopzdqphubosdspuptq` (`volumeId`),
  CONSTRAINT `fk_jsbcyxesmvjdnbhyniskppcfhoypmagwzjyi` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rgxogweivmwfitqdxckbtkzmexwwrfxtkawr` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `volumes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `titleTranslationMethod` varchar(255) NOT NULL DEFAULT 'site',
  `titleTranslationKeyFormat` text,
  `settings` text,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_bmldgaxnfecsmwslljaxwqkwtwtrkistikvx` (`name`),
  KEY `idx_nxwfqdyxmyudrmosxgxqdwbesuybzdyutjhn` (`handle`),
  KEY `idx_oicagamtxvdddpaabysfqiolkwhemittdsjs` (`fieldLayoutId`),
  KEY `idx_pslykwcevtuvofbkplqskrxqaeenkuslofac` (`dateDeleted`),
  CONSTRAINT `fk_nyljghgeerczprhomxnmmgvefksxhwointti` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `widgets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint unsigned DEFAULT NULL,
  `colspan` tinyint DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_yuwuebahhxvnwfayjnmjocwujjznlnaobgrw` (`userId`),
  CONSTRAINT `fk_rpmsrzadosgrcpubzoaapgiwenjmmjcvgjfh` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
INSERT INTO `widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"siteId\":2,\"section\":\"*\",\"limit\":10}',1,'2021-02-28 19:59:10','2021-02-28 19:59:10','2fa2fa78-03cf-473c-8e54-80dec44cf0e7'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2021-02-28 19:59:10','2021-02-28 19:59:10','b9eeb79c-5c7f-45a5-873f-dfad8c2221b1'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2021-02-28 19:59:10','2021-02-28 19:59:10','6a7ac94d-bc15-4647-9e64-ffac70f0763f'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2021-02-28 19:59:10','2021-02-28 19:59:10','554b99e6-94cf-4db5-a8e9-87a9b4a03ada');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-28 19:59:35
