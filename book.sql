/*
 Navicat Premium Data Transfer

 Source Server         : MyDataBase
 Source Server Type    : MySQL
 Source Server Version : 50610
 Source Host           : localhost:3306
 Source Schema         : book

 Target Server Type    : MySQL
 Target Server Version : 50610
 File Encoding         : 65001

 Date: 15/06/2021 21:39:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for annoucement
-- ----------------------------
DROP TABLE IF EXISTS `annoucement`;
CREATE TABLE `annoucement`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `annouce_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `annouce_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `annouce_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of annoucement
-- ----------------------------
INSERT INTO `annoucement` VALUES ('f2a3e61ecd9a11eb9e909c304ef0449f', '端午节祝福', '亲爱的同学们，端午节即将到来，祝大家端午节快乐。', '2021-06-10 13:31:34');
INSERT INTO `annoucement` VALUES ('f443fbcacdde11ebbdd19c304ef0449f', '补办借书卡事宜', '需要补办借书卡的同学请于周一至周五到图书馆一楼大厅补办。', '2021-06-15 21:38:22');

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `book_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `publish_company` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `store_number` int(11) NULL DEFAULT NULL,
  `borrow_number` int(11) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `publish_date` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES ('0286cb1acdb311ebbf9e9c304ef0449f', '自在独行', '贾平凹', '长江文艺出版社', 4, 1, '2021-06-15 16:23:49', '2016-06-01');
INSERT INTO `book` VALUES ('235c31a1cdb211eb968d9c304ef0449f', '老狐狸经', '山阴慧人', '延边人民出版社', 0, 1, '2021-06-15 16:17:34', '1998-11-01');
INSERT INTO `book` VALUES ('4965624dcdb211eba8099c304ef0449f', '尘埃落定', '阿来', '人民文学出版社', 4, 2, '2021-06-15 16:18:38', '1998-03-01');
INSERT INTO `book` VALUES ('9623fe85cdb111ebb9df9c304ef0449f', '海边的卡夫卡', '村上春树', '上海译文出版社', 4, 1, '2021-06-15 16:13:37', '2007-07-01');
INSERT INTO `book` VALUES ('9cdbf8e1cdb211ebb2259c304ef0449f', '万历十五年', '黄仁宇', '中华书局', 8, 0, '2021-06-15 16:20:58', '1982-05-01');
INSERT INTO `book` VALUES ('d19b6f68cdb211eb884f9c304ef0449f', '指弹吉他独奏曲集', '董宏峰', '安徽文艺出版社', 2, 0, '2021-06-15 16:22:26', '2018-07-01');
INSERT INTO `book` VALUES ('f93b3676cdb111eba9df9c304ef0449f', '计算机基础教程', '贾长隆', '大连理工大学出版社', 0, 1, '2021-06-15 16:16:23', '1994-06-01');

-- ----------------------------
-- Table structure for borrow_info
-- ----------------------------
DROP TABLE IF EXISTS `borrow_info`;
CREATE TABLE `borrow_info`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `book_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `book_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `borrow_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `borrow_num` int(11) NULL DEFAULT NULL,
  `borrow_days` int(11) NULL DEFAULT NULL,
  `borrow_time` datetime(0) NULL DEFAULT NULL,
  `return_time` datetime(0) NULL DEFAULT NULL,
  `return_flag` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of borrow_info
-- ----------------------------
INSERT INTO `borrow_info` VALUES ('090eb31ccdb811ebb6659c304ef0449f', '9623fe85cdb111ebb9df9c304ef0449f', '海边的卡夫卡', '张一', 1, 30, '2021-06-15 16:59:47', '2021-07-15 16:59:47', 0);
INSERT INTO `borrow_info` VALUES ('13118868cdde11ebbbbb9c304ef0449f', '235c31a1cdb211eb968d9c304ef0449f', '老狐狸经', '张二', 1, 5, '2021-06-15 21:32:05', '2021-06-20 21:32:05', 0);
INSERT INTO `borrow_info` VALUES ('182ba4d5cdde11eb89149c304ef0449f', 'f93b3676cdb111eba9df9c304ef0449f', '计算机基础教程', '张二', 1, 5, '2021-06-15 21:32:13', '2021-06-20 21:32:13', 1);
INSERT INTO `borrow_info` VALUES ('1f2560b6cdb811ebb6a49c304ef0449f', '4965624dcdb211eba8099c304ef0449f', '尘埃落定', '张一', 1, 20, '2021-05-01 17:00:24', '2021-05-21 17:00:24', 0);
INSERT INTO `borrow_info` VALUES ('7222993fcdde11eba0c69c304ef0449f', '0286cb1acdb311ebbf9e9c304ef0449f', '自在独行', '李四', 1, 10, '2021-06-15 21:34:44', '2021-06-25 21:34:44', 0);
INSERT INTO `borrow_info` VALUES ('a0bbcaf6cdde11ebb0c99c304ef0449f', '4965624dcdb211eba8099c304ef0449f', '尘埃落定', '李四', 1, 20, '2021-06-15 21:36:02', '2021-07-05 21:36:02', 0);

-- ----------------------------
-- Table structure for douban_book
-- ----------------------------
DROP TABLE IF EXISTS `douban_book`;
CREATE TABLE `douban_book`  (
  `img_href` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pub` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pub_year` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `price` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `grade` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `quote` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of douban_book
-- ----------------------------
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s1070959.jpg', '红楼梦', '[清] 曹雪芹 著', '人民文学出版社', '1996-12', '59.70元', '9.6', ' 335837人评价              ', '都云作者痴，谁解其中味？');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s29053580.jpg', '活着', '余华', '作家出版社', '2012-8-1', '20.00元', '9.4', ' 599086人评价              ', '生的苦难与伟大');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s27237850.jpg', '百年孤独', '[哥伦比亚] 加西亚·马尔克斯/范晔', '南海出版公司', '2011-6', '39.50元', '9.3', ' 336763人评价              ', '魔幻现实主义文学代表作');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s4371408.jpg', '1984', '[英] 乔治·奥威尔/刘绍铭', '北京十月文艺出版社', '2010-4-1', '28.00', '9.4', ' 183329人评价              ', '栗树荫下，我出卖你，你出卖我');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s1078958.jpg', '飘', '[美国] 玛格丽特·米切尔/李美华', '译林出版社', '2000-9', '40.00元', '9.3', ' 178196人评价              ', '革命时期的爱情，随风而逝');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s28357056.jpg', '三体全集', '刘慈欣', '重庆出版社', '2012-1-1', '168.00元', '9.4', ' 94966人评价              ', '地球往事三部曲');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1076932.jpg', '三国演义（全二册）', '[明] 罗贯中', '人民文学出版社', '1998-05', '39.50元', '9.3', ' 137522人评价              ', '是非成败转头空');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s29651121.jpg', '房思琪的初恋乐园', '林奕含', '北京联合出版公司', '2018-2', '45.00元', '9.2', ' 250544人评价              ', '向死而生的文学绝唱');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s24514468.jpg', '白夜行', '[日] 东野圭吾/刘姿君', '南海出版公司', '2013-1-1', '39.50元', '9.1', ' 345996人评价              ', '一宗离奇命案牵出跨度近20年步步惊心的故事');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s2347590.jpg', '动物农场', '[英] 乔治·奥威尔/荣如德', '上海译文出版社', '2007-3', '10.00元', '9.2', ' 112963人评价              ', '太阳底下并无新事');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s1229240.jpg', '福尔摩斯探案全集（上中下）', '[英] 阿·柯南道尔/丁钟华 等/群众出版社', '1981-8', '53.00元', '68.00元', '9.3', ' 106020人评价              ', '名侦探的代名词');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1103152.jpg', '小王子', '[法] 圣埃克苏佩里/马振聘', '人民文学出版社', '2003-8', '22.00元', '9.0', ' 638665人评价              ', '献给长成了大人的孩子们');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s26018275.jpg', '天龙八部', '金庸', '生活·读书·新知三联书店', '1994-5', '96.00元', '9.1', ' 113128人评价              ', '有情皆孽，无人不冤');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s1066570.jpg', '撒哈拉的故事', '三毛', '哈尔滨出版社', '2003-8', '15.80元', '9.2', ' 113173人评价              ', '游荡的自由灵魂');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1034062.jpg', '安徒生童话故事集', '（丹麦）安徒生/叶君健', '人民文学出版社', '1997-08', '25.00元', '9.2', ' 103007人评价              ', '为了争取未来的一代');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1144911.jpg', '平凡的世界（全三部）', '路遥', '人民文学出版社', '2005-1', '64.00元', '9.0', ' 276300人评价              ', '中国当代城乡生活全景');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s4468484.jpg', '局外人', '[法] 阿尔贝·加缪/柳鸣九', '上海译文出版社', '2010-8', '22.00元', '9.0', ' 164217人评价              ', '人生在世，永远也不该演戏作假');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1070222.jpg', '围城', '钱锺书', '人民文学出版社', '1991-2', '19.00', '8.9', ' 400296人评价              ', '幽默的语言和对生活深刻的观察');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s1447349.jpg', '沉默的大多数', '王小波', '中国青年出版社', '1997-10', '27.00元', '9.1', ' 118692人评价              ', '沉默是沉默者的通行证');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s3745215.jpg', '明朝那些事儿（1-9）', '当年明月', '中国海关出版社', '2009-4', '358.20元', '9.1', ' 115306人评价              ', '不拘一格的历史书写');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s11284102.jpg', '霍乱时期的爱情', '[哥伦比亚] 加西亚·马尔克斯/杨玲', '南海出版公司', '2012-9-1', '39.50元', '9.0', ' 215150人评价              ', '义无反顾地直达爱情的核心');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s1358984.jpg', '冰与火之歌（卷一）', '[美] 乔治·R. R. 马丁/谭光磊', '重庆出版社', '2005-5', '68.00元', '9.3', ' 35662人评价              ', '凛冬将至。无比宏大的世界观');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s29101586.jpg', '哈利·波特', 'J.K.罗琳 (J.K.Rowling)/苏农', '人民文学出版社', '2008-12-1', '498.00元', '9.7', ' 48718人评价              ', '从9¾站台开始的旅程');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s23128183.jpg', '杀死一只知更鸟', '[美] 哈珀·李/高红梅', '译林出版社', '2012-9', '32.00元', '9.2', ' 101707人评价              ', '有一种东西不能遵循从众原则，那就是——人的良心');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s27814883.jpg', '人类简史', '[以色列] 尤瓦尔·赫拉利/林俊宏', '中信出版社', '2014-11', '68.00元', '9.1', ' 154723人评价              ', '跟着人类一同走过十万年');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s2157335.jpg', '笑傲江湖（全四册）', '金庸', '生活·读书·新知三联书店', '1994-5', '76.80元', '9.0', ' 96270人评价              ', '欲练此功，必先自宫');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s4696893.jpg', '呐喊', '鲁迅', '人民文学出版社', '1973年3月', '0.36元', '9.0', ' 116379人评价              ', '新文学的第一声呐喊');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s2659208.jpg', '月亮和六便士', '[英] 毛姆/傅惟慈', '上海译文出版社', '2006-8', '15.00元', '9.0', ' 162494人评价              ', '有多少人会经历顿悟，就有更少的人甘愿自我放逐');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s4007145.jpg', '肖申克的救赎', '[美] 斯蒂芬·金/施寄青', '人民文学出版社', '2006-7', '29.90元', '9.1', ' 97890人评价              ', '豆瓣电影Top1原著');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s1727290.jpg', '追风筝的人', '[美] 卡勒德·胡赛尼/李继宏', '上海人民出版社', '2006-5', '29.00元', '8.9', ' 696483人评价              ', '为你，千千万万遍');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s1319205.jpg', '中国历代政治得失', '钱穆', '生活·读书·新知三联书店', '2001', '12.00元', '9.2', ' 51322人评价              ', '一部简明的“中国政治制度史”');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s3248016.jpg', '基督山伯爵', '大仲马/周克希', '上海译文出版社', '1991-12-1', '43.90元', '9.0', ' 112025人评价              ', '一个报恩复仇的故事，以法国波旁王朝和七月王朝为背景');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s1765799.jpg', '东方快车谋杀案', '[英] 阿加莎·克里斯蒂/陈尧光', '人民文学出版社', '2006-5', '18.00元', '9.0', ' 111741人评价              ', '谋杀诡计惊人，波洛的抉择耐人寻味');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s1800355.jpg', '万历十五年', '[美] 黄仁宇', '生活·读书·新知三联书店', '1997-5', '18.00元', '8.9', ' 162099人评价              ', '见微知著，历史观的颠覆');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s29376146.jpg', '新名字的故事', '[意] 埃莱娜·费兰特/陈英', '人民文学出版社', '2017-4', '59.00元', '9.1', ' 57644人评价              ', '探索青年时代的激情、困惑、挣扎、背叛和失去');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s29799269.jpg', '失踪的孩子', '[意] 埃莱娜·费兰特/陈英', '人民文学出版社', '2018-7', '62.00元', '9.2', ' 47286人评价              ', '我的整个生命，只是一场为了提升社会地位的低俗斗争。');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s3254244.jpg', '嫌疑人X的献身', '[日] 东野圭吾/刘子倩', '南海出版公司', '2008-9', '28.00', '8.9', ' 452392人评价              ', '数学好是一种极致的浪漫');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s32271204.jpg', '江城', '[美] 彼得·海斯勒/李雪顺', '上海译文出版社', '2012-1', '36.00元', '9.1', ' 44016人评价              ', '外国人眼中的涪陵');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s1762210.jpg', '乡土中国', '费孝通', '上海人民出版社', '2006-04-01', '38.00', '9.2', ' 51581人评价              ', '中国乡土社会传统文化和社会结构理论研究代表作');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s2654869.jpg', '城南旧事', '林海音 文', '中国青年出版社', '2003-7', '16.00元', '9.0', ' 119163人评价              ', '长亭外，古道边，芳草碧连天');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s32271209.jpg', '寻路中国', '[美] 彼得·海斯勒/李雪顺', '上海译文出版社', '2011-1', '33.00元', '9.0', ' 45834人评价              ', '《纽约客》驻北京记者驾车漫游中国大陆的经历');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s2347562.jpg', '刀锋', '[英]毛姆/周煦良', '上海译文出版社', '2007-3', '18.00元', '9.0', ' 64856人评价              ', '一把刀的锋刃不容易越过；因此智者说得救之道是困难的');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s28111905.jpg', '白鹿原', '陈忠实', '人民文学出版社', '2012-9', '39.00元', '9.2', ' 66782人评价              ', '一轴关于我们民族灵魂的现实主义画卷');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s2157336.jpg', '射雕英雄传（全四册）', '金庸', '生活·读书·新知三联书店', '1999-04', '47.00元', '9.0', ' 71580人评价              ', '侠之大者，为国为民');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s1151479.jpg', '我与地坛', '史铁生', '春风文艺出版社', '2002-5', '25.00元', '9.1', ' 72925人评价              ', '这是你的罪孽与福祉');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s4250062.jpg', '傲慢与偏见', '[英] 奥斯丁/张玲', '人民文学出版社', '1993-7', '13.00元', '8.9', ' 203419人评价              ', '所有现代言情小说的母体');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1134341.jpg', '格林童话全集', '[德国]格林兄弟/魏以新', '人民文学出版社', '1994-11', '21.45元', '9.0', ' 78379人评价              ', '一本有教育意义的书');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1076372.jpg', '黄金时代', '王小波', '花城出版社', '1999-3', '19.00元', '8.9', ' 138805人评价              ', '我想爱，想吃，还想在一瞬间变成天上半明半暗的云');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s2962510.jpg', '无人生还', '[英] 阿加莎・克里斯蒂/祁阿红', '人民文学出版社', '2008-3', '19.00', '8.9', ' 115250人评价              ', '童谣杀人案');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s2364689.jpg', '野草', '鲁迅', '人民文学出版社', '1973-3', '0.20元', '9.4', ' 27096人评价              ', '我以这一丛野草，在明与暗，生与死，过去与未来之际，献于友与仇，人与兽，爱者与不爱者之前作证。');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s1768916.jpg', '历史深处的忧虑', '林达', '生活·读书·新知三联书店', '1997-5', '19.00元', '9.0', ' 39461人评价              ', '窥见美国社会的一扇窗');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s26018916.jpg', '神雕侠侣', '金庸/有1996年11月北平第4次印本', '生活·读书·新知三联书店', '1994-5', '76.80元', '8.9', ' 87308人评价              ', '至情至性，情大于武');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1074291.jpg', '许三观卖血记', '余华', '南海出版公司', '1998-9', '16.80元', '8.8', ' 209532人评价              ', '以博大的温情描绘磨难中的人生');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s33500305.jpg', '彷徨', '鲁迅', '人民文学出版社', '1973-3', '0.37元', '9.1', ' 40676人评价              ', '路漫漫其修远兮，吾将上下而求索');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s3219163.jpg', '艺术的故事', '[英] 贡布里希 (Sir E.H.Gombrich)/范景中', '广西美术出版社', '2008-04', '280.00', '9.6', ' 18681人评价              ', '从最早的洞窟绘画到当今的实验艺术');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s1953384.jpg', '史记（全十册）', '司马迁/（索隐）司马贞，（正义）张守节', '中华书局', '1982-11', '125.00', '9.5', ' 19613人评价              ', '史家之绝唱，无韵之离骚');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s24516687.jpg', '邓小平时代', '[美] 傅高义/冯克利', '生活·读书·新知三联书店', '2013-1', '88.00元', '9.2', ' 38296人评价              ', '个人命运背后的历史变局');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s8968135.jpg', '树上的男爵', '[意] 伊塔洛·卡尔维诺/吴正仪', '译林出版社', '2012-4-1', '30.00元', '9.1', ' 32949人评价              ', '是不是真的只有先与人疏离，才能最终与他们在一起？');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s2875823.jpg', '朝花夕拾', '鲁迅', '人民文学出版社', '1972-4', '0.25元', '8.9', ' 111546人评价              ', '在纷扰中寻出一点闲静');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s24611679.jpg', '文学回忆录', '木心 口述', '广西师范大学出版社', '2013-1-10', '98.00元', '9.1', ' 37765人评价              ', '木心留给世界的礼物');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s24468373.jpg', '看见', '柴静', '广西师范大学出版社', '2013-1-1', '39.80元', '8.8', ' 298260人评价              ', '在这里看见中国');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s4521754.jpg', '悲惨世界（上中下）', '[法] 雨果/李丹', '人民文学出版社', '1992-6', '66.00元', '9.0', ' 54676人评价              ', '现实主义与浪漫主义的至高杰作');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s2059791.jpg', '卡拉马佐夫兄弟', '[俄] 费奥多尔·陀思妥耶夫斯基/荣如德', '上海译文出版社', '2006-8', '25.00元', '9.4', ' 19040人评价              ', '错综复杂的社会、家庭矛盾和人性悲剧');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s1486674.jpg', '上帝掷骰子吗', '曹天元', '辽宁教育出版社', '2006-1', '32.00元', '9.2', ' 27233人评价              ', '量子物理史话');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s1020454.jpg', '哭泣的骆驼', '三毛', '哈尔滨出版社', '2003-6', '15.80元', '8.9', ' 49648人评价              ', '沙漠中寻常的生与死');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s2651394.jpg', '灿烂千阳', '[美] 卡勒德·胡赛尼/李继宏', '上海人民出版社', '2007-9', '28.00元', '8.8', ' 99436人评价              ', '唯有希望与爱可以驱散阴霾');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s4526465.jpg', '台北人', '白先勇', '广西师范大学出版社', '2010-10', '38.00元', '8.9', ' 46069人评价              ', '白先勇短篇小说集');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s1627374.jpg', '西游记（全二册）', '吴承恩/黄肃秋 注释', '人民文学出版社', '2004-8', '47.20元', '8.9', ' 67182人评价              ', '神魔皆有人情，精魅亦通世故');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s6807265.jpg', '浪潮之巅', '吴军', '电子工业出版社', '2011-8', '55.00元', '9.0', ' 29263人评价              ', '了解IT领域的入门读物');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1067911.jpg', '窗边的小豆豆', '[日] 黑柳彻子 著/赵玉皎', '南海出版公司', '2003-1', '20.00元', '8.7', ' 175672人评价              ', '真正懂孩子的教育经');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1979223.jpg', '诗经', '孔丘 编订', '北京出版社', '2006-7', '19.90元', '9.4', ' 21619人评价              ', '思无邪');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s29555070.jpg', '永恒的终结', '[美] 艾萨克·阿西莫夫/崔正男', '江苏凤凰文艺出版社', '2014-9', '32.00元', '9.0', ' 29805人评价              ', '关于时间旅行的终极奥秘和恢宏构想');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1015872.jpg', '我们仨', '杨绛', '生活·读书·新知三联书店', '2003-7', '18.80元', '8.7', ' 264952人评价              ', '家庭生活回忆录');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s9130587.jpg', '人间词话', '王国维', '上海古籍出版社', '1998-12-01', '9.80元', '9.0', ' 45608人评价              ', '以新眼光评旧文学');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s6790238.jpg', '悉达多', '[德] 赫尔曼·黑塞/杨玉功 译', '上海人民出版社', '2009-3', '20.00', '9.0', ' 33479人评价              ', '在那最绝望的一刹那，他突然听到了生命之河永恒的声音……');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s4661043.jpg', '爱你就像爱生命', '王小波', '上海锦绣文章出版社', '2008-5', '18.00元', '8.8', ' 95270人评价              ', '王小波与李银河的两地书');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s25814002.jpg', '罗杰疑案', '[英] 阿加莎·克里斯蒂/常禾', '新星出版社', '2013-3', '28.00元', '9.2', ' 29888人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s27003191.jpg', '鼠疫', '(法)阿尔贝·加缪/刘方', '上海译文出版社', '2013-8', '34.00元', '9.0', ' 38548人评价              ', '用别样的监禁生活再现某种监禁生活，与用不存在的事表现真事同等合理');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1045431.jpg', '道德经', '黄元吉', '陕西人民出版社', '1996-10', '4.50元', '9.4', ' 15077人评价              ', '中国历史上首部完整的哲学著作');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1044902.jpg', '飞鸟集', '[印] 罗宾德拉纳德·泰戈尔/徐翰林', '哈尔滨出版社', '2004-6', '16.80元', '8.9', ' 56170人评价              ', '一个淡泊清透的世界');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s1008848.jpg', '唐诗三百首', '蘅塘退士', '中华书局', '1998-1-1', '0.65', '9.4', ' 18782人评价              ', '熟读唐诗三百首，不会吟诗也会吟');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s29071620.jpg', '一个叫欧维的男人决定去死', '[瑞典] 弗雷德里克·巴克曼/宁蒙', '四川文艺出版社', '2015-12', '35.00元', '9.0', ' 44227人评价              ', '这个发生在瑞典的故事，如生命庆典般绚丽斑斓');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s2364685.jpg', '故事新编', '鲁迅', '人民文学出版社', '1973-12-01', '0.31 元', '9.4', ' 22574人评价              ', '拾取古代传说，取一点因由，随意点染');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s28668834.jpg', '巨人的陨落', '[英] 肯·福莱特/于大卫', '江苏凤凰文艺出版社', '2016-5-1', '129.80元', '8.9', ' 73456人评价              ', '五个家族，一场战争');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s2832939.jpg', '教父', '[美]马里奥·普佐/周汉林', '译林出版社', '1997-8', '23.30元', '9.0', ' 34765人评价              ', '“教父三部曲”电影原著');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s1167060.jpg', '呼兰河传', '萧红', '百花文艺出版社', '2005-01', '19.00', '8.9', ' 66544人评价              ', '萧红的童年往事');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s28355811.jpg', '最好的告别', '[美] 阿图·葛文德（Atul Gawande）/彭小华', '浙江人民出版社', '2015-7-31', '54.90元', '9.0', ' 32704人评价              ', '关于衰老与死亡，你必须知道的常识');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1067491.jpg', '海子的诗', '海子', '人民文学出版社', '1999-04', '15.40', '8.9', ' 37943人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s6828981.jpg', '这些人，那些事', '吴念真', '译林出版社', '2011-9', '28.00元', '8.8', ' 59548人评价              ', '平淡叙述下的惊心动魄');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s3134040.jpg', '鹿鼎记（全五册）', '金庸', '广州出版社 花城出版社', '2008-3', '108.00元', '8.8', ' 49272人评价              ', '武侠的解构，流氓的狂欢');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s28332051.jpg', '斯通纳', '[美] 约翰·威廉斯/杨向荣', '上海人民出版社', '2016-1', '49.00元', '8.8', ' 41766人评价              ', '即使不能拥有完美的生活，所幸追求过完整的自我');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s3983958.jpg', '人生的枷锁', '[英] 毛姆/张柏然', '上海译文出版社', '2007-3', '32.00元', '9.0', ' 23731人评价              ', '在混沌纷扰的生活漩流中，寻求人生的真谛');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s1595557.jpg', '边城', '沈从文', '北岳文艺出版社', '2002-4', '12.00元', '8.7', ' 196688人评价              ', '一切充满了善，然而到处是不凑巧');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s2393243.jpg', '梦里花落知多少', '三毛', '北京十月文艺出版社', '2007-6', '28.00元', '8.8', ' 84850人评价              ', '哀而不伤');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s33492346.jpg', '你当像鸟飞往你的山', '[美] 塔拉·韦斯特弗/任爱红', '南海出版公司', '2019-10', '59.00元', '8.8', ' 108321人评价              ', '我来自一个极少有人能想象的家庭，教育给了我新世界');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s1804710.jpg', '看不见的城市', '[意大利]伊塔洛·卡尔维诺/张宓', '译林出版社', '2006-8', '16.00元', '8.8', ' 35941人评价              ', '每一座城市都只在想象中耸立，又在描述中坍圮');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1914861.jpg', '时间简史', '[英] 史蒂芬·霍金/许明贤', '湖南科学技术出版社', '2010-4', '45.00元', '8.8', ' 52619人评价              ', '探索时间和空间的核心秘密');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s8958901.jpg', '冬牧场', '李娟', '新星出版社', '2012-6', '29.80元', '9.0', ' 22299人评价              ', '阿勒泰的精灵');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s6987353.jpg', '陆犯焉识', '严歌苓', '作家出版社', '2011-10', '35.00元', '8.8', ' 48962人评价              ', '翻手为苍凉，覆手为繁华');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s9015481.jpg', '叫魂', '[美] 孔飞力/陈兼', '生活·读书·新知三联书店 上海三联书店', '2012-5', '38.00元', '9.0', ' 22340人评价              ', '1768年中国妖术大恐慌');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s28050760.jpg', '献给阿尔吉侬的花束', '[美] 丹尼尔·凯斯/陈澄和', '广西师范大学出版社', '2015-4', '36.00元', '9.1', ' 28374人评价              ', '当声称能改造智能的科学实验选中心智障碍主角');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s2611329.jpg', '一个陌生女人的来信', '[奥] 斯蒂芬·茨威格/张玉书', '上海译文出版社', '2007-7', '20.00元', '8.7', ' 120027人评价              ', '暗恋的极致');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s4444885.jpg', '金色梦乡', '[日] 伊坂幸太郎/李彦桦', '译林出版社', '2010-9', '35.00元', '9.0', ' 22529人评价              ', '伊坂幸太郎代表作');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s3893343.jpg', '美的历程', '李泽厚', '生活·读书·新知三联书店', '2009-1-1', '43.00元', '9.2', ' 20567人评价              ', '中国美学经典之作');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s4619775.jpg', '人生的智慧', '[德] 阿图尔·叔本华/韦启昌', '上海人民出版社', '2008-10', '28.00元', '9.2', ' 22024人评价              ', '对世俗、实用问题深刻而透彻的讨论');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s6240330.jpg', '孽子', '白先勇', '广西师范大学出版社', '2010.10', '46.00元', '9.1', ' 23658人评价              ', '写给那一群， 在最深最深的黑夜里， 独自彷徨街头， 无所依归的孩子们');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s2019056.jpg', '王尔德童话', '[英] 王尔德/王林', '译林出版社', '2003-6', '6.00元', '9.1', ' 18728人评价              ', '一颗纯美纯善、永难泯灭的童心');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s29535271.jpg', '离开的，留下的', '[意] 埃莱娜·费兰特/陈英', '人民文学出版社', '2017-10', '62.00元', '8.8', ' 45253人评价              ', '探索中年的虚无、困惑、野心和近乎残暴的爱');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s2619779.jpg', '十万个为什么', '', '少年儿童出版社', '1962', '30.00元', '9.1', ' 13299人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s6974202.jpg', '史蒂夫·乔布斯传', '[美] 沃尔特·艾萨克森/管延圻', '中信出版社', '2011-10-24', '68.00元', '8.7', ' 52566人评价              ', '完美主义者的最高形态');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s4124434.jpg', '孩子你慢慢来', '龙应台', '生活·读书·新知三联书店', '2009-12-1', '28.00元', '8.7', ' 69234人评价              ', '我们现在怎样做母亲');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s3042670.jpg', '苏菲的世界', '[挪] 乔斯坦·贾德/萧宝森', '作家出版社', '2007-10', '26.00元', '8.8', ' 45435人评价              ', '哲学启蒙书');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s1785715.jpg', '经济学原理（上下）', '[美] 曼昆/梁小民', '机械工业出版社', '2003-8', '88.00元', '9.1', ' 18024人评价              ', '经济学家们的世界观');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s2990934.jpg', '爱的艺术', '[美] 艾·弗洛姆/李健鸣', '上海译文出版社', '2008-4', '15.00元', '8.8', ' 34583人评价              ', '谦恭地、勇敢地、真诚地和有纪律地爱他人');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s3228699.jpg', '四世同堂', '老舍', '北京十月文艺出版社', '2008-07', '36.00元', '9.3', ' 23180人评价              ', '北平沦陷时代广大平民的悲惨遭遇');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s4243447.jpg', '送你一颗子弹', '刘瑜', '上海三联书店', '2010-1', '25.00元', '8.6', ' 132710人评价              ', '在这本书里，被“审视”的东西杂七杂八');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s1127135.jpg', '情书', '[日] 岩井俊二/穆晓芳', '天津人民出版社', '2004-7', '18.00元', '8.6', ' 94297人评价              ', '一场同名同姓的误会，两段可贵的爱情');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s29746559.jpg', '小径分岔的花园', '[阿根廷] 豪·路·博尔赫斯/王永年', '上海译文出版社', '2015-7', '23.00', '8.9', ' 23935人评价              ', '一个谜语，谜底正是时间');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s23922774.jpg', '國史大綱（上下）', '錢穆', '商務印書館', '2013-8', '76.00元', '9.3', ' 13304人评价              ', '钱穆中国通史');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1099483.jpg', '万水千山走遍', '三毛', '哈尔滨出版社', '2003-08', '13.80', '8.8', ' 38893人评价              ', '从遥远的撒哈拉到敦煌戈壁');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s4133656.jpg', '海的女儿', '安徒生/叶君健', '上海译文出版社', '1978年6月', '0.43', '9.1', ' 14115人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s2280094.jpg', '浮生六记', '（清）沈复', '人民文学出版社', '1999-1', '5.70元', '8.8', ' 55628人评价              ', '苟不记之笔墨，未免有辜彼苍之厚');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s2170315.jpg', '我也有一个梦想', '林达', '生活·读书·新知三联书店', '2004-08', '25.00元', '9.0', ' 14036人评价              ', '在法治国家里，民众怎样运用法律');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s4638950.jpg', '倾城之恋', '张爱玲', '北京十月文艺出版社', '2006-12', '29.80元', '8.7', ' 43166人评价              ', '“一对平凡的夫妻”之间的“一点真心”');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s1121598.jpg', '昨日的世界', '[奥] 斯蒂芬·茨威格/舒昌善', '广西师范大学出版社', '2004-5-1', '32.00元', '9.2', ' 11812人评价              ', '一个高贵而残破的昨日镜像');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s27264181.jpg', '解忧杂货店', '[日] 东野圭吾/李盈春', '南海出版公司', '2014-5', '39.50元', '8.5', ' 683172人评价              ', '现代人内心流失的东西，这家杂货店能帮你找回');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s4421443.jpg', '不能承受的生命之轻', '米兰·昆德拉/许钧', '上海译文出版社', '2010-8', '29.00元', '8.8', ' 38722人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s26040205.jpg', '球状闪电', '刘慈欣', '四川科学技术出版社', '2005-6', '22.00元', '8.7', ' 62511人评价              ', '量子之外，没有真相');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s3984108.jpg', '目送', '龙应台', '生活·读书·新知三联书店', '2009-10', '39.00元', '8.6', ' 194999人评价              ', '不必追');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s3628082.jpg', '受戒', '汪曾祺', '漓江出版社', '1987-10', '3.95元', '9.3', ' 17409人评价              ', '江南乡镇民间生活，健康淳朴的人性');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s3993878.jpg', '亲爱的安德烈', '龙应台', '人民文学出版社', '2008-12', '26.00', '8.6', ' 111280人评价              ', '弭平代沟，跨越文化阻隔');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s9038826.jpg', '面纱', '(英)W.萨默塞特·毛姆/阮景林', '重庆', '2012-05-01', '32.00元', '8.7', ' 51609人评价              ', '揭去生活的面纱');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s6180859.jpg', '我的阿勒泰', '李娟', '云南人民出版社', '2010-7', '22.00元', '8.8', ' 20964人评价              ', '描写疆北阿勒泰地区生活和风情的原生态散文集');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s9950828.jpg', '亮剑', '都梁', '解放军文艺出版社', '2005-3', '28.00元', '8.9', ' 23435人评价              ', '面对强大的对手，明知不敌，也要毅然亮剑');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s1469589.jpg', '野火集', '龙应台', '文汇出版社', '2005-8', '25.00元', '8.8', ' 32247人评价              ', '中国人，你为什么不生气');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s3675595.jpg', '绿毛水怪', '王小波', '时代文艺出版社', '2009-1', '30.00元', '9.0', ' 18379人评价              ', '我们好象在池塘的水底，从一个月亮走向另一个月亮');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s27598249.jpg', '故事', '[美] 罗伯特·麦基/周铁东', '天津人民出版社', '2014-9-1', '68.00元', '9.2', ' 13286人评价              ', '材质、结构、风格和银幕剧作的原理');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1325863.jpg', '古文观止', '吴楚材', '中华书局', '1987-1-1', '21.00元', '9.1', ' 15878人评价              ', '收录自先秦至明末的散文二百二十二篇');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s3979854.jpg', '德米安', '[德] 赫尔曼·黑塞/丁君君', '上海人民出版社', '2009-3', '25.00元', '9.0', ' 21639人评价              ', '少年辛克莱寻找通向自身之路的艰辛历程');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s3696740.jpg', '银河系漫游指南', '[英] 道格拉斯·亚当斯/徐百柯', '四川科学技术出版社', '2005-6', '16.00元', '8.8', ' 19296人评价              ', '一场穿越银河的冒险');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s2391798.jpg', '温柔的夜', '三毛', '北京十月文艺出版社', '2007-5', '28.00元', '9.1', ' 18483人评价              ', '三毛在加纳利群岛的生活');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1738643.jpg', '枪炮、病菌与钢铁', '[美] 贾雷德·戴蒙德/谢延光', '上海世纪出版集团', '2006-4-1', '45.00元', '8.7', ' 38502人评价              ', '人类社会的命运');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1137441.jpg', '麦琪的礼物', '[美] 欧·亨利/张经浩', '上海社会科学院出版社', '2003-7', '25.00元', '8.6', ' 65277人评价              ', '日常的奇迹');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s6185540.jpg', '阿勒泰的角落', '李娟', '万卷出版公司', '2010-6', '25.00元', '9.1', ' 14296人评价              ', '白雪和阳光，青草和白桦林');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1670932.jpg', '社会心理学', '[美] 戴维·迈尔斯/张智勇', '人民邮电出版社', '2006-1', '68.00元', '9.0', ' 21252人评价              ', '人们是如何思索、影响他人并与他人建立联系的');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s1683067.jpg', '尼罗河上的惨案', '[英] 阿加莎·克里斯蒂/宫英海', '人民文学出版社', '2006-5', '22.00元', '8.7', ' 40468人评价              ', '阿加莎·克里斯蒂代表作');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s4293097.jpg', '你好，旧时光（上 下）', '八月长安', '新世界出版社', '2009-12', '39.80元', '8.7', ' 40756人评价              ', '原作名切题');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s24964086.jpg', '霸王别姬', '李碧华', '人民文学出版社', '1999-1', '10.20元', '9.1', ' 16927人评价              ', '人间，只是抹去了脂粉的脸');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s2838737.jpg', '半生缘', '张爱玲', '北京十月文艺出版社', '2006-12', '28.00元', '8.6', ' 75306人评价              ', '世钧，我们回不去了');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s3203360.jpg', '激荡三十年', '吴晓波', '中信出版社', '2008-7-1', '32.00元', '8.6', ' 13873人评价              ', '中国企业1978—2008');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s26237958.jpg', '棋王', '阿城', '作家出版社', '1999-10', '13.00', '8.8', ' 27028人评价              ', '我从未真正见过火，也未见过毁灭，更不知新生');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s29164777.jpg', '我的天才女友', '[意] 埃莱娜·费兰特/陈英', '人民文学出版社', '2017-1', '42.00元', '8.6', ' 72999人评价              ', '“那不勒斯四部曲”第一部，两个女人，50年的友谊和战争');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s33516550.jpg', '茶馆', '老舍', '人民文学出版社', '2002-1', '9.80元', '9.0', ' 19734人评价              ', '清末、民初、抗战胜利以后三个历史时期的北京生活风貌');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s3435158.jpg', '罗生门', '[日] 芥川龙之介/林少华', '上海译文出版社', '2008-7', '12.00元', '8.7', ' 55777人评价              ', '人生，远比地狱更像地狱');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s27217828.jpg', '失明症漫记', '[葡] 若泽·萨拉马戈/范维信', '南海出版公司', '2014-2', '29.50', '9.1', ' 16822人评价              ', '失明症迅速蔓延，整个城市陷入一场空前的灾难');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s6916838.jpg', '一句顶一万句', '刘震云', '长江文艺出版社', '2009-3', '29.80', '8.7', ' 45873人评价              ', '一句胜过千年');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s4146437.jpg', '民主的细节', '刘瑜', '上海三联书店', '2009-6', '25.00', '8.6', ' 71584人评价              ', '公民养成手册');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s26720726.jpg', '最好的我们', '八月长安', '湖南文艺出版社', '2013-8-5', '55', '8.7', ' 62437人评价              ', '耿耿余淮');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s1790246.jpg', '罪与罚', '[俄] 陀思妥耶夫斯基/岳麟', '上海译文出版社', '2006-8', '23.00元', '9.2', ' 17740人评价              ', '描绘人内心的全部深度');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s4093514.jpg', '万物有灵且美', '[英] 吉米·哈利/种衍伦', '中国城市出版社', '2010-1', '28.80', '8.8', ' 19841人评价              ', '活泼的生命完全无须借助魔法，便能对我们述说至美至真的故事');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1681072.jpg', '天朝的崩溃', '茅海建', '生活·读书·新知三联书店', '2005-7', '32.00元', '9.1', ' 12222人评价              ', '鸦片战争再研究');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s1829709.jpg', '倚天屠龙记(共四册)', '金庸', '三联书店', '1999-04', '47.00', '8.6', ' 53693人评价              ', '不识张郎是张郎');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s2170316.jpg', '总统是靠不住的', '林达', '生活·读书·新知三联书店', '2004-08', '21.80', '8.8', ' 18644人评价              ', '美国政治法律制度的基本原理和操作细节');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1024472.jpg', '顾城的诗', '顾城', '人民文学出版社', '1998-12', '20.00', '8.8', ' 21421人评价              ', '火焰是我们诗歌唯一的读者');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s3099438.jpg', '渴望生活', '[美] 欧文·斯通/常涛', '北京十月文艺出版社', '2008-4', '29.80元', '9.2', ' 10174人评价              ', '梵高悲惨而成就辉煌的人生');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s1073574.jpg', '荆棘鸟', '[澳] 考琳·麦卡洛/曾胡', '译林出版社', '1998-7', '28.00元', '8.6', ' 47974人评价              ', '澳洲乱世情');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s28313152.jpg', '我不知道该说什么，关于死亡还是爱情', 'S.A.阿列克谢耶维奇/方祖芳/花城出版社', '铁葫芦图书', '2014-6-15', '34.80元', '9.0', ' 16374人评价              ', '真实记录切尔诺贝利核灾难事件');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s1436519.jpg', '水浒传（全二册）', '[明] 施耐庵', '人民文学出版社', '1997-1', '50.60元', '8.6', ' 63873人评价              ', '替天行道');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s28274132.jpg', '认识电影', '[美] 路易斯·贾内梯/焦雄屏', '世界图书出版公司', '2007-11', '68.00元', '8.9', ' 15552人评价              ', '电影入门经典之作');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s2563279.jpg', '雨季不再来', '三毛', '北京十月文艺出版社', '2007-7', '28.00元', '8.7', ' 46058人评价              ', '三毛少女时代的成长感受');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1993421.jpg', '正见', '宗萨蒋扬钦哲仁波切/姚仁喜', '中国友谊出版公司', '2007-1', '25.00元', '8.8', ' 15671人评价              ', '佛陀的证悟');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s1201610.jpg', '人间草木', '汪曾祺', '江苏文艺出版社', '2005-01', '20.00元', '9.1', ' 21019人评价              ', '我就是要这样香，香得痛痛快快');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s2652540.jpg', '草房子', '曹文轩', '江苏少年儿童出版社', '2009-6', '18.00元', '9.0', ' 31577人评价              ', '男孩桑桑刻骨铭心、终身难忘的六年小学生活');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s29477615.jpg', '美丽新世界', '[英] 赫胥黎/陈超', '上海译文出版社', '2017-6', '45.00元', '9.1', ' 23264人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s28332484.jpg', '九州·缥缈录', '江南', '人民文学出版社', '2015-10', '198.00元', '8.8', ' 5966人评价              ', '一轴腥风血雨的乱世长卷，中国版《冰与火之歌》');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s1070937.jpg', '一千零一夜', '纳训', '人民文学出版社', '2003-01', '22.00', '8.7', ' 50002人评价              ', '阿拉伯地区的古代民间传说');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s1068535.jpg', '理想国', '[古希腊] 柏拉图/郭斌和', '商务印书馆', '1986-8', '28.00元', '8.8', ' 26640人评价              ', '人类历史上最早的乌托邦');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s3668327.jpg', '牧羊少年奇幻之旅', '[巴西] 保罗·柯艾略/丁文林', '南海出版公司', '2009-3-1', '25.00元', '8.5', ' 136463人评价              ', '你自己就是最大的宝藏');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s26546959.jpg', '一桩事先张扬的凶杀案', '[哥伦比亚] 加西亚·马尔克斯/魏然', '南海出版公司', '2013-6', '25.00元', '8.7', ' 29274人评价              ', '我如此急切地想要讲述这桩案件，也许是它最终确定了我的作家生涯');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s1950424.jpg', '上学记', '何兆武 口述', '生活·读书·新知三联书店', '2006-8', '19.80元', '8.9', ' 12884人评价              ', '20世纪中国知识分子的心灵史');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s2142329.jpg', '孙子兵法', '孙武/郭化若', '上海古籍出版社', '2006-7', '20.00元', '9.4', ' 10886人评价              ', '我国最古老最杰出的一部兵书');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s6343233.jpg', '此生未完成', '于娟', '湖南科技出版社', '2011-5', '26.00元', '8.9', ' 18846人评价              ', '一个母亲、妻子、女儿的生命日记');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s23579217.jpg', '雷雨', '曹禺', '人民文学出版社', '1999-05', '9.20', '8.6', ' 66798人评价              ', '一幕人生大悲剧，在一个雷雨夜爆发');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s29796663.jpg', '全球通史', '(美) 斯塔夫里阿诺斯/吴象婴', '北京大学出版社', '2012-2-1', '168.00元', '9.1', ' 15816人评价              ', '从史前史到21世纪');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1072541.jpg', '青铜时代', '王小波', '花城出版社', '1997-5', '29.00元', '8.7', ' 22588人评价              ', '唐人传奇贯注现代情趣');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s5924326.jpg', '简爱（英文全本）', '[英] 夏洛蒂·勃朗特', '世界图书出版公司', '2003-11', '18.00元', '8.5', ' 194167人评价              ', '灰姑娘在十九世纪');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s2516920.jpg', '从一到无穷大', '[美] G. 伽莫夫/暴永宁 译', '科学出版社', '2002-11', '29.00元', '9.1', ' 11389人评价              ', '科学中的事实和臆测');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s28061231.jpg', '海风中失落的血色馈赠', '[加拿大] 阿利斯泰尔·麦克劳德/陈以侃', '上海文艺出版社', '2015-6-1', 'CNY 20.00', '9.1', ' 13380人评价              ', '男女之间、父母与子女之间紧密的纽带和难以逾越的鸿沟');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s29069735.jpg', '恶意', '[日] 东野圭吾/娄美莲', '南海出版公司', '2016-11-1', '39.50元', '8.7', ' 56161人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s1677577.jpg', '圣经', '', '南海出版公司', '2016-11-1', '39.50元', '8.7', ' 56161人评价              ', '上帝说，要有光');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s27914268.jpg', '强风吹拂', '三浦紫苑/林佩瑾', '广西师范大学出版社', '2015-1-1', '39.00元', '9.0', ' 15235人评价              ', '明明这么痛苦，这么难过，为什么就是不能放弃跑步？');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s5804746.jpg', '论语', '', '中华书局', '2006-12', '9.80元', '9.1', ' 16868人评价              ', '仁远乎哉？我欲仁，斯仁至矣');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s2976745.jpg', '金锁记', '张爱玲', '哈尔滨出版社', '2005-6', '13.5元', '8.6', ' 54039人评价              ', '一个小商人家庭出身的女子曹七巧的心灵变迁历程');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s1120437.jpg', '夏洛的网', '[美] E.B.怀特/任溶溶', '上海译文出版社', '2004-5', '17.00元', '8.6', ' 58097人评价              ', '一个蜘蛛和小猪的故事，写给孩子，也写给大人');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1670411.jpg', '如彗星划过夜空', '林达', '生活·读书·新知三联书店', '2006-3', '21.00元', '8.9', ' 10282人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s3380714.jpg', '额尔古纳河右岸', '迟子建', '北京十月文艺出版社', '2005-12-1', '29.00元', '9.0', ' 16711人评价              ', '东北少数民族鄂温克人生存现状及百年沧桑');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s4669554.jpg', '黑客与画家', '[美] Paul Graham/阮一峰', '人民邮电出版社', '2011-4', '49.00元', '8.7', ' 20277人评价              ', '硅谷创业之父Paul Graham文集');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s26037307.jpg', '繁花', '金宇澄', '上海文艺出版社', '2013-3', '48.00元', '8.7', ' 24822人评价              ', '海上繁花，请静观静读');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s4494379.jpg', '巨流河', '齐邦媛', '生活·读书·新知三联书店', '2010-10', '39.00元', '8.7', ' 27383人评价              ', '两代人从巨流河到哑口海的故事');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s1662165.jpg', '张爱玲文集', '张爱玲', '安徽文艺出版社', '1992年', '45元', '8.9', ' 13934人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s2165932.jpg', '设计中的设计', '[日] 原研哉/朱锷', '山东人民出版社', '2006-11', '48.00元', '8.6', ' 31455人评价              ', '日常生活的无限可能性');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s1134166.jpg', '人类的群星闪耀时', '[奥] 斯蒂芬·茨威格/舒昌善', '广西师范大学出版社', '2004-8', '18.00元', '8.7', ' 25030人评价              ', '十四个影响人类文明的瞬间');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s1069364.jpg', '中国哲学简史', '冯友兰/赵复三', '新世界出版社', '2004-1', '38.00元', '8.9', ' 16980人评价              ', '中国哲学入门书');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s27312538.jpg', '挪威的森林', '[日] 村上春树/林少华', '上海译文出版社', '2007-7', '23.00元', '8.5', ' 113675人评价              ', '像喜欢春天的熊一样');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s28033064.jpg', '你一生的故事', '[美] 特德·姜/李克勤', '译林出版社', '2015-5', '36.00元', '8.7', ' 26307人评价              ', '特德·姜科幻小说集');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s3922462.jpg', '佐贺的超级阿嬷', '[日] 岛田洋七/陈宝莲', '南海出版公司', '2007-3', '20.00元', '8.7', ' 21031人评价              ', '乐观的外婆却总有神奇的办法');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s28284337.jpg', '火星救援', '[美] 安迪·威尔/陈灼', '译林出版社', '2015-10', '38.00', '8.9', ' 14511人评价              ', '跟火星来一场不是你死就是我活的过家家游戏');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s3286369.jpg', '荒原狼', '[德]赫尔曼·黑塞/赵登荣', '上海译文出版社', '2008-7', '13.00', '9.0', ' 13932人评价              ', '“超现实主义”风格作品，德国的《尤利西斯》');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s27838442.jpg', '厌女', '(日) 上野千鹤子/王兰', '上海三联书店', '2015-1', '28.00', '9.0', ' 15480人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s3867373.jpg', '香水', '[德] 帕·聚斯金德/李清华', '上海译文出版社', '2009-6', '25.00元', '8.8', ' 15771人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s1657785.jpg', '影响力', '[美] 罗伯特·西奥迪尼/陈叙', '中国人民大学出版社', '2006-5', '45.00元', '8.6', ' 43988人评价              ', '营销防骗指南');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s24598159.jpg', '众病之王', '[美] 悉达多·穆克吉/李虎', '中信出版社', '2013-2', '42.00元', '9.1', ' 10010人评价              ', '癌症传');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s2897060.jpg', '象棋的故事', '[奥] 斯蒂芬·茨威格/张玉书', '上海译文出版社', '2007-7', '23.00元', '9.1', ' 10195人评价              ', '纳粹法西斯对人心灵的折磨及摧残');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s29738720.jpg', '长日将尽', '[英] 石黑一雄/冯涛', '上海译文出版社', '2018-5', '48.00元', '8.9', ' 16118人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s1801057.jpg', '世界尽头与冷酷仙境', '[日] 村上春树/林少华', '上海译文出版社', '2002-12', '23.00元', '8.6', ' 39861人评价              ', '交叉平行蒙太奇');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s1050021.jpg', '老人与海', '海明威/吴劳', '上海译文出版社', '1999-10', '8.20元', '8.4', ' 168859人评价              ', '正是悲壮赋予生活以意义');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s29423902.jpg', '当呼吸化为空气', '[美] 保罗·卡拉尼什/何雨珈', '猫头鹰文化·浙江文艺出版社', '2016-12', '48.00元', '8.8', ' 20125人评价              ', '你在死亡中探究生命的意义，你见证生前的呼吸化作死后的空气');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s24174596.jpg', '毛姆短篇小说精选集', '[英] 威廉·萨默塞特·毛姆/冯亦代', '译林出版社', '2012-11', '36.00元', '9.1', ' 10126人评价              ', '在各种光怪陆离的场景中，迷失的人性引发了一连串的悲剧');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s2756239.jpg', 'ZOO', '[日] 乙一/李颖秋', '当代世界出版社', '2007-10', '20.00元', '8.6', ' 39697人评价              ', '噩梦中的一丝温度');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s1146040.jpg', '骆驼祥子', '老舍', '人民文学出版社', '2000-3-1', '12.00', '8.4', ' 170026人评价              ', '旧中国老北京贫苦市民的典型命运');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s29425921.jpg', '步履不停', '[日] 是枝裕和/郑有杰', '北京联合出版公司', '2017-5', '36.80元', '8.7', ' 31313人评价              ', '人生路上，步履不停，总有那么一点来不及');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s3667048.jpg', '稻草人手记', '三毛', '北京十月文艺出版社', '2009-3', '18.00元', '8.9', ' 16977人评价              ', '三毛在加纳利群岛上的生活');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s28284246.jpg', '银河帝国：基地七部曲', '[美] 艾萨克·阿西莫夫/叶李华', '江苏凤凰文艺出版社', '2015-10-1', '328.00元', '9.5', ' 8335人评价              ', '阿西莫夫经典科幻小说');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s3511590.jpg', '金阁寺', '[日] 三岛由纪夫/唐月梅', '上海译文出版社', '2009-1', '24.00', '8.7', ' 25130人评价              ', '他的犯罪动机是对美的嫉妒');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s1641357.jpg', '多情剑客无情剑(上、中、下)', '古龙', '海天出版社', '1991-12-01', '49.8', '8.7', ' 19456人评价              ', '流水滔滔斩不断，情丝百结冲不破');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s27009357.jpg', '哈姆莱特', '[英] 莎士比亚/朱生豪', '人民文学出版社', '2001-1', '7.00元', '8.6', ' 39738人评价              ', '生存还是毁灭，这是一个值得思考的问题');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s3470220.jpg', '社会契约论', '卢梭/何兆武', '商务印书馆', '2003-2-1', '18.00元', '8.8', ' 15761人评价              ', '一个国家只能有一个契约');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s5763939.jpg', '安娜·卡列尼娜', '[俄] 列夫·托尔斯泰/草婴', '上海文艺出版社', '2007-8', '37.00元', '9.2', ' 16859人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s28036829.jpg', '狂热分子', '[美] 埃里克·霍弗/梁永安', '广西师范大学出版社', '2011-6', '34.00元', '8.9', ' 11963人评价              ', '探讨群众运动的共有特征');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s1817666.jpg', '海底两万里', '[法国] 儒尔·凡尔纳/沈国华', '译林出版社', '2002-9', '19.50元', '8.5', ' 90143人评价              ', '你听说过鹦鹉螺号吗？');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s1075414.jpg', '牡丹亭', '汤显祖', '人民文学出版社', '1963-4-1', '14.50元', '9.0', ' 11250人评价              ', '不到园林，怎知春色如许');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s33323852.jpg', '被讨厌的勇气', '岸见一郎/渠海霞', '机械工业出版社', '2015-3-1', '39.8', '8.6', ' 56944人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s29331058.jpg', '世界的凛冬', '[英] 肯·福莱特/陈杰', '江苏凤凰文艺出版社', '2017-3-1', '132.00（全三册）', '8.8', ' 22253人评价              ', '我亲眼目睹，每一个迈向死亡的生命都在热烈地生长');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s9110246.jpg', '了不起的盖茨比', '[美] 斯科特·菲茨杰拉德/邓若虚', '南海出版公司', '2012-5', '25.00元', '8.7', ' 34790人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s28397415.jpg', '二手时间', '[白俄] S. A. 阿列克谢耶维奇/吕宁思', '中信出版集团', '2016-1', '55.00元', '8.8', ' 16727人评价              ', '用最为细小的马赛克拼出了一幅完整的后苏联时代图景');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s1027286.jpg', '别闹了，费曼先生', '[美] 理查德·费曼/吴程远', '生活·读书·新知三联书店', '1997-12', '22.00', '8.9', ' 9671人评价              ', '科学顽童的故事');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s33623978.jpg', '消失的13级台阶', '[日] 高野和明/赵建勋', '上海文艺出版社', '2020-5-15', '42.00元', '8.7', ' 28398人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s1290828.jpg', '长袜子皮皮', '[瑞典] 阿斯特丽德·林格伦/李之义', '中国少年儿童出版社', '1999-3', '17.80元', '9.0', ' 10688人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s33317677.jpg', '克莱因壶', '[日]冈岛二人/张舟', '化学工业出版社', '2019-11', '48.00元', '8.8', ' 18310人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s8972061.jpg', '不存在的骑士', '[意] 伊塔洛·卡尔维诺/吴正仪', '译林出版社', '2012-4', '22.00元', '8.9', ' 12742人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img3.doubanio.com/view/subject/s/public/s4425090.jpg', '告白', '[日]凑佳苗/丁世佳', '哈尔滨出版社', '2010-7', '26.00元', '8.5', ' 13134人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s2783843.jpg', '社会性动物', '埃利奥特·阿伦森Elliot Aronson/邢占军', '华东师范大学出版社', '2007-12', '45.00元', '9.1', ' 10753人评价              ', '美国社会心理学的《圣经》');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s2508587.jpg', '欢乐英雄', '古龙', '珠海出版社', '2005-8', '28.00元', '8.8', ' 14440人评价              ', '坚持自己的信念，在贫穷中获得欢乐与友谊');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s8972073.jpg', '分成两半的子爵', '[意] 伊塔洛·卡尔维诺/吴正仪', '译林出版社', '2012-4-1', '20.00元', '8.7', ' 14567人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s1562997.jpg', '西方哲学史（上卷）', '[英] 罗素/何兆武', '商务印书馆', '1963-9', '25.00', '8.9', ' 12383人评价              ', '西方哲学史及其与从古代到现代的政治、社会情况的联系');
INSERT INTO `douban_book` VALUES ('https://img1.doubanio.com/view/subject/s/public/s24422879.jpg', '过于喧嚣的孤独', '(捷克) 赫拉巴尔/杨乐云', '北京十月文艺出版社', '2011-10', '22.00元', '8.8', ' 12684人评价              ', '我为它而活着，并为写它推迟了我的死亡');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s8879166.jpg', '通往奴役之路', '弗里德利希・冯・哈耶克/王明毅', '中国社会科学出版社', '1997-08-01', '16.00', '8.8', ' 14009人评价              ', '古典自由主义杰作');
INSERT INTO `douban_book` VALUES ('https://img9.doubanio.com/view/subject/s/public/s29179365.jpg', '长夜难明', '紫金陈', '云南人民出版社', '2017-1', '42.00元', '8.5', ' 56145人评价              ', '');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s9140762.jpg', '尘埃落定', '阿来', '人民文学出版社', '1998-3-1', '22.0', '8.5', ' 57144人评价              ', '一个傻子的土司家族传奇');
INSERT INTO `douban_book` VALUES ('https://img2.doubanio.com/view/subject/s/public/s24503563.jpg', '美国宪政历程', '任东来', '中国法制出版社', '2014-1', '35.00元', '9.1', ' 7352人评价              ', '25个案例异彩纷呈，美国宪政的酸甜苦辣尽在其中');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sender_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `receiver_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `send_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `send_time` datetime(0) NULL DEFAULT NULL,
  `is_replied` int(11) NULL DEFAULT NULL,
  `reply_content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `reply_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('328485fccdde11eb99e59c304ef0449f', 'admin', '张一', '亲爱的张一同学，你借的书籍《张一》未还。请尽快还书，如逾期未还你的账号可能被冻结。', '2021-06-15 21:32:57', 2, NULL, NULL);
INSERT INTO `message` VALUES ('53bffc86cdb811ebbabd9c304ef0449f', '张一', 'admin', '希望能增加计算机相关藏书', '2021-06-15 17:01:52', 1, '已记录，下次采购。', '2021-06-15 21:33:23');
INSERT INTO `message` VALUES ('7e95ee12cdde11eba61c9c304ef0449f', '李四', 'admin', '我的借书卡掉了，去哪里补办呢？', '2021-06-15 21:35:05', 0, NULL, NULL);
INSERT INTO `message` VALUES ('8b9e3ab7cdde11eb9d0f9c304ef0449f', '李四', 'admin', '能不能采购《枕草子》', '2021-06-15 21:35:27', 0, NULL, NULL);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `role` int(11) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `delete_flag` int(11) NULL DEFAULT NULL,
  `current_login_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('12644064935811ea9063d8c497639e37', 'admin', '21232f297a57a5a743894a0e4a801fc3', 0, '2020-05-11 15:23:12', 0, '2020-05-11 15:24:23');
INSERT INTO `user` VALUES ('272e7d7bc73511eba19cd7bd2780f224', '张二', 'c81e728d9d4c2f636f067f89cc14862c', 1, '2021-06-07 10:07:46', 0, '2021-06-07 10:07:46');
INSERT INTO `user` VALUES ('2b0da9f7c73911eb85dbd7bd2780f224', '李四', 'eccbc87e4b5ce2fe28308fd9f2a7baf3', 1, '2021-06-07 10:36:31', 0, '2021-06-07 10:36:31');
INSERT INTO `user` VALUES ('99477a9e935811ea8171d8c497639e37', 'zhangsan', 'e10adc3949ba59abbe56e057f20f883e', 1, '2020-05-11 15:23:12', 0, '2020-05-11 15:24:23');
INSERT INTO `user` VALUES ('c10dcd40c73411ebb832d7bd2780f224', '张一', 'c4ca4238a0b923820dcc509a6f75849b', 1, '2021-06-07 10:04:55', 0, '2021-06-07 10:04:55');

SET FOREIGN_KEY_CHECKS = 1;
