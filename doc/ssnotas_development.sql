-- MySQL dump 10.13  Distrib 5.5.35, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: ssnotas_development
-- ------------------------------------------------------
-- Server version	5.5.35-0ubuntu0.12.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `ssnotas_development`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ssnotas_development` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `ssnotas_development`;

--
-- Table structure for table `audits`
--

DROP TABLE IF EXISTS `audits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `auditable_id` int(11) DEFAULT NULL,
  `auditable_type` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_type` varchar(255) DEFAULT NULL,
  `modifications` text,
  `action` varchar(255) DEFAULT NULL,
  `tag` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `auditable_index` (`auditable_id`,`auditable_type`),
  KEY `auditable_version_idx` (`auditable_id`,`auditable_type`,`version`),
  KEY `user_index` (`user_id`,`user_type`),
  KEY `index_audits_on_created_at` (`created_at`),
  KEY `index_audits_on_action` (`action`),
  KEY `index_audits_on_tag` (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audits`
--

LOCK TABLES `audits` WRITE;
/*!40000 ALTER TABLE `audits` DISABLE KEYS */;
/*!40000 ALTER TABLE `audits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cargos`
--

DROP TABLE IF EXISTS `cargos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cargos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargos`
--

LOCK TABLES `cargos` WRITE;
/*!40000 ALTER TABLE `cargos` DISABLE KEYS */;
INSERT INTO `cargos` VALUES (1,'Director','','2013-09-10 20:23:35','2013-09-10 20:23:35'),(2,'Secretario Tecnico','','2013-09-10 20:25:50','2013-09-10 20:25:50'),(3,'Presidente',NULL,'2013-09-20 18:40:25','2013-09-20 18:40:25'),(4,'Rector',NULL,'2013-09-25 20:49:02','2013-09-25 20:49:02'),(5,'Gerente',NULL,'2013-09-26 18:25:34','2013-09-26 18:25:34'),(8,'Decano','','2013-09-27 19:36:48','2014-02-27 20:20:54'),(10,'Programador',NULL,'2013-10-04 18:01:27','2013-10-04 18:01:27'),(13,'Secretaria de Extension',NULL,'2013-10-17 19:41:05','2013-10-17 19:41:05'),(14,'Comunicador',NULL,'2013-11-06 19:47:51','2013-11-06 19:47:51'),(15,'ViceDecano','','2014-02-27 20:26:01','2014-03-07 19:46:27'),(16,'Secretaria Academica',NULL,'2014-03-07 20:05:04','2014-03-07 20:05:04');
/*!40000 ALTER TABLE `cargos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dependencias`
--

DROP TABLE IF EXISTS `dependencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dependencias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `codigo` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `organismo_id` int(11) DEFAULT NULL,
  `alias` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dependencias`
--

LOCK TABLES `dependencias` WRITE;
/*!40000 ALTER TABLE `dependencias` DISABLE KEYS */;
INSERT INTO `dependencias` VALUES (1,'Decanato','',1,'2013-06-06 22:41:42','2013-06-06 22:41:42',1,NULL),(2,'Departamento de Microbiología','',50,'2013-06-06 23:20:07','2013-06-06 23:20:07',1,NULL),(3,'Departamento de Matemáticas','',55,'2013-06-06 23:26:21','2013-06-06 23:27:06',1,NULL),(7,'Departamento de Computación','',56,'2013-06-07 03:36:34','2013-06-07 03:36:34',1,NULL),(9,'Departamento de Geologia','',57,'2013-06-07 18:57:39','2013-06-07 18:57:39',1,NULL),(21,'Rectorado','',62,'2013-09-25 20:48:53','2014-03-07 19:51:42',2,'Rec'),(29,'Área de Programación y Estadística','Área de Programación y Estadística',63,'2014-02-27 20:29:51','2014-02-27 20:29:51',1,'Programación');
/*!40000 ALTER TABLE `dependencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dependencies`
--

DROP TABLE IF EXISTS `dependencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dependencies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `code` int(11) DEFAULT NULL,
  `subcode` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dependencies`
--

LOCK TABLES `dependencies` WRITE;
/*!40000 ALTER TABLE `dependencies` DISABLE KEYS */;
INSERT INTO `dependencies` VALUES (1,'Decanato','Facultad de Ciencias Exactas Fisico Quimicas y Naturales',1,1,'2013-05-21 19:38:35','2013-05-21 19:38:35'),(2,'Biología Molecular','',1,50,'2013-05-21 20:01:07','2013-05-21 20:01:07'),(3,'Ciencias Naturales','',1,51,'2013-05-21 20:01:26','2013-05-21 20:01:26'),(4,'Computación','',1,56,'2013-05-21 20:01:46','2013-05-21 20:01:46'),(5,'Física','',1,57,'2013-05-21 20:01:58','2013-05-21 20:01:58'),(6,'Geología','',1,52,'2013-05-21 20:02:14','2013-05-21 20:02:14'),(7,'Matemática','',1,53,'2013-05-21 20:02:26','2013-05-21 20:02:26'),(8,'Microbiología','',1,55,'2013-05-21 20:02:36','2013-05-21 20:02:36'),(9,'Química','',1,54,'2013-05-21 20:02:46','2013-05-21 20:02:46');
/*!40000 ALTER TABLE `dependencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entidades`
--

DROP TABLE IF EXISTS `entidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entidades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `persona_id` int(11) DEFAULT NULL,
  `dependencia_id` int(11) DEFAULT NULL,
  `cargo_id` int(11) DEFAULT NULL,
  `es_facultad` tinyint(1) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `es_actual` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entidades`
--

LOCK TABLES `entidades` WRITE;
/*!40000 ALTER TABLE `entidades` DISABLE KEYS */;
INSERT INTO `entidades` VALUES (82,16,1,8,1,NULL,'2014-02-27 20:25:32','2014-03-17 19:24:04',1),(83,30,1,15,1,NULL,'2014-02-27 20:26:05','2014-03-10 18:52:46',1),(84,1,29,10,1,NULL,'2014-02-27 20:30:03','2014-03-10 18:52:48',1),(85,17,1,2,1,NULL,'2014-02-27 20:30:28','2014-03-10 18:52:49',1),(86,31,1,16,1,NULL,'2014-03-07 20:05:10','2014-03-10 18:52:51',1),(88,32,7,1,0,NULL,'2014-03-10 21:00:34','2014-03-10 21:00:34',0);
/*!40000 ALTER TABLE `entidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas`
--

DROP TABLE IF EXISTS `notas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tema` varchar(255) DEFAULT NULL,
  `descripcion` text,
  `fecha_ingreso` date DEFAULT NULL,
  `codigo` varchar(255) DEFAULT NULL,
  `tipo_nota_id` int(11) DEFAULT NULL,
  `remitente_id` int(11) DEFAULT NULL,
  `destinatario_id` int(11) DEFAULT NULL,
  `fecha_eliminada` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `fecha_nota` date DEFAULT NULL,
  `fecha_carga` date DEFAULT NULL,
  `tipo` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `cargado_por_id` int(11) DEFAULT NULL,
  `recibido_por_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `cargado_mesa_entrada` tinyint(1) DEFAULT NULL,
  `eliminada` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas`
--

LOCK TABLES `notas` WRITE;
/*!40000 ALTER TABLE `notas` DISABLE KEYS */;
INSERT INTO `notas` VALUES (36,'Evaluación de la cantidad de becarios','Esta es una nota enviada de la Decana Rosa Cattana a el Vice-Decano Marcelo Fagiano el día 27 de febrero del 2014.\r\n','2014-02-27','000032014',2,82,83,NULL,'2014-02-27 20:27:45','2014-02-27 20:27:45','2014-02-27','2014-02-27',0,1,3,3,NULL,1,0),(37,'Corte enlace a internet','Nota comunicando que en el día 26 de  febrero se corto el enlace a internet','2014-02-27','000042014',1,84,85,NULL,'2014-02-27 20:31:08','2014-02-27 20:31:08','2014-02-27','2014-02-27',0,1,3,3,36,1,0),(38,'Codigo Unico','Esta generando el mismo codigo para cada nota que se carga en el dia,\r\nademas no esta chequeando que no exista el codigo','2014-02-28','000012014',2,84,84,'2014-02-28 19:49:46','2014-02-28 18:47:22','2014-02-28 18:47:22','2014-02-28','2014-02-28',0,1,3,3,36,1,1),(39,'Funciona el código único','Ya esta funcionando la generacion de codigo unico','2014-02-28','000022014',1,84,84,NULL,'2014-02-28 19:50:35','2014-03-07 19:54:12','2014-02-28','2014-02-28',0,1,3,3,36,1,0),(40,'Remitente y Destinatario','Quedo de la version anterior los modelos  remitente y destinatario, de a poco hay que eliminar las referencias a los mismos. Y chequear que no se rompa nada.\r\n\r\n','2014-03-07','000052014',2,86,83,NULL,'2014-03-07 20:06:17','2014-03-07 20:06:17','2014-03-07','2014-03-07',0,1,3,3,39,1,0),(41,'Destinatario No aparece','Em el alta de notas desde la vista de secretaria de departamentos, no me aparecio ningun destinatario.\r\nCalculo que es porque ninguno tiene el es_facultad activo.\r\nes_facultad deberia ser en realidad algo como \"puede recibir notas desde los departamentos\"','2014-03-17','000062014',2,88,82,NULL,'2014-03-17 19:45:25','2014-03-17 19:45:25','2014-03-05','2014-03-10',0,1,2,3,NULL,0,0),(42,'Visualizacion','Se confunde mucho que es remitente y que destinatario-\r\n\r\nAdemas tengo que probar nuevamente la generacion de codigo tanto para Notas como notas temporales','2014-03-17','000072014',2,84,83,NULL,'2014-03-17 19:46:34','2014-03-17 19:46:34','2014-03-17','2014-03-17',0,1,3,3,NULL,1,0),(43,'Generacion de Codigos','Hay que hacer un solo metodo que calcule el codigo de la nota. Y deberia estar fuera del modelo nota.\r\nAdemas se deberia realizar esta accion de manera atomica.','2014-03-17','000102014',2,88,84,NULL,'2014-03-17 20:25:32','2014-03-17 20:25:32','2014-03-10','2014-03-10',0,1,2,3,NULL,0,0),(44,'Creacion de un expedient','Se corrigieron errores con el codigo de nota. Ahora controla tambien en nota temporal','2014-03-17','000112014',1,84,82,NULL,'2014-03-17 20:26:23','2014-03-17 20:26:23','2014-03-17','2014-03-17',0,1,3,3,NULL,1,0);
/*!40000 ALTER TABLE `notas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas_temporales`
--

DROP TABLE IF EXISTS `notas_temporales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notas_temporales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tema` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `fecha_nota` date DEFAULT NULL,
  `fecha_carga` date DEFAULT NULL,
  `codigo` varchar(255) DEFAULT NULL,
  `tipo_nota_id` int(11) DEFAULT NULL,
  `remitente_id` int(11) DEFAULT NULL,
  `texto_remitente` varchar(255) DEFAULT NULL,
  `destinatario_id` int(11) DEFAULT NULL,
  `texto_destinatario` varchar(255) DEFAULT NULL,
  `cargado_por_id` int(11) DEFAULT NULL,
  `dependencia_id` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `nota_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_notas_temporales_on_tipo_nota_id` (`tipo_nota_id`),
  KEY `index_notas_temporales_on_remitente_id` (`remitente_id`),
  KEY `index_notas_temporales_on_destinatario_id` (`destinatario_id`),
  KEY `index_notas_temporales_on_cargado_por_id` (`cargado_por_id`),
  KEY `index_notas_temporales_on_dependencia_id` (`dependencia_id`),
  KEY `index_notas_temporales_on_nota_id` (`nota_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas_temporales`
--

LOCK TABLES `notas_temporales` WRITE;
/*!40000 ALTER TABLE `notas_temporales` DISABLE KEYS */;
INSERT INTO `notas_temporales` VALUES (1,'Destinatario No aparece','Em el alta de notas desde la vista de secretaria de departamentos, no me aparecio ningun destinatario.\r\nCalculo que es porque ninguno tiene el es_facultad activo.\r\nes_facultad deberia ser en realidad algo como \"puede recibir notas desde los departamentos\"','2014-03-05','2014-03-10','000092014',2,NULL,'Director: Arroyo, Marcelo',NULL,'Decana: Cattana, Rosa',2,7,1,41,'2014-03-10 18:32:32','2014-03-17 19:45:25'),(2,'Generacion de Codigos','Hay que hacer un solo metodo que calcule el codigo de la nota. Y deberia estar fuera del modelo nota.\r\nAdemas se deberia realizar esta accion de manera atomica.','2014-03-10','2014-03-10','000102014',2,NULL,'Director: Arroyo, Marcelo',NULL,'Programador: Marozzi, Mauro',2,7,1,43,'2014-03-10 18:51:09','2014-03-17 20:25:32'),(3,'Carga de nota','Carga de nota temporal con el usuario icardetti','2014-03-17','2014-03-17','000082014',2,88,'',84,'',2,7,0,NULL,'2014-03-17 19:47:44','2014-03-17 19:47:44');
/*!40000 ALTER TABLE `notas_temporales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `note_types`
--

DROP TABLE IF EXISTS `note_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `note_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note_types`
--

LOCK TABLES `note_types` WRITE;
/*!40000 ALTER TABLE `note_types` DISABLE KEYS */;
INSERT INTO `note_types` VALUES (1,'Expediente','','2013-05-28 20:16:57','2013-05-28 20:16:57');
/*!40000 ALTER TABLE `note_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organismos`
--

DROP TABLE IF EXISTS `organismos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organismos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `descripcion` text,
  `codigo` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `alias` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organismos`
--

LOCK TABLES `organismos` WRITE;
/*!40000 ALTER TABLE `organismos` DISABLE KEYS */;
INSERT INTO `organismos` VALUES (1,'Fac. Ciencias Exactas Físico Químicas y Naturales','',1,'2013-06-24 19:14:04','2013-10-11 20:39:47','FCEFQyN'),(2,'Universidad Nacional de Río Cuarto','',2,'2013-06-24 19:15:43','2013-10-11 20:46:55','UNRC'),(3,'Fac. de Agronomia y Veterinaria','',3,'2013-06-24 19:16:15','2013-06-24 19:16:15',NULL),(4,'Fac. de Ciencias Económicas','',4,'2013-06-24 19:16:41','2013-06-24 19:16:41',NULL),(5,'Fac. de Ciencias Humanas','',5,'2013-06-24 19:16:59','2013-06-24 19:16:59',NULL),(6,'Fac. de Ingenieria','',6,'2013-06-24 19:17:12','2013-06-24 19:17:12',NULL),(9,'Organismo para prueva de versiones','Se creo este organismo para ver si funcionan las versiones de los objetos, reniego mucho con los usuarios, chequear!!!',7,'2014-03-05 19:57:04','2014-03-07 19:43:01','alias');
/*!40000 ALTER TABLE `organismos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personas`
--

DROP TABLE IF EXISTS `personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `apellido` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personas`
--

LOCK TABLES `personas` WRITE;
/*!40000 ALTER TABLE `personas` DISABLE KEYS */;
INSERT INTO `personas` VALUES (1,'Mauro','Marozzi','mmarozzi@gmail.com','2013-09-09 19:13:29','2013-09-09 19:14:40'),(4,'Nelson','Nusbaum','comunicacion@exa.unrc.edu.ar','2013-09-10 19:07:42','2013-09-10 19:09:01'),(5,'Francisco','Bavera',NULL,'2013-09-19 19:22:59','2013-09-19 19:22:59'),(6,'Marcelo','Ruiz',NULL,'2013-09-25 20:47:53','2013-09-25 20:47:53'),(16,'Rosa','Cattana',NULL,'2013-09-27 19:36:39','2013-09-27 19:36:39'),(17,'Marcela','Daniele',NULL,'2013-10-02 19:36:33','2013-10-02 19:36:33'),(18,'Susana','Bettera',NULL,'2013-10-17 19:40:42','2013-10-17 19:40:42'),(30,'Marcelo','Fagiano','','2014-02-27 20:19:54','2014-02-27 20:19:54'),(31,'','Teresa Quintero',NULL,'2014-03-07 20:04:50','2014-03-07 20:04:50'),(32,'Marcelo','Arroyo',NULL,'2014-03-10 20:29:33','2014-03-10 20:29:33');
/*!40000 ALTER TABLE `personas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin',NULL,NULL,NULL),(2,'sec_mesa_entrada',NULL,NULL,NULL),(3,'sec_dependencias',NULL,NULL,NULL);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20130606220004'),('20130608161109'),('20130609024321'),('20130609162849'),('20130609180348'),('20130609184103'),('20130610130921'),('20130611015807'),('20130624182924'),('20130625155028'),('20130625194844'),('20130629135341'),('20130629135550'),('20130701162019'),('20130705185510'),('20130705185736'),('20130705192413'),('20130705192741'),('20130813195519'),('20130902200259'),('20130902200942'),('20130909185830'),('20130910200152'),('20130911193741'),('20130913180729'),('20130923185401'),('20131011194943'),('20131011203330'),('20131015184406'),('20131017190350'),('20131017192956'),('20131017200632'),('20131017203301'),('20140225200809'),('20140305185713'),('20140305193930'),('20140306204125'),('20140313181113'),('20140313181950'),('20140313195330'),('20140313200139');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessiones`
--

DROP TABLE IF EXISTS `sessiones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessiones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) NOT NULL,
  `data` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_sessiones_on_session_id` (`session_id`),
  KEY `index_sessiones_on_updated_at` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessiones`
--

LOCK TABLES `sessiones` WRITE;
/*!40000 ALTER TABLE `sessiones` DISABLE KEYS */;
INSERT INTO `sessiones` VALUES (1,'1d330549216f7fed3ef0d6dd96dbee38','BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFCSVBkVmZjVVE0bDZtTTZadmxK\ndmpTNmFIWnhNWWlhSjBXTElNamZKRml3PQY7AEY=\n','2013-06-08 16:12:03','2013-06-08 22:36:05'),(2,'9f0609a017f941b39e8823a91ca3b01a','BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFsT2pPbThDdkJDd0VZM2syS0dx\nQnhJdUM4OGNrcmJHcXp6Z0pkdHVFYmtBPQY7AEY=\n','2013-06-09 03:21:28','2013-06-10 13:28:32'),(3,'95b028717c1007ade06a3c6b87d6a127','BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjEvYnl0Z21sVitFc2FURTBud0Er\ndW83QU9HcGpMTFdBeldFMzFlSVRWRXFJPQY7AEY=\n','2013-06-11 15:03:18','2013-06-11 15:03:18'),(4,'75fa5d06b3adba98a5ca13111aacceb7','BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFaWUlRLy9IeFA4QzZrbldjWlAx\nN21qM09sUE91aWw3N2xTcjhCQUJPbTBJPQY7AEY=\n','2013-06-11 16:34:54','2013-06-11 16:34:54'),(5,'f9b016505ba2dc08c0f41bb698786ead','BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFtN1lqN2FkQmpVQ2NBU0VoeHF5\nSlpVeVl4dWplMjZqYndBTEJWMUwzeHBnPQY7AEY=\n','2013-06-12 14:52:46','2013-06-12 14:52:46'),(6,'8f7e47c0a806784def759a342d84f355','BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFVd3lwU3NrN0pMT3MvZkc1TzJi\na3E3bk4zb0VEQWlic0ZSNitwcVJjbnRzPQY7AEY=\n','2013-06-13 15:33:34','2013-06-15 03:18:27'),(7,'a94abaf8f6fa55c169814a7531c6d68b','BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjF3ZnFwS0FaT2I4aU5pRE5RKytv\nb0FHTXF0bXRjWDlWeDJzcGx4czlNN0g0PQY7AEY=\n','2013-06-15 18:56:19','2013-06-15 18:56:19'),(8,'d32e16c1ea34d8a84c7e510817e6b9b2','BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFPT3ExR3NNSEtYRU8raUcwUWlK\nVEZHcVUvcURiK0orUXg3bXBjR1pIOUNBPQY7AEY=\n','2013-06-17 15:19:45','2013-06-17 19:35:46'),(9,'2f076c9b807678af91eec9401256a2b6','BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjE5RWxaTDlSbkJJakNMUktqdTBy\nQjRSOHBaTVdFaGgzOTNVZ0NWN1VtdVBJPQY7AEY=\n','2013-06-18 01:43:17','2013-06-18 01:43:17'),(10,'7ee1bd2621b16c55dee245aceb3a3683','BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFpMTNiVkRjUHRnNTBYZnZkaTdk\nZ0Q1ZWVienBIYkpKQi9DaUhVbHRYY1h3PQY7AEY=\n','2013-06-20 19:05:05','2013-06-20 19:05:05'),(11,'98b853f5c9405c333628b7d187a32553','BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFBT3M2NjFvL0J5OVlkdTRHNVlJ\nVWJ1ekYweWdjT2N0Q2dhaHJOdjJmbGtNPQY7AEY=\n','2013-06-24 17:14:36','2013-06-24 19:17:30'),(12,'38e0ac27e315eff154c44f2bb26a3eac','BAh7BkkiEF9jc3JmX3Rva2VuBjoGRUZJIjFSQThCbjFrMjNUZjdiVlA4VUU5\nT1A1QlZJUFBHR2MyS0MrdVYyOEVBc3JvPQY7AEY=\n','2013-06-25 14:35:53','2013-06-25 18:38:08'),(14,'6bc64c4aec9f8e79a168b379cfab2c0a','BAh7CEkiEF9jc3JmX3Rva2VuBjoGRUZJIjFkR0RTOUN3WWxIRUxKaGppaEdM\nMHFGdWtKSXA0TkZwRk00dTFnZlFBUXpnPQY7AEZJIhx3YXJkZW4udXNlci51\nc3VhcmlvLmtleQY7AFRbB1sGaQYiIiQyYSQxMCRyNnJZWW5EREVycUs1MUhu\nSTZ1ZWtlSSIKZmxhc2gGOwBGbzolQWN0aW9uRGlzcGF0Y2g6OkZsYXNoOjpG\nbGFzaEhhc2gJOgpAdXNlZG86CFNldAY6CkBoYXNoewY6C25vdGljZVQ6DEBj\nbG9zZWRGOg1AZmxhc2hlc3sGOwpJIkN0cmFuc2xhdGlvbiBtaXNzaW5nOiBl\ncy5kZXZpc2UucmVnaXN0cmF0aW9ucy51c3VhcmlvLnNpZ25lZF91cAY7AEY6\nCUBub3cw\n','2013-06-25 19:56:54','2013-06-25 19:56:54'),(15,'1396e35c88cc5f3d74cd8e75205514d0','BAh7B0kiFnVzdWFyaW9fcmV0dXJuX3RvBjoGRUZJIhIvZGVwZW5kZW5jaWFz\nBjsARkkiEF9jc3JmX3Rva2VuBjsARkkiMVBWKzdkR2lLRFZlWE1ZcDNSMTZF\ncktRQ3M3OVpicE9FVzFzVlJFcnFIL289BjsARg==\n','2013-06-29 13:09:03','2013-06-29 13:18:23');
/*!40000 ALTER TABLE `sessiones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_notas`
--

DROP TABLE IF EXISTS `tipos_notas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipos_notas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_notas`
--

LOCK TABLES `tipos_notas` WRITE;
/*!40000 ALTER TABLE `tipos_notas` DISABLE KEYS */;
INSERT INTO `tipos_notas` VALUES (1,'Expedientes','','2013-06-09 17:44:18','2013-06-09 17:44:18'),(2,'Nota','Notas en general','2013-06-17 16:07:05','2014-03-10 18:24:47');
/*!40000 ALTER TABLE `tipos_notas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `password_salt` varchar(255) NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `rol_id` int(11) DEFAULT NULL,
  `dependencia_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_users_on_rol_id` (`rol_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'mmarozzi',NULL,'$2a$10$FPtLohriTIsB4PEEMMLum.ql1ahseXg1u2In6znca3zbj3pHCZG26','$2a$10$FPtLohriTIsB4PEEMMLum.',1,'2013-08-16 18:32:51','2013-08-29 19:23:33',1,NULL),(2,'icardetti','','$2a$10$QaP3/7WDwgo5pnehJd4FKeVLnGcmtb276Fv4CxE8207Jryt0iKrhi','$2a$10$QaP3/7WDwgo5pnehJd4FKe',1,'2013-08-29 18:35:05','2013-11-08 19:21:48',3,7),(3,'mbueno','mbueno@exa.unrc.edu.ar','$2a$10$DhzeRQdGtfH7Alu9i9in0OOTyNvufSiukigWqbvrulw6lxqMJOydK','$2a$10$DhzeRQdGtfH7Alu9i9in0O',1,'2013-09-18 18:41:45','2014-03-12 20:02:16',2,NULL),(4,'wfernandez','wfernandez@exa.unrc.edu.ar','$2a$10$c1Vi7EpeX/hecdVdomYh3.HIMAvM8I3yORDU6yD8EJbQsT8oevpoS','$2a$10$c1Vi7EpeX/hecdVdomYh3.',1,'2013-10-11 20:17:05','2013-10-11 20:17:05',2,NULL),(5,'pancho','pancho@dc.exa.unrc.edu.ar','$2a$10$3k4PK7.El3/hTCe6cX5xbe/dFefxW5xaNNORTXFHslOpbz3fPp4m6','$2a$10$3k4PK7.El3/hTCe6cX5xbe',1,'2013-11-18 18:45:56','2013-11-18 18:45:56',1,NULL),(6,'matematica','','$2a$10$wojAWi.xwfmslx5pqB1.t.Nm62Z0qJit5mYhnM5qgtt/2mLXa5Daq','$2a$10$wojAWi.xwfmslx5pqB1.t.',1,'2013-11-28 19:17:10','2013-11-28 19:17:10',3,3);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `versions`
--

DROP TABLE IF EXISTS `versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `versions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_type` varchar(255) NOT NULL,
  `item_id` int(11) NOT NULL,
  `event` varchar(255) NOT NULL,
  `whodunnit` varchar(255) DEFAULT NULL,
  `object` text,
  `created_at` datetime DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_versions_on_item_type_and_item_id` (`item_type`,`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `versions`
--

LOCK TABLES `versions` WRITE;
/*!40000 ALTER TABLE `versions` DISABLE KEYS */;
INSERT INTO `versions` VALUES (11,'Organismo',9,'update',NULL,'---\nid: 9\nnombre: Organismo para prueva de versiones\ndescripcion: Se creo este organismo para ver si funcionan las versiones de los objetos\ncodigo: 7\ncreated_at: 2014-03-05 19:57:04.000000000 Z\nupdated_at: 2014-03-07 19:31:21.000000000 Z\nalias: alias\n','2014-03-07 19:33:36','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:20.0) Gecko/20100101 Firefox/20.0',-1),(12,'Organismo',9,'update','3','---\nid: 9\nnombre: Organismo para prueva de versiones\ndescripcion: Se creo este organismo para ver si funcionan las versiones de los objetos,\n  reniego mucho con los usuarios\ncodigo: 7\ncreated_at: 2014-03-05 19:57:04.000000000 Z\nupdated_at: 2014-03-07 19:33:36.000000000 Z\nalias: alias\n','2014-03-07 19:43:01','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:20.0) Gecko/20100101 Firefox/20.0',3),(13,'Cargo',15,'update','3','---\nid: 15\nnombre: Vice-Decano\ndescripcion: \ncreated_at: 2014-02-27 20:26:01.000000000 Z\nupdated_at: 2014-02-27 20:26:01.000000000 Z\n','2014-03-07 19:46:28','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:20.0) Gecko/20100101 Firefox/20.0',3),(14,'Dependencia',21,'update','3','---\nid: 21\nnombre: Rectorado\ndescripcion: \'\'\ncodigo: 62\ncreated_at: 2013-09-25 20:48:53.000000000 Z\nupdated_at: 2013-09-25 20:48:53.000000000 Z\norganismo_id: 2\nalias: \n','2014-03-07 19:51:42','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:20.0) Gecko/20100101 Firefox/20.0',3),(15,'Nota',39,'update','3','---\nid: 39\ntema: Funciona el codigo unico\ndescripcion: Ya esta funcionando la generacion de codigo unico\nfecha_ingreso: 2014-02-28\ncodigo: \'000022014\'\ntipo_nota_id: 1\nremitente_id: 84\ndestinatario_id: 84\nfecha_eliminada: \ncreated_at: 2014-02-28 19:50:35.000000000 Z\nupdated_at: 2014-02-28 19:50:35.000000000 Z\nfecha_nota: 2014-02-28\nfecha_carga: 2014-02-28\ntipo: 0\nestado: 1\ncargado_por_id: 3\nrecibido_por_id: 3\nparent_id: \ncargado_mesa_entrada: true\neliminada: false\n','2014-03-07 19:54:12','192.168.88.239','Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.146 Safari/537.36',3),(16,'Persona',31,'create','3',NULL,'2014-03-07 20:04:50','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:20.0) Gecko/20100101 Firefox/20.0',3),(17,'Cargo',16,'create','3',NULL,'2014-03-07 20:05:04','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:20.0) Gecko/20100101 Firefox/20.0',3),(18,'Entidad',86,'create','3',NULL,'2014-03-07 20:05:10','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:20.0) Gecko/20100101 Firefox/20.0',3),(19,'Nota',40,'create','3',NULL,'2014-03-07 20:06:18','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:20.0) Gecko/20100101 Firefox/20.0',3),(20,'TipoNota',2,'update','3','---\nid: 2\nnombre: Nota\ndescripcion: \'\'\ncreated_at: 2013-06-17 16:07:05.000000000 Z\nupdated_at: 2013-06-17 16:07:05.000000000 Z\n','2014-03-10 18:24:47','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3),(21,'NotaTemporal',1,'create','2',NULL,'2014-03-10 18:32:32','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',2),(22,'NotaTemporal',2,'create','2',NULL,'2014-03-10 18:51:09','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',2),(23,'Entidad',82,'update','3','---\nid: 82\npersona_id: 16\ndependencia_id: \ncargo_id: 8\nes_facultad: false\nuser_id: \ncreated_at: 2014-02-27 20:25:32.000000000 Z\nupdated_at: 2014-02-27 20:25:32.000000000 Z\nes_actual: true\n','2014-03-10 18:52:45','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3),(24,'Entidad',83,'update','3','---\nid: 83\npersona_id: 30\ndependencia_id: 1\ncargo_id: 15\nes_facultad: false\nuser_id: \ncreated_at: 2014-02-27 20:26:05.000000000 Z\nupdated_at: 2014-02-27 20:26:05.000000000 Z\nes_actual: true\n','2014-03-10 18:52:46','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3),(25,'Entidad',84,'update','3','---\nid: 84\npersona_id: 1\ndependencia_id: 29\ncargo_id: 10\nes_facultad: false\nuser_id: \ncreated_at: 2014-02-27 20:30:03.000000000 Z\nupdated_at: 2014-02-27 20:30:03.000000000 Z\nes_actual: true\n','2014-03-10 18:52:48','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3),(26,'Entidad',85,'update','3','---\nid: 85\npersona_id: 17\ndependencia_id: 1\ncargo_id: 2\nes_facultad: false\nuser_id: \ncreated_at: 2014-02-27 20:30:28.000000000 Z\nupdated_at: 2014-02-27 20:30:28.000000000 Z\nes_actual: true\n','2014-03-10 18:52:49','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3),(27,'Entidad',86,'update','3','---\nid: 86\npersona_id: 31\ndependencia_id: 1\ncargo_id: 16\nes_facultad: false\nuser_id: \ncreated_at: 2014-03-07 20:05:10.000000000 Z\nupdated_at: 2014-03-07 20:05:10.000000000 Z\nes_actual: true\n','2014-03-10 18:52:51','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3),(28,'Persona',32,'create','3',NULL,'2014-03-10 20:29:33','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3),(29,'Entidad',87,'create','3',NULL,'2014-03-10 20:29:38','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3),(30,'Entidad',87,'destroy','3','---\nid: 87\npersona_id: 32\ndependencia_id: 7\ncargo_id: 1\nes_facultad: false\nuser_id: \ncreated_at: 2014-03-10 20:29:38.000000000 Z\nupdated_at: 2014-03-10 20:29:38.000000000 Z\nes_actual: true\n','2014-03-10 20:57:47','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3),(31,'Entidad',88,'create','3',NULL,'2014-03-10 21:00:34','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3),(32,'User',3,'update','3','---\nid: 3\nusername: mbueno\nemail: mbueno@exa.unrc.edu.ar\npassword_hash: $2a$10$g1ENtzxAI9sFvV60ASU7T.nLifbmVQAGYOabfaq1C5ODmJgs24IJO\npassword_salt: $2a$10$g1ENtzxAI9sFvV60ASU7T.\nactive: true\ncreated_at: 2013-09-18 18:41:45.000000000 Z\nupdated_at: 2013-09-18 18:57:05.000000000 Z\nrol_id: 2\ndependencia_id: \n','2014-03-12 19:33:14','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3),(33,'User',3,'update','3','---\nid: 3\nusername: mbueno\nemail: mbueno@exa.unrc.edu.ar\npassword_hash: $2a$10$3ODEtTLTOvHmTJCMOp4KJOc0SqKpNqG2BnlFmETdvpdWmvz4WilR2\npassword_salt: $2a$10$3ODEtTLTOvHmTJCMOp4KJO\nactive: true\ncreated_at: 2013-09-18 18:41:45.000000000 Z\nupdated_at: 2014-03-12 19:33:14.000000000 Z\nrol_id: 2\ndependencia_id: \n','2014-03-12 19:53:56','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3),(34,'User',3,'update','3','---\nid: 3\nusername: mbueno\nemail: mbueno@exa.unrc.edu.ar\npassword_hash: $2a$10$/VUEe4Ubezg.XShFrmwJTeh0FHnSiw9lDvK8Jvy82RKTi3Zrnzi.S\npassword_salt: $2a$10$/VUEe4Ubezg.XShFrmwJTe\nactive: true\ncreated_at: 2013-09-18 18:41:45.000000000 Z\nupdated_at: 2014-03-12 19:53:56.000000000 Z\nrol_id: 2\ndependencia_id: \n','2014-03-12 20:02:16','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3),(35,'Entidad',89,'create','3',NULL,'2014-03-17 19:22:42','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3),(36,'Entidad',89,'destroy','3','---\nid: 89\npersona_id: 16\ndependencia_id: 1\ncargo_id: 8\nes_facultad: false\nuser_id: \ncreated_at: 2014-03-17 19:22:41.000000000 Z\nupdated_at: 2014-03-17 19:22:41.000000000 Z\nes_actual: true\n','2014-03-17 19:23:43','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3),(37,'Entidad',82,'update','3','---\nid: 82\npersona_id: 16\ndependencia_id: \ncargo_id: 8\nes_facultad: true\nuser_id: \ncreated_at: 2014-02-27 20:25:32.000000000 Z\nupdated_at: 2014-03-10 18:52:45.000000000 Z\nes_actual: true\n','2014-03-17 19:24:04','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3),(38,'Nota',41,'create','3',NULL,'2014-03-17 19:45:25','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3),(39,'NotaTemporal',1,'update','3','---\nid: 1\ntema: Destinatario No aparece\ndescripcion: \"Em el alta de notas desde la vista de secretaria de departamentos, no\n  me aparecio ningun destinatario.\\r\\nCalculo que es porque ninguno tiene el es_facultad\n  activo.\\r\\nes_facultad deberia ser en realidad algo como \\\"puede recibir notas desde\n  los departamentos\\\"\"\nfecha_nota: 2014-03-05\nfecha_carga: 2014-03-10\ncodigo: \'00560000201403050001\'\ntipo_nota_id: 2\nremitente_id: \ntexto_remitente: \'Director: Arroyo, Marcelo\'\ndestinatario_id: \ntexto_destinatario: \'Decana: Cattana, Rosa\'\ncargado_por_id: 2\ndependencia_id: 7\nestado: 0\nnota_id: \ncreated_at: 2014-03-10 18:32:32.000000000 Z\nupdated_at: 2014-03-10 18:32:32.000000000 Z\n','2014-03-17 19:45:25','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3),(40,'Nota',42,'create','3',NULL,'2014-03-17 19:46:34','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3),(41,'NotaTemporal',3,'create','2',NULL,'2014-03-17 19:47:44','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',2),(42,'Nota',43,'create','3',NULL,'2014-03-17 20:25:32','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3),(43,'NotaTemporal',2,'update','3','---\nid: 2\ntema: Generacion de Codigos\ndescripcion: \"Hay que hacer un solo metodo que calcule el codigo de la nota. Y deberia\n  estar fuera del modelo nota.\\r\\nAdemas se deberia realizar esta accion de manera\n  atomica.\"\nfecha_nota: 2014-03-10\nfecha_carga: 2014-03-10\ncodigo: \'000102014\'\ntipo_nota_id: 2\nremitente_id: \ntexto_remitente: \'Director: Arroyo, Marcelo\'\ndestinatario_id: \ntexto_destinatario: \'Programador: Marozzi, Mauro\'\ncargado_por_id: 2\ndependencia_id: 7\nestado: 0\nnota_id: \ncreated_at: 2014-03-10 18:51:09.000000000 Z\nupdated_at: 2014-03-10 18:51:09.000000000 Z\n','2014-03-17 20:25:32','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3),(44,'Nota',44,'create','3',NULL,'2014-03-17 20:26:23','127.0.0.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:27.0) Gecko/20100101 Firefox/27.0',3);
/*!40000 ALTER TABLE `versions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-03-18 15:56:14
