-- Drop school database if exists
drop database if exists `school`;
-- Create school database and set default character set and collation
create database `school` default charset utf8mb4;
-- Switch to school database context
use `school`;
-- Create College Table
create table `tb_college` (
    `col_id` int unsigned auto_increment comment 'ID',
    `col_name` varchar(50) not null comment 'College Name',
    `col_intro` varchar(5000) default '' comment 'College Introduction',
    primary key (`col_id`)
) engine = innodb comment 'College Table';
-- Create Student Table
create table `tb_student` (
    `stu_id` int unsigned not null comment 'Student ID',
    `stu_name` varchar(20) not null comment 'Student Name',
    `stu_sex` boolean default 1 comment 'Gender',
    `stu_birth` date not null comment 'Date of Birth',
    `stu_addr` varchar(255) default '' comment 'Native Place',
    `col_id` int unsigned not null comment 'College ID',
    primary key (`stu_id`),
    foreign key (`col_id`) references `tb_college` (`col_id`)
) engine = innodb comment 'Student Table';
-- Create Teacher Table
create table `tb_teacher` (
    `tea_id` int unsigned not null comment 'Employee ID',
    `tea_name` varchar(20) not null comment 'Teacher Name',
    `tea_title` varchar(10) default 'Assistant' comment 'Professional Title',
    `col_id` int unsigned not null comment 'College ID',
    primary key (`tea_id`),
    foreign key (`col_id`) references `tb_college` (`col_id`)
) engine = innodb comment 'Teacher Table';
-- Create Course Table
create table `tb_course` (
    `cou_id` int unsigned not null comment 'Course ID',
    `cou_name` varchar(50) not null comment 'Course Name',
    `cou_credit` int unsigned not null comment 'Course Credit',
    `tea_id` int unsigned not null comment 'Instructor ID',
    primary key (`cou_id`),
    foreign key (`tea_id`) references `tb_teacher` (`tea_id`)
) engine = innodb comment 'Course Table';
-- Create Course Registration Record Table
create table `tb_record` (
    `rec_id` bigint unsigned auto_increment comment 'Course Registration Record ID',
    `sid` int unsigned not null comment 'Student ID',
    `cid` int unsigned not null comment 'Course ID',
    `sel_date` date not null comment 'Course Registration Date',
    `score` decimal(4, 1) comment 'Exam Score',
    primary key (`rec_id`),
    foreign key (`sid`) references `tb_student` (`stu_id`),
    foreign key (`cid`) references `tb_course` (`cou_id`),
    unique (`sid`, `cid`)
) engine = innodb comment 'Course Registration Record Table';
-- Insert College Data
insert into `tb_college` (`col_name`, `col_intro`)
values (
        'School of Computer Science',
        'The School of Computer Science established the computer major in 1958, founded the Department of Computer Science in 1981, established the School of Computer Science in 1998. In May 2005, to further integrate teaching and scientific research resources, the school decided to merge the administrative teams of the School of Computer Science and Software School and implement independent teaching and student management. The school has three departments: Department of Computer Science and Technology, Department of Internet of Things Engineering, Department of Computational Finance; two research institutes: Image and Graphics Research Institute, Cyber Security Research Institute (established in 2015); three teaching experimental centers: Computer Basic Teaching Experimental Center, IBM Technology Center, and Computer Professional Experimental Center.'
    ),
    (
        'School of Foreign Languages',
        'The School of Foreign Languages has 7 teaching units and 6 undergraduate majors for both liberal arts and sciences. It has 1 doctoral awarding point for first-level discipline, 3 doctoral awarding points for second-level disciplines, 5 master degree authorization points for first-level disciplines, 5 master degree authorization points for second-level disciplines, 5 master professional authorization fields, and 2 master professional degrees (MTI). The school has more than 210 faculty and staff, including more than 80 professors and associate professors, with more than 60% of teachers holding PhDs from domestic and international universities or pursuing doctorates.'
    ),
    (
        'School of Economics and Management',
        'The School of Economics was founded in 1905 as the Department of Economics. Renowned economists such as Peng Dixian, Zhang Yujiu, Jiang Xuemode, Hu Jihuang, Tao Dayong, Hu Daiguang, and contemporary scholars Liu Shifu have taught or studied here.'
    );
