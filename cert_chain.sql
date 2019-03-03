/*
 Navicat Premium Data Transfer

 Source Server         : javaonline
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : 39.96.200.91:3306
 Source Schema         : cert_chain

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 03/03/2019 22:43:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for appuser
-- ----------------------------
DROP TABLE IF EXISTS `appuser`;
CREATE TABLE `appuser`  (
  `user_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `user_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `user_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `user_headimage` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户头像',
  `user_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户邮箱',
  `user_sign` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户个性签名',
  `user_job` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '用户职业',
  `user_signin_time` datetime(0) NULL DEFAULT NULL COMMENT '用户登录时间',
  `user_login_times` int(11) NULL DEFAULT NULL COMMENT '用户登录次数',
  `org_id` int(11) NULL DEFAULT NULL COMMENT '组织id',
  `user_authority` int(255) NULL DEFAULT NULL COMMENT '0禁用1正常2删除',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3001 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of appuser
-- ----------------------------
INSERT INTO `appuser` VALUES (3000, '陆平', '123456', '18848968888', NULL, '821011@qq.com', NULL, NULL, NULL, NULL, 1, NULL);

-- ----------------------------
-- Table structure for cert_user
-- ----------------------------
DROP TABLE IF EXISTS `cert_user`;
CREATE TABLE `cert_user`  (
  `cert_user_id` int(11) NOT NULL,
  `org_id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `course_id` int(11) UNSIGNED NOT NULL,
  `cert_id` int(11) UNSIGNED NOT NULL,
  `cert_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `cert_createtime` datetime(0) NULL DEFAULT NULL,
  `org_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `course_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `cert_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`cert_user_id`) USING BTREE,
  INDEX `org`(`org_id`) USING BTREE,
  INDEX `course`(`course_id`) USING BTREE,
  INDEX `user`(`user_id`) USING BTREE,
  INDEX `cert`(`cert_id`) USING BTREE,
  CONSTRAINT `cert` FOREIGN KEY (`cert_id`) REFERENCES `certification` (`cert_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `course` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `org` FOREIGN KEY (`org_id`) REFERENCES `orgnation` (`org_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user` FOREIGN KEY (`user_id`) REFERENCES `appuser` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cert_user
-- ----------------------------
INSERT INTO `cert_user` VALUES (1, 1, 3000, 1000, 2000, '1231', '2019-03-03 11:45:16', '易生生教育', '区块链技术与运用', '区块链认证一级证书');

-- ----------------------------
-- Table structure for certification
-- ----------------------------
DROP TABLE IF EXISTS `certification`;
CREATE TABLE `certification`  (
  `cert_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '证书id',
  `cert_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '证书名字',
  `org_id` int(11) NOT NULL COMMENT '机构id',
  `cert_number` int(11) NULL DEFAULT NULL COMMENT '证书编号',
  `cert_time` datetime(0) NULL DEFAULT NULL,
  `cert_image` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '证书图片',
  PRIMARY KEY (`cert_id`) USING BTREE,
  INDEX `cert_name`(`cert_name`) USING BTREE,
  INDEX `cert_id`(`cert_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2001 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of certification
-- ----------------------------
INSERT INTO `certification` VALUES (2000, '区块链认证一级证书', 1, 101, '2019-01-30 21:03:10', '');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `course_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `course_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `course_image` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '课程图片路径',
  `course_period` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '课程课时',
  `course_allstudent` int(11) NULL DEFAULT NULL COMMENT '课程开课总人数',
  `course_teacher` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '开课老师',
  `course_starttime` datetime(0) NULL DEFAULT NULL COMMENT '开课时间',
  `course_endtime` datetime(0) NULL DEFAULT NULL COMMENT '结课时间',
  `course_detail` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '课程详情',
  `course_authority` int(11) NULL DEFAULT NULL,
  `org_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`course_id`) USING BTREE,
  INDEX `course_name`(`course_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1006 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (1000, '区块链技术与运用', '123231.jpg', '11', 66, '张三', '2019-03-01 17:22:15', '2019-03-16 17:24:49', '区块链技术的商业应用，近一两年来，区块链成为了各行业热议的新技术。目前，几乎所有领域都在开展相关的探索甚至研发。区块链在银行与金融业的用例.今年到目前为止，比特币及其他加密货币热度居高不下，不过人们的关注重点正在渐渐转向支撑这些货币的底层技术——区块链。', NULL, 1);
INSERT INTO `course` VALUES (1001, '数字经济师', '123.jpg', '8', 20, '李四', NULL, NULL, NULL, NULL, 1);
INSERT INTO `course` VALUES (1002, '区块链思维', 'jiugongge.jpg', '15', 56, '陆平', NULL, NULL, NULL, NULL, 1);

-- ----------------------------
-- Table structure for orgnation
-- ----------------------------
DROP TABLE IF EXISTS `orgnation`;
CREATE TABLE `orgnation`  (
  `org_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `org_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `org_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `org_owner` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '机构负责人',
  `org_headimage` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '机构头像',
  `org_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '机构联系电话',
  `org_mail` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '机构联系邮箱',
  `org_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '机构地址',
  `org_license` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '机构的营业执照',
  `org_licenseno` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '机构营业执照编号',
  `org_ownerIdcard` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '机构负责人的身份证',
  `org_ownerIdcardreverse` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '机构负责人的身份证反面',
  `org_privatekey` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '机构的私钥路径地址',
  `org_authority` int(11) NULL DEFAULT NULL COMMENT '机构状态0禁用1正常2删除',
  PRIMARY KEY (`org_id`) USING BTREE,
  INDEX `org_name`(`org_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orgnation
-- ----------------------------
INSERT INTO `orgnation` VALUES (1, '易生生教育', '123456', 'zhang', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `orgnation` VALUES (2, 'ss', 'ww', NULL, NULL, 'p', 'm', NULL, '1551197965929.png', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `role_authority` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
