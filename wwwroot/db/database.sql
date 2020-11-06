-- MySQL Script generated by MySQL Workbench
-- Fri Nov  6 09:39:43 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema nxtframework
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `nxtframework` ;

-- -----------------------------------------------------
-- Schema nxtframework
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `nxtframework` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `nxtframework` ;

-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_acl_action`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_acl_action` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_acl_action` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `action_class` VARCHAR(128) NULL DEFAULT NULL,
  `action_name` VARCHAR(255) NULL DEFAULT NULL,
  `action_remark` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `action_name_UNIQUE` (`action_name` ASC),
  UNIQUE INDEX `action_class_UNIQUE` (`action_class` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 61
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_acl_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_acl_group` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_acl_group` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `group_name` VARCHAR(128) NULL DEFAULT NULL,
  `group_remark` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `group_name_UNIQUE` (`group_name` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_acl_group_action`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_acl_group_action` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_acl_group_action` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `group_id` BIGINT(20) NOT NULL,
  `action_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_nxt_acl_group_action_nxt_acl_action1_idx` (`action_id` ASC),
  INDEX `fk_nxt_acl_group_action_nxt_acl_group1_idx` (`group_id` ASC),
  UNIQUE INDEX `unique_group_action` (`action_id` ASC, `group_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 86
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_acl_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_acl_role` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_acl_role` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(128) NULL DEFAULT NULL,
  `role_remark` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `role_name_UNIQUE` (`role_name` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_acl_role_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_acl_role_group` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_acl_role_group` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `role_id` BIGINT(20) NOT NULL,
  `group_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_nxt_acl_role_group_nxt_acl_group1_idx` (`group_id` ASC),
  INDEX `fk_nxt_acl_role_group_nxt_acl_role1_idx` (`role_id` ASC),
  UNIQUE INDEX `unique_role_group` (`role_id` ASC, `group_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 28
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_user` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_user` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(128) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL COMMENT '登录用户名',
  `password` VARCHAR(32) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '登录密码 md5(password+salt) 全小写',
  `salt` VARCHAR(32) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '密码盐',
  `token` VARCHAR(32) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '每次注销/登录都要变化',
  `status` INT(11) NULL DEFAULT NULL COMMENT '0:正常 -1:黑名单',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  INDEX `index_status` (`status` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 20
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_acl_user_action`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_acl_user_action` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_acl_user_action` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT(20) NOT NULL,
  `action_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_nxt_acl_user_action_nxt_user1_idx` (`user_id` ASC),
  INDEX `fk_nxt_acl_user_action_nxt_acl_action1_idx` (`action_id` ASC),
  UNIQUE INDEX `unique_user_action` (`user_id` ASC, `action_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_acl_user_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_acl_user_role` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_acl_user_role` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT(20) NOT NULL,
  `role_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_nxt_acl_user_role_nxt_user1_idx` (`user_id` ASC),
  INDEX `fk_nxt_acl_user_role_nxt_acl_role1_idx` (`role_id` ASC),
  UNIQUE INDEX `unique_user_role` (`user_id` ASC, `role_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 19
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_banner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_banner` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_banner` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '网站轮播图',
  `location_name` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '位置名',
  `uploadfile_id` BIGINT(20) NULL DEFAULT NULL COMMENT '图片id',
  `click_url` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '点击链接',
  PRIMARY KEY (`id`),
  INDEX `index_location_name` (`location_name` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 127
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_news_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_news_category` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_news_category` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '资讯分类',
  `category_name` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '分类名称',
  `category_pid` BIGINT(20) NULL DEFAULT NULL COMMENT '上级分类id',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_content` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_content` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '网站内容表【包含资讯新闻、单页标题和内容如about等】',
  `category_id` BIGINT(20) NOT NULL COMMENT '资讯类别',
  `content_title` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '内容标题',
  `content_detail` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '内容HTML',
  `dateline_update` BIGINT(20) NULL DEFAULT NULL COMMENT '更新时间（精确到毫秒）',
  `dateline_create` BIGINT(20) NULL DEFAULT NULL COMMENT '创建时间（精确到毫秒）',
  `is_recommend` INT(11) NULL DEFAULT NULL COMMENT '推荐',
  `sort_id` BIGINT(20) NULL DEFAULT NULL COMMENT '排序，大的在前面',
  PRIMARY KEY (`id`),
  INDEX `fk_nxt_content_nxt_news_category1_idx` (`category_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 37
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_cronjob`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_cronjob` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_cronjob` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT ' 后台任务',
  `job_name` VARCHAR(45) NULL DEFAULT NULL COMMENT '任务名称',
  `job_key` VARCHAR(255) NULL DEFAULT NULL COMMENT '任务唯一标识',
  `job_status` INT(11) NULL DEFAULT NULL COMMENT '任务状态（0:off 1:on)',
  `job_status_description` VARCHAR(255) NULL DEFAULT NULL COMMENT '任务进度状态描述',
  `job_status_dateline` BIGINT(20) NULL DEFAULT NULL COMMENT '任务进度状态更新时间',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `job_key_UNIQUE` (`job_key` ASC),
  INDEX `index_job_status_dateline` (`job_status_dateline` ASC),
  INDEX `index_job_status` (`job_status` ASC),
  INDEX `index_job_key` (`job_key` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_guestmessage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_guestmessage` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_guestmessage` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '【留言板】',
  `guest_company` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '留言者公司',
  `guest_name` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '留言者名称',
  `guest_phone` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '联系电话',
  `guest_email` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '联系邮箱',
  `message_content` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '内容',
  `message_dateline` BIGINT(20) NULL DEFAULT NULL COMMENT '留言时间',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_product_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_product_category` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_product_category` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '分类名称',
  `category_pid` BIGINT(20) NULL DEFAULT NULL COMMENT '上级分类id',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_uploadfile_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_uploadfile_category` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_uploadfile_category` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '分类名称',
  `category_pid` BIGINT(20) NULL DEFAULT NULL COMMENT '上级分类id',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_uploadfile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_uploadfile` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_uploadfile` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `file_location` INT(11) NULL DEFAULT NULL COMMENT '0:网盘文件 1:七牛云oss 2:阿里云oss 3:本地',
  `category_id` BIGINT(20) NOT NULL COMMENT '0:图片 正数:category表分类',
  `file_ext` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '文件类型后缀（小写）',
  `filename_source` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '原始文件名',
  `filename_saved` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '存储文件名',
  `filepath` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '相对于ftp或oss根目录的路径',
  `urlpath` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '相对于域名的路径',
  `filesize` BIGINT(20) NULL DEFAULT NULL COMMENT '文件大小 字节',
  `dateline_update` BIGINT(20) NULL DEFAULT NULL COMMENT '保存或更新时间（精确到毫秒）',
  `netdisk_url` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '网盘地址',
  `netdisk_pwd` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '网盘下载密码',
  PRIMARY KEY (`id`),
  INDEX `fk_nxt_uploadfile_nxt_uploadfile_category1_idx` (`category_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 375
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_product_brand`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_product_brand` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_product_brand` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '产品品牌管理',
  `brand_name` VARCHAR(255) NULL COMMENT '分类名称',
  `uploadfile_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_nxt_product_brand_nxt_uploadfile1_idx` (`uploadfile_id` ASC),
  INDEX `index_brand_name` (`brand_name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_product` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_product` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `category_id` BIGINT(20) NOT NULL,
  `brand_id` BIGINT(20) NULL,
  `product_name` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '产品名称',
  `product_subtitle` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '副标题（营销使用）',
  `deal_quantity_min` BIGINT(20) NULL COMMENT '单次最少购买',
  `deal_quantity_max` BIGINT(20) NULL COMMENT '单次最多购买',
  `free_shipping` INT(11) NULL COMMENT '包邮',
  `delivery_config_id` BIGINT(20) NULL COMMENT '运费模版',
  `item_no` VARCHAR(255) NULL COMMENT '货号',
  `with_sku` INT(11) NULL COMMENT '是否附带sku',
  `price` BIGINT(20) NULL DEFAULT NULL COMMENT '价格（单位：分）',
  `price_discount` BIGINT(20) NULL COMMENT '折扣：100表示不打折，95是95折，以此类推',
  `inventory_quantity` BIGINT(20) NULL,
  `product_description` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '产品介绍',
  `dateline_create` BIGINT(20) NULL DEFAULT NULL COMMENT '创建时间（精确到毫秒）',
  `dateline_updated` BIGINT(20) NULL DEFAULT NULL COMMENT '更新时间（精确到毫秒）',
  `is_recommend` INT(11) NULL DEFAULT NULL COMMENT '是否推荐',
  `is_hot` INT(11) NULL COMMENT '热卖',
  `is_new` INT(11) NULL COMMENT '新品',
  `is_selling` INT(11) NULL COMMENT '上架',
  `sort_id` BIGINT(20) NULL DEFAULT NULL COMMENT '排序，大的在前面',
  `is_trash` INT(11) NULL COMMENT '放入回收站',
  PRIMARY KEY (`id`),
  INDEX `fk_nxt_product_nxt_product_category_idx` (`category_id` ASC),
  INDEX `fk_nxt_product_nxt_product_brand1_idx` (`brand_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 91
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_product_picture`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_product_picture` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_product_picture` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `product_id` BIGINT(20) NOT NULL COMMENT '产品id',
  `uploadfile_id` BIGINT(20) NOT NULL COMMENT '图片id',
  `sort_id` BIGINT(20) NULL DEFAULT NULL COMMENT '排序（小的在前）',
  PRIMARY KEY (`id`),
  INDEX `fk_nxt_product_picture_nxt_product1_idx` (`product_id` ASC),
  INDEX `fk_nxt_product_picture_nxt_uploadfile1_idx` (`uploadfile_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 131
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_product_sku`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_product_sku` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_product_sku` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `product_id` BIGINT(20) NOT NULL COMMENT '产品ID',
  `sku_key_name` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT 'sku键名称',
  PRIMARY KEY (`id`),
  INDEX `fk_nxt_product_sku_nxt_product1_idx` (`product_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 114
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_product_sku_value`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_product_sku_value` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_product_sku_value` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `sku_id` BIGINT(20) NOT NULL COMMENT 'sku的ID',
  `sku_value_name` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '值名',
  PRIMARY KEY (`id`),
  INDEX `fk_nxt_product_sku_value_nxt_product_sku1_idx` (`sku_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 252
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_setting`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_setting` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_setting` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '网站设置表【相当于一个key-value数据库】',
  `setting_key` VARCHAR(128) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL COMMENT 'key',
  `setting_value` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT 'value',
  `setting_name` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '设置名',
  `display_type` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT 'input、textarea两种',
  `dateline_updated` BIGINT(20) NULL DEFAULT NULL COMMENT '保存或更新时间（精确到毫秒）',
  `placeholder` VARCHAR(255) NULL DEFAULT NULL COMMENT '填写说明',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `setting_key_UNIQUE` (`setting_key` ASC),
  INDEX `index_dateline_updated` (`dateline_updated` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_web_page`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_web_page` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_web_page` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '网站页面表【包含页面标题和其它设置等】',
  `web_key` VARCHAR(45) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '标识(会根据web_key 查询)',
  `web_title` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '页面标题',
  `content_title` VARCHAR(255) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '内容标题',
  `content_detail` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT '内容HTML',
  `seo_keyword` TEXT CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NULL DEFAULT NULL COMMENT 'SEO关键词',
  `dateline_update` BIGINT(20) NULL DEFAULT NULL COMMENT '更新时间（精确到毫秒）',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `unique_web_key` (`web_key` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_delivery_region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_delivery_region` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_delivery_region` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '【物流配送地区】',
  `region_name` VARCHAR(255) NULL COMMENT '名称',
  `region_pid` BIGINT(20) NULL COMMENT '上级地区id',
  `sort_id` BIGINT(20) NULL COMMENT '排序，大的在前面',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_delivery_config`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_delivery_config` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_delivery_config` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '运费模版',
  `name` VARCHAR(255) NULL COMMENT '名称',
  `type` INT(11) NULL COMMENT '类型：（1:按重量 2:按体积 3:按件数）',
  PRIMARY KEY (`id`),
  INDEX `index_name` (`name` ASC),
  INDEX `index_type` (`type` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_delivery_config_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_delivery_config_item` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_delivery_config_item` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `delivery_config_id` BIGINT(20) NOT NULL,
  `billable_quantity` BIGINT(20) NULL COMMENT '首重/首体积/最低计费数量',
  `billable_price` BIGINT(20) NULL COMMENT '起步价',
  `addition_quantity` BIGINT(20) NULL COMMENT '续重/续体积/最低增加单位量',
  `addition_price` BIGINT(20) NULL COMMENT '最低单位续费',
  PRIMARY KEY (`id`),
  INDEX `fk_nxt_delivery_config_item_nxt_delivery_config1_idx` (`delivery_config_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_delivery_config_item_region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_delivery_config_item_region` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_delivery_config_item_region` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '运费模版条目所含地区',
  `delivery_config_item_id` BIGINT(20) NOT NULL,
  `delivery_region_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_nxt_delivery_config_item_region_nxt_delivery_region1_idx` (`delivery_region_id` ASC),
  INDEX `fk_nxt_delivery_config_item_region_nxt_delivery_config_item_idx` (`delivery_config_item_id` ASC),
  UNIQUE INDEX `unique_item_region` (`delivery_region_id` ASC, `delivery_config_item_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_delivery_company`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_delivery_company` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_delivery_company` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '快递管理',
  `name` VARCHAR(255) NULL,
  `code_100` VARCHAR(255) NULL,
  `activity` INT(11) NULL COMMENT '是否生效 1:生效 0:不生效',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nxtframework`.`nxt_product_sku_value_price_etc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nxtframework`.`nxt_product_sku_value_price_etc` ;

CREATE TABLE IF NOT EXISTS `nxtframework`.`nxt_product_sku_value_price_etc` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `sku_value_id_1` BIGINT(20) NULL,
  `sku_value_id_2` BIGINT(20) NULL,
  `sku_value_inventory_quantity` BIGINT(20) NULL COMMENT '库存',
  `sku_value_price` BIGINT(20) NULL COMMENT '价格',
  `sku_value_price_discount` BIGINT(20) NULL COMMENT '折扣',
  PRIMARY KEY (`id`),
  INDEX `fk_nxt_product_sku_value_price_etc_nxt_product_sku_value1_idx` (`sku_value_id_1` ASC),
  INDEX `fk_nxt_product_sku_value_price_etc_nxt_product_sku_value2_idx` (`sku_value_id_2` ASC),
  UNIQUE INDEX `unique_value_id` (`sku_value_id_1` ASC, `sku_value_id_2` ASC),
  INDEX `index5` (`sku_value_inventory_quantity` ASC),
  INDEX `index6` (`sku_value_price` ASC),
  INDEX `index7` (`sku_value_price_discount` ASC))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
