/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2022/12/20 21:40:37                          */
/*==============================================================*/

SET NAMES utf8mb4;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS newsys;
CREATE SCHEMA newsys;
USE newsys;

/*==============================================================*/
/* Table: Users                                                 */
/*==============================================================*/


create table Users
(
   user_name            char(16) not null  comment '',
   account              char(16) not null  comment '',
   password             char(24) not null  comment '',
   user_type            boolean not null  comment '',
   teacher_id           decimal not null  comment '',
   primary key (account)
);

/*==============================================================*/
/* Table: computer_configs                                      */
/*==============================================================*/
create table computer_configs
(
   configs_id           decimal not null  comment '',
   displayer            char(64) not null  comment '',
   cpu                  char(64) not null  comment '',
   gpu                  char(64) not null  comment '',
   primary key (configs_id)
);

/*==============================================================*/
/* Table: course_software                                       */
/*==============================================================*/
create table course_software
(
   course_id            decimal not null  comment '',
   software_id          decimal not null  comment '',
   software_version     char(64)  comment '',
   primary key (course_id, software_id)
);

/*==============================================================*/
/* Table: courses                                               */
/*==============================================================*/
create table courses
(
   course_id            decimal not null  comment '',
   course_name          char(128) not null  comment '',
   teacher_id           decimal not null  comment '',
   labs_id              decimal not null  comment '',
   institute_id         decimal not null  comment '',
   period               decimal not null  comment '',
   student_num          decimal  comment '',
   primary key (course_id)
);

/*==============================================================*/
/* Table: institute                                             */
/*==============================================================*/
create table institute
(
   institute_id         decimal not null  comment '',
   institute_name       char(128) not null  comment '',
   primary key (institute_id)
);

/*==============================================================*/
/* Table: lab_software                                          */
/*==============================================================*/
create table lab_software
(
   labs_id              decimal not null  comment '',
   software_id          decimal not null  comment '',
   software_versioin    char(64)  comment '',
   last_update          datetime not null  comment '',
   needed_space         char(64)  comment '',
   primary key (labs_id, software_id)
);

/*==============================================================*/
/* Index: lab_software_PK                                       */
/*==============================================================*/
create index lab_software_PK on lab_software
(
   software_id
);

/*==============================================================*/
/* Table: laboratory                                            */
/*==============================================================*/
create table laboratory
(
   labs_id              decimal not null  comment '',
   configs_id           decimal not null  comment '',
   lab_name             char(64) not null  comment '',
   lab_address          char(128) not null  comment '',
   manager              char(64) not null  comment '',
   square               decimal  comment '',
   device_num           decimal not null  comment '',
   primary key (labs_id)
);

/*==============================================================*/
/* Index: lab_name                                              */
/*==============================================================*/
create index lab_name on laboratory
(
   lab_name
);

/*==============================================================*/
/* Table: reservation                                           */
/*==============================================================*/
create table reservation
(
   reservation_id       decimal not null  comment '',		# 主键约束
   account              char(16) not null  comment '',		
   labs_id              decimal not null  comment '',
   re_time_start        datetime not null  comment '',
   re_purpose           char(128) not null  comment '',
   phone_num            char(128) not null  comment '',
   create_tiem          datetime not null  comment '',
   process_time         datetime  comment '',
   re_time_end          datetime not null  comment '',
   re_result            bool not null  comment '',
   primary key (reservation_id)							
);

/*==============================================================*/
/* Table: software_types                                        */
/*==============================================================*/
create table software_types
(
   softype_id           decimal not null  comment '',
   type_name            char(64) not null  comment '',
   primary key (softype_id)
);

/*==============================================================*/
/* Table: softwares                                             */
/*==============================================================*/
create table softwares
(
   software_id          decimal not null  comment '',
   softype_id           decimal not null  comment '',
   software_name        char(64) not null  comment '',
   software_arch        char(64) not null  comment '',
   primary key (software_id)
);

/*==============================================================*/
/* Table: teachers                                              */
/*==============================================================*/
create table teachers
(
   teacher_id           decimal not null  comment '',  # 主键约束
   account              char(16)  comment '',		   # 外键但可空
   institute_id         decimal not null  comment '',  # 外键非空约束
   teacher_name         char(64) not null  comment '', # 非空约束
   primary key (teacher_id)
);

/*==============================================================*/
/* View: SoftwaresOfLab                                         */
/*==============================================================*/
create VIEW  SoftwaresOfLab
 as
select laboratory.lab_name, displayer, computer_configs.cpu, gpu
from laboratory,computer_configs
where laboratory.configs_id=computer_configs.configs_id;

alter table Users add constraint FK_USERS_USER_TEAC_TEACHERS foreign key (teacher_id)
      references teachers (teacher_id) on delete restrict on update restrict;

alter table course_software add constraint FK_COURSE_S_COURSE_SO_COURSES foreign key (course_id)
      references courses (course_id) on delete restrict on update restrict;

alter table course_software add constraint FK_COURSE_S_COURSE_SO_SOFTWARE foreign key (software_id)
      references softwares (software_id) on delete restrict on update restrict;

alter table courses add constraint FK_COURSES_COURSE_IN_INSTITUT foreign key (institute_id)
      references institute (institute_id) on delete restrict on update restrict;

alter table courses add constraint FK_COURSES_COURSE_LA_LABORATO foreign key (labs_id)
      references laboratory (labs_id) on delete restrict on update restrict;

alter table courses add constraint FK_COURSES_COURSE_TE_TEACHERS foreign key (teacher_id)
      references teachers (teacher_id) on delete restrict on update restrict;

alter table lab_software add constraint FK_LAB_SOFT_LAB_SOFTW_LABORATO foreign key (labs_id)
      references laboratory (labs_id) on delete restrict on update restrict;

alter table lab_software add constraint FK_LAB_SOFT_LAB_SOFTW_SOFTWARE foreign key (software_id)
      references softwares (software_id) on delete restrict on update restrict;

alter table laboratory add constraint FK_LABORATO_LAB_CONFI_COMPUTER foreign key (configs_id)
      references computer_configs (configs_id) on delete restrict on update restrict;

alter table reservation add constraint FK_RESERVAT_RESERVATI_LABORATO foreign key (labs_id)
      references laboratory (labs_id) on delete restrict on update restrict;

alter table reservation add constraint FK_RESERVAT_USER_RESE_USERS foreign key (account)
      references Users (account) on delete restrict on update restrict;

alter table softwares add constraint FK_SOFTWARE_SOFTWARE__SOFTWARE foreign key (softype_id)
      references software_types (softype_id) on delete restrict on update restrict;

alter table teachers add constraint FK_TEACHERS_USER_TEAC_USERS foreign key (account)
      references Users (account) on delete restrict on update restrict;

alter table teachers add constraint FK_TEACHERS_学院_教师_INSTITUT foreign key (institute_id)
      references institute (institute_id) on delete restrict on update restrict;


DELIMITER ;;
CREATE DEFINER=`root`@`localhost` TRIGGER `lab_software_BEFORE_UPDATE` BEFORE UPDATE ON `lab_software` FOR EACH ROW BEGIN
	set NEW.last_update=NOW() ;
END
