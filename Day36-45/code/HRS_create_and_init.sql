-- Create HRS database
drop database if exists `hrs`;
create database `hrs` default charset utf8mb4;
-- Switch to HRS database
use `hrs`;
-- Create Department Table
create table `tb_dept` (
    `dno` int not null comment 'Department ID',
    `dname` varchar(10) not null comment 'Department Name',
    `dloc` varchar(20) not null comment 'Department Location',
    primary key (dno)
);
-- Insert 4 departments
insert into `tb_dept`
values (10, 'Accounting', 'Beijing'),
    (20, 'R&D', 'Chengdu'),
    (30, 'Sales', 'Chongqing'),
    (40, 'Operations', 'Shenzhen');
-- Create Employee Table
create table `tb_emp` (
    `eno` int not null comment 'Employee ID',
    `ename` varchar(20) not null comment 'Employee Name',
    `job` varchar(20) not null comment 'Employee Position',
    `mgr` int comment 'Manager ID',
    `sal` int not null comment 'Monthly Salary',
    `comm` int comment 'Monthly Allowance',
    `dno` int comment 'Department ID',
    primary key (eno),
    constraint `fk_emp_mgr` foreign key (`mgr`) references tb_emp (`eno`),
    constraint `fk_emp_dno` foreign key (`dno`) references tb_dept (`dno`)
);
-- Insert 14 employees
insert into `tb_emp`
values (
        7800,
        'Zhang Sanfeng',
        'President',
        null,
        9000,
        1200,
        20
    ),
    (
        2056,
        'Qiao Feng',
        'Analyst',
        7800,
        5000,
        1500,
        20
    ),
    (
        3088,
        'Li Mochou',
        'Designer',
        2056,
        3500,
        800,
        20
    ),
    (
        3211,
        'Zhang Wuji',
        'Programmer',
        2056,
        3200,
        null,
        20
    ),
    (
        3233,
        'Qu Chushi',
        'Programmer',
        2056,
        3400,
        null,
        20
    ),
    (
        3251,
        'Zhang Cuishan',
        'Programmer',
        2056,
        4000,
        null,
        20
    ),
    (
        5566,
        'Song Yuanqiao',
        'Accountant',
        7800,
        4000,
        1000,
        10
    ),
    (
        5234,
        'Guo Jing',
        'Cashier',
        5566,
        2000,
        null,
        10
    ),
    (
        3344,
        'Huang Rong',
        'Sales Manager',
        7800,
        3000,
        800,
        30
    ),
    (
        1359,
        'Hu Yidao',
        'Salesman',
        3344,
        1800,
        200,
        30
    ),
    (
        4466,
        'Miao Renfeng',
        'Salesman',
        3344,
        2500,
        null,
        30
    ),
    (
        3244,
        'Ouyang Feng',
        'Programmer',
        3088,
        3200,
        null,
        20
    ),
    (
        3577,
        'Yang Guo',
        'Accountant',
        5566,
        2200,
        null,
        10
    ),
    (
        3588,
        'Zhu Jiuzhen',
        'Accountant',
        5566,
        2500,
        null,
        10
    );
-- Query employee with highest monthly salary
-- Query employee name and annual salary (annual salary = (sal + comm) * 13)
-- Query department ID and employee count for departments with employees
-- Query department name and employee count for all departments
-- Query employee name and monthly salary for employees earning above average
-- Query employee name, department ID, and monthly salary for employees earning above their department's average
-- Query highest paid employee in each department: name, salary, and department name
-- Query manager name and position
-- Query employees ranked 4-6 by salary: rank, name, and salary
-- Query top 2 employees by salary in each department: name, salary, and department ID