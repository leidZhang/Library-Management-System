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

 Date: 29/12/2022 18:23:18
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
INSERT INTO `admin` VALUES ('admin01@libman.com', '******');
INSERT INTO `admin` VALUES ('admin02@libman.com', '000000');
INSERT INTO `admin` VALUES ('lizh021@libman.com', '123456');
INSERT INTO `admin` VALUES ('rmikrot@libman.com', '385825');

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
INSERT INTO `person` VALUES ('admin01@libman.com', 'Brian', 'K', 'Roses', 'admin01', 'QC', 'Montreal', '288 Cinge', '5123647894');
INSERT INTO `person` VALUES ('admin02@libman.com', 'Daisy', 'L', 'Goodvin', 'admin02', 'QC', 'Quebec', '823 Kings', '5236987412');
INSERT INTO `person` VALUES ('azelaya@yahoo.com', 'Alicia', 'J', 'Zelaya', 'azelaya', 'TX', 'Spring', '3221 Castle', '4623587412');
INSERT INTO `person` VALUES ('fblorg@outlook.com', 'Friend', 'C', 'Blorg', 'blorggg', 'ON', 'North York', '867 Skywood', '4236587412');
INSERT INTO `person` VALUES ('jamesborg@gmail.com', 'James', 'E', 'Borg', 'jamborg', 'TX', 'Houston', '450 Stone', '4325874156');
INSERT INTO `person` VALUES ('jande8654@outlook.com', 'Jane', 'C', 'Doe', 'jande865', 'ON', 'North York', '187 Sayview', '4358974156');
INSERT INTO `person` VALUES ('jbs123@gmail.com', 'John', 'B', 'Smith', 'jbs123', 'TX', 'Houston', '731 Fondren', '4395210124');
INSERT INTO `person` VALUES ('jen2687@gmail.com', 'Joyce', 'A', 'English', 'jen26687', 'TX', 'Houston', '5631 Dallas', '4598741256');
INSERT INTO `person` VALUES ('jwallace2598@outlook.com', 'Jennifer', 'S', 'Wallace', 'jwallace85', 'TX', 'Ballaire', '291 Berry', '4632157894');
INSERT INTO `person` VALUES ('kojitadokoro@gmail.com', 'Koji', 'M', 'Tadokoro', 'kojitada123', 'ON', 'Mississauga', '123 Upwood', '5632147845');
INSERT INTO `person` VALUES ('lizh021@libman.com', 'Liz', NULL, 'Hauge', 'lizh021', 'ON', 'Toronto', '123 Queens', '4856321478');
INSERT INTO `person` VALUES ('rmikrot@libman.com', 'Robin', NULL, 'Mikrot', 'rmikrot', 'NS', 'Halifax', '195 Southwood', '3548967412');
INSERT INTO `person` VALUES ('spacestarfish@outlook.com', 'Evil', 'S', 'Starfish', 'spacestarfish', 'NS', 'Halifax', '2333 Longe', '4856321475');
INSERT INTO `person` VALUES ('wf2887@outlook.com', 'Franklin', 'T', 'Wong', 'wf288c', 'TX', 'Houston', '638 Voss', '4381254789');
INSERT INTO `person` VALUES ('yoshida124@yahoo.com', 'Hiroshi', 'V', 'Yoshida', 'hyoshida', 'ON', 'North York', '3001 Dinch', '6321478569');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `age` int NOT NULL,
  `uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cTime` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `uTime` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`email`) USING BTREE,
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`email`) REFERENCES `person` (`email`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('azelaya@yahoo.com', 'Female', 27, '20221224597193486', '2022-12-24 17:33:04', NULL);
INSERT INTO `user` VALUES ('fblorg@outlook.com', 'Other', 4, '20221224346174758', '2022-12-24 17:38:39', '2022-12-25 16:33:41');
INSERT INTO `user` VALUES ('jamesborg@gmail.com', 'Male', 45, '202212242055571912', '2022-12-24 17:36:58', NULL);
INSERT INTO `user` VALUES ('jande8654@outlook.com', 'Female', 23, '20221224564425856', '2022-12-24 17:39:53', NULL);
INSERT INTO `user` VALUES ('jbs123@gmail.com', 'Male', 33, '202212241946340529', '2022-12-24 17:30:11', NULL);
INSERT INTO `user` VALUES ('jen2687@gmail.com', 'Female', 25, '20221224723207108', '2022-12-24 17:36:14', NULL);
INSERT INTO `user` VALUES ('jwallace2598@outlook.com', 'Female', 36, '20221224679361579', '2022-12-24 17:34:57', NULL);
INSERT INTO `user` VALUES ('kojitadokoro@gmail.com', 'Male', 18, '20221224828600467', '2022-12-24 17:43:47', NULL);
INSERT INTO `user` VALUES ('spacestarfish@outlook.com', 'Other', 17, '20221225752851968', '2022-12-25 16:35:37', '2022-12-29 18:18:59');
INSERT INTO `user` VALUES ('wf2887@outlook.com', 'Male', 25, '202212241314368891', '2022-12-24 17:31:42', NULL);
INSERT INTO `user` VALUES ('yoshida124@yahoo.com', 'Male', 33, '202212241065002931', '2022-12-24 17:41:54', NULL);

SET FOREIGN_KEY_CHECKS = 1;
