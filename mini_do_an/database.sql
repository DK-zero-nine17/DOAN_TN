USE dacn;

CREATE TABLE IF NOT EXISTS TheUser (
  id INT PRIMARY KEY AUTO_INCREMENT,
  passwordUser VARCHAR(500) NOT NULL,
  mssvUser VARCHAR(15) NOT NULL,
  nameUser NVARCHAR(50) NOT NULL,
  emailUser VARCHAR(100) NOT NULL,
  lopUser NVARCHAR(100) ,
  sdtUser VARCHAR(15) ,
  dateUser VARCHAR(20) ,
  diachiUser NVARCHAR(100),
  avatarUser VARCHAR(500)
);
INSERT INTO TheUser VALUES(1,'6051071057','Rơm','1234567','60@1234','CNTT','033964','11-11-2011','quận 9','/data/user/0/com.example.mini_do_an/cache/scaled_FB_IMG_1685680826124.jpg');
INSERT INTO TheUser VALUES(2,'60510710','AliceJex','gAAAAABkh+ZACEzmkyRblcV4jW1MDaSe16zDc+ymd2hIo7VxPLdaU5TCoz+PgwubGX/Q+86R6LoIolvvVTJpaYk3YkA32MsLUQ==','60@1234','bưu chính viễn thông',NULL,NULL,NULL,NULL);

CREATE TABLE IF NOT EXISTS Post (
  id INT PRIMARY KEY AUTO_INCREMENT,
  idUser INT NOT NULL,
  tieudePost VARCHAR(100),
  nguoiguiPost VARCHAR(50),
  datePost VARCHAR(20),
  noidungPost VARCHAR(200),
  picturesPost VARCHAR(500),
  trangThai VARCHAR(50),
  mdHuHong VARCHAR(50),
  mdCanThiet VARCHAR(50),
  thietBi VARCHAR(50),
  diachi VARCHAR(100),
  FOREIGN KEY (idUser) REFERENCES TheUser(id)
);
INSERT INTO Post VALUES(1,1,'Trộm bàn','aaaa','2023-06-01 20:30:09.023867','bới bà con có trộm','/data/user/0/com.example.mini_do_an/cache/scaled_7045c25cf07a2f0aa5403b7d256703f0.png','Chưa duyệt','Nặng','Bình Thường','bàn học','302C2');
INSERT INTO Post VALUES(2,1,'a','','2023-06-01 20:55:01.378336','mmmmm','/data/user/0/com.example.mini_do_an/cache/scaled_d5d34d0d3e22a03c67cc40cd3590c1d0.png','Chưa duyệt','Nặng','Bình Thường','bàn học','b');
INSERT INTO Post VALUES(3,1,'p','ah','2023-06-01 21:40:52.250021','vdtyujhtrt','/data/user/0/com.example.mini_do_an/cache/scaled_f621eeaf-8b56-4b92-a62d-9a4ab80ff7814019146433502461014.jpg','Chưa duyệt','Bình Thường','Thấp','cái ghế','y');
INSERT INTO Post VALUES(4,1,'j','ah','2023-06-01 22:25:56.151872','hjkgff','/data/user/0/com.example.mini_do_an/cache/scaled_Screenshot_20230509-194218.png','Chưa duyệt','Bình Thường','Cao','bàn phím máy tính','h');
INSERT INTO Post VALUES(5,1,'tiiiii','ah','2023-06-02 16:45:12.145714','hhahjakaka','/data/user/0/com.example.mini_do_an/cache/scaled_FB_IMG_1685680826124.jpg','Chưa duyệt','Nặng','Bình Thường','máy chiếu','iioo');
INSERT INTO Post VALUES(6,1,'tiiiii','ah','2023-06-02 16:45:34.246151','hhahjakaka','/data/user/0/com.example.mini_do_an/cache/scaled_FB_IMG_1685680826124.jpg','Chưa duyệt','Nặng','Bình Thường','máy chiếu','iioo');
INSERT INTO Post VALUES(7,1,'o','ah','2023-06-02 16:54:42.181795','hh','/data/user/0/com.example.mini_do_an/cache/scaled_Screenshot_20230520-185113.png','Chưa duyệt','Bình Thường','Cao','máy tính','i');
INSERT INTO Post VALUES(8,1,'o','ah','2023-06-02 16:57:00.182489','hh','/data/user/0/com.example.mini_do_an/cache/scaled_Screenshot_20230520-185113.png','Chưa duyệt','Bình Thường','Cao','máy tính','i');
INSERT INTO Post VALUES(9,2,'o','ah','2023-06-02 17:05:06.750887','hh','/data/user/0/com.example.mini_do_an/cache/scaled_Screenshot_20230520-185113.png','Chưa duyệt','Bình Thường','Cao','máy tính','i');
INSERT INTO Post VALUES(10,2,'o','ah','2023-06-02 17:06:13.351901','hh','/data/user/0/com.example.mini_do_an/cache/scaled_Screenshot_20230520-185113.png','Chưa duyệt','Bình Thường','Cao','máy tính','i');
INSERT INTO Post VALUES(11,2,'oiyuok','ah','2023-06-02 17:07:00.340415','hìugjjbhh','/data/user/0/com.example.mini_do_an/cache/scaled_FB_IMG_1685613119015.jpg','Chưa duyệt','Nặng','Bình Thường','máy chiếu','hjkbg');

