/*
Navicat MySQL Data Transfer

Source Server         : Craenkland_NEW
Source Server Version : 50613
Source Host           : localhost:3310
Source Database       : dayz_cherno_real

Target Server Type    : MYSQL
Target Server Version : 50613
File Encoding         : 65001

Date: 2013-09-04 20:42:06
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `building`
-- ----------------------------
DROP TABLE IF EXISTS `building`;
CREATE TABLE `building` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `class_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq1_building` (`class_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of building
-- ----------------------------

-- ----------------------------
-- Table structure for `cust_loadout`
-- ----------------------------
DROP TABLE IF EXISTS `cust_loadout`;
CREATE TABLE `cust_loadout` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `inventory` varchar(2048) NOT NULL,
  `backpack` varchar(2048) NOT NULL,
  `model` varchar(100) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cust_loadout
-- ----------------------------

-- ----------------------------
-- Table structure for `cust_loadout_profile`
-- ----------------------------
DROP TABLE IF EXISTS `cust_loadout_profile`;
CREATE TABLE `cust_loadout_profile` (
  `cust_loadout_id` bigint(20) unsigned NOT NULL,
  `unique_id` varchar(128) NOT NULL,
  PRIMARY KEY (`cust_loadout_id`,`unique_id`),
  KEY `fk2_cust_loadout_profile` (`unique_id`),
  CONSTRAINT `cust_loadout_profile_ibfk_1` FOREIGN KEY (`cust_loadout_id`) REFERENCES `cust_loadout` (`id`),
  CONSTRAINT `cust_loadout_profile_ibfk_2` FOREIGN KEY (`unique_id`) REFERENCES `profile` (`unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cust_loadout_profile
-- ----------------------------

-- ----------------------------
-- Table structure for `deployable`
-- ----------------------------
DROP TABLE IF EXISTS `deployable`;
CREATE TABLE `deployable` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `class_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq1_deployable` (`class_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of deployable
-- ----------------------------
INSERT INTO `deployable` VALUES ('4', 'Hedgehog_DZ');
INSERT INTO `deployable` VALUES ('5', 'Sandbag1_DZ');
INSERT INTO `deployable` VALUES ('7', 'StashMedium');
INSERT INTO `deployable` VALUES ('6', 'StashSmall');
INSERT INTO `deployable` VALUES ('1', 'TentStorage');
INSERT INTO `deployable` VALUES ('2', 'TrapBear');
INSERT INTO `deployable` VALUES ('3', 'Wire_cat1');

-- ----------------------------
-- Table structure for `instance`
-- ----------------------------
DROP TABLE IF EXISTS `instance`;
CREATE TABLE `instance` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `world_id` smallint(5) unsigned NOT NULL DEFAULT '1',
  `inventory` varchar(2048) NOT NULL DEFAULT '[]',
  `backpack` varchar(2048) NOT NULL DEFAULT '["DZ_Patrol_Pack_EP1",[[],[]],[[],[]]]',
  PRIMARY KEY (`id`),
  KEY `fk1_instance` (`world_id`),
  CONSTRAINT `instance_ibfk_1` FOREIGN KEY (`world_id`) REFERENCES `world` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of instance
-- ----------------------------
INSERT INTO `instance` VALUES ('1', '1', '[[\"AK_47_M\",\"Makarov\",\"ItemMap\",\"ItemFlashlight\"],[\"30Rnd_762x39_AK47\",\"30Rnd_762x39_AK47\",\"30Rnd_762x39_AK47\",\"ItemMorphine\",\"FoodCanBakedBeans\",\"ItemSodaPepsi\",\"ItemMorphine\",\"ItemPainkiller\",\"ItemBandage\",\"ItemBandage\",\"ItemBandage\",\"ItemBandage\",\"8Rnd_9x18_Makarov\",\"8Rnd_9x18_Makarov\",\"8Rnd_9x18_Makarov\",\"8Rnd_9x18_Makarov\"]]', '[\"DZ_Patrol_Pack_EP1\",[[],[]],[[],[]]]');
INSERT INTO `instance` VALUES ('2', '1', '[[],[\'ItemPainkiller\',\'ItemBandage\']]', '[\'DZ_Patrol_Pack_EP1\',[[],[]],[[],[]]]');
INSERT INTO `instance` VALUES ('3', '1', '[[],[\'ItemPainkiller\',\'ItemBandage\']]', '[\'DZ_Patrol_Pack_EP1\',[[],[]],[[],[]]]');

-- ----------------------------
-- Table structure for `instance_building`
-- ----------------------------
DROP TABLE IF EXISTS `instance_building`;
CREATE TABLE `instance_building` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `building_id` smallint(5) unsigned NOT NULL,
  `instance_id` bigint(20) unsigned NOT NULL DEFAULT '1',
  `worldspace` varchar(60) NOT NULL DEFAULT '[0,[0,0,0]]',
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx1_instance_building` (`building_id`),
  KEY `idx3_instance_building` (`instance_id`),
  CONSTRAINT `instance_building_ibfk_1` FOREIGN KEY (`instance_id`) REFERENCES `instance` (`id`),
  CONSTRAINT `instance_building_ibfk_2` FOREIGN KEY (`building_id`) REFERENCES `building` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of instance_building
-- ----------------------------

-- ----------------------------
-- Table structure for `instance_deployable`
-- ----------------------------
DROP TABLE IF EXISTS `instance_deployable`;
CREATE TABLE `instance_deployable` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `unique_id` varchar(60) NOT NULL,
  `deployable_id` smallint(5) unsigned NOT NULL,
  `owner_id` int(10) unsigned NOT NULL,
  `instance_id` bigint(20) unsigned NOT NULL DEFAULT '1',
  `worldspace` varchar(60) NOT NULL DEFAULT '[0,[0,0,0]]',
  `inventory` varchar(2048) NOT NULL DEFAULT '[]',
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Hitpoints` varchar(500) NOT NULL DEFAULT '[]',
  `Fuel` double(13,0) NOT NULL DEFAULT '0',
  `Damage` double(13,0) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx1_instance_deployable` (`deployable_id`),
  KEY `idx2_instance_deployable` (`owner_id`),
  KEY `idx3_instance_deployable` (`instance_id`),
  CONSTRAINT `instance_deployable_ibfk_1` FOREIGN KEY (`instance_id`) REFERENCES `instance` (`id`),
  CONSTRAINT `instance_deployable_ibfk_2` FOREIGN KEY (`owner_id`) REFERENCES `survivor` (`id`),
  CONSTRAINT `instance_deployable_ibfk_3` FOREIGN KEY (`deployable_id`) REFERENCES `deployable` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of instance_deployable
-- ----------------------------

-- ----------------------------
-- Table structure for `instance_vehicle`
-- ----------------------------
DROP TABLE IF EXISTS `instance_vehicle`;
CREATE TABLE `instance_vehicle` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `world_vehicle_id` bigint(20) unsigned NOT NULL,
  `instance_id` bigint(20) unsigned NOT NULL DEFAULT '1',
  `worldspace` varchar(60) NOT NULL DEFAULT '[0,[0,0,0]]',
  `inventory` varchar(2048) NOT NULL DEFAULT '[]',
  `parts` varchar(1024) NOT NULL DEFAULT '[]',
  `fuel` double NOT NULL DEFAULT '0',
  `damage` double NOT NULL DEFAULT '0',
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `idx3_instance_vehicle` (`instance_id`),
  KEY `fk3_instance_vehicle` (`world_vehicle_id`),
  CONSTRAINT `fk3_instance_vehicle` FOREIGN KEY (`world_vehicle_id`) REFERENCES `world_vehicle` (`id`),
  CONSTRAINT `instance_vehicle_ibfk_1` FOREIGN KEY (`instance_id`) REFERENCES `instance` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of instance_vehicle
-- ----------------------------

-- ----------------------------
-- Table structure for `log_code`
-- ----------------------------
DROP TABLE IF EXISTS `log_code`;
CREATE TABLE `log_code` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_log_code` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log_code
-- ----------------------------
INSERT INTO `log_code` VALUES ('1', 'Login', 'Player has logged in');
INSERT INTO `log_code` VALUES ('2', 'Logout', 'Player has logged out');
INSERT INTO `log_code` VALUES ('3', 'Ban', 'Player was banned');
INSERT INTO `log_code` VALUES ('4', 'Connect', 'Player has connected');
INSERT INTO `log_code` VALUES ('5', 'Disconnect', 'Player has disconnected');

-- ----------------------------
-- Table structure for `log_entry`
-- ----------------------------
DROP TABLE IF EXISTS `log_entry`;
CREATE TABLE `log_entry` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `unique_id` varchar(128) NOT NULL DEFAULT '',
  `log_code_id` int(11) unsigned NOT NULL,
  `text` varchar(1024) DEFAULT '',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `instance_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk1_log_entry` (`log_code_id`),
  CONSTRAINT `fk1_log_entry` FOREIGN KEY (`log_code_id`) REFERENCES `log_code` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of log_entry
-- ----------------------------

-- ----------------------------
-- Table structure for `message`
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `payload` varchar(1024) NOT NULL,
  `loop_interval` int(10) unsigned NOT NULL DEFAULT '0',
  `start_delay` int(10) unsigned NOT NULL DEFAULT '30',
  `instance_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk1_message` (`instance_id`),
  CONSTRAINT `message_ibfk_1` FOREIGN KEY (`instance_id`) REFERENCES `instance` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------

-- ----------------------------
-- Table structure for `migration_schema_log`
-- ----------------------------
DROP TABLE IF EXISTS `migration_schema_log`;
CREATE TABLE `migration_schema_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `schema_name` varchar(255) NOT NULL,
  `event_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `old_version` varchar(255) NOT NULL,
  `new_version` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of migration_schema_log
-- ----------------------------
INSERT INTO `migration_schema_log` VALUES ('1', 'Reality', '2013-09-04 20:18:46', '0.000000', '0.010000');
INSERT INTO `migration_schema_log` VALUES ('2', 'Reality', '2013-09-04 20:18:48', '0.010000', '0.020000');
INSERT INTO `migration_schema_log` VALUES ('3', 'Reality', '2013-09-04 20:18:48', '0.020000', '0.030000');
INSERT INTO `migration_schema_log` VALUES ('4', 'Reality', '2013-09-04 20:18:48', '0.030000', '0.040000');
INSERT INTO `migration_schema_log` VALUES ('5', 'Reality', '2013-09-04 20:18:51', '0.040000', '0.050000');
INSERT INTO `migration_schema_log` VALUES ('6', 'Reality', '2013-09-04 20:18:53', '0.050000', '0.060000');
INSERT INTO `migration_schema_log` VALUES ('7', 'Reality', '2013-09-04 20:18:53', '0.060000', '0.070000');
INSERT INTO `migration_schema_log` VALUES ('8', 'Reality', '2013-09-04 20:18:56', '0.070000', '0.080000');
INSERT INTO `migration_schema_log` VALUES ('9', 'Reality', '2013-09-04 20:18:56', '0.080000', '0.090000');
INSERT INTO `migration_schema_log` VALUES ('10', 'Reality', '2013-09-04 20:18:56', '0.090000', '0.100000');
INSERT INTO `migration_schema_log` VALUES ('11', 'Reality', '2013-09-04 20:18:58', '0.100000', '0.110000');
INSERT INTO `migration_schema_log` VALUES ('12', 'Reality', '2013-09-04 20:18:58', '0.110000', '0.120000');
INSERT INTO `migration_schema_log` VALUES ('13', 'Reality', '2013-09-04 20:18:59', '0.120000', '0.130000');
INSERT INTO `migration_schema_log` VALUES ('14', 'Reality', '2013-09-04 20:18:59', '0.130000', '0.140000');
INSERT INTO `migration_schema_log` VALUES ('15', 'Reality', '2013-09-04 20:19:00', '0.140000', '0.150000');
INSERT INTO `migration_schema_log` VALUES ('16', 'Reality', '2013-09-04 20:19:00', '0.150000', '0.160000');
INSERT INTO `migration_schema_log` VALUES ('17', 'Reality', '2013-09-04 20:19:00', '0.160000', '0.170000');
INSERT INTO `migration_schema_log` VALUES ('18', 'Reality', '2013-09-04 20:19:00', '0.170000', '0.180000');
INSERT INTO `migration_schema_log` VALUES ('19', 'Reality', '2013-09-04 20:19:00', '0.180000', '0.190000');
INSERT INTO `migration_schema_log` VALUES ('20', 'Reality', '2013-09-04 20:19:03', '0.190000', '0.200000');
INSERT INTO `migration_schema_log` VALUES ('21', 'Reality', '2013-09-04 20:19:12', '0.200000', '0.210000');
INSERT INTO `migration_schema_log` VALUES ('22', 'Reality', '2013-09-04 20:19:12', '0.210000', '0.220000');
INSERT INTO `migration_schema_log` VALUES ('23', 'Reality', '2013-09-04 20:19:12', '0.220000', '0.230000');
INSERT INTO `migration_schema_log` VALUES ('24', 'Reality', '2013-09-04 20:19:12', '0.230000', '0.240000');
INSERT INTO `migration_schema_log` VALUES ('25', 'Reality', '2013-09-04 20:19:12', '0.240000', '0.250000');
INSERT INTO `migration_schema_log` VALUES ('26', 'Reality', '2013-09-04 20:19:12', '0.250000', '0.260000');
INSERT INTO `migration_schema_log` VALUES ('27', 'Reality', '2013-09-04 20:19:17', '0.260000', '0.270000');
INSERT INTO `migration_schema_log` VALUES ('28', 'Reality', '2013-09-04 20:19:17', '0.270000', '0.280000');
INSERT INTO `migration_schema_log` VALUES ('29', 'Reality', '2013-09-04 20:19:17', '0.280000', '0.290000');
INSERT INTO `migration_schema_log` VALUES ('30', 'Reality', '2013-09-04 20:19:17', '0.290000', '0.300000');
INSERT INTO `migration_schema_log` VALUES ('31', 'Reality', '2013-09-04 20:19:17', '0.300000', '0.310000');
INSERT INTO `migration_schema_log` VALUES ('32', 'Reality', '2013-09-04 20:19:17', '0.310000', '0.320000');
INSERT INTO `migration_schema_log` VALUES ('33', 'Reality', '2013-09-04 20:19:17', '0.320000', '0.330000');
INSERT INTO `migration_schema_log` VALUES ('34', 'Reality', '2013-09-04 20:19:18', '0.330000', '0.340000');
INSERT INTO `migration_schema_log` VALUES ('35', 'Reality', '2013-09-04 20:19:18', '0.340000', '0.350000');
INSERT INTO `migration_schema_log` VALUES ('36', 'Reality', '2013-09-04 20:19:18', '0.350000', '0.360000');
INSERT INTO `migration_schema_log` VALUES ('37', 'Reality', '2013-09-04 20:19:19', '0.360000', '0.370000');
INSERT INTO `migration_schema_log` VALUES ('38', 'Reality', '2013-09-04 20:19:20', '0.370000', '0.380000');
INSERT INTO `migration_schema_log` VALUES ('39', 'Reality', '2013-09-04 20:19:20', '0.380000', '0.390000');
INSERT INTO `migration_schema_log` VALUES ('40', 'Reality', '2013-09-04 20:19:20', '0.390000', '0.400000');
INSERT INTO `migration_schema_log` VALUES ('41', 'Reality', '2013-09-04 20:19:20', '0.400000', '0.410000');
INSERT INTO `migration_schema_log` VALUES ('42', 'Reality', '2013-09-04 20:19:20', '0.410000', '0.420000');
INSERT INTO `migration_schema_log` VALUES ('43', 'Reality', '2013-09-04 20:19:20', '0.420000', '0.430000');
INSERT INTO `migration_schema_log` VALUES ('44', 'Reality', '2013-09-04 20:19:20', '0.430000', '0.440000');
INSERT INTO `migration_schema_log` VALUES ('45', 'Reality', '2013-09-04 20:19:20', '0.440000', '0.450000');
INSERT INTO `migration_schema_log` VALUES ('46', 'RealityBuildings', '2013-09-04 20:22:35', '0.000000', '0.010000');
INSERT INTO `migration_schema_log` VALUES ('47', 'RealityMessaging', '2013-09-04 20:22:41', '0.000000', '0.010000');
INSERT INTO `migration_schema_log` VALUES ('48', 'RealityInvCust', '2013-09-04 20:22:49', '0.000000', '0.010000');
INSERT INTO `migration_schema_log` VALUES ('49', 'RealityInvCust', '2013-09-04 20:22:49', '0.010000', '0.020000');

-- ----------------------------
-- Table structure for `migration_schema_version`
-- ----------------------------
DROP TABLE IF EXISTS `migration_schema_version`;
CREATE TABLE `migration_schema_version` (
  `name` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of migration_schema_version
-- ----------------------------
INSERT INTO `migration_schema_version` VALUES ('Reality', '0.450000');
INSERT INTO `migration_schema_version` VALUES ('RealityBuildings', '0.010000');
INSERT INTO `migration_schema_version` VALUES ('RealityInvCust', '0.020000');
INSERT INTO `migration_schema_version` VALUES ('RealityMessaging', '0.010000');

-- ----------------------------
-- Table structure for `profile`
-- ----------------------------
DROP TABLE IF EXISTS `profile`;
CREATE TABLE `profile` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `unique_id` varchar(128) NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `humanity` int(6) NOT NULL DEFAULT '2500',
  `survival_attempts` int(3) unsigned NOT NULL DEFAULT '1',
  `total_survival_time` int(5) unsigned NOT NULL DEFAULT '0',
  `total_survivor_kills` int(4) unsigned NOT NULL DEFAULT '0',
  `total_bandit_kills` int(4) unsigned NOT NULL DEFAULT '0',
  `total_zombie_kills` int(5) unsigned NOT NULL DEFAULT '0',
  `total_headshots` int(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_profile` (`unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of profile
-- ----------------------------

-- ----------------------------
-- Table structure for `survivor`
-- ----------------------------
DROP TABLE IF EXISTS `survivor`;
CREATE TABLE `survivor` (
  `id` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `unique_id` varchar(128) NOT NULL,
  `world_id` smallint(5) unsigned NOT NULL DEFAULT '1',
  `worldspace` varchar(60) NOT NULL DEFAULT '[]',
  `inventory` varchar(2048) NOT NULL DEFAULT '[]',
  `backpack` varchar(2048) NOT NULL DEFAULT '[]',
  `medical` varchar(255) NOT NULL DEFAULT '[false,false,false,false,false,false,false,12000,[],[0,0],0]',
  `is_dead` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `model` varchar(128) NOT NULL DEFAULT 'Survivor2_DZ',
  `state` varchar(128) NOT NULL DEFAULT '["","aidlpercmstpsnonwnondnon_player_idlesteady04",36]',
  `survivor_kills` int(3) unsigned NOT NULL DEFAULT '0',
  `bandit_kills` int(3) unsigned NOT NULL DEFAULT '0',
  `zombie_kills` int(4) unsigned NOT NULL DEFAULT '0',
  `headshots` int(4) unsigned NOT NULL DEFAULT '0',
  `last_ate` int(3) unsigned NOT NULL DEFAULT '0',
  `last_drank` int(3) unsigned NOT NULL DEFAULT '0',
  `survival_time` int(3) unsigned NOT NULL DEFAULT '0',
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `start_time` datetime NOT NULL,
  `DistanceFoot` int(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx1_main` (`unique_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of survivor
-- ----------------------------

-- ----------------------------
-- Table structure for `vehicle`
-- ----------------------------
DROP TABLE IF EXISTS `vehicle`;
CREATE TABLE `vehicle` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `class_name` varchar(100) DEFAULT NULL,
  `damage_min` decimal(4,3) NOT NULL DEFAULT '0.100',
  `damage_max` decimal(4,3) NOT NULL DEFAULT '0.700',
  `fuel_min` decimal(4,3) NOT NULL DEFAULT '0.200',
  `fuel_max` decimal(4,3) NOT NULL DEFAULT '0.800',
  `limit_min` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `limit_max` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `parts` varchar(1024) DEFAULT NULL,
  `inventory` varchar(2048) NOT NULL DEFAULT '[]',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq1_vehicle` (`class_name`),
  KEY `idx1_vehicle` (`class_name`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of vehicle
-- ----------------------------
INSERT INTO `vehicle` VALUES ('1', 'UAZ_Unarmed_TK_EP1', '0.500', '0.700', '0.200', '0.800', '0', '30', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[], []], [[\"20Rnd_762x51_DMR\"], [5]], [[], []]]');
INSERT INTO `vehicle` VALUES ('2', 'UAZ_Unarmed_TK_CIV_EP1', '0.500', '0.700', '0.200', '0.800', '0', '40', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[], []], [[\"10Rnd_127x99_m107\"], [5]], [[], []]]');
INSERT INTO `vehicle` VALUES ('3', 'UAZ_Unarmed_UN_EP1', '0.500', '0.700', '0.200', '0.800', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[], []], [[\"30Rnd_556x45_StanagSD\"], [5]], [[], []]]');
INSERT INTO `vehicle` VALUES ('4', 'UAZ_RU', '0.500', '0.700', '0.200', '0.800', '0', '10', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[], []], [[\"HandGrenade_west\"], [5]], [[], []]]');
INSERT INTO `vehicle` VALUES ('5', 'ATV_US_EP1', '0.500', '0.700', '0.200', '0.800', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[], []], [[\"ItemTent\", \"ItemMatchbox\"], [1, 1]], [[], []]]');
INSERT INTO `vehicle` VALUES ('6', 'ATV_CZ_EP1', '0.500', '0.700', '0.200', '0.800', '0', '20', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[], []], [[\"Skin_Camo1_DZ\", \"ItemCompass\"], [1, 1]], [[], []]]');
INSERT INTO `vehicle` VALUES ('7', 'SkodaBlue', '0.500', '0.700', '0.200', '0.800', '0', '10', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[], []], [[\"ItemWatch\", \"ItemKnife\"], [1, 1]], [[], []]]');
INSERT INTO `vehicle` VALUES ('8', 'Skoda', '0.500', '0.700', '0.200', '0.800', '0', '10', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[\"Binocular\"], [1]], [[], []], [[\"CZ_VestPouch_EP1\"], [1]]]');
INSERT INTO `vehicle` VALUES ('9', 'SkodaGreen', '0.500', '0.700', '0.200', '0.800', '0', '40', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[], []], [[\"ItemMatchbox\", \"ItemMap\"], [1, 1]], [[], []]]');
INSERT INTO `vehicle` VALUES ('10', 'TT650_Ins', '0.500', '0.700', '0.200', '0.800', '0', '10', 'motor', '[[[], []], [[\"ItemJerrycan\"], [1]], [[], []]]');
INSERT INTO `vehicle` VALUES ('11', 'TT650_TK_EP1', '0.500', '0.700', '0.200', '0.800', '0', '20', 'motor', '[[[], []], [[\"PartGeneric\"], [1]], [[], []]]');
INSERT INTO `vehicle` VALUES ('12', 'TT650_TK_CIV_EP1', '0.500', '0.700', '0.200', '0.800', '0', '50', 'motor', '[[[], []], [[\"PartWheel\"], [1]], [[], []]]');
INSERT INTO `vehicle` VALUES ('13', 'Old_bike_TK_CIV_EP1', '0.000', '0.000', '0.000', '0.000', '5', '50', null, '[]');
INSERT INTO `vehicle` VALUES ('14', 'Old_bike_TK_INS_EP1', '0.000', '0.000', '0.000', '0.000', '5', '50', null, '[]');
INSERT INTO `vehicle` VALUES ('15', 'UH1H_DZ', '0.500', '0.700', '0.200', '0.800', '0', '30', 'motor,elektronika,mala vrtule,velka vrtule', '[[[], []], [[\"ItemSodaCoke\"], [5]], [[], []]]');
INSERT INTO `vehicle` VALUES ('16', 'hilux1_civil_3_open', '0.500', '0.700', '0.200', '0.800', '0', '10', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[], []], [[\"PartFueltank\", \"PartWheel\"], [1, 1]], [[], []]]');
INSERT INTO `vehicle` VALUES ('17', 'Ikarus_TK_CIV_EP1', '0.500', '0.700', '0.200', '0.800', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[], []], [[\"ItemWatch\", \"ItemSodaPepsi\"], [1, 3]], [[], []]]');
INSERT INTO `vehicle` VALUES ('18', 'Ikarus', '0.500', '0.700', '0.200', '0.800', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[], []], [[\"PartWheel\", \"ItemSodaCoke\"], [1, 3]], [[], []]]');
INSERT INTO `vehicle` VALUES ('19', 'Tractor', '0.500', '0.700', '0.200', '0.800', '0', '10', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[], []], [[\"ItemWire\", \"ItemJerrycan\"], [1, 1]], [[], []]]');
INSERT INTO `vehicle` VALUES ('20', 'S1203_TK_CIV_EP1', '0.500', '0.700', '0.200', '0.800', '0', '40', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[\"Makarov\"], [1]], [[\"FoodCanBakedBeans\"], [3]], [[], []]]');
INSERT INTO `vehicle` VALUES ('21', 'V3S_Civ', '0.500', '0.700', '0.200', '0.800', '1', '10', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[\"MR43\"], [1]], [[\"PartEngine\"], [1]], [[], []]]');
INSERT INTO `vehicle` VALUES ('22', 'UralCivil', '0.500', '0.700', '0.200', '0.800', '1', '10', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[], []], [[\"PartWheel\", \"ItemToolbox\", \"ItemTankTrap\"], [1, 1, 1]], [[], []]]');
INSERT INTO `vehicle` VALUES ('23', 'car_hatchback', '0.500', '0.700', '0.200', '0.800', '0', '40', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[\"LeeEnfield\"], [1]], [[\"5x_22_LR_17_HMR\"], [3]], [[], []]]');
INSERT INTO `vehicle` VALUES ('24', 'Fishing_Boat', '0.500', '0.700', '0.200', '0.800', '0', '50', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('25', 'PBX', '0.500', '0.700', '0.200', '0.800', '1', '10', 'motor', '[[[], []], [[\"ItemFlashlightRed\"], [1]], [[\"DZ_Backpack_EP1\"], [1]]]');
INSERT INTO `vehicle` VALUES ('26', 'Smallboat_1', '0.500', '0.700', '0.200', '0.800', '0', '40', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('27', 'Volha_2_TK_CIV_EP1', '0.500', '0.700', '0.200', '0.800', '0', '20', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[], []], [[\"ItemSodaPepsi\", \"FoodCanFrankBeans\"], [3, 3]], [[], []]]');
INSERT INTO `vehicle` VALUES ('28', 'Volha_1_TK_CIV_EP1', '0.500', '0.700', '0.200', '0.800', '0', '30', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[], []], [[\"ItemSodaCoke\", \"FoodCanBakedBeans\"], [3, 3]], [[], []]]');
INSERT INTO `vehicle` VALUES ('29', 'SUV_TK_CIV_EP1', '0.500', '0.700', '0.200', '0.800', '1', '10', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[], []], [[\"Pipebomb\"], [1]], [[], []]]');
INSERT INTO `vehicle` VALUES ('30', 'car_sedan', '0.500', '0.700', '0.200', '0.800', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[], []], [[\"ItemFlashlight\", \"ItemMap\"], [1, 1]], [[\"DZ_ALICE_Pack_EP1\"], [1]]]');
INSERT INTO `vehicle` VALUES ('31', 'hilux1_civil_3_open_EP1', '0.500', '0.700', '0.200', '0.800', '0', '10', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[], []], [[\"PartEngine\", \"ItemJerrycan\"], [1, 1]], [[], []]]');
INSERT INTO `vehicle` VALUES ('32', 'UralCivil2', '0.500', '0.700', '0.200', '0.800', '1', '10', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[], []], [[\"PartVRotor\", \"ItemMorphine\", \"FoodCanPasta\"], [1, 1, 1]], [[], []]]');
INSERT INTO `vehicle` VALUES ('33', 'LandRover_CZ_EP1', '0.500', '0.700', '0.200', '0.800', '0', '20', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[\"AK_47_M\"], [1]], [[\"ItemPainkiller\"], [1]], [[], []]]');
INSERT INTO `vehicle` VALUES ('34', 'Ka60_GL_NAC', '0.500', '0.700', '0.200', '0.800', '1', '10', 'motor,elektronika,mala vrtule,velka vrtule', '[]');
INSERT INTO `vehicle` VALUES ('35', 'Mi17_Civilian_Nam', '0.500', '0.700', '0.200', '0.800', '1', '10', 'motor,elektronika,mala vrtule,velka vrtule', '[]');
INSERT INTO `vehicle` VALUES ('36', 'BW_Ikarus1', '0.500', '0.700', '0.200', '0.800', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[]');
INSERT INTO `vehicle` VALUES ('37', 'BW_Ikarus2', '0.500', '0.700', '0.200', '0.800', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[]');
INSERT INTO `vehicle` VALUES ('38', 'kpfs_golf_g', '0.500', '0.700', '0.200', '0.800', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[]');
INSERT INTO `vehicle` VALUES ('39', 'kpfs_golf_p', '0.500', '0.700', '0.200', '0.800', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[]');
INSERT INTO `vehicle` VALUES ('40', 'kpfs_golf_post', '0.500', '0.700', '0.200', '0.800', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[]');
INSERT INTO `vehicle` VALUES ('41', 'kpfs_golf_tk', '0.500', '0.700', '0.200', '0.800', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[]');
INSERT INTO `vehicle` VALUES ('42', 'Lada1_GDR', '0.500', '0.700', '0.200', '0.800', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[]');
INSERT INTO `vehicle` VALUES ('43', 'Lada2_GDR', '0.500', '0.700', '0.200', '0.800', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[]');
INSERT INTO `vehicle` VALUES ('44', 'Lada2_TK_CIV_EP1', '0.500', '0.700', '0.200', '0.800', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[]');
INSERT INTO `vehicle` VALUES ('45', 'Lada4_GDR', '0.500', '0.700', '0.200', '0.800', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[]');
INSERT INTO `vehicle` VALUES ('46', 'Lada5_GDR', '0.500', '0.700', '0.200', '0.800', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[]');
INSERT INTO `vehicle` VALUES ('47', 'TT650_Civ', '0.500', '0.700', '0.200', '0.800', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[]');
INSERT INTO `vehicle` VALUES ('48', 'TT650_Gue', '0.500', '0.700', '0.200', '0.800', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[]');
INSERT INTO `vehicle` VALUES ('49', 'MTVR', '0.500', '0.700', '0.200', '0.800', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[]');
INSERT INTO `vehicle` VALUES ('50', 'M1030_US_DES_EP1', '0.500', '0.700', '0.200', '0.800', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[]');
INSERT INTO `vehicle` VALUES ('51', 'smallboat_2', '0.500', '0.700', '0.200', '0.800', '0', '50', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('52', 'Post_bike_E', '0.500', '0.700', '0.200', '0.800', '0', '50', null, '[]');
INSERT INTO `vehicle` VALUES ('53', 'AH6X_DZ', '0.600', '0.800', '0.500', '0.700', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('54', 'Mi17_DZ', '0.800', '0.900', '0.500', '0.700', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('55', 'AN2_DZ', '0.600', '0.900', '0.200', '0.500', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('56', 'BAF_Offroad_D', '0.500', '0.800', '0.300', '0.600', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('57', 'BAF_Offroad_W', '0.500', '0.800', '0.300', '0.600', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('58', 'datsun1_civil_3_open', '0.050', '0.050', '0.000', '0.500', '0', '20', 'motor,karoserie,palivo,wheel_1_1_steering,wheel_2_1_steering,wheel_1_2_steering,wheel_2_2_steering,sklo predni P,sklo predni L,glass1,glass2,glass3', '[]');
INSERT INTO `vehicle` VALUES ('59', 'Fishing_Boat_DZ', '0.050', '0.050', '0.000', '0.500', '0', '10', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('60', 'PBX_DZ', '0.050', '0.050', '0.000', '0.500', '0', '20', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('61', 'An2_2_TK_CIV_EP1_DZ', '0.050', '0.050', '0.000', '0.500', '0', '20', null, '[]');
INSERT INTO `vehicle` VALUES ('62', 'datsun1_civil_2_covered', '0.050', '0.050', '0.000', '0.500', '0', '10', 'motor,karoserie,palivo,wheel_1_1_steering,wheel_2_1_steering,wheel_1_2_steering,wheel_2_2_steering,sklo predni P,sklo predni L,glass1,glass2,glass3', '[]');
INSERT INTO `vehicle` VALUES ('63', 'GAZ_Vodnik', '0.050', '0.050', '0.000', '0.500', '0', '1', 'motor,karoserie,palivo,wheel_1_1_steering,wheel_2_1_steering,wheel_1_2_steering,wheel_2_2_steering,sklo predni P,sklo predni L,glass1,glass2,glass3', '[]');
INSERT INTO `vehicle` VALUES ('64', 'hilux1_civil_1_open', '0.050', '0.050', '0.000', '0.500', '0', '40', 'motor,karoserie,palivo,wheel_1_1_steering,wheel_2_1_steering,wheel_1_2_steering,wheel_2_2_steering,sklo predni P,sklo predni L,glass1,glass2,glass3', '[]');
INSERT INTO `vehicle` VALUES ('65', 'hilux1_civil_2_covered', '0.050', '0.050', '0.000', '0.500', '0', '40', 'motor,karoserie,palivo,wheel_1_1_steering,wheel_2_1_steering,wheel_1_2_steering,wheel_2_2_steering,sklo predni P,sklo predni L,glass1,glass2,glass3', '[]');
INSERT INTO `vehicle` VALUES ('66', 'Lada', '0.050', '0.050', '0.000', '0.500', '0', '10', 'motor,karoserie,palivo,wheel_1_1_steering,wheel_2_1_steering,wheel_1_2_steering,wheel_2_2_steering,sklo predni P,sklo predni L,glass1,glass2,glass3', '[]');
INSERT INTO `vehicle` VALUES ('67', 'Lada1', '0.050', '0.050', '0.000', '0.500', '0', '10', 'motor,karoserie,palivo,wheel_1_1_steering,wheel_2_1_steering,wheel_1_2_steering,wheel_2_2_steering,sklo predni P,sklo predni L,glass1,glass2,glass3', '[]');
INSERT INTO `vehicle` VALUES ('68', 'Lada1_TK_CIV_EP1', '0.050', '0.050', '0.000', '0.500', '0', '30', 'motor,karoserie,palivo,wheel_1_1_steering,wheel_2_1_steering,wheel_1_2_steering,wheel_2_2_steering,sklo predni P,sklo predni L,glass1,glass2,glass3', '[]');
INSERT INTO `vehicle` VALUES ('69', 'LadaLM', '0.050', '0.050', '0.000', '0.500', '0', '20', 'motor,karoserie,palivo,wheel_1_1_steering,wheel_2_1_steering,wheel_1_2_steering,wheel_2_2_steering,sklo predni P,sklo predni L,glass1,glass2,glass3', '[]');
INSERT INTO `vehicle` VALUES ('70', 'LandRover_TK_CIV_EP1', '0.050', '0.050', '0.000', '0.500', '0', '20', 'motor,karoserie,palivo,wheel_1_1_steering,wheel_2_1_steering,wheel_1_2_steering,wheel_2_2_steering,sklo predni P,sklo predni L,glass1,glass2,glass3', '[]');
INSERT INTO `vehicle` VALUES ('71', 'Mi17_Civilian_DZ', '0.050', '0.050', '0.000', '0.500', '0', '40', 'motor,karoserie,palivo,elektronika,mala vrtule,velka vrtule,sklo predni P,sklo predni L,glass1,glass3', '[]');
INSERT INTO `vehicle` VALUES ('72', 'Mi17_medevac_RU_DZ', '0.050', '0.050', '0.000', '0.500', '0', '20', 'motor,karoserie,palivo,elektronika,mala vrtule,velka vrtule,sklo predni P,sklo predni L,glass1,glass3', '[]');
INSERT INTO `vehicle` VALUES ('73', 'MMT_Civ', '0.050', '0.050', '0.000', '0.500', '0', '30', null, '[]');
INSERT INTO `vehicle` VALUES ('74', 'Old_moto_TK_Civ_EP1', '0.050', '0.050', '0.000', '0.500', '0', '40', 'motor,karoserie,palivo,wheel_1_1_steering,wheel_2_1_steering,wheel_1_2_steering,wheel_2_2_steering,sklo predni P,sklo predni L,glass1,glass2,glass3', '[]');
INSERT INTO `vehicle` VALUES ('75', 'RHIB2Turret_DZ', '0.050', '0.050', '0.000', '0.500', '0', '10', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('76', 'S1203_ambulance_EP1', '0.050', '0.050', '0.000', '0.500', '0', '50', 'motor,karoserie,palivo,wheel_1_1_steering,wheel_2_1_steering,wheel_1_2_steering,wheel_2_2_steering,sklo predni P,sklo predni L,glass1,glass2,glass3', '[]');
INSERT INTO `vehicle` VALUES ('77', 'SkodaRed', '0.050', '0.050', '0.000', '0.500', '0', '20', 'motor,karoserie,palivo,wheel_1_1_steering,wheel_2_1_steering,wheel_1_2_steering,wheel_2_2_steering,sklo predni P,sklo predni L,glass1,glass2,glass3', '[]');
INSERT INTO `vehicle` VALUES ('78', 'Smallboat_1_DZ', '0.050', '0.050', '0.000', '0.500', '0', '10', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('79', 'Smallboat_2_DZ', '0.050', '0.050', '0.000', '0.500', '0', '10', 'motor', '[]');
INSERT INTO `vehicle` VALUES ('80', 'TowingTractor', '0.050', '0.050', '0.000', '0.500', '0', '10', 'motor,karoserie,palivo,wheel_1_1_steering,wheel_2_1_steering,wheel_1_2_steering,wheel_2_2_steering,sklo predni P,sklo predni L,glass1,glass2,glass3', '[]');
INSERT INTO `vehicle` VALUES ('81', 'VWGolf', '0.050', '0.050', '0.000', '0.500', '0', '30', 'motor,karoserie,palivo,wheel_1_1_steering,wheel_2_1_steering,wheel_1_2_steering,wheel_2_2_steering,sklo predni P,sklo predni L,glass1,glass2,glass3', '[]');
INSERT INTO `vehicle` VALUES ('82', 'VolhaLimo_TK_CIV_EP1', '0.050', '0.050', '0.000', '0.500', '0', '60', 'motor,karoserie,palivo,wheel_1_1_steering,wheel_2_1_steering,wheel_1_2_steering,wheel_2_2_steering,sklo predni P,sklo predni L,glass1,glass2,glass3', '[]');
INSERT INTO `vehicle` VALUES ('88', 'UralRefuel_INS', '0.500', '0.700', '0.200', '0.800', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[]');
INSERT INTO `vehicle` VALUES ('89', 'Ural_INS', '0.500', '0.700', '0.200', '0.800', '0', '20', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[]');
INSERT INTO `vehicle` VALUES ('90', 'HMMWV_DES_EP1', '0.500', '0.700', '0.200', '0.800', '0', '50', null, '[[[], []], [[\"Pipebomb\"], [3]], [[], []]]');
INSERT INTO `vehicle` VALUES ('91', 'C130J', '0.500', '0.700', '0.200', '0.800', '0', '50', null, '[]');
INSERT INTO `vehicle` VALUES ('92', 'MH6J_DZ', '0.500', '0.500', '0.000', '0.500', '0', '10', 'motor,elektronika,mala vrtule,velka vrtule', '[[[],[]],[[\"1Rnd_Smoke_M203\", \"7Rnd_45ACP_1911\", \"30Rnd_556x45_StanagSD\", \"200Rnd_556x45_M249\", \"FoodCanPasta\", \"15Rnd_W1866_Slug\", \"5x_22_LR_17_HMR\", \"15Rnd_9x19_M9SD\", \"17Rnd_9x19_glock17\", \"100Rnd_762x51_M240\", \"6Rnd_45ACP\", \"8Rnd_9x18_Makarov\"],[]],[[\"DZ_Backpack_EP1\"],[]]]');
INSERT INTO `vehicle` VALUES ('93', 'HMMWV_DZ', '0.800', '0.900', '0.300', '0.700', '0', '50', 'palivo,motor,karoserie,wheel_1_1_steering,wheel_1_2_steering,wheel_2_1_steering,wheel_2_2_steering', '[[[\"AK_47_M\"],[]],[[\"PartWoodPile\", \"ItemBandage\", \"HandGrenade_west\", \"6Rnd_45ACP\", \"ItemEpinephrine\", \"8Rnd_B_Beneli_74Slug\", \"HandChemBlue\", \"8Rnd_B_Beneli_Pellets\", \"PartEngine\", \"17Rnd_9x19_glock17\", \"ItemTent\"],[]],[[\"DZ_CivilBackpack_EP1\"],[]]]');
INSERT INTO `vehicle` VALUES ('94', 'MV22_DZ', '0.500', '0.700', '0.200', '0.800', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('95', 'Ka137_DZ', '0.500', '0.700', '0.200', '0.800', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('96', 'ibr_as350lingor', '0.500', '0.700', '0.200', '0.800', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('97', 'ibr_as350_pmc', '0.500', '0.700', '0.200', '0.800', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('98', 'ibr_as350_pol', '0.500', '0.700', '0.200', '0.800', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('99', 'JetSkiYanahui_Case_Yellow', '0.500', '0.700', '0.200', '0.800', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('100', 'JetSkiYanahui_Case_Green', '0.500', '0.700', '0.200', '0.800', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('101', 'JetSkiYanahui_Case_Blue', '0.500', '0.700', '0.200', '0.800', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('102', 'JetSkiYanahui_Case_Red', '0.500', '0.700', '0.200', '0.800', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('103', 'JetSkiYanahui_Yellow', '0.500', '0.700', '0.200', '0.800', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('104', 'JetSkiYanahui_Green', '0.500', '0.700', '0.200', '0.800', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('105', 'JetSkiYanahui_Blue', '0.500', '0.700', '0.200', '0.800', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('106', 'JetSkiYanahui_Red', '0.500', '0.700', '0.200', '0.800', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('107', 'SUV_SpecialSkaro', '0.500', '0.700', '0.200', '0.800', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('108', 'C185_DZ', '0.500', '0.700', '0.200', '0.800', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('109', 'C185F_DZ', '0.500', '0.700', '0.200', '0.800', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('110', 'C185E_DZ', '0.500', '0.700', '0.200', '0.800', '0', '10', null, '[]');
INSERT INTO `vehicle` VALUES ('111', 'SUV_DZ', '0.500', '0.700', '0.200', '0.800', '0', '10', null, '[]');

-- ----------------------------
-- Table structure for `world`
-- ----------------------------
DROP TABLE IF EXISTS `world`;
CREATE TABLE `world` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '0',
  `max_x` mediumint(9) DEFAULT '0',
  `max_y` mediumint(9) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_world` (`name`),
  KEY `idx1_world` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of world
-- ----------------------------
INSERT INTO `world` VALUES ('1', 'chernarus', '14700', '15360');
INSERT INTO `world` VALUES ('2', 'lingor', '10000', '10000');
INSERT INTO `world` VALUES ('3', 'utes', '5100', '5100');
INSERT INTO `world` VALUES ('4', 'takistan', '14000', '14000');
INSERT INTO `world` VALUES ('5', 'panthera2', '10200', '10200');
INSERT INTO `world` VALUES ('6', 'fallujah', '10200', '10200');
INSERT INTO `world` VALUES ('7', 'zargabad', '8000', '8000');
INSERT INTO `world` VALUES ('8', 'namalsk', '12000', '12000');
INSERT INTO `world` VALUES ('9', 'mbg_celle2', '13000', '13000');
INSERT INTO `world` VALUES ('10', 'tavi', '25600', '25600');

-- ----------------------------
-- Table structure for `world_vehicle`
-- ----------------------------
DROP TABLE IF EXISTS `world_vehicle`;
CREATE TABLE `world_vehicle` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vehicle_id` smallint(5) unsigned NOT NULL DEFAULT '1',
  `world_id` smallint(5) unsigned NOT NULL DEFAULT '1',
  `worldspace` varchar(60) NOT NULL DEFAULT '[]',
  `description` varchar(1024) DEFAULT NULL,
  `chance` decimal(4,3) unsigned NOT NULL DEFAULT '0.000',
  `last_modified` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx1_world_vehicle` (`vehicle_id`),
  KEY `idx2_world_vehicle` (`world_id`),
  CONSTRAINT `world_vehicle_ibfk_1` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicle` (`id`),
  CONSTRAINT `world_vehicle_ibfk_2` FOREIGN KEY (`world_id`) REFERENCES `world` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1121 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of world_vehicle
-- ----------------------------
INSERT INTO `world_vehicle` VALUES ('1', '1', '1', '[0,[12140.168, 12622.802,0]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('2', '2', '1', '[0,[6279.4966, 7810.3691,0]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('3', '3', '1', '[45,[6865.2432,2481.6943,0]]', 'UAZ in Cherno.', '0.650', '0.19');
INSERT INTO `world_vehicle` VALUES ('4', '4', '1', '[157,[3693.0386, 5969.1489,0]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('5', '2', '1', '[20,[13264.081,12167.432,0]]', 'Black Lake UAZ.', '0.650', '0.19');
INSERT INTO `world_vehicle` VALUES ('6', '2', '1', '[223,[4817.6572, 2556.5034,0]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('7', '1', '1', '[337,[8120.3057,9305.4912,0]]', null, '0.650', '0.19');
INSERT INTO `world_vehicle` VALUES ('8', '5', '1', '[337,[3312.2793,11270.755,0]]', null, '0.700', '0.19');
INSERT INTO `world_vehicle` VALUES ('9', '5', '1', '[50,[3684.0366, 5999.0117,0]]', null, '0.700', null);
INSERT INTO `world_vehicle` VALUES ('10', '6', '1', '[202,[11464.035, 11381.071,0]]', null, '0.700', null);
INSERT INTO `world_vehicle` VALUES ('11', '5', '1', '[253,[11459.299,11386.546,0]]', null, '0.700', '0.19');
INSERT INTO `world_vehicle` VALUES ('12', '6', '1', '[335,[8856.8359,2893.7903,0]]', null, '0.700', '0.19');
INSERT INTO `world_vehicle` VALUES ('13', '7', '1', '[353,[12869.565,4450.4077,0]]', null, '0.650', '0.19');
INSERT INTO `world_vehicle` VALUES ('14', '8', '1', '[223,[6288.416, 7834.3521,0]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('15', '9', '1', '[306,[8125.7075,3166.3708,0]]', null, '0.650', '0.19');
INSERT INTO `world_vehicle` VALUES ('16', '5', '1', '[284,[8854.9082,2891.5762,0]]', null, '0.700', '0.19');
INSERT INTO `world_vehicle` VALUES ('17', '10', '1', '[291,[11945.78,9099.3633,0]]', null, '0.700', '0.19');
INSERT INTO `world_vehicle` VALUES ('18', '11', '1', '[151,[6592.686,2906.8245,0]]', null, '0.700', '0.19');
INSERT INTO `world_vehicle` VALUES ('19', '12', '1', '[372,[8762.8516, 11727.877,0]]', null, '0.700', null);
INSERT INTO `world_vehicle` VALUES ('20', '12', '1', '[52,[8713.4893, 7103.0518,0]]', null, '0.700', null);
INSERT INTO `world_vehicle` VALUES ('21', '13', '1', '[50,[8040.6777, 7086.5356,0]]', null, '0.950', null);
INSERT INTO `world_vehicle` VALUES ('22', '13', '1', '[316,[7943.5068,6988.1763,0]]', null, '0.950', '0.19');
INSERT INTO `world_vehicle` VALUES ('23', '14', '1', '[201,[8070.6958, 3358.7793,0]]', null, '0.950', null);
INSERT INTO `world_vehicle` VALUES ('24', '14', '1', '[179,[3474.3989, 2562.4915,0]]', null, '0.950', null);
INSERT INTO `world_vehicle` VALUES ('25', '14', '1', '[236,[1773.9318,2351.6221,0]]', null, '0.950', '0.19');
INSERT INTO `world_vehicle` VALUES ('26', '13', '1', '[236,[3699.9189,2474.2119,0]]', null, '0.950', '0.19');
INSERT INTO `world_vehicle` VALUES ('27', '13', '1', '[73,[8350.0947, 2480.542,0]]', null, '0.950', null);
INSERT INTO `world_vehicle` VALUES ('28', '14', '1', '[35,[8345.7227, 2482.6855,0]]', null, '0.950', null);
INSERT INTO `world_vehicle` VALUES ('29', '13', '1', '[23,[3203.0916, 3988.6379,0]]', null, '0.950', null);
INSERT INTO `world_vehicle` VALUES ('30', '14', '1', '[191,[2782.7134,5285.5342,0]]', null, '0.950', '0.19');
INSERT INTO `world_vehicle` VALUES ('31', '14', '1', '[155,[8680.75,2445.5315,0]]', null, '0.950', '0.19');
INSERT INTO `world_vehicle` VALUES ('32', '13', '1', '[155,[12158.999,3468.7563,0]]', null, '0.950', '0.19');
INSERT INTO `world_vehicle` VALUES ('33', '14', '1', '[250,[11984.01,3835.9231,0]]', null, '0.950', '0.19');
INSERT INTO `world_vehicle` VALUES ('34', '13', '1', '[255,[10153.068,2219.3547,0]]', null, '0.950', '0.19');
INSERT INTO `world_vehicle` VALUES ('35', '15', '1', '[60,[11279.154,4296.0205,0]]', 'UH1H at Rog Castle.', '0.250', '0.19');
INSERT INTO `world_vehicle` VALUES ('36', '15', '1', '[133,[4211.8789,10735.168,0]]', null, '0.250', '0.19');
INSERT INTO `world_vehicle` VALUES ('37', '15', '1', '[52,[6874.0503,11432.864,0]]', 'UH1H at Devil\'s Castle.', '0.250', '0.19');
INSERT INTO `world_vehicle` VALUES ('38', '15', '1', '[58,[10571.7,2220.3101,0.0015564]]', null, '0.250', '0.19');
INSERT INTO `world_vehicle` VALUES ('39', '15', '1', '[359,[6377.8799,2757.8899,-0.048767101]]', null, '0.250', '0.19');
INSERT INTO `world_vehicle` VALUES ('40', '16', '1', '[344,[2045.3989,7267.4165,0]]', null, '0.550', '0.19');
INSERT INTO `world_vehicle` VALUES ('41', '16', '1', '[133,[8310.9902, 3348.3579,0]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('42', '16', '1', '[124,[11309.963, 6646.3989,0]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('43', '16', '1', '[6,[11240.744, 5370.6128,0]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('44', '17', '1', '[230,[3762.5764,8736.1709,0]]', null, '0.550', '0.19');
INSERT INTO `world_vehicle` VALUES ('45', '18', '1', '[279,[10628.433,8037.8188,0]]', null, '0.550', '0.19');
INSERT INTO `world_vehicle` VALUES ('46', '18', '1', '[245,[4580.3203,4515.9282,0]]', null, '0.550', '0.19');
INSERT INTO `world_vehicle` VALUES ('47', '17', '1', '[333,[6040.0923,7806.5439,0]]', null, '0.550', '0.19');
INSERT INTO `world_vehicle` VALUES ('48', '18', '1', '[76,[10314.745, 2147.5374,0]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('49', '17', '1', '[59,[6705.8887, 2991.9358,0]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('50', '19', '1', '[195,[9681.8213,8947.2354,0]]', null, '0.750', '0.19');
INSERT INTO `world_vehicle` VALUES ('51', '19', '1', '[262,[3825.1318,8941.4873,0]]', null, '0.750', '0.19');
INSERT INTO `world_vehicle` VALUES ('52', '19', '1', '[19,[11246.52, 7534.7954,0]]', null, '0.750', null);
INSERT INTO `world_vehicle` VALUES ('53', '20', '1', '[19,[11066.828,7915.2275,0]]', null, '0.550', '0.19');
INSERT INTO `world_vehicle` VALUES ('54', '20', '1', '[352,[12058.555,3577.8667,0]]', null, '0.550', '0.19');
INSERT INTO `world_vehicle` VALUES ('55', '20', '1', '[218,[11940.854, 8872.8389,0]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('56', '20', '1', '[346,[13386.471,6604.0098,0]]', null, '0.550', '0.19');
INSERT INTO `world_vehicle` VALUES ('57', '21', '1', '[178,[13276.482, 6098.4463,0]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('58', '22', '1', '[338,[1890.9952,12417.333,0]]', null, '0.550', '0.19');
INSERT INTO `world_vehicle` VALUES ('59', '23', '1', '[226,[1975.1283, 9150.0195,0]]', null, '0.750', null);
INSERT INTO `world_vehicle` VALUES ('60', '23', '1', '[315,[7429.4849,5157.8682,0]]', null, '0.750', '0.19');
INSERT INTO `world_vehicle` VALUES ('61', '24', '1', '[315,[8317.2676,2348.6055,0]]', null, '0.550', '0.19');
INSERT INTO `world_vehicle` VALUES ('62', '24', '1', '[315,[13222.181,10015.431,0]]', null, '0.550', '0.19');
INSERT INTO `world_vehicle` VALUES ('63', '25', '1', '[55,[13454.882, 13731.796,0]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('64', '26', '1', '[245,[14417.589,12886.104,0]]', null, '0.550', '0.19');
INSERT INTO `world_vehicle` VALUES ('65', '26', '1', '[268,[13098.13, 8250.8828,0]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('66', '27', '1', '[205,[9731.1514,8937.7998,0]]', null, '0.550', '0.19');
INSERT INTO `world_vehicle` VALUES ('67', '28', '1', '[337,[9715.0352,6522.8286,0]]', null, '0.550', '0.19');
INSERT INTO `world_vehicle` VALUES ('68', '28', '1', '[241,[2614.0862,5079.6357,0]]', null, '0.550', '0.19');
INSERT INTO `world_vehicle` VALUES ('69', '27', '1', '[18,[10827.634, 2701.5688,0]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('70', '28', '1', '[222,[5165.7231,2375.7642,0]]', null, '0.550', '0.19');
INSERT INTO `world_vehicle` VALUES ('71', '27', '1', '[207,[1740.8503,3622.6938,0]]', null, '0.550', '0.19');
INSERT INTO `world_vehicle` VALUES ('72', '111', '1', '[266,[9157.8408, 11019.819,0]]', null, '0.450', null);
INSERT INTO `world_vehicle` VALUES ('73', '30', '1', '[222,[12360.468, 10817.882,0]]', null, '0.750', null);
INSERT INTO `world_vehicle` VALUES ('74', '1', '2', '[130,[13129.8,11560,0.0706997]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('75', '2', '2', '[3,[7107.41,5825.43,0]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('76', '3', '2', '[271,[6424,6777.25,0.00143909]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('77', '4', '2', '[5,[4150.78,1426.02,0.0821762]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('78', '2', '2', '[87,[2476.24,4105.05,0.00119781]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('79', '2', '2', '[177,[4073.41,5156.29,0.00143814]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('80', '111', '2', '[9,[6457.83,6660.57,0]]', null, '0.450', null);
INSERT INTO `world_vehicle` VALUES ('81', '5', '2', '[355,[6888.25,3147.13,0.00132751]]', null, '0.700', null);
INSERT INTO `world_vehicle` VALUES ('82', '5', '2', '[17,[5968.15,6595.98,0.00117016]]', null, '0.700', null);
INSERT INTO `world_vehicle` VALUES ('83', '6', '2', '[186,[3546.66,3740.02,0.00143433]]', null, '0.700', null);
INSERT INTO `world_vehicle` VALUES ('84', '5', '2', '[75,[3287.92,6434.28,0.00110245]]', null, '0.700', null);
INSERT INTO `world_vehicle` VALUES ('85', '6', '2', '[51,[5927.38,6616.12,0.00140476]]', null, '0.700', null);
INSERT INTO `world_vehicle` VALUES ('86', '7', '2', '[3,[5805.57,4727.47,0.00143814]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('87', '8', '2', '[0,[6115.49,5859.39,0]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('88', '15', '2', '[208,[1748.81,642.642,14.1062]]', null, '0.250', null);
INSERT INTO `world_vehicle` VALUES ('89', '5', '2', '[323,[1199.85,5270.49,10.8326]]', null, '0.700', null);
INSERT INTO `world_vehicle` VALUES ('90', '10', '2', '[267,[4080.74,1130.51,0.00143909]]', null, '0.700', null);
INSERT INTO `world_vehicle` VALUES ('91', '11', '2', '[-209,[6592.686, 2906.8245,0]]', null, '0.700', null);
INSERT INTO `world_vehicle` VALUES ('92', '12', '2', '[179,[5802.9,4712.73,0.00143814]]', null, '0.700', null);
INSERT INTO `world_vehicle` VALUES ('93', '12', '2', '[97,[4589.57,2616.75,0.00136948]]', null, '0.700', null);
INSERT INTO `world_vehicle` VALUES ('95', '32', '2', '[90,[6821.08,2497.89,0.00143909]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('96', '33', '2', '[294,[3143.17,7997.26,0.00159264]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('97', '14', '2', '[254,[3933.37,4220.77,0.00143433]]', null, '0.950', null);
INSERT INTO `world_vehicle` VALUES ('98', '14', '2', '[184,[3551.31,3739.72,0.0010376]]', null, '0.950', null);
INSERT INTO `world_vehicle` VALUES ('99', '31', '2', '[163,[5985.63,5351.37,0.00143909]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('100', '13', '2', '[10,[8819.02,8023.86,0.00143814]]', null, '0.950', null);
INSERT INTO `world_vehicle` VALUES ('101', '14', '2', '[279,[5796.81,4688.25,0.00143814]]', null, '0.950', null);
INSERT INTO `world_vehicle` VALUES ('102', '13', '2', '[0,[5671.37,796.868,0.00129175]]', null, '0.950', null);
INSERT INTO `world_vehicle` VALUES ('103', '6', '2', '[0,[969.451,1275.39,0.00255895]]', null, '0.700', null);
INSERT INTO `world_vehicle` VALUES ('104', '111', '2', '[9,[6593.81,5728.57,0]]', null, '0.450', null);
INSERT INTO `world_vehicle` VALUES ('105', '27', '2', '[94,[621.466,4631.81,0.00143814]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('106', '15', '2', '[5,[3360.08,1126.39,0.00143862]]', null, '0.250', null);
INSERT INTO `world_vehicle` VALUES ('107', '15', '2', '[18,[3956.76,4229.46,0.00143433]]', null, '0.250', null);
INSERT INTO `world_vehicle` VALUES ('108', '15', '2', '[168,[602.249,4686.56,6.81655]]', null, '0.250', null);
INSERT INTO `world_vehicle` VALUES ('109', '15', '2', '[89,[6597.37,6767.08,0]]', null, '0.250', null);
INSERT INTO `world_vehicle` VALUES ('110', '15', '2', '[274,[6863.03,4451.83,0.00143814]]', null, '0.250', null);
INSERT INTO `world_vehicle` VALUES ('111', '17', '2', '[79,[3472.71,1374.62,0.00143909]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('112', '18', '2', '[79,[3572.71,1374.62,0.00143909]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('113', '18', '2', '[180,[5775.69,4724.98,0.00143814]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('114', '17', '2', '[209,[835.536,5520.96,7.97942]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('115', '18', '2', '[9,[6572.64,5970.13,0]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('116', '17', '2', '[9,[6472.64,5970.13,0]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('117', '12', '2', '[272,[2837.28,5328.06,0.373938]]', null, '0.700', null);
INSERT INTO `world_vehicle` VALUES ('118', '19', '2', '[89,[7971.34,1091.71,0.00143909]]', null, '0.750', null);
INSERT INTO `world_vehicle` VALUES ('119', '19', '2', '[317,[2645.8,6945.16,0.00143909]]', null, '0.750', null);
INSERT INTO `world_vehicle` VALUES ('120', '20', '2', '[285,[4290.23,4935.53,0.00152206]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('121', '20', '2', '[5,[4198.66,4442.61,0.00143814]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('122', '20', '2', '[3,[5796.71,4721.43,0.00143814]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('123', '20', '2', '[167,[13367.5,6601.11,0.0126638]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('124', '21', '2', '[4,[4401.8,1702.02,0.121414]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('125', '24', '2', '[137,[3800.27,2307.3,4.6834]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('126', '24', '2', '[137,[3700.27,2307.3,4.6834]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('127', '25', '2', '[222,[2926.8052, 7965.2969, 0]]', null, '0.550', '0.40');
INSERT INTO `world_vehicle` VALUES ('128', '26', '2', '[147,[8433.71,7797.2,2.1895]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('129', '26', '2', '[310,[3822.1,2299.23,0.000923157]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('131', '28', '2', '[272,[6827.53,5927.34,0.00143909]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('132', '28', '2', '[356,[8039.13,2916.39,0.00257635]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('133', '27', '2', '[274,[3697.02,1404.02,0.00143909]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('134', '28', '2', '[260,[8299.95,2358.95,1.28169]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('135', '27', '2', '[47,[4149.76,1537.27,0.0821762]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('136', '111', '2', '[183,[5784.84,4712.17,0.00143814]]', null, '0.450', null);
INSERT INTO `world_vehicle` VALUES ('137', '30', '2', '[222,[9120.468,8667.882,0]]', null, '0.750', null);
INSERT INTO `world_vehicle` VALUES ('138', '24', '2', '[273,[8842.5,921.916,0.00130701]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('139', '1', '2', '[249,[7563.33,1693.72,0.00143909]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('140', '24', '2', '[195,[6800.51,2828.05,0.00150663]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('141', '15', '1', '[310,[6365.7402,7795.3501,-0.048767101]]', null, '0.250', '0.19');
INSERT INTO `world_vehicle` VALUES ('142', '15', '1', '[14,[13308.511,3227.0215,0]]', null, '0.250', '0.19');
INSERT INTO `world_vehicle` VALUES ('143', '15', '1', '[265,[7695.0356,3991.2056,0]]', null, '0.250', '0.19');
INSERT INTO `world_vehicle` VALUES ('144', '15', '1', '[22,[12009.904,12636.732,0]]', 'UH1H at NEAF.', '0.250', '0.19');
INSERT INTO `world_vehicle` VALUES ('145', '18', '4', '[79,[5228.1963,6146.6855,-1.19209]]', null, '0.500', '0.21');
INSERT INTO `world_vehicle` VALUES ('146', '27', '4', '[334,[1399.4459,3464.3445,0]]', null, '0.500', '0.21');
INSERT INTO `world_vehicle` VALUES ('147', '18', '4', '[227,[4621.7837,649.05255,0.00663757]]', null, '0.500', '0.21');
INSERT INTO `world_vehicle` VALUES ('148', '27', '4', '[204,[5309.2461,6202.939,0]]', null, '0.500', '0.21');
INSERT INTO `world_vehicle` VALUES ('149', '15', '4', '[132,[8189.5273,2064.668,0.00119019]]', null, '0.250', '0.21');
INSERT INTO `world_vehicle` VALUES ('150', '5', '4', '[6,[6837.0986,4988.1509,0.000762939]]', null, '0.500', '0.21');
INSERT INTO `world_vehicle` VALUES ('151', '20', '4', '[219,[8263.0322,7730.8857,0]]', null, '0.500', '0.21');
INSERT INTO `world_vehicle` VALUES ('152', '5', '4', '[17,[11738.519,8349.665,0.0155945]]', null, '0.500', '0.21');
INSERT INTO `world_vehicle` VALUES ('153', '12', '4', '[169,[12313.892,10475.649,4.19617]]', null, '0.500', '0.21');
INSERT INTO `world_vehicle` VALUES ('154', '15', '4', '[18,[5843.7178,11336.136,0.00793457]]', null, '0.250', '0.21');
INSERT INTO `world_vehicle` VALUES ('155', '20', '4', '[353,[1497.7494,5739.3496,6.67572]]', null, '0.500', '0.21');
INSERT INTO `world_vehicle` VALUES ('156', '7', '4', '[165,[9157.1348,6692.1816,0.00242615]]', null, '0.500', '0.21');
INSERT INTO `world_vehicle` VALUES ('157', '21', '4', '[341,[2069.3496,7657.5806,0]]', null, '0.500', '0.21');
INSERT INTO `world_vehicle` VALUES ('158', '1', '4', '[130,[12242.198,11064.873,0.0706997]]', null, '0.500', '0.21');
INSERT INTO `world_vehicle` VALUES ('159', '32', '4', '[252,[10489.811,11066.72,0.000778198]]', null, '0.500', '0.21');
INSERT INTO `world_vehicle` VALUES ('160', '23', '4', '[310,[5298.9331,4714.4155,0.00106812]]', null, '0.500', '0.21');
INSERT INTO `world_vehicle` VALUES ('161', '27', '4', '[123,[4157.9121,11910.076,0]]', null, '0.500', '0.21');
INSERT INTO `world_vehicle` VALUES ('162', '13', '4', '[51,[1914.0155,7597.2456,-1.52588]]', null, '0.600', '0.21');
INSERT INTO `world_vehicle` VALUES ('163', '13', '4', '[15,[5315.9443,6134.3672,0.0126953]]', null, '0.600', '0.21');
INSERT INTO `world_vehicle` VALUES ('164', '13', '4', '[211,[8495.876,2404.3872,0.00710678]]', null, '0.600', '0.21');
INSERT INTO `world_vehicle` VALUES ('165', '13', '4', '[108,[8464.3613,2459.9939,0.00117016]]', null, '0.600', '0.21');
INSERT INTO `world_vehicle` VALUES ('166', '1', '4', '[123,[9946.1982,11338.414,0.00994873]]', null, '0.500', '0.21');
INSERT INTO `world_vehicle` VALUES ('167', '15', '4', '[300,[772.11139,10483.121,0]]', null, '0.250', '0.21');
INSERT INTO `world_vehicle` VALUES ('168', '9', '4', '[46,[2072.7871,299.8927,0.00143433]]', null, '0.500', '0.21');
INSERT INTO `world_vehicle` VALUES ('169', '13', '4', '[93,[5962.1055,1078.1791,6.10352]]', null, '0.600', '0.21');
INSERT INTO `world_vehicle` VALUES ('170', '32', '4', '[42,[6365.4731,11270.29,0]]', null, '0.500', '0.21');
INSERT INTO `world_vehicle` VALUES ('171', '21', '4', '[28,[5953.3921,11337.747,0.00424194]]', null, '0.500', '0.21');
INSERT INTO `world_vehicle` VALUES ('172', '13', '4', '[103,[11825.438,2588.1191,0.0188293]]', null, '0.600', '0.21');
INSERT INTO `world_vehicle` VALUES ('173', '8', '4', '[106,[1786.9825,11949.147,0.00014782]]', null, '0.500', '0.21');
INSERT INTO `world_vehicle` VALUES ('174', '13', '4', '[132,[12311.814,11033.296,0.0022583]]', null, '0.600', '0.21');
INSERT INTO `world_vehicle` VALUES ('175', '13', '4', '[101,[5591.5513,8915.2783,0.0133638]]', null, '0.600', '0.21');
INSERT INTO `world_vehicle` VALUES ('176', '13', '4', '[223,[7903.8716,3229.6731,0.0132484]]', null, '0.600', '0.21');
INSERT INTO `world_vehicle` VALUES ('177', '13', '4', '[182,[8346.94,2458.27,0.0158215]]', null, '0.600', '0.21');
INSERT INTO `world_vehicle` VALUES ('178', '21', '4', '[84,[8101.6929,2026.0935,0.0254517]]', null, '0.500', '0.21');
INSERT INTO `world_vehicle` VALUES ('179', '1', '5', '[225,[6140,5668,0]]', 'Radovna', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('180', '1', '5', '[0,[4029,7226,0]]', 'Arnoldstein', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('181', '32', '5', '[270,[8601,4809,0]]', 'Lesce Airport', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('182', '32', '5', '[180,[7920,1267,0]]', 'New Skooma', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('183', '21', '5', '[110,[5394,3899,0]]', 'Ukanc', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('184', '5', '5', '[140,[6053,5085,0]]', 'Radovna', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('185', '5', '5', '[140,[4266,3929,0]]', 'Radovna', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('187', '5', '5', '[140,[4265,3925,0]]', 'Krsnka Koca', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('188', '5', '5', '[180,[7241,6009,0]]', 'Jesenice', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('189', '5', '5', '[180,[5334,2567,0]]', 'Sela', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('190', '20', '5', '[320,[4676,5020,0]]', 'Trenta', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('191', '20', '5', '[180,[6741,1593,0]]', 'Belley', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('192', '20', '5', '[0,[8718,3981,0]]', 'Kropa', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('193', '8', '5', '[0,[7288,1369,0]]', 'Rockburn', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('194', '20', '5', '[90,[3094,5878,0]]', 'Cave del Predil', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('195', '20', '5', '[185,[6072,7455,0]]', 'Senzatoka', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('196', '23', '5', '[275,[6752,6876,0]]', 'Kleinfort', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('197', '23', '5', '[180,[6416,6210,0]]', 'Dovje', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('198', '24', '5', '[180,[7922,1230,0]]', 'Hafen New Skooma', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('199', '25', '5', '[180,[3465,2459,0]]', 'Bucht sÃ¼dlich von Livek', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('200', '24', '5', '[180,[3900,2214,0]]', 'Bucht bei Bolhovo', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('201', '25', '5', '[180,[3197,4531,0]]', 'LandeinwÃ¤rts Ende des Flusses', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('202', '15', '5', '[0,[4141,7466,0]]', 'NÃ¶rdlichstes Airfield im Hangar', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('203', '15', '5', '[315,[6921,793,0]]', 'Helipad im SÃ¼den', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('204', '15', '5', '[0,[2674,3406,0]]', 'Helipad westliches AF', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('205', '15', '5', '[270,[6702,7344,0]]', 'Firestation Rennstrecke', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('206', '15', '5', '[180,[5573,4968,0]]', 'Dom Planika', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('207', '13', '5', '[340,[4752,1864,0]]', 'Taff Grove', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('208', '13', '5', '[335,[6530,3734,0]]', 'Boh. Bistrica', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('209', '13', '5', '[180,[5052,6404,0]]', 'Kranjska Gora', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('210', '13', '5', '[270,[8767,3107,0]]', 'Selca Leuchtturm', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('211', '13', '5', '[90,[6672,394,0]]', 'Cato', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('212', '13', '5', '[40,[5218,3867,0]]', 'Ukanc', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('213', '18', '5', '[90,[5889,894,0]]', 'Tankstelle Zappado', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('214', '18', '5', '[0,[7872,1567,0]]', 'Tankstelle New Skooma', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('215', '18', '5', '[90,[7988,4925,0]]', 'Bled', '0.700', '0.21');
INSERT INTO `world_vehicle` VALUES ('216', '1', '5', '[90,[3406,2473,0]]', 'Livek', '0.650', '0.21');
INSERT INTO `world_vehicle` VALUES ('217', '1', '5', '[270,[8677,5631,0]]', '086|046', '0.650', '0.21');
INSERT INTO `world_vehicle` VALUES ('218', '1', '5', '[270,[5007,5127,0]]', 'Trenta', '0.650', '0.21');
INSERT INTO `world_vehicle` VALUES ('219', '34', '8', '[219,[4148.12,6579.55,3.866]]', null, '0.250', null);
INSERT INTO `world_vehicle` VALUES ('220', '4', '8', '[182,[4127.6,6703.51,0.00146484]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('221', '4', '8', '[93,[3552.5,6675.55,0.00143433]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('222', '32', '8', '[220,[3941.47,7595.37,0.00143814]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('223', '32', '8', '[180,[5849.93,8659.4,0.00143814]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('224', '22', '8', '[90,[4837.61,6145.8,0.00143814]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('225', '31', '8', '[90,[7051.95,5777.77,0.00144196]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('226', '22', '8', '[180,[7894.81,7718.42,0.00142384]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('227', '31', '8', '[52,[7358.11,7984.73,0.00138092]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('228', '32', '8', '[351,[7685.47,8729.3,0.00157166]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('229', '4', '8', '[23,[5975.07,6690.23,0.00141525]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('230', '31', '8', '[255,[5748.33,9844.07,0.00140762]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('231', '19', '8', '[296,[8252.9,10792.1,0.00143909]]', null, '0.750', null);
INSERT INTO `world_vehicle` VALUES ('232', '13', '8', '[22,[8957.08,10629.1,0.00132465]]', null, '0.950', null);
INSERT INTO `world_vehicle` VALUES ('233', '24', '8', '[110,[9134.51,10091.7,4.11368]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('234', '13', '8', '[81,[7209.53,10848.4,0.00142956]]', null, '0.950', null);
INSERT INTO `world_vehicle` VALUES ('235', '22', '8', '[270,[6739.51,11323.5,0.00143909]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('236', '31', '8', '[74,[7029.23,11540.7,0.00143909]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('237', '13', '8', '[11,[6665.94,11022.5,0.00143909]]', null, '0.950', null);
INSERT INTO `world_vehicle` VALUES ('238', '31', '8', '[278,[5796.78,10761.3,0.00142288]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('239', '4', '8', '[203,[4849.06,10858.9,0.00143909]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('240', '4', '8', '[280,[4418.92,10748.9,0.00143909]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('241', '35', '8', '[47,[4521,11230,3.81583]]', null, '0.250', null);
INSERT INTO `world_vehicle` VALUES ('242', '25', '8', '[55,[4525.93,11255.1,0.001692]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('243', '24', '8', '[92,[4387.41,11293.1,7.2188]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('244', '24', '8', '[0,[4430.48,11303.5,8.4149]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('245', '4', '8', '[250,[4090.02,9225.91,0.00144958]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('246', '24', '8', '[180,[4306.51,4719.16,5.83564]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('247', '13', '8', '[34,[2197.75,5762.33,0.00141096]]', null, '0.950', null);
INSERT INTO `world_vehicle` VALUES ('248', '25', '8', '[88,[2144.77,5754.73,1.84505]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('249', '25', '8', '[245,[5031.6,6100.52,5.8214]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('250', '13', '8', '[6,[4877.88,6215.15,0.00143814]]', null, '0.950', null);
INSERT INTO `world_vehicle` VALUES ('251', '25', '8', '[228,[6044.81,6760.48,2.24013]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('252', '32', '8', '[126,[7647.15,7406.74,0.00144958]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('253', '22', '8', '[1,[4991.09,8165.97,0.00148773]]', null, '0.550', null);
INSERT INTO `world_vehicle` VALUES ('254', '50', '9', '[42,[6065.28,2703.19,-0.0156651]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('255', '51', '9', '[0,[10773.651,975.24237,0.23155731]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('256', '52', '9', '[0,[8482.4492,8107.7109,-2.4795532e-005]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('257', '49', '9', '[71,[2094.65,7619.18,-0.00772476]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('258', '13', '9', '[0,[2319.8,1213.5911,4.0054321e-005]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('259', '44', '9', '[360,[8516.86,2148.63,0.0001297]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('260', '42', '9', '[35,[1671.69,2091.84,0.000419617]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('261', '39', '9', '[81,[2360.87,1208.99,0.00244331]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('262', '47', '9', '[310,[409.376,3768.02,-0.00925827]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('263', '19', '9', '[152,[4736.75,3007.69,-1.33514e-005]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('264', '11', '9', '[0,[1625.8889,2078.1746,1.335144e-005]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('265', '41', '9', '[27,[367.971,3718.82,-6.67572e-005]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('266', '13', '9', '[88,[6140.061,2629.8596,-3.8146973e-006]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('267', '19', '9', '[120,[6078.4307,2745.4111,-3.0517578e-005]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('268', '45', '9', '[7,[8918.93,2126.1,7.34329e-005]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('269', '13', '9', '[0,[8923.083,2139.8386,-5.7220459e-006]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('270', '15', '9', '[94,[8777.93,2076.05,-0.0491714]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('271', '19', '9', '[0,[8843.0586,2538.1528,-1.9073486e-006]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('272', '25', '9', '[299,[8613.07,2467.64,0.175663]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('273', '19', '9', '[0,[8766.1475,2672.552,5.7220459e-006]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('274', '26', '9', '[0,[6771.4668,3383.1628,0.084204674]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('275', '15', '9', '[162,[7797.06,1508.78,0.0114393]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('276', '13', '9', '[0,[10837.63,876.93933]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('277', '48', '9', '[0,[7489.06,1447.57,0.0154333]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('278', '13', '9', '[45,[10976.697,885.80438,9.5367432e-007]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('279', '6', '9', '[149,[2629.24,4096.96,0.000131607]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('280', '10', '9', '[27,[10973.6,906.303,-0.0132909]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('281', '31', '9', '[33,[2437.44,4242.37,0]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('282', '46', '9', '[210,[561.609,5010.75,5.91278e-005]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('283', '47', '9', '[1,[583.873,4999.42,-0.0209208]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('284', '40', '9', '[0,[657.07629,5135.0928,6.6757202e-006]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('285', '12', '9', '[360,[8531.11,8107.91,0.00588608]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('286', '38', '9', '[82,[8884.36,2633.27,0.12]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('287', '43', '9', '[41,[6677.15,8072.63,3.8147e-006]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('288', '19', '9', '[327,[6876.86,11167,2.76566e-005]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('289', '11', '9', '[0,[3008.2402,11027.495]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('290', '13', '9', '[0,[6852.0908,11166.002,-1.9073486e-006]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('291', '36', '9', '[355,[2902.24,10913.6,-0.000387192]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('292', '40', '9', '[39,[3072.7,11002.3,0.000118256]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('293', '37', '9', '[360,[8852.78,2168.46,-1.90735e-006]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('294', '33', '9', '[358,[10465.1,11582.3,-1.52588e-005]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('295', '11', '9', '[274,[10446.7,11510.6,-0.00825787]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('296', '15', '9', '[152,[10976,11109.1,-0.0227766]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('297', '13', '9', '[0,[10507.803,10731.588,-5.3405762e-005]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('298', '10', '9', '[0,[10478.332,10651.773,-4.0054321e-005]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('299', '44', '9', '[0,[9081.3779,8934.1094]]', null, '0.650', null);
INSERT INTO `world_vehicle` VALUES ('301', '53', '1', '[2,[12010.7,12637.2,0]]', null, '0.250', null);
INSERT INTO `world_vehicle` VALUES ('302', '53', '1', '[113,[6880.2007,11454.291,0]]', null, '0.250', null);
INSERT INTO `world_vehicle` VALUES ('303', '54', '1', '[156,[7660.271,3982.0063,0]]', null, '0.300', null);
INSERT INTO `world_vehicle` VALUES ('304', '54', '1', '[-188,[7220.6538,9116.3428,0]]', null, '0.300', null);
INSERT INTO `world_vehicle` VALUES ('305', '54', '1', '[4,[13584.044,3199.9648,0]]', null, '0.300', null);
INSERT INTO `world_vehicle` VALUES ('306', '55', '1', '[252,[4530.52,10785.1,0]]', null, '0.250', null);
INSERT INTO `world_vehicle` VALUES ('307', '56', '1', '[162,[3702.04,6044.3101,0]]', null, '0.500', null);
INSERT INTO `world_vehicle` VALUES ('308', '56', '1', '[141,[11953.279,9107.3896,0]]', null, '0.500', null);
INSERT INTO `world_vehicle` VALUES ('309', '57', '1', '[71,[3708.5,5999.4199,0]]', null, '0.500', null);
INSERT INTO `world_vehicle` VALUES ('310', '57', '1', '[322,[7201.5181,3034.3232,0]]', null, '0.500', null);
INSERT INTO `world_vehicle` VALUES ('564', '91', '10', '[242,[10291.3,18354.9,-0.180809]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('565', '29', '10', '[354,[10951,17800.9,0.0223007]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('566', '29', '10', '[162,[10922.9,17345.1,0.0321388]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('567', '81', '10', '[157,[10157.5,19150.1,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('568', '18', '10', '[184,[10339.8,18663.9,0.0126953]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('569', '30', '10', '[340,[10948.5,17206.8,0.0906601]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('570', '3', '10', '[62,[10984.5,18950.9,-4.76837e-007]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('571', '3', '10', '[339,[10270.8,17668.5,0.0456314]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('572', '32', '10', '[204,[11211.6,18116,0.00648117]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('573', '21', '10', '[243,[10228.8,18638.9,0.00063324]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('574', '15', '10', '[293,[9964.81,18664.9,0.00174713]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('575', '55', '10', '[313,[10490,17603.4,-0.629063]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('576', '55', '10', '[176,[10090.7,18410.8,-0.674576]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('577', '55', '10', '[245,[10177.2,18598.8,-0.671776]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('578', '89', '10', '[327,[11099.5,18673.8,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('579', '14', '10', '[319,[10633.1,17340.5,0.00105286]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('580', '81', '10', '[170,[10117.2,19008.2,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('581', '90', '10', '[85,[9962.75,18923,0.00149536]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('582', '81', '10', '[95,[10306.9,16804,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('583', '81', '10', '[131,[8788.46,19497.9,0.0118561]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('584', '3', '10', '[349,[11036.6,16840.4,0.0015564]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('585', '58', '10', '[316,[8778.47,19045.2,-0.00346375]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('586', '25', '10', '[92,[11698.8,18823.9,-0.338678]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('587', '25', '10', '[112,[11680.8,18691.2,-0.360215]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('588', '29', '10', '[317,[7474.65,4423.4,-0.00769424]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('589', '29', '10', '[277,[9057.16,2530.97,-0.0063858]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('590', '29', '10', '[134,[9135.33,7964.65,-0.00769043]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('591', '29', '10', '[95,[4019.75,6695.92,-0.00769424]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('592', '29', '10', '[220,[13403,8635.49,-0.00769043]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('593', '29', '10', '[66,[5822.55,8464.95,-0.00753784]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('594', '29', '10', '[56,[12022.2,15220.1,-0.00769806]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('595', '29', '10', '[318,[14163.5,12404.8,-0.00769424]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('596', '29', '10', '[0,[15257.5,9471.55,-0.00769615]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('597', '29', '10', '[70,[17359,7417.03,-0.00769043]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('598', '29', '10', '[189,[12614,11897.5,-0.00769806]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('599', '29', '10', '[57,[16971.7,12787.1,-0.00769615]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('600', '29', '10', '[304,[11371.1,1101.07,-0.00540161]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('601', '81', '10', '[92,[6514.76,8748.42,0.0316048]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('602', '81', '10', '[233,[4727.36,8095.94,7.62939e-006]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('603', '81', '10', '[131,[5224.73,6274.16,0.00038147]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('604', '81', '10', '[131,[10011.1,7181.43,0.00144958]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('605', '81', '10', '[120,[6510.3,5542.96,0.000148773]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('606', '81', '10', '[131,[7768.96,4579.06,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('607', '81', '10', '[320,[13427.7,8644.56,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('608', '81', '10', '[178,[15123.8,9375.95,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('609', '81', '10', '[169,[16213.3,14955.3,0.0228539]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('610', '81', '10', '[45,[7706.79,4174.13,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('611', '81', '10', '[360,[15355.2,9831.41,3.05176e-005]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('612', '81', '10', '[333,[12887.8,13419.6,0.02285]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('613', '81', '10', '[131,[8395.68,3332.51,0.000270844]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('614', '81', '10', '[296,[15925.3,8918.18,0.00468254]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('615', '81', '10', '[131,[14267.7,11740.5,0.00571442]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('616', '81', '10', '[167,[11115.6,16432.1,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('617', '81', '10', '[50,[9682.93,5836.99,0.0102997]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('618', '81', '10', '[147,[10770.1,2291.05,0.00911713]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('619', '81', '10', '[146,[8233.2,3557.05,0.00823021]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('620', '81', '10', '[154,[14631.3,18568.4,0.00568962]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('621', '81', '10', '[357,[15333,16325.5,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('622', '81', '10', '[179,[14983.5,9843.48,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('623', '81', '10', '[131,[11717.7,14820.3,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('624', '81', '10', '[160,[14953.7,17686.2,0.0230598]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('625', '81', '10', '[124,[11765.8,15295.7,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('626', '81', '10', '[193,[16535.6,12305.2,0.0189724]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('627', '81', '10', '[58,[13973.5,12345.3,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('628', '81', '10', '[0,[13233.2,12143.6,0.0196762]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('629', '81', '10', '[183,[17595.4,6287.17,0.00100708]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('630', '81', '10', '[131,[16712.8,8479.33,0.0872345]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('631', '81', '10', '[1,[12873.5,12944.9,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('632', '81', '10', '[143,[15653,10009.4,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('633', '81', '10', '[143,[12961.6,14013.4,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('634', '18', '10', '[132,[7808.4,4330.21,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('635', '18', '10', '[66,[17398.7,6512.27,0.0234985]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('636', '18', '10', '[183,[15569,8258.74,0.141594]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('637', '18', '10', '[158,[17167.2,7767.53,0.0743866]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('638', '18', '10', '[158,[12452.1,14354.7,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('639', '18', '10', '[128,[16412.7,8723.52,0.151649]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('640', '18', '10', '[214,[16459,12013.3,0.00720406]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('641', '18', '10', '[278,[15560.1,16005.2,0.00566101]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('642', '18', '10', '[76,[13169.2,19343.8,0.0113888]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('643', '18', '10', '[158,[11545.9,15615.5,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('644', '18', '10', '[84,[12838.6,11940.6,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('645', '18', '10', '[181,[14907.1,9766.22,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('646', '18', '10', '[158,[17324.2,7421.05,-0.102005]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('647', '18', '10', '[158,[5179.3,8106.45,0.00350952]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('648', '18', '10', '[113,[7495.9,8301.67,0.00138855]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('649', '18', '10', '[128,[9141,8111.72,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('650', '18', '10', '[303,[5915.2,5921.79,1.90735e-005]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('651', '18', '10', '[130,[7652.84,4086.29,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('652', '7', '10', '[203,[10693.7,6536.87,0.0229568]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('653', '9', '10', '[157,[8047.39,8636.07,0.00374603]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('654', '77', '10', '[158,[5482.39,8202.6,0.0140457]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('655', '8', '10', '[349,[5570.72,6114.17,8.7738e-005]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('656', '30', '10', '[318,[6888.35,5214.03,0.00019455]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('657', '30', '10', '[225,[7839.55,4494.92,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('658', '30', '10', '[140,[8652.84,3068.12,0.00364494]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('659', '30', '10', '[128,[7167.82,8533.28,0.00255585]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('660', '30', '10', '[120,[16354.1,13180.9,0.0191612]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('661', '30', '10', '[158,[8211.36,6154.37,0.0160217]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('662', '30', '10', '[208,[9050.35,7881.65,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('663', '30', '10', '[215,[16175.9,10431.5,0.0055275]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('664', '30', '10', '[182,[15113.4,9929.65,0.137263]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('665', '30', '10', '[134,[11133.3,1959.98,0.000549316]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('666', '30', '10', '[144,[8542.64,3162.03,0.000202179]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('667', '30', '10', '[295,[13424,8648.58,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('668', '30', '10', '[179,[15252.8,9215.89,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('669', '77', '10', '[126,[7214.78,4930.56,0.00031662]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('670', '8', '10', '[140,[8275.1,3476.29,0.00530815]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('671', '7', '10', '[271,[16905.2,6272.22,0.00584412]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('672', '77', '10', '[143,[10510.9,2562.58,0.0067749]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('673', '8', '10', '[147,[9604.49,4852.59,0.00148773]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('674', '77', '10', '[91,[11172.7,15990.7,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('675', '8', '10', '[181,[12874.6,13155.3,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('676', '9', '10', '[185,[16062.1,15670.4,0.0116997]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('677', '77', '10', '[180,[16259.6,11102.7,0.0425148]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('678', '8', '10', '[87,[17370.6,7346.27,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('679', '19', '10', '[271,[12152.6,14950.1,0.0159607]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('680', '19', '10', '[311,[12435,15202.6,0.00318909]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('681', '19', '10', '[277,[13670.5,13096.8,0.00578308]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('682', '19', '10', '[222,[13162.4,13622.9,0.00712585]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('683', '19', '10', '[293,[13364.2,13315.5,0.0142212]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('684', '19', '10', '[250,[13268.5,19505.5,0.0949459]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('685', '19', '10', '[332,[12080.8,19157.7,0.0564194]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('686', '19', '10', '[283,[8596.41,19476.3,0.0055542]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('687', '19', '10', '[293,[8411.4,19204.7,0.125671]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('688', '19', '10', '[293,[1663.18,7532.56,0.00292587]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('689', '19', '10', '[2,[2249.73,7592.62,0.0450172]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('690', '19', '10', '[272,[1519.11,7133.55,0.141129]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('691', '19', '10', '[293,[1680.76,6870.38,0.0112076]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('692', '19', '10', '[201,[5554.78,6028.8,3.8147e-005]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('693', '19', '10', '[31,[4594.34,6231.05,0.0142784]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('694', '20', '10', '[315,[7374.36,4759.34,-0.000656128]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('695', '20', '10', '[44,[7710.61,4611.11,-0.000656128]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('696', '20', '10', '[128,[7716.36,3906.45,-0.000656128]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('697', '20', '10', '[274,[13456,8603.68,-0.000671387]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('698', '20', '10', '[2,[14879.6,9330.99,-0.000658035]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('699', '3', '10', '[315,[11508.4,1262.49,0.0632362]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('700', '3', '10', '[330,[9883.54,3139.64,0.0131836]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('701', '3', '10', '[237,[11825,1411.95,0.0010252]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('702', '3', '10', '[274,[13190.3,8792.78,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('703', '3', '10', '[134,[13450.8,8605.12,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('704', '3', '10', '[339,[10688.8,11734,0.550781]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('705', '3', '10', '[191,[16826.5,8195.05,0.00675964]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('706', '3', '10', '[184,[15012.4,15616.1,0.00805664]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('707', '3', '10', '[293,[18394.7,5052.93,0.106243]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('708', '3', '10', '[273,[17564.7,6309.81,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('709', '3', '10', '[181,[16446.6,11620.8,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('710', '3', '10', '[293,[13174.2,13260.9,0.0268364]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('711', '3', '10', '[292,[12478,13860,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('712', '3', '10', '[270,[14688.2,10835.4,0.0373383]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('713', '3', '10', '[318,[9711.47,1983.53,0.00771332]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('714', '3', '10', '[25,[5711.09,5851.74,0.0101013]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('715', '3', '10', '[233,[9015.01,7405.48,0.021965]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('716', '3', '10', '[320,[2799.21,7081.33,0.0408325]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('717', '3', '10', '[315,[7649.58,21950.5,0.0791931]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('718', '3', '10', '[293,[11398.1,15315.9,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('719', '3', '10', '[293,[15651.9,9659.04,-0.102001]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('720', '3', '10', '[350,[16812.2,6297.74,0.00746155]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('721', '32', '10', '[179,[9082.64,21516.1,0.116533]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('722', '32', '10', '[266,[12963.3,11995.9,0.0131302]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('723', '32', '10', '[293,[3807.23,7246.74,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('724', '32', '10', '[55,[4034.12,7745.7,6.10352e-005]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('725', '32', '10', '[43,[5856.52,8621.12,0.00302887]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('726', '32', '10', '[221,[17118.1,7807.23,0.0652618]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('727', '32', '10', '[91,[15039.7,14824.6,0.00798798]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('728', '32', '10', '[259,[16347.1,7414.9,0.137238]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('729', '32', '10', '[359,[13414.2,8651.67,1.52588e-005]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('730', '32', '10', '[273,[15457.5,9795.01,0.0424709]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('731', '32', '10', '[272,[16283.9,10041.2,0.00337219]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('732', '32', '10', '[2,[16335.7,10544.5,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('733', '32', '10', '[259,[7742.34,7074.12,0.0001297]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('734', '32', '10', '[243,[8374.7,5813.29,0.0271759]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('735', '32', '10', '[181,[16465.9,14267.1,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('736', '32', '10', '[3,[15151.9,9366.48,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('737', '32', '10', '[307,[9534.39,7782.44,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('738', '32', '10', '[293,[11570.2,15115.9,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('739', '32', '10', '[293,[13297.6,12424.3,0.00325775]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('740', '32', '10', '[47,[10099,2944.08,0.0168152]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('741', '32', '10', '[319,[8721.09,2951.82,0.00160789]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('742', '32', '10', '[308,[6124.46,5807.65,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('743', '21', '10', '[314,[7756.23,4266.02,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('744', '21', '10', '[271,[2168,7026.63,0.000202179]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('745', '21', '10', '[359,[2129.33,7064.36,0.0020256]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('746', '21', '10', '[275,[16448.8,9219.42,0.146385]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('747', '23', '10', '[293,[15137.8,10164.2,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('748', '90', '10', '[72,[17214.1,5605.34,-0.00038147]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('749', '21', '10', '[293,[17380.9,5111.01,0.0486755]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('750', '21', '10', '[360,[9630.26,4229.79,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('751', '21', '10', '[5,[6760.29,9811.86,0.0148087]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('752', '21', '10', '[358,[9628.1,4417.41,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('753', '21', '10', '[151,[16695.3,10633.4,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('754', '21', '10', '[360,[3888.82,6974.72,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('755', '29', '10', '[360,[9303.53,4234.05,-0.00769806]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('756', '29', '10', '[271,[9409.02,4633.06,-0.00769806]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('757', '53', '10', '[293,[6739.95,8450.5,0.00347137]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('758', '15', '10', '[271,[15123.8,9746.96,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('759', '15', '10', '[183,[17514.7,5240.99,0.00959778]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('760', '15', '10', '[132,[7747.75,4258.96,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('761', '55', '10', '[221,[16613.3,11616.6,-0.674572]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('762', '55', '10', '[339,[7197.96,8235.7,-0.667679]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('763', '55', '10', '[216,[7469.84,8071.2,-0.678246]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('764', '58', '10', '[118,[16014.9,8410.25,0.0563278]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('765', '62', '10', '[137,[9612.94,2065.55,-0.0139961]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('766', '23', '10', '[270,[2167.46,7018.76,0.000156403]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('767', '58', '10', '[266,[3695.45,2348.44,0.293526]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('768', '62', '10', '[293,[4927.72,8571.45,0.0936146]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('769', '23', '10', '[293,[4558.08,6561.13,0.000110626]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('770', '62', '10', '[91,[17374.2,7641.97,-0.0154572]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('771', '23', '10', '[93,[13412.8,8656.76,1.52588e-005]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('772', '58', '10', '[340,[9514.06,4977.89,-0.0154419]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('773', '62', '10', '[216,[14227.3,19121.1,0.0452614]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('774', '23', '10', '[265,[17085,6914.41,0.0455627]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('775', '58', '10', '[129,[6218.76,9814.33,-0.00266266]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('776', '62', '10', '[338,[4092.65,8087.38,0.104589]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('777', '23', '10', '[217,[9454.04,5261.97,0.00300598]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('778', '89', '10', '[199,[12525.9,11984,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('779', '89', '10', '[293,[9351.74,15258.9,0.00850677]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('780', '89', '10', '[310,[9251.79,2059.08,0.0140038]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('781', '89', '10', '[271,[16503.3,9805.29,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('782', '89', '10', '[219,[7489.96,8046.14,0.000335693]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('783', '89', '10', '[54,[9704.19,4731.92,0.0215988]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('784', '89', '10', '[273,[3503,7838.59,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('785', '47', '10', '[342,[2130.2,7102.84,0.0467148]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('786', '14', '10', '[1,[15129.4,9539.02,0.0100794]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('787', '10', '10', '[342,[2141.89,7102.96,0.0446053]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('788', '48', '10', '[343,[2137.76,7102.6,0.0414391]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('789', '12', '10', '[341,[2133.69,7103.56,0.0480652]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('790', '47', '10', '[342,[2126.66,7103.33,0.0381203]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('791', '10', '10', '[122,[1867.53,7180.35,0.0412025]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('792', '48', '10', '[91,[2236.42,7332.13,0.0434113]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('793', '12', '10', '[227,[1977.12,7314.2,0.0414314]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('794', '47', '10', '[325,[14276.1,11341.2,0.0357208]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('795', '10', '10', '[154,[17485.7,5878.32,0.0465851]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('796', '48', '10', '[90,[11995.8,14826.6,0.0642624]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('797', '12', '10', '[91,[12786.3,12594.9,0.0311279]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('798', '47', '10', '[294,[8427.57,3328.11,0.0574608]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('799', '10', '10', '[90,[5415.58,6186.02,0.0469246]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('800', '48', '10', '[339,[5298.04,8531.94,0.0501747]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('801', '12', '10', '[62,[4288.17,7869.8,0.0450974]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('802', '47', '10', '[293,[8058,6558.82,0.0485535]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('803', '10', '10', '[1,[16414,11521.6,0.0345001]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('804', '12', '10', '[91,[11200.6,15657.3,0.0419388]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('805', '47', '10', '[183,[16510.8,8259.83,0.0452576]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('806', '10', '10', '[79,[16100.5,14243.9,0.0524826]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('807', '48', '10', '[31,[15075.9,15924.6,0.0644913]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('808', '12', '10', '[90,[11175.4,15818.8,0.0353546]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('809', '47', '10', '[293,[15589.7,9072.52,0.0452518]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('810', '10', '10', '[91,[15733.3,9512.98,0.0452595]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('811', '48', '10', '[91,[14683.8,9881.79,0.0452595]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('812', '12', '10', '[315,[13419.4,8650.89,0.0454712]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('813', '47', '10', '[3,[14528.9,9956.16,0.0452671]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('814', '12', '10', '[91,[15001.5,9881.99,0.0452595]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('815', '14', '10', '[269,[5979.19,9939.29,0.0100784]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('816', '14', '10', '[318,[7468.45,4436.98,0.0100784]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('817', '14', '10', '[292,[4299.27,7984.63,0.00423813]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('818', '14', '10', '[293,[15248.2,9745.34,-0.0358782]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('819', '14', '10', '[293,[15493.8,9881.16,0.0145454]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('820', '14', '10', '[293,[9066.47,8118.34,0.0128784]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('821', '14', '10', '[273,[16184.7,10004.8,0.0109634]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('822', '14', '10', '[293,[17030.3,6246.27,0.0174866]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('823', '14', '10', '[293,[15270.5,9511.31,0.0100775]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('824', '14', '10', '[356,[16098.2,8204.98,0.125397]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('825', '14', '10', '[171,[16231.9,14855.5,0.0170135]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('826', '14', '10', '[359,[14889.9,17936.8,0.00637054]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('827', '14', '10', '[293,[1425.62,7193.55,0.0614738]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('828', '14', '10', '[294,[6193.01,1521.38,0.182577]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('829', '14', '10', '[171,[8537.62,20142.9,0.0104523]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('830', '14', '10', '[227,[14825.1,11901.1,0.0316849]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('831', '14', '10', '[221,[14642.6,12337.7,0.0271759]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('832', '14', '10', '[232,[16447.9,12912.2,0.032845]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('833', '14', '10', '[294,[8296.59,6950.21,0.253869]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('834', '14', '10', '[6,[6532.7,9966.24,0.0240402]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('835', '14', '10', '[340,[2123.28,7102.89,0.00970459]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('836', '65', '10', '[180,[16116.4,13812.2,-0.000217438]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('837', '65', '10', '[200,[17477.2,12276.4,0.0108566]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('838', '65', '10', '[324,[4629.23,8336.25,0.10837]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('839', '65', '10', '[273,[6671.33,8720.9,0.0102539]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('840', '65', '10', '[293,[7600.95,4315.18,-0.000370026]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('841', '65', '10', '[309,[9290.08,8222.67,-0.00038147]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('842', '65', '10', '[311,[10295.3,6320.12,0.0368347]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('843', '65', '10', '[126,[7805.89,9122.92,0.00511932]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('844', '65', '10', '[319,[8723.51,2986.67,0.00176048]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('845', '65', '10', '[94,[9381.76,4272.11,-0.000366211]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('846', '81', '10', '[266,[2160.29,7085.14,0.00204849]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('847', '81', '10', '[272,[2236.44,7065.34,0.00204086]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('848', '25', '10', '[144,[3722.14,2355.7,-0.544513]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('849', '25', '10', '[273,[11932.6,20890.1,-0.530017]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('850', '25', '10', '[179,[11920.5,20888.2,-0.55589]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('851', '82', '10', '[145,[15725.9,13419.4,0.0174866]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('852', '25', '10', '[85,[13425.4,4308.68,-0.535668]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('853', '25', '10', '[85,[13713.5,2884.49,-0.517073]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('854', '29', '10', '[185,[9694.08,4451.54,-0.00769806]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('855', '29', '10', '[340,[9697.81,4446.22,-0.00769806]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('856', '58', '10', '[155,[9885.42,3154.16,-0.00692749]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('857', '18', '10', '[110,[9887.89,3147.46,0.0118561]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('858', '7', '10', '[310,[9897.35,3145.53,0.00969696]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('859', '81', '10', '[345,[9900.03,3140.46,0.0110016]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('860', '26', '10', '[330,[8542.83,6953.21,-0.608744]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('861', '18', '10', '[90,[12262,15516.9,0]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('862', '9', '10', '[87,[12158.4,15170.1,0.00104523]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('863', '20', '10', '[90,[11822.1,15463.8,-0.00177765]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('864', '10', '10', '[90,[11954.3,15065.7,0.0534363]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('865', '25', '10', '[212,[10175.6,13971,-0.263998]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('866', '25', '10', '[159,[10558.2,13938.9,-0.592891]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('867', '25', '10', '[67,[10819.4,14116.8,-0.0761685]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('868', '25', '10', '[241,[9526.37,14832.4,-0.440026]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('869', '25', '10', '[281,[9509.38,14986.7,-0.416944]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('870', '88', '10', '[220,[7940.75,5388.84,0.0183563]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('871', '88', '10', '[135,[8950.19,3592.84,0.000854492]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('872', '91', '10', '[218,[7722.66,7858.29,-0.184998]]', '', '0.700', '0.34');
INSERT INTO `world_vehicle` VALUES ('873', '92', '1', '[122,[10137.868,12049.376,-6.1035156e-005]]', null, '0.250', '0.36');
INSERT INTO `world_vehicle` VALUES ('874', '93', '1', '[0,[13441.056,12003.912,4.5776367e-005]]', null, '0.400', '0.36');
INSERT INTO `world_vehicle` VALUES ('875', '94', '2', '[90,[5986.6792,7027.0684,4.863739e-005]]', null, '0.250', '0.39');
INSERT INTO `world_vehicle` VALUES ('876', '55', '2', '[0,[3055.7537,6474.4546,-0.70897663]]', null, '0.650', '0.39');
INSERT INTO `world_vehicle` VALUES ('877', '55', '2', '[180,[4318.3994,1878.7593,-0.66435003]]', null, '0.500', '0.39');
INSERT INTO `world_vehicle` VALUES ('878', '53', '2', '[180,[1301.7004,1455.2246,-4.7683716e-006]]', null, '0.555', '0.39');
INSERT INTO `world_vehicle` VALUES ('879', '53', '2', '[0,[6081.769,1671.0074,-1.0490417e-005]]', null, '0.555', '0.39');
INSERT INTO `world_vehicle` VALUES ('880', '53', '2', '[150,[5508.1572,5060.7256,-1.2397766e-005]]', null, '0.555', '0.39');
INSERT INTO `world_vehicle` VALUES ('881', '92', '2', '[180,[7519.2031,8273.2949,-2.1934509e-005]]', null, '0.500', '0.39');
INSERT INTO `world_vehicle` VALUES ('882', '92', '2', '[90,[6952.7598,6430.978,9.5367432e-006]]', null, '0.500', '0.39');
INSERT INTO `world_vehicle` VALUES ('883', '92', '2', '[90,[4183.8716,7572.7285,1.1444092e-005]]', null, '0.500', '0.39');
INSERT INTO `world_vehicle` VALUES ('884', '54', '2', '[75,[3064.6106,7974.1719,-0.51635265]]', null, '0.500', '0.39');
INSERT INTO `world_vehicle` VALUES ('885', '95', '2', '[0,[5205.9272, 4022.6003, 1.4305115e-005]]', null, '0.250', '0.40');
INSERT INTO `world_vehicle` VALUES ('886', '96', '2', '[0,[5889.4961, 6797.897, -9.5367432e-007]]', null, '0.400', '0.40');
INSERT INTO `world_vehicle` VALUES ('887', '97', '2', '[0,[4491.751, 4787.2593, -3.8146973e-006]]', null, '0.400', '0.40');
INSERT INTO `world_vehicle` VALUES ('888', '98', '2', '[0,[1395.826, 608.14166, -1.5258789e-005]]', null, '0.400', '0.40');
INSERT INTO `world_vehicle` VALUES ('889', '99', '2', '[54,[1028.6489, 5299.1694, -0.13182747]]', null, '0.555', '0.40');
INSERT INTO `world_vehicle` VALUES ('890', '100', '2', '[170,[6046.6108, 6032.4341, 0.071113408]]', null, '0.555', '0.40');
INSERT INTO `world_vehicle` VALUES ('891', '101', '2', '[125,[1095.5248, 1502.8373, 0.011992991]]', null, '0.500', '0.40');
INSERT INTO `world_vehicle` VALUES ('892', '102', '2', '[170,[4236.9077, 3593.072, 0.053207695]]', null, '0.500', '0.40');
INSERT INTO `world_vehicle` VALUES ('893', '103', '2', '[105,[7171.2598, 1379.329, -0.046738148]]', null, '0.500', '0.40');
INSERT INTO `world_vehicle` VALUES ('894', '104', '2', '[5,[6673.5703, 1599.817, -0.1397385]]', null, '0.500', '0.40');
INSERT INTO `world_vehicle` VALUES ('895', '105', '2', '[0,[7217.437, 2314.2693, -0.055636108]]', null, '0.500', '0.45');
INSERT INTO `world_vehicle` VALUES ('896', '106', '2', '[75,[7590.3486, 8260.0996, -0.082376719]]', null, '0.500', '0.40');
INSERT INTO `world_vehicle` VALUES ('897', '107', '2', '[80,[3965.0176, 9361.5029, 0.00010919571]]', null, '0.500', '0.40');
INSERT INTO `world_vehicle` VALUES ('898', '108', '2', '[0,[9332.3389, 5007.4839, 4.7]]', null, '0.500', '0.42');
INSERT INTO `world_vehicle` VALUES ('1001', '111', '1', '[0,[13159.146,13083.029,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1002', '25', '1', '[0,[13869.803,13508.12,-0.33730567]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1003', '93', '1', '[0,[13441.056,12003.912,4.5776367e-005]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1004', '53', '1', '[227,[10319.874,12084.312,3.0517578e-005]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1005', '92', '1', '[122,[10137.868,12049.376,-6.1035156e-005]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1006', '92', '1', '[114,[10275.374,12019.95,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1007', '93', '1', '[-122,[10266.736,12001.66,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1008', '33', '1', '[64,[9653.4443,13555.063,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1009', '53', '1', '[-117,[9698.9893,13686.655,4.5776367e-005]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1010', '111', '1', '[0,[6158.7725,9005.5732,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1011', '31', '1', '[0,[12276.199,10586.779,-1.5258789e-005]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1012', '111', '1', '[0,[11934.478,9518.6309,0.00016021729]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1013', '111', '1', '[0,[12288.495,11094.473,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1014', '111', '1', '[0,[12118.503,9445.8721,-5.7220459e-006]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1015', '17', '1', '[-122,[12283.381,9464.5566,-1.1444092e-005]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1016', '111', '1', '[0,[12102.996,9451.2998,5.531311e-005]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1017', '111', '1', '[0,[12090.864,9453.6055,2.6702881e-005]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1018', '66', '1', '[-171,[12989.563,10075.743,-5.2452087e-006]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1019', '62', '1', '[-75,[12987.494,10039.641,-1.2397766e-005]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1020', '19', '1', '[0,[12670.277,10015.792,-3.8146973e-006]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1021', '19', '1', '[108,[12684.55,10074.417,-6.6757202e-005]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1022', '22', '1', '[-25,[12683.362,9825.7119,0.00010728836]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1023', '32', '1', '[-161,[13098.729,10248.01,2.6702881e-005]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1024', '20', '1', '[0,[12996.397,10078.24,1.2397766e-005]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1025', '16', '1', '[-161,[13145.874,10416.225,-7.8678131e-005]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1026', '32', '1', '[108,[13109.942,10302.45,1.9073486e-006]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1027', '14', '1', '[-56,[4570.3975,2421.6531,-1.2397766e-005]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1028', '53', '1', '[-190,[13112.096,10432.461,2.4795532e-005]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1029', '5', '1', '[-190,[4564.9624,2371.521,3.528595e-005]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1030', '57', '1', '[-95,[4713.7666,2616.6179,1.6212463e-005]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1031', '111', '1', '[37,[4360.8408,2482.9688,9.5367432e-006]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1032', '30', '1', '[19,[4454.373,2453.6816,-1.4781952e-005]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1033', '55', '1', '[-125,[4809.2461,2539.2903,2.8610229e-006]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1034', '55', '1', '[134,[5172.3457,2172.7046,-0.044954818]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1035', '55', '1', '[108,[5260.3203,2261.9851,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1036', '54', '1', '[4,[13584.044,3199.9648,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1037', '7', '1', '[-163,[9691.2695,6551.8672,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1038', '55', '1', '[-212,[5156.3555,2651.9055,-2.6702881e-005]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1039', '13', '1', '[-63,[5986.3462,10373.445,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1040', '58', '1', '[7,[5969.1924,10313.057,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1041', '5', '1', '[-32,[5984.6064,10161.703,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1042', '66', '1', '[105,[6027.7988,10459.635,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1043', '64', '1', '[-134,[6448.6953,6543.1836,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1044', '82', '1', '[-14,[6208.9775,10403.117,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1045', '14', '1', '[-138,[8511.4111,6044.689,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1046', '17', '1', '[-120,[8440.3926,5975.1753,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1047', '111', '1', '[-93,[9157.7549,11019.93,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1048', '30', '1', '[-68,[7438.0454,5180.8857,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1049', '111', '1', '[-71,[8330.4639,5971.6885,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1050', '93', '1', '[241,[10641.2,8073.2202,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1051', '27', '1', '[306,[10454.8,8872.0996,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1052', '93', '1', '[62,[10320.025,2157.7627,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1053', '54', '1', '[-188,[7220.6538,9116.3428,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1054', '53', '1', '[113,[6880.2007,11454.291,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1055', '27', '1', '[189,[10812.7,2686.29,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1056', '65', '1', '[210,[11351.6,6633.52,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1057', '15', '1', '[160,[11216.4,4234.8101,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1058', '57', '1', '[322,[7201.5181,3034.3232,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1059', '19', '1', '[191,[11424.036,7355.7295,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1060', '5', '1', '[42,[11461.1,11380.5,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1061', '20', '1', '[245,[11463.3,7545.9302,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1062', '5', '1', '[-37,[11483.7,11382.7,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1063', '15', '1', '[7,[12057.56,12626.336,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1064', '10', '1', '[272,[11945.3,9130.3398,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1065', '20', '1', '[376,[12130.7,3516.8899,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1066', '20', '1', '[-38,[12167.4,9748.5498,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1067', '7', '1', '[186,[12903.9,4431.3799,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1068', '1', '1', '[89,[13127.792,11561.818,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1069', '21', '1', '[330,[13088.4,7108.5698,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1070', '20', '1', '[183,[13367.5,6601.1099,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1071', '32', '1', '[233,[1915.7,12442.2,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1072', '56', '1', '[141,[11953.279,9107.3896,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1073', '23', '1', '[287,[1967.1801,9147.2197,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1074', '93', '1', '[309,[2768.26,6000.1602,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1075', '27', '1', '[82,[2578.5901,5084.1099,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1076', '13', '1', '[-149,[2792.48,3114.03,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1077', '13', '1', '[202,[2947.2,2036.92,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1078', '13', '1', '[-3,[2882.28,5270.4902,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1079', '57', '1', '[71,[3708.5,5999.4199,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1080', '56', '1', '[162,[3702.04,6044.3101,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1081', '13', '1', '[51,[3572.6201,2545.29,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1082', '18', '1', '[180,[3728.0701,8669.0098,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1083', '19', '1', '[-32,[3790.79,8961.0898,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1084', '6', '1', '[274,[3748.5901,5990.8701,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1085', '6', '1', '[313,[4087.0901,11669.4,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1086', '6', '1', '[121,[4059.3201,11658.4,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1087', '91', '1', '[268,[4238.04,10781.7,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1088', '54', '1', '[156,[7660.271,3982.0063,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1089', '55', '1', '[252,[4530.52,10785.1,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1090', '1', '1', '[226,[4790.1299,2571.3501,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1091', '18', '1', '[304,[4564.6948,4506.1382,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1092', '16', '1', '[246,[4952.6401,5616.5098,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1093', '53', '1', '[2,[12010.7,12637.2,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1094', '27', '1', '[222,[5136.8501,2362.4299,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1095', '17', '1', '[102,[6237.4902,7705.6602,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1096', '13', '1', '[70,[6294.96,7833.77,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1097', '9', '1', '[99,[6293.1201,7827.1201,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1098', '10', '1', '[46,[6404.5347,3209.2341,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1099', '15', '1', '[34,[6360.2271,2767.6943,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1100', '4', '1', '[231,[6319.1499,7733.6499,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1101', '17', '1', '[202,[6575.8828,2868.105,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1102', '4', '1', '[340,[6850.1362,2480.0134,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1103', '15', '1', '[-23,[7154.9399,8157.1401,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1104', '13', '1', '[130,[7919.9063,7231.3369,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1105', '31', '1', '[215,[7807.3442,3539.9856,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1106', '27', '1', '[185,[8039.1299,2916.3899,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1107', '14', '1', '[4,[8027.8701,7076.1699,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1108', '8', '1', '[49,[8001.5898,3342.51,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1109', '24', '1', '[253,[8299.9502,2358.95,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1110', '4', '1', '[160,[8115.6299,9295.5,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1111', '14', '1', '[285,[8091.2998,3350.3101,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1112', '14', '1', '[197,[8342.5996,2460.51,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1113', '10', '1', '[13,[8783.2061,11723.631,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1114', '10', '1', '[-17,[8636.0049,6856.8818,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1115', '14', '1', '[160,[8346.9404,2458.27,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1116', '6', '1', '[294,[8830.5,2863.95,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1117', '15', '1', '[27,[9686.9316,3604.3081,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1118', '27', '1', '[124,[9676.3398,8880.75,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1119', '6', '1', '[84,[8837.4805,2844.75,0]]', '', '1.000', '0.19');
INSERT INTO `world_vehicle` VALUES ('1120', '4', '1', '[332,[4872.57,9688.53,0.001]]', '', '1.000', '0.19');

-- ----------------------------
-- View structure for `v_deployable`
-- ----------------------------
DROP VIEW IF EXISTS `v_deployable`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_deployable` AS select `id`.`id` AS `instance_deployable_id`,`d`.`id` AS `vehicle_id`,`d`.`class_name` AS `class_name`,`s`.`id` AS `owner_id`,`p`.`name` AS `owner_name`,`p`.`unique_id` AS `owner_unique_id`,`s`.`is_dead` AS `is_owner_dead`,`id`.`worldspace` AS `worldspace`,`id`.`inventory` AS `inventory` from (((`instance_deployable` `id` join `deployable` `d` on((`id`.`deployable_id` = `d`.`id`))) join `survivor` `s` on((`id`.`owner_id` = `s`.`id`))) join `profile` `p` on((`s`.`unique_id` = `p`.`unique_id`)));

-- ----------------------------
-- View structure for `v_player`
-- ----------------------------
DROP VIEW IF EXISTS `v_player`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_player` AS select `p`.`name` AS `player_name`,`p`.`humanity` AS `humanity`,`s`.`id` AS `alive_survivor_id`,`s`.`world_id` AS `alive_survivor_world_id` from (`profile` `p` left join `survivor` `s` on(((`p`.`unique_id` = `s`.`unique_id`) and (`s`.`is_dead` = 0))));

-- ----------------------------
-- View structure for `v_vehicle`
-- ----------------------------
DROP VIEW IF EXISTS `v_vehicle`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_vehicle` AS select `iv`.`id` AS `instance_vehicle_id`,`v`.`id` AS `vehicle_id`,`iv`.`instance_id` AS `instance_id`,`i`.`world_id` AS `world_id`,`v`.`class_name` AS `class_name`,`iv`.`worldspace` AS `worldspace`,`iv`.`inventory` AS `inventory`,`iv`.`parts` AS `parts`,`iv`.`damage` AS `damage`,`iv`.`fuel` AS `fuel` from (((`instance_vehicle` `iv` join `world_vehicle` `wv` on((`iv`.`world_vehicle_id` = `wv`.`id`))) join `vehicle` `v` on((`wv`.`vehicle_id` = `v`.`id`))) join `instance` `i` on((`iv`.`instance_id` = `i`.`id`)));

-- ----------------------------
-- Procedure structure for `proc_getBuildingPageCount`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_getBuildingPageCount`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getBuildingPageCount`(in `p_instanceId` int)
begin
  declare itemsPerPage int default 5; -- must match proc_getobjects
  select
    floor(count(*) / itemsPerPage) + if((count(*) mod itemsPerPage) > 0, 1, 0)
  from instance_building
  where instance_id = p_instanceId; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_getBuildings`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_getBuildings`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getBuildings`(in `p_instanceId` int, in `p_currentPage` int)
begin
  set @instance = p_instanceId; --
  set @page = greatest(((p_currentPage - 1) * 5), 0); --
  prepare stmt from '
  select
    b.class_name, ib.worldspace
  from
    instance_building ib
    inner join building b on ib.building_id = b.id
  where
    ib.instance_id = ?
  limit ?, 5'; --
  execute stmt using @instance, @page; --
  deallocate prepare stmt; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_getMessagePage`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_getMessagePage`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getMessagePage`(in `p_instanceId` int, in `p_currentPage` int)
begin
  set @instance = p_instanceId; --
  set @page = greatest(((p_currentPage - 1) * 10), 0); --
  prepare stmt from 'select payload, loop_interval, start_delay  from message where instance_id = ? limit ?, 10'; --
  execute stmt using @instance, @page; -- 
  deallocate prepare stmt; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_getMessagePageCount`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_getMessagePageCount`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_getMessagePageCount`(in `p_instanceId` int)
begin
  declare itemsPerPage int default 10; -- must match proc_getMessagePage
  select
    floor(count(*) / itemsPerPage) + if((count(*) mod itemsPerPage) > 0, 1, 0)
  from message
  where message.instance_id = p_instanceId; --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_loglogin`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_loglogin`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_loglogin`(in `p_uniqueId` varchar(128), in `p_instanceId` int)
begin
  insert ignore into log_entry (unique_id, instance_id, log_code_id) values (p_uniqueId, p_instanceId, 1); --
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for `proc_loglogout`
-- ----------------------------
DROP PROCEDURE IF EXISTS `proc_loglogout`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_loglogout`(in `p_uniqueId` varchar(128), in `p_instanceId` int)
begin
  insert into log_entry (unique_id, instance_id, log_code_id) values (p_uniqueId, p_instanceId, 5); --
end
;;
DELIMITER ;
