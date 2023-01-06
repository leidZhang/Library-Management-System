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

 Date: 06/01/2023 16:11:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `passwrd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`email`) USING BTREE,
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`email`) REFERENCES `person` (`email`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('admin02@libman.com', 'd4e01a749610b02ce7d27366a4008bfa');
INSERT INTO `admin` VALUES ('jasonliu88@libman.com', 'd4e01a749610b02ce7d27366a4008bfa');
INSERT INTO `admin` VALUES ('mlas028@libman.com', 'd4e01a749610b02ce7d27366a4008bfa');

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `isbn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `publish_date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `publisher` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `cDate` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `uDate` datetime NULL DEFAULT NULL,
  `cover` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `credit` int NULL DEFAULT NULL,
  `number` int NULL DEFAULT 0,
  PRIMARY KEY (`isbn`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES ('0128203315', 'Computer Organization and Design RISC-V Edition: The Hardware Software Interface', 'Science > Computer Science', 'Computer Organization and Design RISC-V Edition: The Hardware Software Interface, Second Edition, the award-winning textbook from Patterson and Hennessy that is used by more than 40,000 students per year, continues to present the most comprehensive and readable introduction to this core computer science topic. ', '2020-12-31', 'David A. Patterson', 'Morgan Kaufmann', '2023-01-03 23:54:53', '2023-01-05 21:41:25', 'https://m.media-amazon.com/images/W/WEBP_402378-T2/images/I/51tRhoFUQ2L._SX405_BO1,204,203,200_.jpg', 10, 4);
INSERT INTO `book` VALUES ('0131103628', 'C Programming Langeage', 'Science > Computer Science', 'Written by the developers of C, this new version helps readers keep up with the finalized ANSI standard for C while showing how to take advantage of C\'s rich set of operators, economy of expression, improved control flow, and data structures.', '1988-03-22', 'Brian W. Kernighan', 'Pearson', '2023-01-03 16:18:14', '2023-01-05 21:41:22', 'https://m.media-amazon.com/images/I/411ejyE8obL._SX377_BO1,204,203,200_.jpg', 10, 2);
INSERT INTO `book` VALUES ('0133970779', 'Fundamentals of Database Systems', 'Science > Computer Science', 'This book introduces the fundamental concepts necessary for designing, using, and implementing database systems and database applications. Our presentation stresses the fundamentals of database modeling and design, the languages and models provided by the database management systems, and database system implementation techniques.', '2015-06-08', 'Ramez Elmasri', 'Pearson', '2023-01-03 16:06:46', '2023-01-04 18:02:18', 'https://m.media-amazon.com/images/I/51IBmkQUFuL._SX400_BO1,204,203,200_.jpg', 15, 2);
INSERT INTO `book` VALUES ('1721801286', 'Roman History: A Captivating Guide to Ancient Rome, Including the Roman Republic, the Roman Empire and the Byzantium', 'History > European History', 'A Captivating Guide to Ancient Rome, Including the Roman Republic, the Roman Empire and the Byzantium', '2018-06-22', 'Captivating History', 'CreateSpace Independent Publishing Platform', '2023-01-06 15:57:45', '2023-01-06 15:59:16', 'https://m.media-amazon.com/images/I/51f2iRPAUKL._SX398_BO1,204,203,200_.jpg', 20, 3);
INSERT INTO `book` VALUES ('1791929729', 'Ottoman Empire: A Captivating Guide to the Rise and Fall of the Ottoman Empire, The Fall of Constantinople, and the Life of Suleiman the Magnificent', 'History > European History', 'A Captivating Guide to the Rise and Fall of the Ottoman Empire, The Fall of Constantinople, and the Life of Suleiman the Magnificent', '2018-12-18', 'Captivating History', 'Independently published', '2023-01-06 16:03:26', NULL, 'https://m.media-amazon.com/images/I/514CSKI-PKL._SX398_BO1,204,203,200_.jpg', 15, 3);

-- ----------------------------
-- Table structure for borrow
-- ----------------------------
DROP TABLE IF EXISTS `borrow`;
CREATE TABLE `borrow`  (
  `isbn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id` int NOT NULL DEFAULT 1,
  `cDate` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `bstatus` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `duration` int NULL DEFAULT 1,
  `rDate` datetime NULL DEFAULT NULL,
  `notification` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`isbn`, `email`, `id`) USING BTREE,
  INDEX `borrow_ibfk_2`(`email` ASC) USING BTREE,
  CONSTRAINT `borrow_ibfk_1` FOREIGN KEY (`isbn`) REFERENCES `book` (`isbn`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `borrow_ibfk_2` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of borrow
-- ----------------------------
INSERT INTO `borrow` VALUES ('0128203315', 'azelaya@yahoo.com', 1, '2023-01-05 23:12:22', 'Returned', 1, '2023-01-06 23:12:22', 'unexpired');
INSERT INTO `borrow` VALUES ('0128203315', 'azelaya@yahoo.com', 2, '2023-01-06 00:02:04', 'Returned', 5, '2023-01-11 00:02:04', 'unexpired');
INSERT INTO `borrow` VALUES ('0128203315', 'azelaya@yahoo.com', 3, '2023-01-06 00:03:20', 'Returned', 5, '2023-01-11 00:03:20', 'unexpired');
INSERT INTO `borrow` VALUES ('0128203315', 'fblorg@outlook.com', 1, '2023-01-05 23:07:41', 'Returned', 1, '2023-01-06 23:07:41', 'unexpired');
INSERT INTO `borrow` VALUES ('0128203315', 'jbs123@gmail.com', 1, '2023-01-06 00:09:35', 'Borrowed', 1, '2023-01-07 00:09:35', 'almost due');
INSERT INTO `borrow` VALUES ('0128203315', 'spacestarfish@outlook.com', 1, '2023-01-06 00:45:22', 'Returned', 5, '2023-01-11 00:45:22', 'unexpired');
INSERT INTO `borrow` VALUES ('0131103628', 'fblorg@outlook.com', 1, '2023-01-05 23:56:17', 'Returned', 3, '2023-01-08 23:56:17', 'unexpired');
INSERT INTO `borrow` VALUES ('0131103628', 'jande8654@outlook.com', 1, '2023-01-06 00:39:41', 'Returned', 1, '2023-01-07 00:39:41', 'unexpired');
INSERT INTO `borrow` VALUES ('0131103628', 'jen2687@gmail.com', 1, '2023-01-05 23:56:28', 'Returned', 5, '2023-01-10 23:56:28', 'unexpired');
INSERT INTO `borrow` VALUES ('0131103628', 'jen2687@gmail.com', 2, '2023-01-06 00:09:03', 'Borrowed', 5, '2023-01-11 00:09:03', 'before due');
INSERT INTO `borrow` VALUES ('0131103628', 'jen2687@gmail.com', 3, '2023-01-06 15:33:17', 'Borrowed', 1, '2023-01-07 15:33:17', 'almost due');
INSERT INTO `borrow` VALUES ('0131103628', 'linsmith@gmail.com', 1, '2023-01-05 23:57:22', 'Returned', 1, '2023-01-06 23:57:22', 'unexpired');
INSERT INTO `borrow` VALUES ('0131103628', 'spacestarfish@outlook.com', 1, '2023-01-06 00:43:53', 'Returned', 1, '2023-01-07 00:43:53', 'unexpired');
INSERT INTO `borrow` VALUES ('0131103628', 'wf2887@outlook.com', 1, '2023-01-06 00:49:21', 'Borrowed', 6, '2023-01-12 00:49:21', 'before due');
INSERT INTO `borrow` VALUES ('0133970779', 'azelaya@yahoo.com', 1, '2023-01-06 11:26:30', 'Returned', 1, '2023-01-07 11:26:30', 'before due');
INSERT INTO `borrow` VALUES ('0133970779', 'fblorg@outlook.com', 1, '2023-01-06 00:49:35', 'Borrowed', 3, '2023-01-09 00:49:35', 'before due');
INSERT INTO `borrow` VALUES ('0133970779', 'jamesborg@gmail.com', 1, '2023-01-06 00:09:13', 'Borrowed', 3, '2023-01-09 00:09:13', 'before due');
INSERT INTO `borrow` VALUES ('0133970779', 'jbs123@gmail.com', 1, '2023-01-05 23:56:38', 'Returned', 1, '2023-01-06 23:56:38', 'unexpired');
INSERT INTO `borrow` VALUES ('0133970779', 'jwallace2598@outlook.com', 1, '2023-01-06 00:40:00', 'Borrowed', 1, '2023-01-07 00:40:00', 'almost due');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `cDate` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `uDate` datetime NULL DEFAULT NULL,
  `pid` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 'History', 'history', '2023-01-02 16:12:23', NULL, NULL);
INSERT INTO `category` VALUES (2, 'Science', 'science', '2023-01-02 16:12:45', NULL, NULL);
INSERT INTO `category` VALUES (3, 'Book Arts', 'book arts', '2023-01-02 16:12:57', '2023-01-02 18:35:33', NULL);
INSERT INTO `category` VALUES (4, 'European History', 'european history', '2023-01-02 16:19:44', NULL, 1);
INSERT INTO `category` VALUES (5, 'Asian History', 'asian history', '2023-01-02 16:20:09', NULL, 1);
INSERT INTO `category` VALUES (7, 'Education', 'education', '2023-01-02 17:47:34', NULL, NULL);
INSERT INTO `category` VALUES (8, 'Technology', 'technology', '2023-01-02 17:54:07', NULL, NULL);
INSERT INTO `category` VALUES (9, 'Social Science', 'social science', '2023-01-02 18:13:36', NULL, 2);
INSERT INTO `category` VALUES (10, 'Natural Science', 'natural science', '2023-01-02 18:14:41', NULL, 2);
INSERT INTO `category` VALUES (11, 'Information Technology', 'information Technology', '2023-01-02 18:42:46', NULL, 8);
INSERT INTO `category` VALUES (12, 'Computer Science', 'computer science', '2023-01-03 18:11:35', NULL, 2);
INSERT INTO `category` VALUES (15, 'Biotechnology', 'biotechnology', '2023-01-04 17:28:22', NULL, 8);

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
  `status` tinyint NULL DEFAULT 1,
  PRIMARY KEY (`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of person
