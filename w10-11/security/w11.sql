DROP TABLE IF EXISTS user;

CREATE TABLE user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    password VARCHAR(255)
);

insert into user(name, password) values
  ('John', 'p1'),
  ('Smith', 'p2');

DROP TABLE IF EXISTS gold;

create table gold (
  id INT PRIMARY KEY  AUTO_INCREMENT, 
  value VARCHAR(255)
);

-- SQL INJECTION EXAMPLES
-- WARNING: these examples are only for learning about security!!!!
--

-- normal INSERT
insert into gold(value) values('100'),('200');

-- malicious INSERT: 
-- to achieve this, on the HTML form field for value, the malicious user enters the following value: 
--      ');drop table gold;
insert into gold(value) values('dummy');drop table gold;

-- sanitized INSERT: 
--  \')\;drop table gold\;
insert into gold(value) values('dummy\')\;drop table gold\;

-- normal SELECT
select * from user where name='John';

-- malicious SELECT: name's value is designed to include an INSERT statement for the hacker account
-- to achieve this, on the HTML form field for name, the malicious user enters the following value: 
--      dummy';insert into user(name, password) values('hacker', '123456')
select * from user where name='';insert into user(name, password) values('hacker', '123456');

select * from user where name='dummy';insert into user(name, password) values('hacker', '123456');

-- sanitised data
select * from user where name='dummy\'\;insert into user(name, password) values(\'hacker\', \'123456\')\;

-- for numeric columns: 1 = 1 always returns true (1)
select 1=1;

select * from user where id=1=1;