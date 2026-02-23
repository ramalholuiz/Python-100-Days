drop database if exists library;
create database library default charset utf8;
use library;
create table tb_book (
  bookid integer primary key auto_increment,
  title varchar(100) not null,
  author varchar(50) not null,
  publisher varchar(50) not null,
  price float not null,
  lendout bit default 0,
  lenddate datetime,
  lendcount integer default 0
);
insert into tb_book (title, author, publisher, price, lendcount)
values (
    'Java Core Technology Volume 1',
    'Cay S. Horstmann',
    'Mechanical Industry Press',
    98.2,
    102
  );
insert into tb_book (title, author, publisher, price, lendcount)
values (
    'Thinking in Java',
    'Bruce Eckel',
    'Mechanical Industry Press',
    86.4,
    87
  );
insert into tb_book (title, author, publisher, price, lendcount)
values (
    'Deep Understanding of Java Virtual Machine',
    'Zhou Zhiming',
    'Mechanical Industry Press',
    64.4,
    32
  );
insert into tb_book (title, author, publisher, price, lendcount)
values (
    'Effective Java Second Edition',
    'Joshua Bloch',
    'Mechanical Industry Press',
    36.8,
    200
  );
insert into tb_book (title, author, publisher, price, lendcount)
values (
    'Data Structures and Algorithm Analysis in Java 3rd Edition',
    'Mark Allen Weiss',
    'Mechanical Industry Press',
    51.0,
    15
  );
insert into tb_book (title, author, publisher, price, lendcount)
values (
    'Java 8 in Action',
    'Raoul-Gabriel Urma',
    'Posts and Telecommunications Press',
    56.8,
    25
  );
insert into tb_book (title, author, publisher, price, lendcount)
values (
    'Refactoring: Improving the Design of Existing Code',
    'Martin Fowler',
    'Posts and Telecommunications Press',
    53.1,
    99
  );
insert into tb_book (title, author, publisher, price, lendcount)
values (
    'Code Complete Second Edition',
    'Steve McConnell',
    'Electronic Industry Press',
    53.1,
    99
  );
insert into tb_book (title, author, publisher, price, lendcount)
values (
    'The Pragmatic Programmer: From Journeyman to Master',
    'Andrew Hunt',
    'Electronic Industry Press',
    45.4,
    50
  );
insert into tb_book (title, author, publisher, price, lendcount)
values (
    'Clean Code: A Handbook of Agile Software Craftsmanship',
    'Robert C. Martin',
    'Posts and Telecommunications Press',
    45.4,
    30
  );
insert into tb_book (title, author, publisher, price, lendcount)
values (
    'Design Patterns: Elements of Reusable Object-Oriented Software',
    'Erich Gamma, Richard Helm',
    'Mechanical Industry Press',
    30.2,
    77
  );
insert into tb_book (title, author, publisher, price, lendcount)
values (
    'The Zen of Design Patterns Second Edition',
    'Qin Xiaobo',
    'Mechanical Industry Press',
    70.4,
    100
  );