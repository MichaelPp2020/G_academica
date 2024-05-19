-- MariaDB dump 10.19-11.2.3-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: G_Academica
-- ------------------------------------------------------
-- Server version	11.2.3-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `asignatura`
--

DROP TABLE IF EXISTS `asignatura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asignatura` (
  `ID_ASIGNATURA` int(11) NOT NULL,
  `ID_ESTUDIANTE` int(11) DEFAULT NULL,
  `ID_DOCENTE` int(11) DEFAULT NULL,
  `NOMBRE` char(15) DEFAULT NULL,
  `DESCRIPCION` char(30) DEFAULT NULL,
  PRIMARY KEY (`ID_ASIGNATURA`),
  KEY `FK_RELATIONSHIP_7` (`ID_ESTUDIANTE`),
  KEY `FK_RELATIONSHIP_8` (`ID_DOCENTE`),
  CONSTRAINT `FK_RELATIONSHIP_7` FOREIGN KEY (`ID_ESTUDIANTE`) REFERENCES `estudiante` (`ID_ESTUDIANTE`),
  CONSTRAINT `FK_RELATIONSHIP_8` FOREIGN KEY (`ID_DOCENTE`) REFERENCES `docente` (`ID_DOCENTE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asignatura`
--

LOCK TABLES `asignatura` WRITE;
/*!40000 ALTER TABLE `asignatura` DISABLE KEYS */;
/*!40000 ALTER TABLE `asignatura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asistencia`
--

DROP TABLE IF EXISTS `asistencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asistencia` (
  `ID_ASISTENCIA` int(11) NOT NULL,
  `ID_INSPECTOR` int(11) DEFAULT NULL,
  `ID_ESTUDIANTE` int(11) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  `ESTADO` char(20) DEFAULT NULL,
  PRIMARY KEY (`ID_ASISTENCIA`),
  KEY `FK_RELATIONSHIP_14` (`ID_INSPECTOR`),
  KEY `FK_RELATIONSHIP_15` (`ID_ESTUDIANTE`),
  CONSTRAINT `FK_RELATIONSHIP_14` FOREIGN KEY (`ID_INSPECTOR`) REFERENCES `inspector` (`ID_INSPECTOR`),
  CONSTRAINT `FK_RELATIONSHIP_15` FOREIGN KEY (`ID_ESTUDIANTE`) REFERENCES `estudiante` (`ID_ESTUDIANTE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencia`
--

LOCK TABLES `asistencia` WRITE;
/*!40000 ALTER TABLE `asistencia` DISABLE KEYS */;
/*!40000 ALTER TABLE `asistencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calificacion`
--

DROP TABLE IF EXISTS `calificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calificacion` (
  `ID_CALIFICACION` int(11) NOT NULL,
  `ID_ESTUDIANTE` int(11) DEFAULT NULL,
  `ID_CURSO` int(11) DEFAULT NULL,
  `NOTA` int(11) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  PRIMARY KEY (`ID_CALIFICACION`),
  KEY `FK_RELATIONSHIP_16` (`ID_ESTUDIANTE`),
  KEY `FK_RELATIONSHIP_17` (`ID_CURSO`),
  CONSTRAINT `FK_RELATIONSHIP_16` FOREIGN KEY (`ID_ESTUDIANTE`) REFERENCES `estudiante` (`ID_ESTUDIANTE`),
  CONSTRAINT `FK_RELATIONSHIP_17` FOREIGN KEY (`ID_CURSO`) REFERENCES `curso` (`ID_CURSO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calificacion`
--

LOCK TABLES `calificacion` WRITE;
/*!40000 ALTER TABLE `calificacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `calificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conducta`
--

DROP TABLE IF EXISTS `conducta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conducta` (
  `ID_CONDUCTA` int(11) NOT NULL,
  `ID_ESTUDIANTE` int(11) DEFAULT NULL,
  `ID_INSPECTOR` int(11) DEFAULT NULL,
  `CALIFICACION` char(10) DEFAULT NULL,
  `OBSERVACIONES` char(30) DEFAULT NULL,
  PRIMARY KEY (`ID_CONDUCTA`),
  KEY `FK_RELATIONSHIP_24` (`ID_ESTUDIANTE`),
  KEY `FK_RELATIONSHIP_25` (`ID_INSPECTOR`),
  CONSTRAINT `FK_RELATIONSHIP_24` FOREIGN KEY (`ID_ESTUDIANTE`) REFERENCES `estudiante` (`ID_ESTUDIANTE`),
  CONSTRAINT `FK_RELATIONSHIP_25` FOREIGN KEY (`ID_INSPECTOR`) REFERENCES `inspector` (`ID_INSPECTOR`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conducta`
--

LOCK TABLES `conducta` WRITE;
/*!40000 ALTER TABLE `conducta` DISABLE KEYS */;
/*!40000 ALTER TABLE `conducta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso`
--

DROP TABLE IF EXISTS `curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curso` (
  `ID_CURSO` int(11) NOT NULL,
  `ID_ESTUDIANTE` int(11) DEFAULT NULL,
  `ID_DOCENTE` int(11) DEFAULT NULL,
  `DEPARTAMENTO` char(5) DEFAULT NULL,
  `CAPACIDAD` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_CURSO`),
  KEY `FK_RELATIONSHIP_18` (`ID_DOCENTE`),
  KEY `FK_RELATIONSHIP_6` (`ID_ESTUDIANTE`),
  CONSTRAINT `FK_RELATIONSHIP_18` FOREIGN KEY (`ID_DOCENTE`) REFERENCES `docente` (`ID_DOCENTE`),
  CONSTRAINT `FK_RELATIONSHIP_6` FOREIGN KEY (`ID_ESTUDIANTE`) REFERENCES `estudiante` (`ID_ESTUDIANTE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso`
--

LOCK TABLES `curso` WRITE;
/*!40000 ALTER TABLE `curso` DISABLE KEYS */;
/*!40000 ALTER TABLE `curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `docente`
--

DROP TABLE IF EXISTS `docente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `docente` (
  `ID_DOCENTE` int(11) NOT NULL,
  `ID_ROL` int(11) DEFAULT NULL,
  `ID_USUARIO` int(11) DEFAULT NULL,
  `NOMBRE` char(20) DEFAULT NULL,
  `APELLIDO` char(20) DEFAULT NULL,
  `ESPECIALIDAD` char(20) DEFAULT NULL,
  PRIMARY KEY (`ID_DOCENTE`),
  KEY `FK_RELATIONSHIP_5` (`ID_ROL`,`ID_USUARIO`),
  CONSTRAINT `FK_RELATIONSHIP_5` FOREIGN KEY (`ID_ROL`, `ID_USUARIO`) REFERENCES `usuario_roles` (`ID_ROL`, `ID_USUARIO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `docente`
--

LOCK TABLES `docente` WRITE;
/*!40000 ALTER TABLE `docente` DISABLE KEYS */;
/*!40000 ALTER TABLE `docente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ejemplo`
--

DROP TABLE IF EXISTS `ejemplo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ejemplo` (
  `ID` varchar(255) DEFAULT NULL,
  `NOMBRE` varchar(255) DEFAULT NULL,
  `EJEMPLO` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ejemplo`
--

LOCK TABLES `ejemplo` WRITE;
/*!40000 ALTER TABLE `ejemplo` DISABLE KEYS */;
/*!40000 ALTER TABLE `ejemplo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudiante`
--

DROP TABLE IF EXISTS `estudiante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estudiante` (
  `ID_ESTUDIANTE` int(11) NOT NULL,
  `ID_ROL` int(11) DEFAULT NULL,
  `ID_USUARIO` int(11) DEFAULT NULL,
  `NOMBRE` char(30) DEFAULT NULL,
  `APELLIDO` char(30) DEFAULT NULL,
  `FECHA_NACIMIENTO` date DEFAULT NULL,
  `GRADO_ACTUAL` char(10) DEFAULT NULL,
  `CELULAR_REPRESENTANTE` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_ESTUDIANTE`),
  KEY `FK_RELATIONSHIP_4` (`ID_ROL`,`ID_USUARIO`),
  CONSTRAINT `FK_RELATIONSHIP_4` FOREIGN KEY (`ID_ROL`, `ID_USUARIO`) REFERENCES `usuario_roles` (`ID_ROL`, `ID_USUARIO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiante`
--

LOCK TABLES `estudiante` WRITE;
/*!40000 ALTER TABLE `estudiante` DISABLE KEYS */;
/*!40000 ALTER TABLE `estudiante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventos_academico`
--

DROP TABLE IF EXISTS `eventos_academico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventos_academico` (
  `ID_EVENTOS` int(11) NOT NULL,
  `ID_ESTUDIANTE` int(11) DEFAULT NULL,
  `NOMBRE` char(20) DEFAULT NULL,
  `DESCRIPCION` char(20) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  `LUGAR` char(20) DEFAULT NULL,
  PRIMARY KEY (`ID_EVENTOS`),
  KEY `FK_RELATIONSHIP_28` (`ID_ESTUDIANTE`),
  CONSTRAINT `FK_RELATIONSHIP_28` FOREIGN KEY (`ID_ESTUDIANTE`) REFERENCES `estudiante` (`ID_ESTUDIANTE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventos_academico`
--

LOCK TABLES `eventos_academico` WRITE;
/*!40000 ALTER TABLE `eventos_academico` DISABLE KEYS */;
/*!40000 ALTER TABLE `eventos_academico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo`
--

DROP TABLE IF EXISTS `grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupo` (
  `ID_GRUPO` int(11) NOT NULL,
  `ID_CURSO` int(11) DEFAULT NULL,
  `ID_DOCENTE` int(11) DEFAULT NULL,
  `HORARIO` char(30) DEFAULT NULL,
  `NIVEL` char(15) DEFAULT NULL,
  PRIMARY KEY (`ID_GRUPO`),
  KEY `FK_RELATIONSHIP_10` (`ID_DOCENTE`),
  KEY `FK_RELATIONSHIP_9` (`ID_CURSO`),
  CONSTRAINT `FK_RELATIONSHIP_10` FOREIGN KEY (`ID_DOCENTE`) REFERENCES `docente` (`ID_DOCENTE`),
  CONSTRAINT `FK_RELATIONSHIP_9` FOREIGN KEY (`ID_CURSO`) REFERENCES `curso` (`ID_CURSO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo`
--

LOCK TABLES `grupo` WRITE;
/*!40000 ALTER TABLE `grupo` DISABLE KEYS */;
/*!40000 ALTER TABLE `grupo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incidentes`
--

DROP TABLE IF EXISTS `incidentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incidentes` (
  `ID_INCIDENTES` int(11) NOT NULL,
  `ID_ESTUDIANTE` int(11) DEFAULT NULL,
  `ID_INSPECTOR` int(11) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  `DESCRIPCION_INCIDENTE` char(30) DEFAULT NULL,
  `TIPO_SANCION` char(30) DEFAULT NULL,
  PRIMARY KEY (`ID_INCIDENTES`),
  KEY `FK_RELATIONSHIP_21` (`ID_ESTUDIANTE`),
  KEY `FK_RELATIONSHIP_23` (`ID_INSPECTOR`),
  CONSTRAINT `FK_RELATIONSHIP_21` FOREIGN KEY (`ID_ESTUDIANTE`) REFERENCES `estudiante` (`ID_ESTUDIANTE`),
  CONSTRAINT `FK_RELATIONSHIP_23` FOREIGN KEY (`ID_INSPECTOR`) REFERENCES `inspector` (`ID_INSPECTOR`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidentes`
--

LOCK TABLES `incidentes` WRITE;
/*!40000 ALTER TABLE `incidentes` DISABLE KEYS */;
/*!40000 ALTER TABLE `incidentes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inspector`
--

DROP TABLE IF EXISTS `inspector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inspector` (
  `ID_INSPECTOR` int(11) NOT NULL,
  `ID_ROL` int(11) DEFAULT NULL,
  `ID_USUARIO` int(11) DEFAULT NULL,
  `NOMBRE` char(20) DEFAULT NULL,
  `APELLIDO` char(30) DEFAULT NULL,
  `ESPECIALIDAD` char(20) DEFAULT NULL,
  PRIMARY KEY (`ID_INSPECTOR`),
  KEY `FK_RELATIONSHIP_11` (`ID_ROL`,`ID_USUARIO`),
  CONSTRAINT `FK_RELATIONSHIP_11` FOREIGN KEY (`ID_ROL`, `ID_USUARIO`) REFERENCES `usuario_roles` (`ID_ROL`, `ID_USUARIO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inspector`
--

LOCK TABLES `inspector` WRITE;
/*!40000 ALTER TABLE `inspector` DISABLE KEYS */;
/*!40000 ALTER TABLE `inspector` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `justificacion_asistencia`
--

DROP TABLE IF EXISTS `justificacion_asistencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `justificacion_asistencia` (
  `ID_ESTUDIANTE` int(11) DEFAULT NULL,
  `ID_JUSTIFICACION` int(11) NOT NULL,
  `ID_INSPECTOR` int(11) DEFAULT NULL,
  `TIPO` char(20) DEFAULT NULL,
  `ESTADO` char(20) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  PRIMARY KEY (`ID_JUSTIFICACION`),
  KEY `FK_RELATIONSHIP_26` (`ID_ESTUDIANTE`),
  KEY `FK_RELATIONSHIP_27` (`ID_INSPECTOR`),
  CONSTRAINT `FK_RELATIONSHIP_26` FOREIGN KEY (`ID_ESTUDIANTE`) REFERENCES `estudiante` (`ID_ESTUDIANTE`),
  CONSTRAINT `FK_RELATIONSHIP_27` FOREIGN KEY (`ID_INSPECTOR`) REFERENCES `inspector` (`ID_INSPECTOR`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `justificacion_asistencia`
--

LOCK TABLES `justificacion_asistencia` WRITE;
/*!40000 ALTER TABLE `justificacion_asistencia` DISABLE KEYS */;
/*!40000 ALTER TABLE `justificacion_asistencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matricula`
--

DROP TABLE IF EXISTS `matricula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matricula` (
  `ID_MATRICULA` int(11) NOT NULL,
  `ID_GRUPO` int(11) DEFAULT NULL,
  `ID_ESTUDIANTE` int(11) DEFAULT NULL,
  `PERIODO` char(20) DEFAULT NULL,
  `FECHA__MATRICULA` date DEFAULT NULL,
  PRIMARY KEY (`ID_MATRICULA`),
  KEY `FK_RELATIONSHIP_12` (`ID_GRUPO`),
  KEY `FK_RELATIONSHIP_13` (`ID_ESTUDIANTE`),
  CONSTRAINT `FK_RELATIONSHIP_12` FOREIGN KEY (`ID_GRUPO`) REFERENCES `grupo` (`ID_GRUPO`),
  CONSTRAINT `FK_RELATIONSHIP_13` FOREIGN KEY (`ID_ESTUDIANTE`) REFERENCES `estudiante` (`ID_ESTUDIANTE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matricula`
--

LOCK TABLES `matricula` WRITE;
/*!40000 ALTER TABLE `matricula` DISABLE KEYS */;
/*!40000 ALTER TABLE `matricula` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan_estudio`
--

DROP TABLE IF EXISTS `plan_estudio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plan_estudio` (
  `ID_EVENTOS` int(11) NOT NULL,
  `ID_ASIGNATURA` int(11) NOT NULL,
  PRIMARY KEY (`ID_EVENTOS`,`ID_ASIGNATURA`),
  KEY `FK_RELATIONSHIP_29` (`ID_ASIGNATURA`),
  CONSTRAINT `FK_RELATIONSHIP_29` FOREIGN KEY (`ID_ASIGNATURA`) REFERENCES `asignatura` (`ID_ASIGNATURA`),
  CONSTRAINT `FK_RELATIONSHIP_30` FOREIGN KEY (`ID_EVENTOS`) REFERENCES `programas_academico` (`ID_EVENTOS`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_estudio`
--

LOCK TABLES `plan_estudio` WRITE;
/*!40000 ALTER TABLE `plan_estudio` DISABLE KEYS */;
/*!40000 ALTER TABLE `plan_estudio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programas_academico`
--

DROP TABLE IF EXISTS `programas_academico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `programas_academico` (
  `ID_EVENTOS` int(11) NOT NULL,
  `NOMBRE` char(20) DEFAULT NULL,
  `DESCRIPCION` char(20) DEFAULT NULL,
  `ASIGNATURA_REQUERIDA` char(20) DEFAULT NULL,
  PRIMARY KEY (`ID_EVENTOS`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programas_academico`
--

LOCK TABLES `programas_academico` WRITE;
/*!40000 ALTER TABLE `programas_academico` DISABLE KEYS */;
/*!40000 ALTER TABLE `programas_academico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rol` (
  `ID_ROL` int(11) NOT NULL,
  `NOMBRE` char(20) DEFAULT NULL,
  PRIMARY KEY (`ID_ROL`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sanciones`
--

DROP TABLE IF EXISTS `sanciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sanciones` (
  `ID_SANCION` int(11) NOT NULL,
  `ID_INSPECTOR` int(11) DEFAULT NULL,
  `ID_ESTUDIANTE` int(11) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  `DESCRIPCION` char(20) DEFAULT NULL,
  `TIPO` char(20) DEFAULT NULL,
  PRIMARY KEY (`ID_SANCION`),
  KEY `FK_RELATIONSHIP_19` (`ID_INSPECTOR`),
  KEY `FK_RELATIONSHIP_22` (`ID_ESTUDIANTE`),
  CONSTRAINT `FK_RELATIONSHIP_19` FOREIGN KEY (`ID_INSPECTOR`) REFERENCES `inspector` (`ID_INSPECTOR`),
  CONSTRAINT `FK_RELATIONSHIP_22` FOREIGN KEY (`ID_ESTUDIANTE`) REFERENCES `estudiante` (`ID_ESTUDIANTE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sanciones`
--

LOCK TABLES `sanciones` WRITE;
/*!40000 ALTER TABLE `sanciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `sanciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `ID_USUARIO` int(11) NOT NULL,
  `USUARIO` char(20) DEFAULT NULL,
  `CONTRASENA` char(30) DEFAULT NULL,
  PRIMARY KEY (`ID_USUARIO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_roles`
--

DROP TABLE IF EXISTS `usuario_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario_roles` (
  `ID_ROL` int(11) NOT NULL,
  `ID_USUARIO` int(11) NOT NULL,
  PRIMARY KEY (`ID_ROL`,`ID_USUARIO`),
  KEY `FK_RELATIONSHIP_2` (`ID_USUARIO`),
  CONSTRAINT `FK_RELATIONSHIP_2` FOREIGN KEY (`ID_USUARIO`) REFERENCES `usuario` (`ID_USUARIO`),
  CONSTRAINT `FK_RELATIONSHIP_3` FOREIGN KEY (`ID_ROL`) REFERENCES `rol` (`ID_ROL`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_roles`
--

LOCK TABLES `usuario_roles` WRITE;
/*!40000 ALTER TABLE `usuario_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario_roles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-10  6:38:00
