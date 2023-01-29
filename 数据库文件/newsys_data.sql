SET NAMES utf8mb4;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';
SET @old_autocommit=@@autocommit;

USE newsys;



SET AUTOCOMMIT=0;
INSERT INTO Users VALUES ('Andy','1000000001','123456',false,1),
('Bob','1000000002','123456',false,2),
('Cindy','1000000003','123456',false,3),
('root','123456','123456',true,4);
COMMIT;

SET AUTOCOMMIT=0;
INSERT INTO computer_configs VALUES (1,'xiaomi','i5 10400f','RTX2060'),
(2,'lenovo','i7 10700k','3060'),
(3,'aoc','i9 12900t','4060');
COMMIT;

SET AUTOCOMMIT=0;
INSERT INTO institute VALUES (1,'计算机科学与技术学院'),
(2,'理学院'),
(3,'建筑学院');
COMMIT;

SET AUTOCOMMIT=0;
INSERT INTO teachers VALUES (1,'1000000001',1,'Andy'),
(2,'1000000002',2,'Bob'),
(3,'1000000003',3,'Cindy'),
(4,'123456',1,'test'),
(5,null,1,'test2'),
(6,null,2,'test3'),
(7,null,3,'test4');
COMMIT;

SET AUTOCOMMIT=0;
INSERT INTO software_types VALUES (1,'编程类'),
(2,'通讯类'),
(3,'系统类'),
(4,'办公类');
COMMIT;

SET AUTOCOMMIT=0;
INSERT INTO softwares VALUES (1,1,'Codeblocks','Windows'),
(2,1,'IDEA','Windows'),
(3,2,'QQ','Windows'),
(4,3,'VirtualBox','Windows'),
(5,4,'Word','Windows'),
(6,4,'PowerPoint','Windows');
COMMIT;

SET AUTOCOMMIT=0;
INSERT INTO laboratory VALUES (1,1,'实验室1','T5102','Andy',400, 150),
(2,2,'实验室2','T5202','Andy',300, 120),
(3,3,'实验室3','T5608','Andy',400, 150);
COMMIT;

SET AUTOCOMMIT=0;
INSERT INTO courses VALUES (1,'数据库系统',1,1,1,48,60),
(2,'高等数学',2,2,2,48,60),
(3,'线性代数',3,3,3,32,90);
COMMIT;

SET AUTOCOMMIT=0;
INSERT INTO reservation VALUES (1,'1000000001',1,'2022-09-01 08:30:00','上课','10086','2022-08-21 08:30:00','2022-08-23 17:30:00','2022-09-01 12:15:00',true),
(2,'1000000002',2,'2022-09-03 08:30:00','上课','10010','2022-08-22 08:30:00','2022-08-26 14:30:00','2022-09-03 12:15:00',true),
(3,'1000000003',3,'2022-09-15 08:30:00','上课','10001','2022-08-29 08:30:00','2022-09-03 17:30:00','2022-09-15 12:15:00',true);
COMMIT;



SET AUTOCOMMIT=0;
INSERT INTO course_software VALUES (1,1,'1.0'),
(1,3,'16.0'),
(1,5,'11.0'),
(2,3,'17.0'),
(2,5,'11.0'),
(3,5,'11.0'),
(3,6,'1.0.8');
COMMIT;

SET AUTOCOMMIT=0;
INSERT INTO lab_software VALUES (1,1,'1.0','2022-08-22 08:30:00','114MB'),
(1,3,'16.0','2022-08-22 08:30:00','512MB'),
(1,5,'11.0','2022-08-22 08:30:00','323MB'),
(2,3,'17.0','2022-08-22 08:30:00','600MB'),
(2,5,'11.0','2022-08-22 08:30:00','323MB'),
(3,5,'11.0','2022-08-22 08:30:00','323MB'),
(3,6,'1.0.8','2022-08-22 08:30:00','896MB');
COMMIT;


