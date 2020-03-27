/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 5.7.28 : Database - etc_management
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`etc_management` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `etc_management`;

/*Table structure for table `tab_permission` */

DROP TABLE IF EXISTS `tab_permission`;

CREATE TABLE `tab_permission` (
  `id` int(4) NOT NULL AUTO_INCREMENT COMMENT '权限id',
  `details` varchar(50) DEFAULT NULL COMMENT '权限描述',
  `url` varchar(50) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `tab_permission` */

insert  into `tab_permission`(`id`,`details`,`url`) values (1,'管理人员',NULL),(2,'管理车辆',NULL),(3,'一般权限',NULL);

/*Table structure for table `tab_record` */

DROP TABLE IF EXISTS `tab_record`;

CREATE TABLE `tab_record` (
  `id` int(8) NOT NULL AUTO_INCREMENT COMMENT '用车记录编号',
  `vehicleId` int(4) NOT NULL COMMENT '车辆编号',
  `departDate` datetime DEFAULT NULL COMMENT '出车时间',
  `backDate` datetime DEFAULT NULL COMMENT '还车日期',
  `level` varchar(4) DEFAULT NULL COMMENT '紧急程度',
  `event` varchar(50) DEFAULT NULL COMMENT '用车事由',
  `status1` int(2) DEFAULT '0' COMMENT '审核状态1',
  `realDepartDate` datetime DEFAULT NULL COMMENT '实际出车时间',
  `realBackDate` datetime DEFAULT NULL COMMENT '实际还车时间',
  `status2` int(2) DEFAULT '0' COMMENT '审核状态2',
  `timeout` int(2) DEFAULT '0' COMMENT '是否超时未还',
  `username` varchar(16) NOT NULL COMMENT '申请人账号',
  `name` varchar(16) DEFAULT NULL COMMENT '用车人姓名',
  PRIMARY KEY (`id`),
  KEY `vehicleId` (`vehicleId`),
  CONSTRAINT `tab_record_ibfk_1` FOREIGN KEY (`vehicleId`) REFERENCES `tab_vehicle` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

/*Data for the table `tab_record` */

insert  into `tab_record`(`id`,`vehicleId`,`departDate`,`backDate`,`level`,`event`,`status1`,`realDepartDate`,`realBackDate`,`status2`,`timeout`,`username`,`name`) values (26,1,'2020-03-04 12:02:00','2020-03-19 15:15:00','高','因公需要',1,'2020-03-13 15:32:00',NULL,0,0,'xiaohei','小黑'),(27,2,'2020-03-04 15:15:00','2020-03-21 18:08:00','中','因公需要',1,'2020-03-13 15:19:32',NULL,0,0,'xiaohuang1','小黄毛'),(28,2,'2020-03-04 15:15:00','2020-03-19 15:15:00','低','因公需要',0,NULL,NULL,0,0,'zhangsan','张三'),(29,3,'2020-03-04 12:12:00','2020-03-20 15:15:00','低','因公需要',1,'2020-03-13 15:30:19',NULL,0,0,'xiaohuang','小黄');

/*Table structure for table `tab_role` */

DROP TABLE IF EXISTS `tab_role`;

CREATE TABLE `tab_role` (
  `id` int(4) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `details` varchar(50) DEFAULT '普通用户' COMMENT '角色描述',
  `ps` varchar(50) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `tab_role` */

insert  into `tab_role`(`id`,`details`,`ps`) values (1,'系统管理员',NULL),(2,'车辆管理员',NULL),(3,'普通员工',NULL);

/*Table structure for table `tab_role_permission` */

DROP TABLE IF EXISTS `tab_role_permission`;

CREATE TABLE `tab_role_permission` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `roleId` int(8) NOT NULL,
  `permissionId` int(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `roleId` (`roleId`),
  KEY `permissionId` (`permissionId`),
  CONSTRAINT `tab_role_permission_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `tab_role` (`id`),
  CONSTRAINT `tab_role_permission_ibfk_2` FOREIGN KEY (`permissionId`) REFERENCES `tab_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `tab_role_permission` */

insert  into `tab_role_permission`(`id`,`roleId`,`permissionId`) values (1,1,1),(2,2,2),(3,3,3);

/*Table structure for table `tab_user` */

DROP TABLE IF EXISTS `tab_user`;

CREATE TABLE `tab_user` (
  `id` int(8) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(16) NOT NULL COMMENT '用户名',
  `password` varchar(6) NOT NULL DEFAULT '000000' COMMENT '用户密码',
  `name` varchar(16) NOT NULL COMMENT '用户姓名',
  `phone` varchar(11) DEFAULT NULL COMMENT '手机号码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `tab_user` */

insert  into `tab_user`(`id`,`username`,`password`,`name`,`phone`) values (1,'admin','000000','夏小良','13245678941'),(2,'zhangsan','000000','张三','13245678951'),(3,'lisi','000000','李四','13212345781'),(4,'wangwu','000000','王五','15645456454'),(5,'xiaoming','000000','小明','13123456789'),(8,'xiaohuang','000000','小黄','13123457896'),(9,'xiaohei','000000','小黑','13123456789'),(10,'xiaohuang1','000000','小黄毛','13212345678');

/*Table structure for table `tab_user_role` */

DROP TABLE IF EXISTS `tab_user_role`;

CREATE TABLE `tab_user_role` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `userId` int(8) NOT NULL,
  `roleId` int(4) NOT NULL DEFAULT '3',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `roleId` (`roleId`),
  CONSTRAINT `tab_user_role_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `tab_user` (`id`),
  CONSTRAINT `tab_user_role_ibfk_2` FOREIGN KEY (`roleId`) REFERENCES `tab_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `tab_user_role` */

insert  into `tab_user_role`(`id`,`userId`,`roleId`) values (1,1,1),(2,2,2),(3,3,2),(4,4,3),(5,5,3),(7,8,3),(8,9,2),(9,10,3);

/*Table structure for table `tab_vehicle` */

DROP TABLE IF EXISTS `tab_vehicle`;

CREATE TABLE `tab_vehicle` (
  `id` int(4) NOT NULL AUTO_INCREMENT COMMENT '车辆编号',
  `vehicleNumber` varchar(16) NOT NULL DEFAULT '000000' COMMENT '车牌号',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '车辆是否可用',
  `seats` int(2) DEFAULT '4' COMMENT '座位数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `tab_vehicle` */

insert  into `tab_vehicle`(`id`,`vehicleNumber`,`status`,`seats`) values (1,'陕A12345',0,4),(2,'粤B12345',0,6),(3,'陕B54321',0,4);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
