--  主题表
create table theme(
                      post_id int NOT NULL AUTO_INCREMENT primary key,		-- 主键自动增长
                      title varchar(100),
                      content varchar(10000),
                      posting_time varchar(50),
                      user_id varchar(30),
                      area    int,
                      good_post	varchar(3),
                      is_nav	varchar(3),
                      is_banner	varchar(3)
);
--  drop table theme;

--  回复表
create table theme_back
(
    back_id int NOT NULL AUTO_INCREMENT primary key,
    back_theme_id int,
    user_id varchar(30) ,
    content varchar(3000),
    reply_time varchar(50)
);
--  drop table theme_back;

-- 阅读/回帖数
create table post_count (
                            id  int NOT NULL AUTO_INCREMENT primary key,
                            post_id int NOT NULL unique,
                            read_count int,
                            back_count int
);

-- 用户表
create table users(
                      email varchar(30) primary key,
                      password varchar(50),
                      user_id varchar(30),
                      register_time varchar(50),
                      role_id int,
                      pms_area varchar(255)
);
-- drop table users;
-- select * from users;

-- 用户信息表
create table userdetail(
                           user_id varchar(30) primary key,
                           phone varchar(15),
                           nickname varchar(30),
                           sex varchar(3),
                           signature varchar(100),
                           image varchar(1100),
                           county varchar(30),
                           login_time varchar(50)
);
-- drop table userdetail;

-- 新闻接口中间表
DROP TABLE IF EXISTS `api_news_temp`;
CREATE TABLE `api_news_temp`  (
                                  `id` int(11) NOT NULL AUTO_INCREMENT,
                                  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                  `category` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                  `src` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                  `pic` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                  `content` varchar(10000) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                  `weburl` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                  `creation_date` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                  `time` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                  `sync` varchar(3) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- 密保表
create table pass_security(
                              id int  NOT NULL AUTO_INCREMENT primary key,
                              user_id varchar(30),
                              question1 VARCHAR(50),
                              answer1 varchar(100),
                              question2 varchar(50),
                              answer2	varchar(100)
);

-- 用户积分表
create table integration(
                            user_id varchar(30) primary key,
                            online_time int,
                            post_num int,
                            back_num int,
                            good_post_num int,
                            score int,
                            monicker varchar(20)
);
-- drop table integration

-- 权限表
-- ----------------------------
-- Table structure for `permission`
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
                              `pms_id` int(11) NOT NULL AUTO_INCREMENT primary key,
                              `pms_form` varchar(10) DEFAULT NULL,
                              `pms_description` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('1', 'rwx', '增删改查可执行');
INSERT INTO `permission` VALUES ('2', 'rw', '增删改查');
INSERT INTO `permission` VALUES ('3', 'r', '查（小黑屋）');

-- 角色表
-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
                        `role_id` int(11) NOT NULL,
                        `role_name` varchar(10) DEFAULT NULL,
                        `role_pms` int(11) DEFAULT NULL,
                        `role_description` varchar(50) DEFAULT NULL,
                        PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '超管', '1', '系统超级管理员');
INSERT INTO `role` VALUES ('2', '版主', '1', '板块管理人员');
INSERT INTO `role` VALUES ('3', '用户', '2', '注册用户');
INSERT INTO `role` VALUES ('4', '封禁人员', '3', '违规被禁人员');

-- 管理员表
create table admin(
                      adm_id int not null primary key,
                      adm_username varchar(25),
                      adm_password varchar(50),
                      adm_nicename varchar(20),
                      role_id int
);

-- select table_name from user_tables;

-- 好友表
create table friend(
                       id int NOT NULL AUTO_INCREMENT primary key,
                       usera_id varchar(30),
                       userb_id varchar(30),
                       add_time	varchar(50)
);

-- 消息表
create table news(
                     id int NOT NULL AUTO_INCREMENT primary key,
                     post_id varchar(30),
                     post_nickname varchar(30),
                     recev_id varchar(30),
                     recev_nickname varchar(30),
                     type varchar(10),
                     status varchar(10),
                     time varchar(50),
                     looked varchar(10)
);

