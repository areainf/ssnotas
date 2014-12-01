-- MySQL dump 10.13  Distrib 5.5.32, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: ssnotas_development
-- ------------------------------------------------------
-- Server version	5.5.32-0ubuntu0.12.04.1

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
-- Table structure for table `autoridades`
--

DROP TABLE IF EXISTS `autoridades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autoridades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cargo` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoridades`
--

LOCK TABLES `autoridades` WRITE;
/*!40000 ALTER TABLE `autoridades` DISABLE KEYS */;
INSERT INTO `autoridades` VALUES (1,'Decano','','2013-06-09 18:27:45','2013-06-09 18:27:45'),(2,'Secretario Tecnico','','2013-06-09 18:29:21','2013-06-10 13:23:32');
/*!40000 ALTER TABLE `autoridades` ENABLE KEYS */;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dependencias`
--

LOCK TABLES `dependencias` WRITE;
/*!40000 ALTER TABLE `dependencias` DISABLE KEYS */;
INSERT INTO `dependencias` VALUES (1,'Decanato','',1,'2013-06-06 22:41:42','2013-06-06 22:41:42',1),(2,'Departamento de Microbiología','',50,'2013-06-06 23:20:07','2013-06-06 23:20:07',1),(3,'Departamento de Matemáticas','',55,'2013-06-06 23:26:21','2013-06-06 23:27:06',1),(5,'Pagano Hogar','',2,'2013-06-07 03:35:32','2013-06-25 19:28:43',7),(6,'Riveiro','',10,'2013-06-09 04:39:03','2013-06-25 19:09:01',7),(7,'Departamento de Computación','',56,'2013-06-07 03:36:34','2013-06-07 03:36:34',1),(9,'Departamento de Geologia','',57,'2013-06-07 18:57:39','2013-06-07 18:57:39',1),(10,'test','exa',58,'2013-06-25 17:22:59','2013-06-25 17:22:59',1);
/*!40000 ALTER TABLE `dependencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `destinatarios`
--

DROP TABLE IF EXISTS `destinatarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `destinatarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `apellido` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `autoridad_id` int(11) DEFAULT NULL,
  `nro_autoridad` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `destinatarios`
--

LOCK TABLES `destinatarios` WRITE;
/*!40000 ALTER TABLE `destinatarios` DISABLE KEYS */;
INSERT INTO `destinatarios` VALUES (1,'Rosa','Cattana','',1,1,'2013-06-10 12:01:16','2013-06-10 12:01:16'),(2,'Luis','Poloni','',2,1,'2013-06-10 13:28:03','2013-06-10 13:28:03'),(3,'Marcela','Daniele','',2,2,'2013-06-10 13:28:24','2013-06-10 13:28:24');
/*!40000 ALTER TABLE `destinatarios` ENABLE KEYS */;
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
  `fecha_eliminada` date DEFAULT NULL,
  `fecha_finalizada` date DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas`
--

LOCK TABLES `notas` WRITE;
/*!40000 ALTER TABLE `notas` DISABLE KEYS */;
INSERT INTO `notas` VALUES (1,'Tema Nro 1','Poner por defecto la fecha actual','2013-06-14','00000001000000022013061400000001',2,1,2,NULL,NULL,'2013-06-14 20:39:37','2013-06-17 19:35:41'),(2,'2da Nota','Generando codigo automaticamente','2013-06-14','00000001000000032013061400000001',1,1,3,NULL,NULL,'2013-06-14 20:43:07','2013-06-14 20:43:07'),(3,'otra mas','Final','2013-06-14','00000001000000032013061400000002',1,1,3,NULL,NULL,'2013-06-14 20:43:42','2013-06-14 20:43:42'),(4,'Prueba de nota enviada por el gerente de riveiro a la decana Rosa Cattana. Aca iria el motivo o tema','Tengo que ver la forma de mostrar las notas en una grilla debido a que no se muestra correctamente la informacion cuando la nota tiene un poco de contenido.\r\n\r\nEn teoria todas las notas tienen este tamaño','2013-06-15','00000003000000012013061500000001',1,3,1,NULL,NULL,'2013-06-15 03:12:13','2013-06-15 03:12:13'),(5,'Lo que faltaria hacer en notas.','En Nuevo permitir agregar;\r\n   - Dependencia\r\n   - Remitente\r\n   - Destinatario\r\n   - Tipo de Nota\r\nEn Listado:\r\n   - Permitir especificar el campo de busqueda, por ejemplo rm:remitente dt:destinatario cd:codigo desc: descripcion\r\n','2013-06-15','00000001000000032013061500000001',1,1,3,NULL,NULL,'2013-06-15 03:18:22','2013-06-15 03:18:22');
/*!40000 ALTER TABLE `notas` ENABLE KEYS */;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organismos`
--

