;; MySQL schema definitions

delimiter $$

CREATE TABLE `Region` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lon` double DEFAULT NULL,
  `population` bigint(20) DEFAULT '0',
  `type` varchar(50) DEFAULT NULL,
  `alternateNames` varchar(5000) DEFAULT NULL,
  `hotelCount` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8$$

CREATE TABLE `RegionAlternateNames` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `region_id` int(11) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `region_id` (`region_id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=387340 DEFAULT CHARSET=utf8$$

CREATE TABLE `RegionPerimeter` (
  `region_id` int(10) unsigned NOT NULL,
  `lat` double DEFAULT NULL,
  `lon` double DEFAULT NULL,
  `perimeter` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8$$

CREATE TABLE `RegionHierarchyClosure` (
  `parent_region_id` int(10) unsigned NOT NULL,
  `region_id` int(10) unsigned NOT NULL,
  `distance` int(10) unsigned NOT NULL,
  `regionTree_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`regionTree_id`,`region_id`,`parent_region_id`),
  KEY `tree_region_id` (`regionTree_id`,`region_id`,`distance`),
  KEY `tree_parent_region_id` (`regionTree_id`,`parent_region_id`,`distance`),
  KEY `region_id` (`region_id`,`distance`,`parent_region_id`),
  KEY `parent_region_id` (`parent_region_id`,`distance`,`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED$$

