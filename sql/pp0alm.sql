/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80030 (8.0.30)
 Source Host           : localhost:3306
 Source Schema         : pp0alm

 Target Server Type    : MySQL
 Target Server Version : 80030 (8.0.30)
 File Encoding         : 65001

 Date: 23/12/2022 18:55:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `passwrd` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`email`) USING BTREE,
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`email`) REFERENCES `person` (`email`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------

-- ----------------------------
-- Table structure for person
-- ----------------------------
DROP TABLE IF EXISTS `person`;
CREATE TABLE `person`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `minit` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `lname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `username` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `street` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of person
-- ----------------------------
INSERT INTO `person` VALUES ('aj489@gmail.com', 'Ahemad', 'V', 'Jabbar', 'aj489', 'TX', 'Houston', '980 Dallas', '5743621584');
INSERT INTO `person` VALUES ('azelaya@gmail.com', 'Alicia', 'J', 'Zelaya', 'alizela', 'TX', 'Spring', '3221 Castle', '4896321450');
INSERT INTO `person` VALUES ('hiroshi123@gmail.com', 'Hiroshi', 'S', 'Yoshida', 'hiroshi123', 'ON', 'North York', '586 Sayview', '4521597845');
INSERT INTO `person` VALUES ('JanWall@yahoo.com', 'Jannifer', 'S', 'Wallace', 'jan889', 'TX', 'Bellaire', '291 Berry', '4581234587');
INSERT INTO `person` VALUES ('jborg@gmail.com', 'James', 'E', 'Borg', 'jborg', 'TX', 'Houston', '450 Stone', '1237531598');
INSERT INTO `person` VALUES ('jbs123@gmail.com', 'John', 'B', 'Smith', 'jbs123', 'TX', 'Houston', '731 Fondren', '5412357895');
INSERT INTO `person` VALUES ('jdoe557@outllok.com', 'Jane', 'S', 'Doe', 'jdo557', 'ON', 'North York', '186 Southwood', '4375896214');
INSERT INTO `person` VALUES ('jen2887@gmail.com', 'Joyce', 'A', 'English', 'jenglish', 'TX', 'Houston', '5631 Rice', '4831251397');
INSERT INTO `person` VALUES ('rnarayan@outlook.com', 'Ramesh', 'K', 'Narayan', 'rnarayan', 'TX', 'Humble', '975 Fire Oak', '4891251478');
INSERT INTO `person` VALUES ('tado125@gmail.com', 'Koji', 'A', 'Tadokoro', 'tado125', 'ON', 'Mississauga', '1587 Dinch', '4872301523');
INSERT INTO `person` VALUES ('wf556@outlook.com', 'Franklin', 'T', 'Wong', 'wong2', 'TX', 'Houston', '638 Voss', '4851230214');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `age` int NOT NULL,
  `uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cTime` date NULL DEFAULT NULL,
  `uTime` date NULL DEFAULT NULL,
  PRIMARY KEY (`email`) USING BTREE,
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`email`) REFERENCES `person` (`email`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('aj489@gmail.com', 'Male', 37, '923145789', '2022-12-23', NULL);
INSERT INTO `user` VALUES ('azelaya@gmail.com', 'Female', 29, '987654321', '2022-12-22', NULL);
INSERT INTO `user` VALUES ('hiroshi123@gmail.com', 'Male', 27, '203145879', '2022-12-23', NULL);
INSERT INTO `user` VALUES ('JanWall@yahoo.com', 'Female', 30, '888665555', '2022-12-23', NULL);
INSERT INTO `user` VALUES ('jborg@gmail.com', 'Male', 48, '147365248', '2022-12-23', NULL);
INSERT INTO `user` VALUES ('jbs123@gmail.com', 'Male', 33, '123456789', '2022-12-22', NULL);
INSERT INTO `user` VALUES ('jdoe557@outllok.com', 'Female', 32, '856147236', '2022-12-23', NULL);
INSERT INTO `user` VALUES ('jen2887@gmail.com', 'Female', 29, '159753246', '2022-12-23', NULL);
INSERT INTO `user` VALUES ('rnarayan@outlook.com', 'Male', 33, '852741963', '2022-12-23', NULL);
INSERT INTO `user` VALUES ('tado125@gmail.com', 'Male', 18, '963214578', '2022-12-23', NULL);
INSERT INTO `user` VALUES ('wf556@outlook.com', 'Male', 25, '333445555', '2022-12-22', NULL);

SET FOREIGN_KEY_CHECKS = 1;