-- 站内信表
create table message(
                        mess_id int NOT NULL AUTO_INCREMENT primary key,
                        postmess_id varchar(30),
                        recevmess_id varchar(30),
                        mess_title varchar(200),
                        mess_content varchar(4000),
                        time varchar(50),
                        looked varchar(10)
);

-- 首页轮播图表
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner`  (
                           `id` int(11) NOT NULL AUTO_INCREMENT,
                           `post_id` int(11) NULL DEFAULT NULL COMMENT '帖子id',
                           `main_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '主标题',
                           `sub_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '副标题',
                           `big_pic_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '大图链接',
                           `small_pic_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '小图链接',
                           `post_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '帖子链接',
                           `area` int(11) NULL DEFAULT NULL COMMENT '区域',
                           `is_enable` varchar(5) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '是否生效',
                           `creation_date` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '创建时间',
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 499 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- 创建integration表触发器
create trigger integration_trigger
    before UPDATE
    on integration
    for each row begin
    set new.score = (new.online_time*0.1+new.post_num*30+new.back_num*10+new.good_post_num*200),
new.monicker =
(case when new.score <200 then '江湖小虾'
	when new.score<500 then '江湖小哥'
	when new.score<1000 then '江湖少侠'
	when new.score<1600 then '武林高手'
	when new.score<2500 then '一代宗师'
	when new.score<4000 then '武林至尊'
	else '世外高人' end);
end;

-- 创建theme触发器，（发帖时对应在integration表post_num字段+1）
create trigger theme_trigger
    before INSERT
    on theme
    for each row begin
    update integration set post_num = post_num+1 where integration.user_id=new.user_id;
end;

-- 创建theme触发器（删帖时对应在integration表post_num字段-1）
create trigger theme2_trigger
    before DELETE
    on theme
    for each row begin
    update integration set post_num = post_num-1 where integration.user_id=old.user_id;
end;

-- 创建theme触发器（删帖时对应在post_count表上的对应帖子删除）
create trigger theme3_trigger
    before DELETE
    on theme
    for each row begin
    DELETE from post_count where post_count.post_id=old.post_id;
end;

-- 创建theme_back触发器(回帖时触发integration表back_num字段+1)
create trigger theme_back_trigger
    before INSERT
    on theme_back
    for each row begin
    update integration set back_num = back_num+1 where integration.user_id=new.user_id;
end;

-- 创建theme_back触发器(删除回帖时触发integration表back_num字段-1)
create trigger theme_back_trigger2
    before DELETE
    on theme_back
    for each row begin
    update integration set back_num = back_num-1 where integration.user_id=old.user_id;
end;

-- 创建theme_back触发器(回帖时触发post_count表back_count字段+1)
create trigger theme_back_postcount_trigger
    before INSERT
    on theme_back
    for each row begin
    update post_count set back_count = back_count+1 where post_count.post_id=new.back_theme_id;
end;

-- 创建theme_back触发器(回帖时触发post_count表back_count字段+1)
create trigger theme_back_postcount_trigger2
    before DELETE
    on theme_back
    for each row begin
    update post_count set back_count = back_count-1 where post_count.post_id=old.back_theme_id;
end;

-- 插入新闻哥 账号，用来自动发布新闻（一定要执行）
INSERT INTO `bysj`.`users`(`email`, `password`, `user_id`, `register_time`, `role_id`, `pms_area`) VALUES ('xinwen@qq.com', 'f484f26c3a2625b76117c07935765d30', 'cz4153', '2022-03-20 20:03:21', 3, '1');
INSERT INTO `bysj`.`userdetail`(`user_id`, `phone`, `nickname`, `sex`, `signature`, `image`, `county`, `login_time`) VALUES ('cz4153', '18888888888', '新闻哥', '男', NULL, 'images/user/avatar/tx003.jpg', '潮安区', NULL);
INSERT INTO `bysj`.`integration`(`user_id`, `online_time`, `post_num`, `back_num`, `good_post_num`, `score`, `monicker`) VALUES ('cz4153', 0, 0, 0, 0, null, null);