/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 8.0.37 : Database - music_recommdation
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`music_recommdation` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `music_recommdation`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can view permission',1,'view_permission'),(5,'Can add group',2,'add_group'),(6,'Can change group',2,'change_group'),(7,'Can delete group',2,'delete_group'),(8,'Can view group',2,'view_group'),(9,'Can add user',3,'add_user'),(10,'Can change user',3,'change_user'),(11,'Can delete user',3,'delete_user'),(12,'Can view user',3,'view_user'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add 音乐',5,'add_music'),(18,'Can change 音乐',5,'change_music'),(19,'Can delete 音乐',5,'delete_music'),(20,'Can view 音乐',5,'view_music'),(21,'Can add 评论',6,'add_comment'),(22,'Can change 评论',6,'change_comment'),(23,'Can delete 评论',6,'delete_comment'),(24,'Can view 评论',6,'view_comment'),(25,'Can add 用户资料',7,'add_userprofile'),(26,'Can change 用户资料',7,'change_userprofile'),(27,'Can delete 用户资料',7,'delete_userprofile'),(28,'Can view 用户资料',7,'view_userprofile'),(29,'Can add log entry',8,'add_logentry'),(30,'Can change log entry',8,'change_logentry'),(31,'Can delete log entry',8,'delete_logentry'),(32,'Can view log entry',8,'view_logentry'),(33,'Can add session',9,'add_session'),(34,'Can change session',9,'change_session'),(35,'Can delete session',9,'delete_session'),(36,'Can view session',9,'view_session');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user` */

insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values (1,'pbkdf2_sha256$720000$hzLwysO20hSeRWsFzvqbHY$1X7qdi91geOLX5FHWxyt1ugpQ0K+CO11mno8m4xGDKI=','2024-09-10 10:55:05.525538',1,'ruiqi','','','1454309266@qq.com',1,1,'2024-09-09 09:43:34.870636'),(2,'pbkdf2_sha256$720000$g78OLm5w1vJdTKvF3vC1ND$htsh74uC7jUrmmYOLDKFaZwC3vOPS7rWZLQ9OfhQ9e0=','2024-09-10 10:55:08.407029',0,'test1','','','',0,1,'2024-09-09 09:51:16.217114'),(3,'pbkdf2_sha256$720000$0FDR6nbF2RcV5e2H6uvyzI$4XYLkf5TkuRHxXZ1z3U3Xb50YwufVeD8hQhLCcfCk7U=','2024-09-09 17:20:39.370147',0,'test2','','','',0,1,'2024-09-09 09:53:55.952269');

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_admin_log` */

