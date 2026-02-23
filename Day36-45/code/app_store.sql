drop database if exists `app_store`;
create database `app_store` default character set utf8mb4;
use `app_store`;
create table `app_info` (
  `id` bigint(20) not null auto_increment comment 'Auto-increment ID, App ID',
  `app_name` varchar(255) default '' comment 'App Name',
  `icon_url` varchar(255) default '' comment 'Icon URL',
  `version` varchar(32) default '' comment 'Version Number',
  `app_size` varchar(32) default '' comment 'Package Size',
  `banner_info` varchar(4096) default '' comment 'Banner Information',
  `developer_id` varchar(255) default '' comment 'Developer ID',
  `summary` varchar(512) default '' comment 'Summary',
  `app_desc` text comment 'Detailed Description',
  `download_url` varchar(255) default '' comment 'Download URL',
  `price` int(10) default '0' comment 'Price in cents',
  `status` tinyint(4) unsigned default '0' comment 'Status: 1=pending review, 2=approved, 3=offline',
  `version_desc` varchar(4096) default '' comment 'Version Description',
  `create_time` datetime not null default '0000-00-00 00:00:00' comment 'Create Time',
  `update_time` datetime not null default '0000-00-00 00:00:00' comment 'Update Time',
  primary key (`id`)
) engine = innodb auto_increment = 100000 default charset = utf8mb4 comment = 'App Info Table';
create table `app_ext_info` (
  `id` bigint(20) not null auto_increment comment 'Auto-increment ID',
  `app_id` bigint(20) not null default '0' comment 'App ID',
  `install_count` bigint(20) unsigned not null default '0' comment 'App Install Count',
  `score` int(10) unsigned not null default '0' comment 'Rating Score',
  `comment_count` int(10) unsigned not null default '0' comment 'Comment Count',
  `create_time` int(10) not null default 0 comment 'Create Time',
  `update_time` int(10) not null default 0 comment 'Update Time',
  primary key (`id`)
) engine = innodb default charset = utf8mb4 comment = 'App Extension Info Table';
create table `app_category` (
  `id` bigint(20) not null auto_increment comment 'Auto-increment ID',
  `parent_id` bigint(20) not null default '0' comment 'Parent Category ID',
  `name` varchar(64) not null default '' comment 'Category Name',
  `icon` varchar(512) not null default '' comment 'Icon URL',
  `category_desc` text comment 'Category Description',
  `category_level` tinyint(4) unsigned not null default '0' comment 'Category Level',
  `status` tinyint(4) unsigned not null default '0' comment 'Status: 1=in use, 2=hidden',
  `display_order` int(10) unsigned not null default '0' comment 'Display Order (higher value appears first)',
  `create_time` int(10) not null default 0 comment 'Create Time',
  `update_time` int(10) not null default 0 comment 'Update Time',
  primary key (`id`)
) engine = innodb default charset = utf8mb4 comment = 'Category Info Table';
create table `app_category_rel` (
  `id` bigint(20) not null auto_increment comment 'Auto-increment ID',
  `app_id` bigint(20) not null default '0' comment 'App ID',
  `category_id` bigint(20) unsigned not null default '0' comment 'Lowest Level Category ID',
  primary key (`id`),
  unique key `idx_category_app` (`category_id`, `app_record_id`),
) engine = innodb default charset = utf8mb4 comment = 'App and Category Relationship Table';
create table `app_comment` (
  `id` bigint(20) not null auto_increment comment 'Auto-increment ID',
  `app_id` bigint(20) not null default '0' comment 'App ID',
  `title` varchar(255) default '' comment 'Comment Title',
  `content` varchar(2048) default '' comment 'Comment Content',
  `parent_id` bigint(20) default '0' comment 'Parent Comment ID',
  `commenter_uid` bigint(20) default '0' comment 'Commenter User ID',
  `commenter_name` varchar(255) default '' comment 'Commenter Name',
  `commenter_avatar` varchar(255) default '' comment 'Commenter Avatar',
  `top_flag` tinyint(4) default '0' comment 'Is Pinned',
  `like_count` int(10) default '0' comment 'Comment Like Count',
  `status` tinyint(4) default '0' comment 'Comment Status',
  `create_time` int(10) not null default 0 comment 'Create Time',
  `update_time` int(10) not null default 0 comment 'Update Time',
  primary key (`id`),
  key `idx_app_status` (`app_id`, `status`, `top_flag`)
) engine = innodb default charset = utf8mb4 comment = 'Comment Info Table';
create table `user_app_relation` (
  `id` bigint(20) not null auto_increment comment 'Auto-increment ID',
  `user_id` bigint(20) unsigned not null default '0' comment 'User ID',
  `app_id` bigint(20) not null default '0' comment 'App ID',
  `create_time` int(10) not null default 0 comment 'Create Time',
  `update_time` int(10) not null default 0 comment 'Update Time',
  `is_del` tinyint(4) not null default '0' comment '1=deleted, 0=not deleted',
  primary key (`id`),
  key `idx_user_app` (`user_id`, `app_id`)
) engine = innodb auto_increment = 8063 default charset = utf8mb4 comment = 'User Purchase Relationship Table';
create table `bot_score` (
  `id` bigint(20) not null auto_increment comment 'Auto-increment ID',
  `app_id` bigint(20) not null default '0' comment 'App ID',
  `score` int(10) default '0' comment 'User Rating Score',
  `commenter_uid` bigint(20) default '0' comment 'Rater User ID',
  `status` tinyint(4) default '0' comment 'Rating Status',
  `create_time` int(10) not null default 0 comment 'Create Time',
  `update_time` int(10) not null default 0 comment 'Update Time',
  primary key (`id`),
  unique key `idx_uid_score` (`app_id`, `commenter_uid`)
) engine = innodb default charset = utf8mb4 comment = 'App Rating Table';