-- ----------------------------
INSERT INTO `person` VALUES ('admin02@libman.com', 'Jennifer', 'L', 'Smith', 'admin02', 'QC', 'Quebec', '987 Sheild', '4269571397', 1);
INSERT INTO `person` VALUES ('azelaya@yahoo.com', 'Alicia', 'J', 'Zelaya', 'azelaya', 'TX', 'Spring', '3221 Castle', '4623587412', 1);
INSERT INTO `person` VALUES ('fblorg@outlook.com', 'Friend', 'C', 'Blorg', 'blorggg', 'ON', 'North York', '867 Skywood', '4236587412', 1);
INSERT INTO `person` VALUES ('jamesborg@gmail.com', 'James', 'E', 'Borg', 'jamborg', 'TX', 'Houston', '450 Stone', '4325874156', 1);
INSERT INTO `person` VALUES ('jande8654@outlook.com', 'Jane', 'C', 'Doe', 'jande865', 'ON', 'North York', '187 Sayview', '4358974156', 1);
INSERT INTO `person` VALUES ('jasonliu88@libman.com', 'Jason', 'M', 'Liu', 'jsonliu088', 'ON', 'Toronto', '166 Kings', '4563218974', 1);
INSERT INTO `person` VALUES ('jbs123@gmail.com', 'John', 'B', 'Smith', 'jbs123', 'TX', 'Houston', '731 Fondren', '4395210124', 1);
INSERT INTO `person` VALUES ('jen2687@gmail.com', 'Joyce', 'A', 'English', 'jen26687', 'TX', 'Houston', '5631 Dallas', '4598741256', 1);
INSERT INTO `person` VALUES ('jwallace2598@outlook.com', 'Jennifer', 'S', 'Wallace', 'jwallace85', 'TX', 'Ballaire', '291 Berry', '4632157894', 1);
INSERT INTO `person` VALUES ('kojitadokoro@gmail.com', 'Koji', 'M', 'Tadokoro', 'kojitada114514', 'ON', 'Mississauga', '123 Upwood', '4563281597', 1);
INSERT INTO `person` VALUES ('linsmith@gmail.com', 'Linda', 'Z', 'Smith', 'linsmith028', 'ON', 'Toronto', '876 Prince', '4856321598', 1);
INSERT INTO `person` VALUES ('mlas028@libman.com', 'Mike', 'J', 'Laski', 'mlas028', 'NS', 'Halifax', '195 Centrewood', '4125637852', 0);
INSERT INTO `person` VALUES ('spacestarfish@outlook.com', 'Evil', 'S', 'Starfish', 'spacestarfish', 'NS', 'Halifax', '2333 Void', '4856321475', 1);
INSERT INTO `person` VALUES ('wf2887@outlook.com', 'Franklin', 'T', 'Wong', 'wf288c', 'TX', 'Houston', '638 Voss', '4381254789', 1);
INSERT INTO `person` VALUES ('yoshida124@yahoo.com', 'Hiroshi', 'V', 'Yoshida', 'hyoshida', 'ON', 'North York', '3001 Dinch', '6321478569', 1);

