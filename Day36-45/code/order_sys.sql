-- Transaction Table
CREATE TABLE `transaction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Transaction Serial Number',
  `member_id` bigint(20) NOT NULL COMMENT 'Transaction User ID',
  `amount` decimal(8, 2) NOT NULL COMMENT 'Transaction Amount',
  `integral` int(11) NOT NULL DEFAULT '0' COMMENT 'Points Used',
  `pay_state` tinyint(4) NOT NULL COMMENT 'Payment Type: 0=Balance, 1=WeChat, 2=Alipay, 3=Other',
  `source` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Payment Source: wx, app, web, wap',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Payment Status: -1=Cancelled, 0=Pending, 1=Completed, -2=Exception',
  `completion_time` int(11) NOT NULL COMMENT 'Transaction Completion Time',
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Remarks',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_order_sn_member_id_pay_state_source_status_index` (
    `order_sn`(191),
    `member_id`,
    `pay_state`,
    `source`(191),
    `status`
  )
) ENGINE = InnoDB AUTO_INCREMENT = 36 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
-- Transaction Record Table
CREATE TABLE `transaction_record` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `events` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Event Details',
  `result` text COLLATE utf8mb4_unicode_ci COMMENT 'Result Details',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 36 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
-- Order Table
CREATE TABLE `order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_no` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Order Number',
  `order_sn` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Transaction Number',
  `member_id` int(11) NOT NULL COMMENT 'Customer ID',
  `supplier_id` int(11) NOT NULL COMMENT 'Supplier Code',
  `supplier_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Supplier Name',
  `order_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Order Status: 0=Unpaid, 1=Paid, 2=Shipped, 3=Received, -1=Return Request, -2=Returning, -3=Returned, -4=Cancelled',
  `after_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'User After-sales Status: 0=Not Initiated, 1=Requested, -1=Cancelled, 2=Processing, 200=Completed',
  `product_count` int(11) NOT NULL DEFAULT '0' COMMENT 'Product Quantity',
  `product_amount_total` decimal(12, 4) NOT NULL COMMENT 'Total Product Price',
  `order_amount_total` decimal(12, 4) NOT NULL DEFAULT '0.0000' COMMENT 'Actual Payment Amount',
  `logistics_fee` decimal(12, 4) NOT NULL COMMENT 'Shipping Fee',
  `address_id` int(11) NOT NULL COMMENT 'Delivery Address Code',
  `pay_channel` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Payment Channel: 0=Balance, 1=WeChat, 2=Alipay',
  `out_trade_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Order Payment Number',
  `escrow_trade_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Third-party Payment Serial Number',
  `pay_time` int(11) NOT NULL DEFAULT '0' COMMENT 'Payment Time',
  `delivery_time` int(11) NOT NULL DEFAULT '0' COMMENT 'Delivery Time',
  `order_settlement_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '订单结算状态 0未结算 1已结算',
  `order_settlement_time` int(11) NOT NULL DEFAULT '0' COMMENT '订单结算时间',
  `is_package` enum('0', '1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '是否是套餐',
  `is_integral` enum('0', '1') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '是否是积分产品',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_order_sn_unique` (`order_sn`),
  KEY `order_order_sn_member_id_order_status_out_trade_no_index` (
    `order_sn`,
    `member_id`,
    `order_status`,
    `out_trade_no`(191)
  )
) ENGINE = InnoDB AUTO_INCREMENT = 44 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
-- 售后申请表
CREATE TABLE `order_returns_apply` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '订单单号',
  `order_detail_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '子订单编码',
  `return_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '售后单号',
  `member_id` int(11) NOT NULL COMMENT '用户编码',
  `state` tinyint(4) NOT NULL COMMENT '类型 0 仅退款 1退货退款',
  `product_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '货物状态 0:已收到货 1:未收到货',
  `why` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '退换货原因',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '审核状态 -1 拒绝 0 未审核 1审核通过',
  `audit_time` int(11) NOT NULL DEFAULT '0' COMMENT '审核时间',
  `audit_why` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '审核原因',
  `note` text COLLATE utf8mb4_unicode_ci COMMENT '备注',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
-- 售后记录表
CREATE TABLE `order_returns` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `returns_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '退货编号 供客户查询',
  `order_id` int(11) NOT NULL COMMENT '订单编号',
  `express_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '物流单号',
  `consignee_realname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '收货人姓名',
  `consignee_telphone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系电话',
  `consignee_telphone2` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '备用联系电话',
  `consignee_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '收货地址',
  `consignee_zip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮政编码',
  `logistics_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '物流方式',
  `logistics_fee` decimal(12, 2) NOT NULL COMMENT '物流发货运费',
  `order_logistics_status` int(11) DEFAULT NULL COMMENT '物流状态',
  `logistics_settlement_status` int(11) DEFAULT NULL COMMENT '物流结算状态',
  `logistics_result_last` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '物流最后状态描述',
  `logistics_result` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '物流描述',
  `logistics_create_time` int(11) DEFAULT NULL COMMENT '发货时间',
  `logistics_update_time` int(11) DEFAULT NULL COMMENT '物流更新时间',
  `logistics_settlement_time` int(11) DEFAULT NULL COMMENT '物流结算时间',
  `returns_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0全部退单 1部分退单',
  `handling_way` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'PUPAWAY:退货入库;REDELIVERY:重新发货;RECLAIM-REDELIVERY:不要求归还并重新发货; REFUND:退款; COMPENSATION:不退货并赔偿',
  `returns_amount` decimal(8, 2) NOT NULL COMMENT '退款金额',
  `return_submit_time` int(11) NOT NULL COMMENT '退货申请时间',
  `handling_time` int(11) NOT NULL COMMENT '退货处理时间',
  `remark` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '退货原因',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
-- 评价表
CREATE TABLE `order_appraise` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '订单编码',
  `info` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `level` enum('-1', '0', '1') COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '级别 -1差评 0中评 1好评',
  `desc_star` tinyint(4) NOT NULL COMMENT '描述相符 1-5',
  `logistics_star` tinyint(4) NOT NULL COMMENT '物流服务 1-5',
  `attitude_star` tinyint(4) NOT NULL COMMENT '服务态度 1-5',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_appraise_order_id_index` (`order_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;