LOCK TABLES `organismos` WRITE;
/*!40000 ALTER TABLE `organismos` DISABLE KEYS */;
INSERT INTO `organismos` VALUES (1,'Fac. Ciencias Exactas Físico Químicas y Naturales','',1,'2013-06-24 19:14:04','2013-06-24 19:14:04'),(2,'Universidad Nacional de Río Cuarto','',2,'2013-06-24 19:15:43','2013-06-24 19:15:43'),(3,'Fac. de Agronomia y Veterinaria','',3,'2013-06-24 19:16:15','2013-06-24 19:16:15'),(4,'Fac. de Ciencias Económicas','',4,'2013-06-24 19:16:41','2013-06-24 19:16:41'),(5,'Fac. de Ciencias Humanas','',5,'2013-06-24 19:16:59','2013-06-24 19:16:59'),(6,'Fac. de Ingenieria','',6,'2013-06-24 19:17:12','2013-06-24 19:17:12'),(7,'Otro','',9999,'2013-06-24 19:17:26','2013-06-24 19:17:26');
/*!40000 ALTER TABLE `organismos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remitentes`
--

DROP TABLE IF EXISTS `remitentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remitentes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `dependencia_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remitentes`
--

LOCK TABLES `remitentes` WRITE;
/*!40000 ALTER TABLE `remitentes` DISABLE KEYS */;
INSERT INTO `remitentes` VALUES (1,'Decana','Decana de Exactas',1,'2013-06-09 03:22:32','2013-06-09 03:34:24'),(2,'Secretaría tecnica','',1,'2013-06-09 03:35:12','2013-06-09 03:35:12'),(3,'Gerente','',6,'2013-06-09 03:36:45','2013-06-09 03:36:45'),(4,'Director','',9,'2013-06-24 17:41:54','2013-06-24 17:41:54'),(5,'Director2','',9,'2013-06-24 17:45:26','2013-06-24 17:45:26');
/*!40000 ALTER TABLE `remitentes` ENABLE KEYS */;
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
  `code` int(11) DEFAULT NULL,
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
INSERT INTO `roles` VALUES (1,'Admin',1,'2013-07-05 19:35:31','2013-07-05 19:35:31'),(2,'Mesa de Entrada',2,'2013-07-05 19:37:57','2013-07-05 19:37:57'),(3,'Secretarios Departamento',3,'2013-07-05 19:38:34','2013-07-05 19:38:34');
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
INSERT INTO `schema_migrations` VALUES ('20130606220004'),('20130608161109'),('20130609024321'),('20130609162849'),('20130609180348'),('20130609184103'),('20130610130921'),('20130611015807'),('20130624182924'),('20130625155028'),('20130625194844'),('20130629135341'),('20130629135550'),('20130701162019'),('20130705185510'),('20130705185736'),('20130705192413'),('20130705192741');
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
INSERT INTO `tipos_notas` VALUES (1,'Expedientes','','2013-06-09 17:44:18','2013-06-09 17:44:18'),(2,'Nota','','2013-06-17 16:07:05','2013-06-17 16:07:05');
/*!40000 ALTER TABLE `tipos_notas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_haves_roles`
--

DROP TABLE IF EXISTS `user_haves_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_haves_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `rol_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_haves_roles`
--

LOCK TABLES `user_haves_roles` WRITE;
/*!40000 ALTER TABLE `user_haves_roles` DISABLE KEYS */;
INSERT INTO `user_haves_roles` VALUES (1,1,1,'2013-07-05 19:41:45','2013-07-05 19:41:45');
/*!40000 ALTER TABLE `user_haves_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(128) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_users_on_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'mmarozzi@gmail.com','$2a$10$AAtkZgg7HgoJF2UjYie1b.PYqAD0IW0Dwn/wngTWnNMZ5P8W3SgTq',NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'2013-07-05 19:40:36','2013-07-05 19:47:19','mmarozzi',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-08-06  7:09:33