-- Insert Student Data
insert into `tb_student` (
        `stu_id`,
        `stu_name`,
        `stu_sex`,
        `stu_birth`,
        `stu_addr`,
        `col_id`
    )
values (
        1001,
        'Yang Guo',
        1,
        '1990-3-4',
        'Changsha, Hunan',
        1
    ),
    (
        1002,
        'Ren Woxing',
        1,
        '1992-2-2',
        'Changsha, Hunan',
        1
    ),
    (
        1033,
        'Wang Yuyan',
        0,
        '1989-12-3',
        'Chengdu, Sichuan',
        1
    ),
    (
        1572,
        'Yue Buqun',
        1,
        '1993-7-19',
        'Xianyang, Shaanxi',
        1
    ),
    (
        1378,
        'Ji Yiran',
        0,
        '1995-8-12',
        'Mianyang, Sichuan',
        1
    ),
    (
        1954,
        'Lin Pingzhi',
        1,
        '1994-9-20',
        'Putian, Fujian',
        1
    ),
    (2035, 'Dongfang Bubai', 1, '1988-6-30', null, 2),
    (
        3011,
        'Lin Zhennan',
        1,
        '1985-12-12',
        'Putian, Fujian',
        3
    ),
    (3755, 'Xiang Shaolong', 1, '1993-1-25', null, 3),
    (
        3923,
        'Yang Buhui',
        0,
        '1985-4-17',
        'Chengdu, Sichuan',
        3
    );
-- Insert Teacher Data
insert into `tb_teacher` (`tea_id`, `tea_name`, `tea_title`, `col_id`)
values (1122, 'Zhang Sanfeng', 'Professor', 1),
    (1133, 'Song Yuanqiao', 'Associate Professor', 1),
    (1144, 'Yang Xiao', 'Associate Professor', 1),
    (2255, 'Fan Yao', 'Associate Professor', 2),
    (3366, 'Wei Yixiao', default, 3);
-- Insert Course Data
insert into `tb_course` (`cou_id`, `cou_name`, `cou_credit`, `tea_id`)
values (1111, 'Python Programming', 3, 1122),
    (2222, 'Web Front-end Development', 2, 1122),
    (3333, 'Operating Systems', 4, 1122),
    (4444, 'Computer Networks', 2, 1133),
    (5555, 'Compiler Principles', 4, 1144),
    (6666, 'Algorithms and Data Structures', 3, 1144),
    (7777, 'French for Economics and Trade', 3, 2255),
    (8888, 'Cost Accounting', 2, 3366),
    (9999, 'Auditing', 3, 3366);
-- Insert Course Registration Data
insert into `tb_record` (`sid`, `cid`, `sel_date`, `score`)
values (1001, 1111, '2017-09-01', 95),
    (1001, 2222, '2017-09-01', 87.5),
    (1001, 3333, '2017-09-01', 100),
    (1001, 4444, '2018-09-03', null),
    (1001, 6666, '2017-09-02', 100),
    (1002, 1111, '2017-09-03', 65),
    (1002, 5555, '2017-09-01', 42),
    (1033, 1111, '2017-09-03', 92.5),
    (1033, 4444, '2017-09-01', 78),
    (1033, 5555, '2017-09-01', 82.5),
    (1572, 1111, '2017-09-02', 78),
    (1378, 1111, '2017-09-05', 82),
    (1378, 7777, '2017-09-02', 65.5),
    (2035, 7777, '2018-09-03', 88),
    (2035, 9999, '2019-09-02', null),
    (3755, 1111, '2019-09-02', null),
    (3755, 8888, '2019-09-02', null),
    (3755, 9999, '2017-09-01', 92);