CREATE TABLE IF NOT EXISTS Comment (
  idCmt INT PRIMARY KEY AUTO_INCREMENT,
  idPostCmt INT,
  idUserCmt INT,
  dateCmt VARCHAR(20),
  contentCmt VARCHAR(200),
  picturesCmt VARCHAR(500),
  FOREIGN KEY (idUserCmt) REFERENCES TheUser(id),
  FOREIGN KEY (idPostCmt) REFERENCES Post(id)
);
INSERT INTO Comment VALUES(1,1,1,'2023-06-06 16:20:06.771624','abc bánh bèo',NULL);
INSERT INTO Comment VALUES(2,1,2,'2023-06-06 16:21:24.990412','má t thấy m ròii ',NULL);
INSERT INTO Comment VALUES(3,2,1,'2023-06-06 16:21:34.768848','helllo boy ',NULL);
INSERT INTO Comment VALUES(4,3,1,'2023-06-06 16:21:46.314466','xin chào các men',NULL);
INSERT INTO Comment VALUES(5,3,1,'2023-06-06 16:22:02.997362','oiiiiii muối vẫn mặn',NULL);
INSERT INTO Comment VALUES(6,6,2,'2023-06-06 16:22:26.921284','aloooo cướp ',NULL);
CREATE TABLE IF NOT EXISTS HiddenPost (
  idUser INT,
  idPost INT,
  favorite INT,
  FOREIGN KEY (idUser) REFERENCES TheUser(id),
  FOREIGN KEY (idPost) REFERENCES Post(id)
);
INSERT INTO HiddenPost VALUES(1,2,1);
INSERT INTO HiddenPost VALUES(1,5,0);
INSERT INTO HiddenPost VALUES(1,6,1);
INSERT INTO HiddenPost VALUES(1,8,1);
INSERT INTO HiddenPost VALUES(2,5,1);
INSERT INTO HiddenPost VALUES(2,9,0);
INSERT INTO HiddenPost VALUES(2,2,1);

ALTER TABLE `dacn`.`hiddenpost` 
DROP FOREIGN KEY `hiddenpost_ibfk_1`,
DROP FOREIGN KEY `hiddenpost_ibfk_2`;
ALTER TABLE `dacn`.`hiddenpost` 
CHANGE COLUMN `idUser` `idUser` INT NOT NULL ,
CHANGE COLUMN `idPost` `idPost` INT NOT NULL ,
ADD PRIMARY KEY (`idUser`, `idPost`);
;
ALTER TABLE `dacn`.`hiddenpost` 
ADD CONSTRAINT `hiddenpost_ibfk_1`
  FOREIGN KEY (`idUser`)
  REFERENCES `dacn`.`theuser` (`id`),
ADD CONSTRAINT `hiddenpost_ibfk_2`
  FOREIGN KEY (`idPost`)
  REFERENCES `dacn`.`post` (`id`);