insert  into `django_admin_log`(`id`,`action_time`,`object_id`,`object_repr`,`action_flag`,`change_message`,`content_type_id`,`user_id`) values (1,'2024-09-09 09:57:32.003755','1','夜曲',1,'[{\"added\": {}}]',5,1),(2,'2024-09-09 09:57:38.285168','1','夜曲',2,'[]',5,1),(3,'2024-09-09 09:58:02.419751','2','晴天',1,'[{\"added\": {}}]',5,1),(4,'2024-09-09 09:58:45.884115','3','凄美地',1,'[{\"added\": {}}]',5,1),(5,'2024-09-09 09:59:57.540023','4','若把你',1,'[{\"added\": {}}]',5,1),(6,'2024-09-09 10:00:40.627467','5','IS There Someone ELSE',1,'[{\"added\": {}}]',5,1),(7,'2024-09-09 10:21:52.516630','6','保留',1,'[{\"added\": {}}]',5,1),(8,'2024-09-09 10:22:41.236646','7','AFTER Hours',1,'[{\"added\": {}}]',5,1),(9,'2024-09-09 10:55:01.854068','8','关于青春',1,'[{\"added\": {}}]',5,1),(10,'2024-09-09 10:55:18.685371','9','求救讯号',1,'[{\"added\": {}}]',5,1),(11,'2024-09-09 10:55:35.371387','10','整理整顿清洁中',1,'[{\"added\": {}}]',5,1),(12,'2024-09-09 10:56:04.996171','11','AFTER Hours',1,'[{\"added\": {}}]',5,1),(13,'2024-09-09 10:57:40.333916','12','die for you',1,'[{\"added\": {}}]',5,1),(14,'2024-09-09 10:58:22.445590','13','Sugar',1,'[{\"added\": {}}]',5,1),(15,'2024-09-09 10:58:39.028102','14','IN Your Pocket',1,'[{\"added\": {}}]',5,1),(16,'2024-09-09 10:59:12.107075','15','春日影',1,'[{\"added\": {}}]',5,1),(17,'2024-09-09 10:59:57.604453','16','歌一切',1,'[{\"added\": {}}]',5,1),(18,'2024-09-09 11:00:34.595822','17','影色舞',1,'[{\"added\": {}}]',5,1),(19,'2024-09-09 11:00:47.308039','18','迷星叫',1,'[{\"added\": {}}]',5,1),(20,'2024-09-09 17:52:32.873404','19','Ticking Away 流光似箭',1,'[{\"added\": {}}]',5,1),(21,'2024-09-09 18:11:25.545372','20','Silver City',1,'[{\"added\": {}}]',5,1),(22,'2024-09-09 18:12:20.600169','21','阴天快乐',1,'[{\"added\": {}}]',5,1),(23,'2024-09-09 18:13:09.608106','22','走吧',1,'[{\"added\": {}}]',5,1),(24,'2024-09-09 18:14:27.773416','23','春を告げる 宣告春天',1,'[{\"added\": {}}]',5,1),(25,'2024-09-09 18:15:13.436456','24','芳华美月',1,'[{\"added\": {}}]',5,1),(26,'2024-09-09 18:16:19.459519','25','你不想了解我的样子真是太令人着迷了',1,'[{\"added\": {}}]',5,1),(27,'2024-09-09 18:18:05.207735','26','It Ain\'t Me',1,'[{\"added\": {}}]',5,1),(28,'2024-09-09 18:19:42.823559','27','Travelers\' encore',1,'[{\"added\": {}}]',5,1),(29,'2024-09-09 18:21:12.700686','28','詩超絆',1,'[{\"added\": {}}]',5,1),(30,'2024-09-09 18:22:45.706794','29','水查（Go to HeyYo）',1,'[{\"added\": {}}]',5,1),(31,'2024-09-09 18:24:02.840027','30','迷路日々',1,'[{\"added\": {}}]',5,1),(32,'2024-09-10 09:13:22.401755','31','巫堵',1,'[{\"added\": {}}]',5,1),(33,'2024-09-10 09:22:42.884919','32','this is what winter feels like',1,'[{\"added\": {}}]',5,1),(34,'2024-09-10 09:23:32.809950','33','this is what sadness feels like',1,'[{\"added\": {}}]',5,1),(35,'2024-09-10 09:24:45.010551','34','絶対零度',1,'[{\"added\": {}}]',5,1),(36,'2024-09-10 09:26:34.809423','35','夢でも',1,'[{\"added\": {}}]',5,1),(37,'2024-09-10 09:28:26.290117','36','Vast & Hazy',1,'[{\"added\": {}}]',5,1),(38,'2024-09-10 09:29:28.075014','37','褪色',1,'[{\"added\": {}}]',5,1),(39,'2024-09-10 09:30:56.825718','38','堕天 (Cover)',1,'[{\"added\": {}}]',5,1),(40,'2024-09-10 09:32:11.018029','39','娱乐天空',1,'[{\"added\": {}}]',5,1),(41,'2024-09-10 09:32:49.688128','40','歌いましょう鳴らしましょう',1,'[{\"added\": {}}]',5,1),(42,'2024-09-10 09:33:44.218126','41','指向你的线索',1,'[{\"added\": {}}]',5,1),(43,'2024-09-10 09:35:25.952617','42','对不起我做不到答应了你的事',1,'[{\"added\": {}}]',5,1),(44,'2024-09-10 09:41:07.861556','43','君の神様になりたい。 (Cover)',1,'[{\"added\": {}}]',5,1),(45,'2024-09-10 09:42:08.785122','44','誰にもなれない私だから',1,'[{\"added\": {}}]',5,1),(46,'2024-09-10 09:43:39.770488','45','思念 (live)',1,'[{\"added\": {}}]',5,1),(47,'2024-09-10 09:44:39.386340','46','Who Do You Love',1,'[{\"added\": {}}]',5,1),(48,'2024-09-10 10:12:16.525637','47','搁浅的人',1,'[{\"added\": {}}]',5,1),(49,'2024-09-10 10:21:34.109308','48','志铭',1,'[{\"added\": {}}]',5,1),(50,'2024-09-10 10:30:38.342554','49','这该死的拘执佮爱',1,'[{\"added\": {}}]',5,1),(51,'2024-09-10 10:33:04.507484','50','万千花蕊慈母悲哀',1,'[{\"added\": {}}]',5,1),(52,'2024-09-10 10:33:45.285900','51','打开太阳',1,'[{\"added\": {}}]',5,1),(53,'2024-09-10 10:36:24.987746','52','闲人夜游灯火会',1,'[{\"added\": {}}]',5,1),(54,'2024-09-10 10:37:53.675955','53','后来的灯火',1,'[{\"added\": {}}]',5,1),(55,'2024-09-10 10:38:35.588024','54','Warm (feat. Mia)',1,'[{\"added\": {}}]',5,1),(56,'2024-09-10 10:39:52.171134','55','Everything Goes On (群星依旧)',1,'[{\"added\": {}}]',5,1),(57,'2024-09-10 10:42:18.355840','56','消えてしまいそうです',1,'[{\"added\": {}}]',5,1),(58,'2024-09-10 10:43:29.021440','57','If I Lose Myself',1,'[{\"added\": {}}]',5,1),(59,'2024-09-10 10:45:06.957118','58','Gone, Gone, Gone',1,'[{\"added\": {}}]',5,1),(60,'2024-09-10 10:45:57.449592','59','Fades Away',1,'[{\"added\": {}}]',5,1),(61,'2024-09-10 10:46:50.891287','60','Easy Come Easy Go',1,'[{\"added\": {}}]',5,1),(62,'2024-09-10 10:52:15.517815','61','Ezio\'s Family',1,'[{\"added\": {}}]',5,1),(63,'2024-09-10 10:53:16.358343','62','「僕は...」',1,'[{\"added\": {}}]',5,1);

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values (8,'admin','logentry'),(2,'auth','group'),(1,'auth','permission'),(3,'auth','user'),(4,'contenttypes','contenttype'),(6,'music','comment'),(5,'music','music'),(7,'music','userprofile'),(9,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (1,'contenttypes','0001_initial','2024-09-09 09:31:36.331806'),(2,'auth','0001_initial','2024-09-09 09:31:37.925925'),(3,'music','0001_initial','2024-09-09 09:31:39.232316'),(4,'admin','0001_initial','2024-09-09 09:48:47.980558'),(5,'admin','0002_logentry_remove_auto_add','2024-09-09 09:48:47.996513'),(6,'admin','0003_logentry_add_action_flag_choices','2024-09-09 09:48:48.011502'),(7,'contenttypes','0002_remove_content_type_name','2024-09-09 09:48:48.242051'),(8,'auth','0002_alter_permission_name_max_length','2024-09-09 09:48:48.393388'),(9,'auth','0003_alter_user_email_max_length','2024-09-09 09:48:48.429221'),(10,'auth','0004_alter_user_username_opts','2024-09-09 09:48:48.444114'),(11,'auth','0005_alter_user_last_login_null','2024-09-09 09:48:48.481258'),(12,'auth','0006_require_contenttypes_0002','2024-09-09 09:48:48.488040'),(13,'auth','0007_alter_validators_add_error_messages','2024-09-09 09:48:48.528725'),(14,'auth','0008_alter_user_username_max_length','2024-09-09 09:48:48.685527'),(15,'auth','0009_alter_user_last_name_max_length','2024-09-09 09:48:48.837506'),(16,'auth','0010_alter_group_name_max_length','2024-09-09 09:48:48.869499'),(17,'auth','0011_update_proxy_permissions','2024-09-09 09:48:48.882425'),(18,'auth','0012_alter_user_first_name_max_length','2024-09-09 09:48:49.057857'),(19,'sessions','0001_initial','2024-09-09 09:48:49.152653');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('680xvih024hna4qn3zizxrcf484u8kvr','.eJxVjEEOwiAQAP_C2ZBlC8h69N43EGBRqgaS0p6MfzckPeh1ZjJv4cO-Fb_3vPqFxUWgOP2yGNIz1yH4Eeq9ydTqti5RjkQetsu5cX5dj_ZvUEIvYwtsYyBtFYImNC4lnZ0DxoQ4TY6MoVsEtDZSNhGREYAsQTgrJqfE5wuwmzZT:1snr24:HYlh1rBpLN904o07nYMar6QGUEQBOPVCVE1LjeUY2Nw','2024-09-24 10:55:08.415009');

/*Table structure for table `music_comment` */

DROP TABLE IF EXISTS `music_comment`;

CREATE TABLE `music_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `comment` longtext NOT NULL,
  `comment_time` datetime(6) DEFAULT NULL,
  `user_id` int NOT NULL,
  `song_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `music_comment_user_id_0d3cd408_fk_auth_user_id` (`user_id`),
  KEY `music_comment_song_id_ca79f133_fk_music_music_id` (`song_id`),
  CONSTRAINT `music_comment_song_id_ca79f133_fk_music_music_id` FOREIGN KEY (`song_id`) REFERENCES `music_music` (`id`),
  CONSTRAINT `music_comment_user_id_0d3cd408_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `music_comment` */

insert  into `music_comment`(`id`,`comment`,`comment_time`,`user_id`,`song_id`) values (1,'好听',NULL,1,1),(2,'123125','2024-09-09 17:02:09.718338',2,6),(3,'892374928375','2024-09-09 17:02:15.014695',2,6),(4,'vh真好听','2024-09-09 17:19:30.326731',2,8),(5,'致膝盖上的擦伤，童年的时光和青春心事','2024-09-09 17:53:37.873354',2,19),(6,'浪漫','2024-09-09 18:25:58.809800',2,27),(7,'溜冰溜冰','2024-09-10 10:56:12.450912',2,17),(8,'我心危，好看又好听','2024-09-10 10:56:53.802027',2,62);

/*Table structure for table `music_music` */

DROP TABLE IF EXISTS `music_music`;

CREATE TABLE `music_music` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `song_name` varchar(200) NOT NULL,
  `song_length` int DEFAULT NULL,
  `genre_ids` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `artist_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '无',
  `composer` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '无',
  `lyricist` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '无',
  `language` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '无',
  `url` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `music_music` */

insert  into `music_music`(`id`,`song_name`,`song_length`,`genre_ids`,`artist_name`,`composer`,`lyricist`,`language`,`url`) values (1,'夜曲',123,'流行','周杰伦','方文山','周杰伦','华语','123'),(2,'晴天',123,'流行','周杰伦','方文山','周杰伦','华语','123'),(3,'凄美地',123,'流行','郭顶','郭顶','郭顶','华语','436346833'),(4,'若把你',283728,'流行','不知道','无','无','华语','865632948'),(5,'IS There Someone ELSE',123,'R&B','The Weekend','无','无','英语','1909927738'),(6,'保留',123,'流行','郭顶','无','无','华语','442869203'),(7,'AFTER Hours',123,'R&B','The Weekend','无','无','英语','1424460203'),(8,'关于青春',123,'流行|摇滚','VH','无','无','华语','29713016'),(9,'求救讯号',123,'流行|摇滚','VH','无','无','华语','2155422693'),(10,'整理整顿清洁中',123,'流行|摇滚','VH','无','无','华语','2155422693'),(11,'AFTER Hours',123,'R&B','The Weekend','无','无','英语','1424460203'),(12,'die for you',123,'R&B','The Weekend','无','无','英语','1974630461'),(13,'Sugar',123,'流行','Maroon5','无','无','英语','29019227'),(14,'IN Your Pocket',123,'流行','Maroon5','无','无','英语','29019229'),(15,'春日影',123,'摇滚','MyGo!!!!!','无','无','日语','2097486090'),(16,'歌一切',123,'流行','许钧','许钧','许钧','华语','2103880332'),(17,'影色舞',123,'摇滚','MyGo!!!!!','无','无','日语','2097485072'),(18,'迷星叫',123,'摇滚','MyGo!!!!!','无','无','日语','2097485069'),(19,'Ticking Away 流光似箭',123,'电子舞曲|流行','Grabbitz | bbno$','Grabbitz','Grabbitz | bbno$','英语','2068401809'),(20,'Silver City',123,'电子舞曲','MYRNE/Linying','MYRNE/Linying','MYRNE/Linying','英语','2114659465'),(21,'阴天快乐',123,'流行','陈奕迅','林俊杰','易家扬','华语','28563317'),(22,'走吧',123,'摇滚','黑屋乐队','李巧巧','李巧巧','华语','1443593535'),(23,'春を告げる 宣告春天',123,'流行','yama','くじら','くじら','日语','1486106274'),(24,'芳华美月',123,'摇滚','达闻西乐队','猴子','猴子','华语','2614799468'),(25,'你不想了解我的样子真是太令人着迷了',123,'独立摇滚','达闻西乐队','既视感','既视感','华语','1416956190'),(26,'It Ain\'t Me',123,'电子舞曲','Kygo / Selena Gomez','Andrew Wotman/Brian Lee/Ali TamposiSelena Gomez/Kygo','Andrew Wotman/Brian Lee/Ali Tamposi','英语','507795199'),(27,'Travelers\' encore',123,'纯音乐','Andrew Prahlow','Andrew Prahlow','Andrew Prahlow','纯音乐','1879098277'),(28,'詩超絆',123,'流行/摇滚','MyGO!!!!!','横地健太','藤原優樹','日语','2078062132'),(29,'水查（Go to HeyYo）',123,'流行/摇滚','VH (Vast & Hazy)','林易祺 LNiCH','咖咖 KAKA. Y','华语','2048046247'),(30,'迷路日々',123,'流行/摇滚','MyGO!!!!!','松坂康司','藤原優樹','日语','2097486091'),(31,'巫堵',123,'流行/摇滚','deca joins','deca joins','郑敬儒','华语','483378330'),(32,'this is what winter feels like',123,'流行','JVKE','Jake Lawson/Zac Lawson','JVKE','英语','2116728806'),(33,'this is what sadness feels like',123,'流行','JVKE','无','无','英语','1984537508'),(34,'絶対零度',123,'流行','なとり','なとり','なとり','日语','2140377107'),(35,'夢でも',123,'流行','みゆな','みゆな','みゆな','日语','2018761972'),(36,'Vast & Hazy',123,'流行','VH (Vast & Hazy)','林易祺','颜静萱','华语','409830422'),(37,'褪色',123,'摇滚','犬儒乐队','犬儒乐队','犬儒乐队','华语','2076809065'),(38,'堕天 (Cover)',123,'摇滚','Ave Mujica','DJ 松永','R-指定','日语','2164259995'),(39,'娱乐天空',123,'流行','陈奕迅','火星电台','火星电台','华语','28481104'),(40,'歌いましょう鳴らしましょう',123,'流行/摇滚','MyGO!!!!!','メガテラ・ゼロ','メガテラ・ゼロ','日语','2097485073'),(41,'指向你的线索',123,'流行/摇滚','VH (Vast & Hazy)','林易祺','颜静萱','华语','570087078'),(42,'对不起我做不到答应了你的事',123,'摇滚','康士坦的变化球','ARNY Wu/張譯云 Gail 米/Creed Zhao/陳佑祥 sionC/侯啟泰 CT','ARNY Wu','华语','1499917736'),(43,'君の神様になりたい。 (Cover)',123,'流行','MyGo!!!!!','カンザキイオリ','カンザキイオリ','日语','2164259992'),(44,'誰にもなれない私だから',123,'流行/摇滚','トゲナシトゲアリ','遊部優介','カイザー恵理菜','日语','2145269432'),(45,'思念 (live)',123,'流行','YELLOW黃宣','蔡健雅','蔡健雅','华语','2159349490'),(46,'Who Do You Love',123,'电子舞曲|流行','The Chainsmokers / 5 Seconds of Summer','无','无','英语','1344670477'),(47,'搁浅的人',123,'摇滚','康士坦的变化球','侯启泰/闕昊為/陳佑祥/張譯云/吳穎然','侯启泰/闕昊為/陳佑祥/張譯云/吳穎然','华语','447925725'),(48,'志铭',123,'摇滚','犬儒乐队','犬儒乐队','犬儒乐队','华语','2005708456'),(49,'这该死的拘执佮爱',123,'流行','珂拉琪 Collage','王家权','王家权','闽南语','1903991885'),(50,'万千花蕊慈母悲哀',123,'流行','珂拉琪 Collage','王家权','王家权','闽南语','1903991886'),(51,'打开太阳',123,'流行|摇滚','血肉果汁机','刘宗霖','Gigo','闽南语','1393382497'),(52,'闲人夜游灯火会',123,'纯音乐','聲無哀樂','杨宗勋','无','纯音乐','1915280870'),(53,'后来的灯火',123,'摇滚','醒山AwakeMountains','醒山AwakeMountains','醒山AwakeMountains','华语','1844488612'),(54,'Warm (feat. Mia)',123,'流行','Dre\'es / Mia','Andres De La Pena/Mia Xitlali','Dre\'es / Mia','英语','524148990'),(55,'Everything Goes On (群星依旧)',123,'电子舞曲|流行','To The Moon','To The Moon','To The Moon','英语','1965720244'),(56,'消えてしまいそうです',123,'流行','ずっと真夜中でいいのに。','ACAね','ACAね','日语','1979732581'),(57,'If I Lose Myself',123,'流行|摇滚','OneRepublic','Benny Blanco/Ryan Tedder/Brent Kutzle/Zach Filkins/Alessandro Lindblad','Benny Blanco/Ryan Tedder/Brent Kutzle/Zach Filkins/Alessandro Lindblad','英语','2112442906'),(58,'Gone, Gone, Gone',123,'流行','Phillip Phillips','Todd Clark/Gregg Wattenberg/Derek Fuhrmann','Todd Clark/Gregg Wattenberg/Derek Fuhrmann','英语','27268032'),(59,'Fades Away',123,'电子舞曲|流行','Avicii / MishCatt','Carl Falk/Tim Bergling/Joe Janiak/Joakim Berg','Carl Falk/Tim Bergling/Joe Janiak/Joakim Berg','英语','2027182854'),(60,'Easy Come Easy Go',123,'流行|摇滚','Imagine Dragons','Dan Reynolds/Wayne Sermon/Daniel Platzman/Ben McKee/Jayson DeZuzio','Dan Reynolds/Wayne Sermon/Daniel Platzman/Ben McKee/Jayson DeZuzio','英语','1875176957'),(61,'Ezio\'s Family',123,'纯音乐','Jesper Kyd / Assassin\'s Creed','Jesper Kyd','无','纯音乐','18649294'),(62,'「僕は...」',123,'流行','あたらよ','ひとみ','ひとみ','日语','2112531307');

/*Table structure for table `music_userprofile` */

DROP TABLE IF EXISTS `music_userprofile`;

CREATE TABLE `music_userprofile` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `first_run` tinyint(1) NOT NULL,
  `genre_subscribe` longtext NOT NULL,
  `language_subscribe` longtext NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `music_userprofile_user_id_5531150c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `music_userprofile` */

insert  into `music_userprofile`(`id`,`first_run`,`genre_subscribe`,`language_subscribe`,`user_id`) values (1,0,'R&B','日语',2),(2,0,'R&B','华语,英语',3);

/*Table structure for table `music_userprofile_dislikes` */

DROP TABLE IF EXISTS `music_userprofile_dislikes`;

CREATE TABLE `music_userprofile_dislikes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userprofile_id` bigint NOT NULL,
  `music_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `music_userprofile_dislikes_userprofile_id_music_id_91e95a2a_uniq` (`userprofile_id`,`music_id`),
  KEY `music_userprofile_dislikes_music_id_3038b6b6_fk_music_music_id` (`music_id`),
  CONSTRAINT `music_userprofile_di_userprofile_id_704c1003_fk_music_use` FOREIGN KEY (`userprofile_id`) REFERENCES `music_userprofile` (`id`),
  CONSTRAINT `music_userprofile_dislikes_music_id_3038b6b6_fk_music_music_id` FOREIGN KEY (`music_id`) REFERENCES `music_music` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `music_userprofile_dislikes` */

/*Table structure for table `music_userprofile_likes` */

DROP TABLE IF EXISTS `music_userprofile_likes`;

CREATE TABLE `music_userprofile_likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userprofile_id` bigint NOT NULL,
  `music_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `music_userprofile_likes_userprofile_id_music_id_7c0884d3_uniq` (`userprofile_id`,`music_id`),
  KEY `music_userprofile_likes_music_id_0842498d_fk_music_music_id` (`music_id`),
  CONSTRAINT `music_userprofile_li_userprofile_id_b386dfb3_fk_music_use` FOREIGN KEY (`userprofile_id`) REFERENCES `music_userprofile` (`id`),
  CONSTRAINT `music_userprofile_likes_music_id_0842498d_fk_music_music_id` FOREIGN KEY (`music_id`) REFERENCES `music_music` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `music_userprofile_likes` */

insert  into `music_userprofile_likes`(`id`,`userprofile_id`,`music_id`) values (2,1,15),(1,1,30),(3,1,43);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
