DROP SCHEMA IF EXISTS examDB;
CREATE SCHEMA examDB;

-- ----------------------------
-- Table structure for tbl_announce
-- ----------------------------
DROP TABLE IF EXISTS `examDB`.`tbl_announce` ;
CREATE TABLE `examDB`.`tbl_announce` (
  `announceTitle`   NVARCHAR(300) NOT NULL,
  `announceContent` LONGTEXT      NOT NULL,
  `announceDate`    DATETIME,
  `teacherID`       BIGINT        NOT NULL,
  `announceID`      BIGINT        NOT NULL
);

-- ----------------------------
-- Records of "tbl_announce"
-- ----------------------------
INSERT INTO `examDB`.`tbl_announce` VALUES ('aaa', 'aaaaa', STR_TO_DATE('2017-10-21 11:07:34', '%Y-%m-%d %H:%i:%s'), '25', '39');
INSERT INTO `examDB`.`tbl_announce` VALUES ('准备期末考试', '期末考试定于5月6日晚上，请大家做好准备！
考试形式为闭卷，不允许携带任何电子产品以及参考资料，否则按违纪进行处理', STR_TO_DATE('2016-05-06 13:12:53', '%Y-%m-%d %H:%i:%s'), '24', '13');
INSERT INTO `examDB`.`tbl_announce` VALUES ('期中考试通知', '期中考试即将开始，请同学们做好准备！', STR_TO_DATE('2016-05-06 13:13:31', '%Y-%m-%d %H:%i:%s'), '24', '14');
INSERT INTO `examDB`.`tbl_announce` VALUES ('第三章作业收取', '第三章作业定于下周上交，请同学们抓紧准备', STR_TO_DATE('2016-05-06 13:14:03', '%Y-%m-%d %H:%i:%s'), '24', '15');
INSERT INTO `examDB`.`tbl_announce` VALUES ('asd', 'sadasd', STR_TO_DATE('2016-05-06 13:13:31', '%Y-%m-%d %H:%i:%s'), '14', '16');
INSERT INTO `examDB`.`tbl_announce` VALUES ('asd', 'sadasd', STR_TO_DATE('2016-05-06 13:13:31', '%Y-%m-%d %H:%i:%s'), '14', '17');
INSERT INTO `examDB`.`tbl_announce` VALUES ('生存实战', '大吉大利，今晚吃鸡', STR_TO_DATE('2017-10-20 23:19:52', '%Y-%m-%d %H:%i:%s'), '24', '36');
INSERT INTO `examDB`.`tbl_announce` VALUES ('dsfsadf', 'sadfsdf', STR_TO_DATE('2017-10-21 08:07:33', '%Y-%m-%d %H:%i:%s'), '25', '37');

-- ----------------------------
-- Table structure for tbl_file
-- ----------------------------
DROP TABLE IF EXISTS `examDB`.`tbl_file`;
CREATE TABLE `examDB`.`tbl_file` (
  `fileID` BIGINT NOT NULL primary key AUTO_INCREMENT,
  `fileName` NVARCHAR(100) NOT NULL ,
  `fileLocate` NVARCHAR(1000) NOT NULL ,
  `fromID` BIGINT NOT NULL ,
  `toID` BIGINT NOT NULL ,
  `acceptState` SMALLINT NOT NULL
);

# -- ----------------------------
# -- Records of "tbl_file"
# -- ----------------------------

-- ----------------------------
-- Table structure for tbl_objectanswerinfo
-- ----------------------------
DROP TABLE IF EXISTS `examDB`.`tbl_objectanswerinfo`;
CREATE TABLE `examDB`.`tbl_objectanswerinfo` (
  `answerInfoID` BIGINT NOT NULL primary key AUTO_INCREMENT ,
  `testID` BIGINT NOT NULL ,
  `questionID` BIGINT NOT NULL ,
  `studentAnswer` BIGINT NOT NULL ,
  `answerScore` BIGINT NOT NULL ,
  `answerTime` DATETIME ,
  `isChecked` SMALLINT NOT NULL
)
;

-- ----------------------------
-- Table structure for tbl_objectquestion
-- ----------------------------
DROP TABLE IF EXISTS `examDB`.`tbl_objectquestion`;
CREATE TABLE `examDB`.`tbl_objectquestion` (
  `questionID` BIGINT NOT NULL primary key  AUTO_INCREMENT ,
  `questionContent` LONGTEXT NOT NULL ,
  `answer1` NVARCHAR(300) ,
  `answer2` NVARCHAR(300) ,
  `answer3` NVARCHAR(300) ,
  `answer4` NVARCHAR(300) ,
  `trueAnswer` SMALLINT NOT NULL ,
  `questionAnalyze` NVARCHAR(300) ,
  `score` BIGINT NOT NULL ,
  `questionSpaceID` BIGINT NOT NULL
)
;


-- ----------------------------
-- Table structure for tbl_student
-- ----------------------------
DROP TABLE IF EXISTS `examDB`.`tbl_student`;
CREATE TABLE `examDB`.`tbl_student` (
  `studentID` BIGINT NOT NULL primary key  AUTO_INCREMENT ,
  `studentEmail` VARCHAR(254) ,
  `studentPassword` VARCHAR(254) ,
  `studentName` VARCHAR(254) ,
  `studentGender` DOUBLE
);

-- ----------------------------
-- Records of "tbl_student"
-- ----------------------------
INSERT INTO `examDB`.`tbl_student` VALUES (NULL, 's0@test.com', '123456', 'Student0', '0');
INSERT INTO `examDB`.`tbl_student` VALUES (NULL, 's1@test.com', '123456', 'Student1', '0');
INSERT INTO `examDB`.`tbl_student` VALUES (NULL, 's2@test.com', '123456', 'Student2', '0');
INSERT INTO `examDB`.`tbl_student` VALUES (NULL, 's3@test.com', '123456', 'Student3', '0');
INSERT INTO `examDB`.`tbl_student` VALUES (NULL, 's4@test.com', '123456', 'Student4', '0');


-- ----------------------------
-- Table structure for tbl_student_teacher
-- ----------------------------
DROP TABLE IF EXISTS `examDB`.`tbl_student_teacher`;
CREATE TABLE `examDB`.`tbl_student_teacher` (
  `studentID` DOUBLE ,
  `teacherID` DOUBLE ,
  `relationDate` DATETIME ,
  `relationState` DOUBLE ,
  `relationID` BIGINT primary key AUTO_INCREMENT
)
;

-- ----------------------------
-- Table structure for tbl_teacher
-- ----------------------------
DROP TABLE IF EXISTS `examDB`.`tbl_teacher`;
CREATE TABLE `examDB`.`tbl_teacher` (
  `teacherID` BIGINT NOT NULL primary key AUTO_INCREMENT,
  `teacherEmail` VARCHAR(254) ,
  `teacherPassword` VARCHAR(254) ,
  `teacherName` VARCHAR(254) ,
  `teacherGender` DOUBLE ,
  `teacherPhone` VARCHAR(254)
)
;

-- ----------------------------
-- Records of "tbl_teacher"
-- ----------------------------
INSERT INTO `examDB`.`tbl_teacher` VALUES (NULL, 't0@test.com', '123456', 'teacher0', '0', '18200001111');
INSERT INTO `examDB`.`tbl_teacher` VALUES (NULL, 't1@test.com', '123456', 'teacher1', '0', '18200001111');
INSERT INTO `examDB`.`tbl_teacher` VALUES (NULL, 't2@test.com', '123456', 'teacher2', '0', '18240008888');
INSERT INTO `examDB`.`tbl_teacher` VALUES (NULL, 't3@test.com', '123456', 'teacher3', '0', '18212202222');

-- ----------------------------
-- Table structure for tbl_teacherquestionspace
-- ----------------------------
DROP TABLE IF EXISTS `examDB`.`tbl_teacherquestionspace`;
CREATE TABLE `examDB`.`tbl_teacherquestionspace` (
  `id` DOUBLE NOT NULL primary key AUTO_INCREMENT,
  `type` VARCHAR(254) ,
  `name` VARCHAR(254) ,
  `beginTime` DATETIME ,
  `endTime` DATETIME ,
  `teacherID` DOUBLE ,
  `amountPerTest` DOUBLE
)
;

# -- ----------------------------
# -- Records of "tbl_teacherquestionspace"
# -- ----------------------------
# INSERT INTO `examDB`.`tbl_teacherquestionspace` VALUES ('18', '计算机组成原理', '期末考试', STR_TO_DATE('2016-05-04 00:00:00', '%Y-%m-%d %H:%i:%s'), STR_TO_DATE('2017-01-01 00:00:00', '%Y-%m-%d %H:%i:%s'), '25', '50');
# INSERT INTO `examDB`.`tbl_teacherquestionspace` VALUES ('19', 'C++', '第一章', STR_TO_DATE('2016-03-01 00:00:00', '%Y-%m-%d %H:%i:%s'), STR_TO_DATE('2016-09-01 00:00:00', '%Y-%m-%d %H:%i:%s'), '24', '25');
# INSERT INTO `examDB`.`tbl_teacherquestionspace` VALUES ('20', 'C++', '题库1', STR_TO_DATE('2016-05-04 00:00:00', '%Y-%m-%d %H:%i:%s'), STR_TO_DATE('2017-01-01 00:00:00', '%Y-%m-%d %H:%i:%s'), '25', '10');
# INSERT INTO `examDB`.`tbl_teacherquestionspace` VALUES ('21', '计算机网络', '期末考试', STR_TO_DATE('2014-01-01 00:00:00', '%Y-%m-%d %H:%i:%s'), STR_TO_DATE('2017-01-01 00:00:00', '%Y-%m-%d %H:%i:%s'), '26', '5');

-- ----------------------------
-- Table structure for tbl_test
-- ----------------------------
DROP TABLE IF EXISTS `examDB`.`tbl_test`;
CREATE TABLE `examDB`.`tbl_test` (
  `testID` DOUBLE NOT NULL primary key AUTO_INCREMENT,
  `testTime` DATETIME ,
  `isExam` DOUBLE ,
  `studentID` DOUBLE ,
  `questionSpaceID` DOUBLE ,
  `testScore` DOUBLE
)
;

ALTER TABLE `examDB`.`tbl_announce` ADD CONSTRAINT `SYS_C0011134` CHECK (`announceTitle` IS NOT NULL) ;
ALTER TABLE `examDB`.`tbl_announce` ADD CONSTRAINT `SYS_C0011135` CHECK (`announceContent` IS NOT NULL) ;
ALTER TABLE `examDB`.`tbl_announce` ADD CONSTRAINT `SYS_C0011136` CHECK (`teacherID` IS NOT NULL) ;
ALTER TABLE `examDB`.`tbl_announce` ADD CONSTRAINT `SYS_C0011137` CHECK (`announceID` IS NOT NULL) ;

-- ----------------------------
-- Checks structure for table tbl_file
-- ----------------------------
ALTER TABLE `examDB`.`tbl_file` ADD CONSTRAINT `SYS_C0011138` CHECK (`fileID` IS NOT NULL) ;
ALTER TABLE `examDB`.`tbl_file` ADD CONSTRAINT `SYS_C0011139` CHECK (`fileName` IS NOT NULL) ;
ALTER TABLE `examDB`.`tbl_file` ADD CONSTRAINT `SYS_C0011140` CHECK (`fileLocate` IS NOT NULL) ;
ALTER TABLE `examDB`.`tbl_file` ADD CONSTRAINT `SYS_C0011141` CHECK (`fromID` IS NOT NULL) ;
ALTER TABLE `examDB`.`tbl_file` ADD CONSTRAINT `SYS_C0011142` CHECK (`toID` IS NOT NULL) ;
ALTER TABLE `examDB`.`tbl_file` ADD CONSTRAINT `SYS_C0011143` CHECK (`acceptState` IS NOT NULL) ;

-- ----------------------------
-- Checks structure for table tbl_objectanswerinfo
-- ----------------------------
ALTER TABLE `examDB`.`tbl_objectanswerinfo` ADD CONSTRAINT `SYS_C0011144` CHECK (`answerInfoID` IS NOT NULL) ;
ALTER TABLE `examDB`.`tbl_objectanswerinfo` ADD CONSTRAINT `SYS_C0011145` CHECK (`testID` IS NOT NULL) ;
ALTER TABLE `examDB`.`tbl_objectanswerinfo` ADD CONSTRAINT `SYS_C0011146` CHECK (`questionID` IS NOT NULL) ;
ALTER TABLE `examDB`.`tbl_objectanswerinfo` ADD CONSTRAINT `SYS_C0011147` CHECK (`studentAnswer` IS NOT NULL) ;
ALTER TABLE `examDB`.`tbl_objectanswerinfo` ADD CONSTRAINT `SYS_C0011148` CHECK (`answerScore` IS NOT NULL) ;
ALTER TABLE `examDB`.`tbl_objectanswerinfo` ADD CONSTRAINT `SYS_C0011149` CHECK (`isChecked` IS NOT NULL) ;

-- ----------------------------
-- Checks structure for table tbl_objectquestion
-- ----------------------------
ALTER TABLE `examDB`.`tbl_objectquestion` ADD CONSTRAINT `SYS_C0011150` CHECK (`questionID` IS NOT NULL) ;
ALTER TABLE `examDB`.`tbl_objectquestion` ADD CONSTRAINT `SYS_C0011151` CHECK (`questionContent` IS NOT NULL) ;
ALTER TABLE `examDB`.`tbl_objectquestion` ADD CONSTRAINT `SYS_C0011152` CHECK (`trueAnswer` IS NOT NULL) ;
ALTER TABLE `examDB`.`tbl_objectquestion` ADD CONSTRAINT `SYS_C0011153` CHECK (`score` IS NOT NULL) ;
ALTER TABLE `examDB`.`tbl_objectquestion` ADD CONSTRAINT `SYS_C0011154` CHECK (`questionSpaceID` IS NOT NULL) ;

select 'DATABASE INITIALIZATION COMPLETE!' AS '';