-- MySQL dump 10.13  Distrib 5.7.20, for Win64 (x86_64)
--
-- Host: localhost    Database: project_crowd
-- ------------------------------------------------------
-- Server version	5.7.20

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
-- Table structure for table `inner_admin_role`
--

DROP TABLE IF EXISTS `inner_admin_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inner_admin_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inner_admin_role`
--

LOCK TABLES `inner_admin_role` WRITE;
/*!40000 ALTER TABLE `inner_admin_role` DISABLE KEYS */;
INSERT INTO `inner_admin_role` VALUES (12,1424,13),(13,1424,15),(14,1425,14),(15,1425,16);
/*!40000 ALTER TABLE `inner_admin_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inner_role_auth`
--

DROP TABLE IF EXISTS `inner_role_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inner_role_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) DEFAULT NULL,
  `auth_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inner_role_auth`
--

LOCK TABLES `inner_role_auth` WRITE;
/*!40000 ALTER TABLE `inner_role_auth` DISABLE KEYS */;
INSERT INTO `inner_role_auth` VALUES (15,15,1),(16,15,8),(17,16,4),(18,16,5);
/*!40000 ALTER TABLE `inner_role_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_address`
--

DROP TABLE IF EXISTS `t_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `receive_name` char(100) DEFAULT NULL COMMENT '收件人',
  `phone_num` char(100) DEFAULT NULL COMMENT '手机号',
  `address` char(200) DEFAULT NULL COMMENT '收货地址',
  `member_id` int(11) DEFAULT NULL COMMENT '用户 id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_address`
--

LOCK TABLES `t_address` WRITE;
/*!40000 ALTER TABLE `t_address` DISABLE KEYS */;
INSERT INTO `t_address` VALUES (1,'taoye','1321231321','上海市普通新区',1),(2,'songguoguo','123456789','上海市普通新区',1);
/*!40000 ALTER TABLE `t_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_admin`
--

DROP TABLE IF EXISTS `t_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login_acct` varchar(255) NOT NULL,
  `user_pswd` char(100) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `create_time` char(19) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_acct` (`login_acct`)
) ENGINE=InnoDB AUTO_INCREMENT=1431 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_admin`
--

LOCK TABLES `t_admin` WRITE;
/*!40000 ALTER TABLE `t_admin` DISABLE KEYS */;
INSERT INTO `t_admin` VALUES (2,'taoye','$2a$10$AmUKtCWxDuwFLxwRUHP7yO6QtomSvY5A8vre/OeNyziib.Q6l3vJe','taoye','510087153@qq.com','2020-04-05'),(3,'muzimz','$2a$10$AmUKtCWxDuwFLxwRUHP7yO6QtomSvY5A8vre/OeNyziib.Q6l3vJe','taoye','510087153@qq.com','2020-04-05'),(1423,'songguoguo','$2a$10$LKZDH2wD1ws/8o.PuhBZA.ADJZ.MZ.Fpr5D8XRP6P1mstNNKZeGfa','songguoguo','510087153@qq.com','2020-04-07 10:31:50'),(1424,'adminOperator','$2a$10$OhPsJJ2RJg45Q6fFIlo41eOInKubnznrLNQIXmg7ad9nJuBLgUOlu','天行健','510087153@qq.com','2020-04-07 10:33:08'),(1425,'roleOperator','$2a$10$Nojr4w8ATVYc9LtfB2vCUuFmY3uTdihGWKL19o.wQc1i/a1Fomsqy','天行健','510087153@qq.com','2020-04-07 10:34:26'),(1426,'admin01','$2a$10$s3kqr0fW9c2N0yDDrd5Lc./MN3Mc32jbjD5Kw/0G.UFIQA5KKMi3i','天行健','510087153@qq.com','2020-04-07 10:35:39'),(1427,'admin02','$2a$10$gBS5EObYCc12GSgGsP98FORvoc9RYtJgnPuGi2Ek2/Z8qLuj9n.D2','songguoguo','510087153@qq.com','2020-04-07 10:35:53'),(1428,'admin03','$2a$10$brfBxdLbTkn6WcTVytsmHOWrlWuZFw2wpcymAttNL5y9u4lpz5AQu','songguoguo','510087153@qq.com','2020-04-07 10:36:14'),(1429,'tian','510087153','天行健','510087153@qq.com','2020-04-15'),(1430,'xing','510087153','行','510087153@qq.com','2020-04-15');
/*!40000 ALTER TABLE `t_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_auth`
--

DROP TABLE IF EXISTS `t_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_auth`
--

LOCK TABLES `t_auth` WRITE;
/*!40000 ALTER TABLE `t_auth` DISABLE KEYS */;
INSERT INTO `t_auth` VALUES (1,'','用户模块',NULL),(2,'user:delete','删除',1),(3,'user:get','查询',1),(4,'','角色模块',NULL),(5,'role:delete','删除',4),(6,'role:get','查询',4),(7,'role:add','新增',4),(8,'user:save','保存',1);
/*!40000 ALTER TABLE `t_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_member`
--

DROP TABLE IF EXISTS `t_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loginacct` varchar(255) NOT NULL,
  `userpswd` char(200) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `authstatus` int(4) DEFAULT NULL COMMENT '实名认证状态 0 - 未实名认证， 1 - 实名认证申\n请中， 2 - 已实名认证',
  `usertype` int(4) DEFAULT NULL COMMENT ' 0 - 个人， 1 - 企业',
  `realname` varchar(255) DEFAULT NULL,
  `cardnum` varchar(255) DEFAULT NULL,
  `accttype` int(4) DEFAULT NULL COMMENT '0 - 企业， 1 - 个体， 2 - 个人， 3 - 政府',
  PRIMARY KEY (`id`),
  UNIQUE KEY `loginacct` (`loginacct`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_member`
--

LOCK TABLES `t_member` WRITE;
/*!40000 ALTER TABLE `t_member` DISABLE KEYS */;
INSERT INTO `t_member` VALUES (1,'taoye','$2a$10$r2DS3f.09Ln3gFaYlKg2cujOsaPdvxwAtJ7MAfUAKxEXrH.hTrbTu','taoye','510087153@qq.com',1,1,'??','510087153',2),(7,'songguoguo','$2a$10$KT7pP8IzIf37xts63u96RupF/r.hSG..X4df/QZbNxmos2qkC.YSm','松果果','510087153@qq.com',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `t_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_member_confirm_info`
--

DROP TABLE IF EXISTS `t_member_confirm_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_member_confirm_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `memberid` int(11) DEFAULT NULL COMMENT '会员 id',
  `paynum` varchar(200) DEFAULT NULL COMMENT '易付宝企业账号',
  `cardnum` varchar(200) DEFAULT NULL COMMENT '法人身份证号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_member_confirm_info`
--

LOCK TABLES `t_member_confirm_info` WRITE;
/*!40000 ALTER TABLE `t_member_confirm_info` DISABLE KEYS */;
INSERT INTO `t_member_confirm_info` VALUES (1,1,'18801282948','18801282948'),(2,7,'18801282948','18801282948'),(3,7,'18801282948','18801282948'),(4,1,'18801282948','18801282948'),(5,1,'18801282948','18801282948');
/*!40000 ALTER TABLE `t_member_confirm_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_member_launch_info`
--

DROP TABLE IF EXISTS `t_member_launch_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_member_launch_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `memberid` int(11) DEFAULT NULL COMMENT '会员 id',
  `description_simple` varchar(255) DEFAULT NULL COMMENT '简单介绍',
  `description_detail` varchar(255) DEFAULT NULL COMMENT '详细介绍',
  `phone_num` varchar(255) DEFAULT NULL COMMENT '联系电话',
  `service_num` varchar(255) DEFAULT NULL COMMENT '客服电话',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_member_launch_info`
--

LOCK TABLES `t_member_launch_info` WRITE;
/*!40000 ALTER TABLE `t_member_launch_info` DISABLE KEYS */;
INSERT INTO `t_member_launch_info` VALUES (1,1,'i am mao','我是猫哥','123456','654321'),(2,7,'大萨达撒多撒多','所发生的发生发过是发给','123456','654321'),(3,7,'i am mao','我是猫哥','123456','654321'),(4,1,'i am mao','我是猫哥','123456','654321'),(5,1,'i am mao','我是猫哥','123456','654321');
/*!40000 ALTER TABLE `t_member_launch_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_menu`
--

DROP TABLE IF EXISTS `t_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `icon` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_menu`
--

LOCK TABLES `t_menu` WRITE;
/*!40000 ALTER TABLE `t_menu` DISABLE KEYS */;
INSERT INTO `t_menu` VALUES (1,NULL,'系统权限菜单',NULL,'glyphicon glyphicon-th-list'),(2,1,' 控 制 面 板 ','main.htm','glyphicon glyphicon-dashboard'),(3,1,'权限管理',NULL,'glyphicon glyphicon glyphicon-tasks'),(5,3,' 角 色 维 护 ','role/index.htm','glyphicon glyphicon-king'),(6,3,' 菜 单 维 护 ','permission/index.htm','glyphicon glyphicon-lock'),(7,1,' 业 务 审 核 ',NULL,'glyphicon glyphicon-ok'),(8,7,'实名认证审核','auth_cert/index.htm','glyphicon glyphicon-check'),(9,7,' 广 告 审 核 ','auth_adv/index.htm','glyphicon glyphicon-check'),(10,7,' 项 目 审 核 ','auth_project/index.htm','glyphicon glyphicon-check'),(11,1,' 业 务 管 理 ',NULL,'glyphicon glyphicon-th-large'),(12,11,' 资 质 维 护 ','cert/index.htm','glyphicon glyphicon-picture'),(13,11,' 分 类 管 理 ','certtype/index.htm','glyphicon glyphicon-equalizer'),(14,11,' 流 程 管 理 ','process/index.htm','glyphicon glyphicon-random'),(15,11,' 广 告 管 理 ','advert/index.htm','glyphicon glyphicon-hdd'),(16,11,' 消 息 模 板 ','message/index.htm','glyphicon glyphicon-comment'),(17,11,' 项 目 分 类 ','projectType/index.htm','glyphicon glyphicon-list'),(18,11,' 项 目 标 签 ','tag/index.htm','glyphicon glyphicon-tags'),(19,1,' 参 数 管 理 ','param/index.htm','glyphicon glyphicon-list-alt'),(20,3,'用 户 维 护','user/index.htm','glyphicon glyphicon-user');
/*!40000 ALTER TABLE `t_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_order`
--

DROP TABLE IF EXISTS `t_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_num` char(100) DEFAULT NULL COMMENT '订单号',
  `pay_order_num` char(100) DEFAULT NULL COMMENT '支付宝流水号',
  `order_amount` double(10,5) DEFAULT NULL COMMENT '订单金额',
  `invoice` int(11) DEFAULT NULL COMMENT '是否开发票（0 不开，1 开）',
  `invoice_title` char(100) DEFAULT NULL COMMENT '发票抬头',
  `order_remark` char(100) DEFAULT NULL COMMENT '订单备注',
  `address_id` char(100) DEFAULT NULL COMMENT '收货地址 id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_order`
--

LOCK TABLES `t_order` WRITE;
/*!40000 ALTER TABLE `t_order` DISABLE KEYS */;
INSERT INTO `t_order` VALUES (1,'202004142224487520D07BDCDB457F825A5277C92714B9','2020041422001417480501352898',80.00000,1,'爱的色放打发点方法都是','规划还记得东方红',NULL);
/*!40000 ALTER TABLE `t_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_order_project`
--

DROP TABLE IF EXISTS `t_order_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_order_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `project_name` char(200) DEFAULT NULL COMMENT '项目名称',
  `launch_name` char(100) DEFAULT NULL COMMENT '发起人',
  `return_content` char(200) DEFAULT NULL COMMENT '回报内容',
  `return_count` int(11) DEFAULT NULL COMMENT '回报数量',
  `support_price` int(11) DEFAULT NULL COMMENT '支持单价',
  `freight` int(11) DEFAULT NULL COMMENT '配送费用',
  `order_id` int(11) DEFAULT NULL COMMENT '订单表的主键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_order_project`
--

LOCK TABLES `t_order_project` WRITE;
/*!40000 ALTER TABLE `t_order_project` DISABLE KEYS */;
INSERT INTO `t_order_project` VALUES (1,'brotherMao','i am mao','以身相许',8,10,0,1);
/*!40000 ALTER TABLE `t_order_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_project`
--

DROP TABLE IF EXISTS `t_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_name` varchar(255) DEFAULT NULL COMMENT '项目名称',
  `project_description` varchar(255) DEFAULT NULL COMMENT '项目描述',
  `money` bigint(11) DEFAULT NULL COMMENT '筹集金额',
  `day` int(11) DEFAULT NULL COMMENT '筹集天数',
  `status` int(4) DEFAULT NULL COMMENT '0-即将开始，1-众筹中，2-众筹成功，3-众筹失败\n',
  `deploydate` varchar(10) DEFAULT NULL COMMENT '项目发起时间',
  `supportmoney` bigint(11) DEFAULT NULL COMMENT '已筹集到的金额',
  `supporter` int(11) DEFAULT NULL COMMENT '支持人数',
  `completion` int(3) DEFAULT NULL COMMENT '百分比完成度',
  `memberid` int(11) DEFAULT NULL COMMENT '发起人的会员 id',
  `createdate` varchar(19) DEFAULT NULL COMMENT '项目创建时间',
  `follower` int(11) DEFAULT NULL COMMENT '关注人数',
  `header_picture_path` varchar(255) DEFAULT NULL COMMENT '头图路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_project`
--

LOCK TABLES `t_project` WRITE;
/*!40000 ALTER TABLE `t_project` DISABLE KEYS */;
INSERT INTO `t_project` VALUES (6,'brotherMao','就是帅！',NULL,30,0,'2020-04-13',NULL,NULL,NULL,1,'2020-04-13',NULL,'http://115.29.149.30:8080/group1/M00/00/00/rB-4aF6UYrKAemxnAACEp4aRTT0106.jpg'),(7,'超级计算机','超级计算机',NULL,30,0,'2020-04-13',NULL,NULL,NULL,7,'2020-04-14',NULL,'http://115.29.149.30:8080/group1/M00/00/00/rB-4aF6VQaaAJELiAAF-VXusT2A575.gif'),(8,'brotherMao','就是帅！',NULL,30,0,'2020-04-13',NULL,NULL,NULL,7,'2020-04-14',NULL,'http://115.29.149.30:8080/group1/M00/00/00/rB-4aF6VQ-eAFi7oAAFmN02q500240.jpg'),(9,'brotherMao','就是帅！',100000,30,0,'2020-04-13',NULL,NULL,NULL,1,'2020-04-14',NULL,'http://115.29.149.30:8080/group1/M00/00/00/rB-4aF6VSDyAc3InAACEp4aRTT0794.jpg'),(10,'brotherMao','就是帅！',100000,30,0,'2020-04-13',NULL,NULL,NULL,1,'2020-04-14',NULL,'http://115.29.149.30:8080/group1/M00/00/00/rB-4aF6VSuWAME2uAACaYWEc7Lc016.jpg');
/*!40000 ALTER TABLE `t_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_project_item_pic`
--

DROP TABLE IF EXISTS `t_project_item_pic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_project_item_pic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projectid` int(11) DEFAULT NULL,
  `item_pic_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_project_item_pic`
--

LOCK TABLES `t_project_item_pic` WRITE;
/*!40000 ALTER TABLE `t_project_item_pic` DISABLE KEYS */;
INSERT INTO `t_project_item_pic` VALUES (1,6,'http://115.29.149.30:8080/group1/M00/00/00/rB-4aF6UYrOAMMLOAAAiuzEM_3o759.jpg'),(2,7,'http://115.29.149.30:8080/group1/M00/00/00/rB-4aF6VQaeAeZ6cAAPVkDrtwz0995.jpg'),(3,8,'http://115.29.149.30:8080/group1/M00/00/00/rB-4aF6VQaeABkCjAAHqhv_qGlY595.jpg'),(4,9,'http://115.29.149.30:8080/group1/M00/00/00/rB-4aF6VQ-iAN-_IAA8rjYWjVMc108.jpg'),(5,10,'http://115.29.149.30:8080/group1/M00/00/00/rB-4aF6VSDyAD-RrAAAiuzEM_3o836.jpg'),(6,10,'http://115.29.149.30:8080/group1/M00/00/00/rB-4aF6VSuaAYtHxAA8qdQCrNsQ915.jpg');
/*!40000 ALTER TABLE `t_project_item_pic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_project_tag`
--

DROP TABLE IF EXISTS `t_project_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_project_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projectid` int(11) DEFAULT NULL,
  `tagid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_project_tag`
--

LOCK TABLES `t_project_tag` WRITE;
/*!40000 ALTER TABLE `t_project_tag` DISABLE KEYS */;
INSERT INTO `t_project_tag` VALUES (6,6,4),(7,7,5),(8,8,8),(9,9,9),(10,10,6),(11,6,4),(12,6,8),(13,7,9),(14,7,6),(15,8,5),(16,8,6),(17,9,8),(18,9,7),(19,10,9),(20,10,6),(21,7,4),(22,8,9),(23,10,8),(24,9,10),(25,10,6),(26,10,8),(27,10,10);
/*!40000 ALTER TABLE `t_project_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_project_type`
--

DROP TABLE IF EXISTS `t_project_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_project_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projectid` int(11) DEFAULT NULL,
  `typeid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_project_type`
--

LOCK TABLES `t_project_type` WRITE;
/*!40000 ALTER TABLE `t_project_type` DISABLE KEYS */;
INSERT INTO `t_project_type` VALUES (11,6,2),(12,7,4),(13,7,1),(14,7,2),(15,8,3),(16,8,4),(17,8,1),(18,9,2),(19,9,3),(20,9,4),(21,10,1),(22,10,2),(23,7,3),(24,8,4),(25,10,1),(26,10,2),(27,10,3),(28,10,4);
/*!40000 ALTER TABLE `t_project_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_return`
--

DROP TABLE IF EXISTS `t_return`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_return` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projectid` int(11) DEFAULT NULL,
  `type` int(4) DEFAULT NULL COMMENT '0 - 实物回报， 1 虚拟物品回报',
  `supportmoney` int(11) DEFAULT NULL COMMENT '支持金额',
  `content` varchar(255) DEFAULT NULL COMMENT '回报内容',
  `count` int(11) DEFAULT NULL COMMENT '回报产品限额，“0”为不限回报数量',
  `signalpurchase` int(11) DEFAULT NULL COMMENT '是否设置单笔限购',
  `purchase` int(11) DEFAULT NULL COMMENT '具体限购数量',
  `freight` int(11) DEFAULT NULL COMMENT '运费，“0”为包邮',
  `invoice` int(4) DEFAULT NULL COMMENT '0 - 不开发票， 1 - 开发票',
  `returndate` int(11) DEFAULT NULL COMMENT '项目结束后多少天向支持者发送回报',
  `describ_pic_path` varchar(255) DEFAULT NULL COMMENT '说明图片路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_return`
--

LOCK TABLES `t_return` WRITE;
/*!40000 ALTER TABLE `t_return` DISABLE KEYS */;
INSERT INTO `t_return` VALUES (1,6,NULL,10,'以身相许',5,1,8,10,1,15,'http://115.29.149.30:8080/group1/M00/00/00/rB-4aF6UYr6AdmMAAAF-VXusT2A656.gif'),(2,7,0,100,'以身相许',10,1,8,30,1,20,'http://115.29.149.30:8080/group1/M00/00/00/rB-4aF6VQbyAQm1ZAAIApavVEwA657.jpg'),(3,8,0,100,'以身相许',20,0,8,10,1,3,'http://115.29.149.30:8080/group1/M00/00/00/rB-4aF6VQdmAJalIAAHqhv_qGlY486.jpg'),(4,9,1,10,'以身相许',5,1,8,0,1,15,'http://115.29.149.30:8080/group1/M00/00/00/rB-4aF6VRAmAB_w-AA8rjYWjVMc331.jpg'),(5,10,1,10,'以身相许',5,1,8,0,1,15,'http://115.29.149.30:8080/group1/M00/00/00/rB-4aF6VRAmAB_w-AA8rjYWjVMc331.jpg'),(6,7,0,10,'以身相许',5,1,8,30,1,15,'http://115.29.149.30:8080/group1/M00/00/00/rB-4aF6VSEmAK5k_AACZX8D9B1g238.jpg'),(7,10,0,10,'以身相许',5,NULL,8,0,1,15,'http://115.29.149.30:8080/group1/M00/00/00/rB-4aF6VSvmACJXwAA8WeAqVi18676.jpg');
/*!40000 ALTER TABLE `t_return` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_role`
--

DROP TABLE IF EXISTS `t_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_role`
--

LOCK TABLES `t_role` WRITE;
/*!40000 ALTER TABLE `t_role` DISABLE KEYS */;
INSERT INTO `t_role` VALUES (13,'经理'),(14,'部长'),(15,'经理操作者'),(16,'部长操作者');
/*!40000 ALTER TABLE `t_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_tag`
--

DROP TABLE IF EXISTS `t_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_tag`
--

LOCK TABLES `t_tag` WRITE;
/*!40000 ALTER TABLE `t_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_type`
--

DROP TABLE IF EXISTS `t_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '分类名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '分类介绍',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_type`
--

LOCK TABLES `t_type` WRITE;
/*!40000 ALTER TABLE `t_type` DISABLE KEYS */;
INSERT INTO `t_type` VALUES (1,'科技','开启智慧未来'),(2,'设计','创建改变未来'),(3,'农业','网络天下肥美'),(4,'公益','汇集点点爱心');
/*!40000 ALTER TABLE `t_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-22 22:37:26