-- ----------------------------
-- Table structure for reterns
-- ----------------------------
DROP TABLE IF EXISTS `reterns`;
CREATE TABLE `reterns`  (
  `isbn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id` int NOT NULL,
  `cDate` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `bstatus` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `duration` int NULL DEFAULT 1,
  `rDate` datetime NULL DEFAULT NULL,
  `aDate` datetime NULL DEFAULT NULL COMMENT 'actual return date',
  PRIMARY KEY (`isbn`, `email`, `id`) USING BTREE,
  INDEX `email`(`email` ASC) USING BTREE,
  CONSTRAINT `reterns_ibfk_1` FOREIGN KEY (`isbn`) REFERENCES `book` (`isbn`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `reterns_ibfk_2` FOREIGN KEY (`email`) REFERENCES `user` (`email`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reterns
-- ----------------------------
INSERT INTO `reterns` VALUES ('0128203315', 'azelaya@yahoo.com', 1, '2023-01-05 23:12:22', 'Returned', 1, '2023-01-06 23:12:22', '2023-01-05 23:35:53');
INSERT INTO `reterns` VALUES ('0128203315', 'azelaya@yahoo.com', 2, '2023-01-06 00:02:04', 'Returned', 5, '2023-01-11 00:02:04', '2023-01-06 00:02:13');
INSERT INTO `reterns` VALUES ('0128203315', 'azelaya@yahoo.com', 3, '2023-01-06 00:03:20', 'Returned', 5, '2023-01-11 00:03:20', '2023-01-06 00:03:24');
INSERT INTO `reterns` VALUES ('0128203315', 'fblorg@outlook.com', 1, '2023-01-05 23:07:41', 'Returned', 1, '2023-01-06 23:07:41', '2023-01-05 23:33:48');
INSERT INTO `reterns` VALUES ('0128203315', 'spacestarfish@outlook.com', 1, '2023-01-06 00:45:22', 'Returned', 5, '2023-01-11 00:45:22', '2023-01-06 00:46:42');
INSERT INTO `reterns` VALUES ('0131103628', 'fblorg@outlook.com', 1, '2023-01-05 23:56:17', 'Returned', 3, '2023-01-08 23:56:17', '2023-01-06 00:00:50');
INSERT INTO `reterns` VALUES ('0131103628', 'jande8654@outlook.com', 1, '2023-01-06 00:39:41', 'Returned', 1, '2023-01-07 00:39:41', '2023-01-06 00:40:06');
INSERT INTO `reterns` VALUES ('0131103628', 'jen2687@gmail.com', 1, '2023-01-05 23:56:28', 'Returned', 5, '2023-01-10 23:56:28', '2023-01-06 00:00:48');
INSERT INTO `reterns` VALUES ('0131103628', 'linsmith@gmail.com', 1, '2023-01-05 23:57:22', 'Returned', 1, '2023-01-06 23:57:22', '2023-01-05 23:57:29');
INSERT INTO `reterns` VALUES ('0131103628', 'spacestarfish@outlook.com', 1, '2023-01-06 00:43:53', 'Returned', 1, '2023-01-07 00:43:53', '2023-01-06 00:44:05');
INSERT INTO `reterns` VALUES ('0133970779', 'azelaya@yahoo.com', 1, '2023-01-06 11:26:30', 'Returned', 1, '2023-01-07 11:26:30', '2023-01-06 11:26:39');
INSERT INTO `reterns` VALUES ('0133970779', 'jbs123@gmail.com', 1, '2023-01-05 23:56:38', 'Returned', 1, '2023-01-06 23:56:38', '2023-01-06 00:00:47');

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
  `aCredit` int NULL DEFAULT 0,
  PRIMARY KEY (`email`) USING BTREE,
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`email`) REFERENCES `person` (`email`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('azelaya@yahoo.com', 'Female', 27, '20221224597193486', '2022-12-24 17:33:04', '2023-01-06 00:06:50', 500);
INSERT INTO `user` VALUES ('fblorg@outlook.com', 'Other', 4, '20221224346174758', '2022-12-24 17:38:39', '2023-01-06 00:06:48', 435);
INSERT INTO `user` VALUES ('jamesborg@gmail.com', 'Male', 45, '202212242055571912', '2022-12-24 17:36:58', '2023-01-06 00:06:48', 455);
INSERT INTO `user` VALUES ('jande8654@outlook.com', 'Female', 23, '20221224564425856', '2022-12-24 17:39:53', '2023-01-06 00:06:48', 500);
INSERT INTO `user` VALUES ('jbs123@gmail.com', 'Male', 33, '202212241946340529', '2022-12-24 17:30:11', '2023-01-06 00:06:53', 475);
INSERT INTO `user` VALUES ('jen2687@gmail.com', 'Female', 25, '20221224723207108', '2022-12-24 17:36:14', '2023-01-06 00:06:49', 430);
INSERT INTO `user` VALUES ('jwallace2598@outlook.com', 'Female', 36, '20221224679361579', '2022-12-24 17:34:57', '2023-01-06 00:06:50', 485);
INSERT INTO `user` VALUES ('kojitadokoro@gmail.com', 'Male', 18, '20221224828600467', '2022-12-24 17:43:47', '2023-01-06 00:06:47', 485);
INSERT INTO `user` VALUES ('linsmith@gmail.com', 'Unknown', 37, '202301041937374814', '2023-01-04 17:08:08', '2023-01-06 00:06:46', 500);
INSERT INTO `user` VALUES ('spacestarfish@outlook.com', 'Other', 17, '20221225752851968', '2022-12-25 16:35:37', '2023-01-06 00:06:46', 500);
INSERT INTO `user` VALUES ('wf2887@outlook.com', 'Male', 25, '202212241314368891', '2022-12-24 17:31:42', '2023-01-06 00:06:52', 440);
INSERT INTO `user` VALUES ('yoshida124@yahoo.com', 'Male', 33, '202212241065002931', '2022-12-24 17:41:54', '2023-01-06 00:06:47', 500);

SET FOREIGN_KEY_CHECKS = 1;
