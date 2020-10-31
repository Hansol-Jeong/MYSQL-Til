#CRUD : Create, Read, Update, Delete
#create use alter drop
create database test;
use test;
select database();

#Alter 설정, 수정
show variables like "character_set_database";
alter database test character set = utf8;
alter database world character set = utf8;

#alter: add, modify, dorp
use jbs;
CREATE TABLE user2(
user_id INT primary key AUTO_INCREMENT,
name varchar(20) NOT NULL,
email varchar(30) unique NOT NULL,
age INT(3) default 30,
rdate TIMESTAMP
);
desc user2;
alter table user2 Add tmp text;
desc user2;
alter table user2 modify column tmp int;
desc user2;

#DROP
drop database test;
show databases;

use jbs;
drop table user1;
show tables;
drop database test;

desc user2;
select * from user2;

#Insert(create)
#INSERT : 데이터 추가
INSERT INTO user2(user_id, name, email, age, rdate)
values(1,"andy","andy@gmail.com",23,"2020-10-01");
select * from user2;

#Update
update user2
set email = "jin@gmail.com"
where name = "andy"
limit 1;
select * from user2;

#DELETE
delete from user2 where name = "andy" limit 1;
select * from user2;

#Truncate
insert into user2(user_id,name, email, age, rdate)
values(1,"andy", "andy@gmail.com", 23, "2020-02-20");
truncate user2;
select * from user2;-- 구조만 남기고 모두 삭제
drop table user2;

#foreign key 
#데이터의 무결성을 지키기 위해서 사용한다.
#foreign key 설정을 하려면 참조되는 부모 컬럼이 PK이거나 Unique해야 한다.

#user, money
use jbs;
set foreign_key_checks = 0;
drop table users;
set foreign_key_checks = 1;

create table users(
	user_id int primary key auto_increment,
    name varchar(20),
    addr varchar(20)
);
desc user;

create table money(
	money_id int primary key auto_increment,
    income int,
    user_id int
);
desc money;

insert into users (name, addr)
values ("jin", "seoul"),("andy", "pusan"); select * from users;
select * from users;
insert into money (income, user_id)
values (1000,1), (2000,2);
select * from money;
truncate money;
-- 이제 money에 FK넣어 볼 것임
alter table money add constraint FK foreign key (user_id) references users (user_id);
desc money;
drop table money;

#테이블 생성시 FK설정
create table money(
	money_id int primary key auto_increment,
    income int,
    user_id int,
    foreign key (user_id) references users (user_id)
);

desc money; 
insert into money (income, user_id)
values (2000,1), (3000,2);
-- (3000,3) 은 넣지 못한다. 데이터 무결성이 깨지기 때문에
select * from money;
-- users의 user_id가 변경되면 money의 user_id도 변경되지만 반대의 경우는 그렇지 못하다. 그렇기 때문에 생긴 것이 On Update, On Delete

#데이터 삭제
select *from money;
delete from money
where user_id = 2
limit 1;
select * from users; select * from money; -- 보면 money는 잘 지워졌다 그러나
delete from users where user_id = 1 limit 1; -- users의 user_id 1은 money에 의해 참조되어있기 때문에 지워지지 않는다. (같은 맥락에서 drop table users 또한 되지 않는다.)
delete from users where user_id = 2 limit 1; -- 그러나 이미 money에서 지워진 user_id 2 는 잘 지워지는 것을 볼 수 있다.

#ON DELETE, ON UPDATE 설정 (FK 어려우니까 생김)
#참조를 받는 데이터가 수정하거나 삭제될 때 참조 하는 데이터를 설정(수정, 삭제 등등...) 역으로 영향을 준다 (동기화) 그니까 원래는 참조받는 쪽에서 데이터 수정, 삭제가 불가했지만 가능하게 해준다.
#CASCADE : 참조 받은 데이터가 수정, 삭제하면, 참조하는 데이터도 수정, 삭제
#SET NULL : 참조 받는 데이터가 수정, 삭제하면, 참조하는 데이터는 NULL로 수정
#업데이트 되면 업데이트(cascade), 삭제되면 NULL값으로 수정 (set null) null이되면 컬럼간의 FK는 유지되지만 참조하는 값 자체가 null이기 때문에 무결성은 유지된다. (if null이 아닌값이 되면 문제가되지만 null이면 문제가 안된다.)
#위에 무슨소린지 이해해보자

insert into users(name, addr) values ("peter", "incheon");
select * from users;

drop table money; -- 머니 삭제하고 연결설정해보겠다.  
create table money (
money_id int primary key auto_increment,
income int,
user_id int,
foreign key (user_id) references users(user_id)
on update cascade on delete set null -- money 단에서 수정, 삭제 시 부모가 동기화 되도록 설정 하였다.
);
desc money;
select * from users; select * from money; -- 현제 user_id 1,3이 존재한다. 그니까 이 둘은 애초에 넣을 수 있는 것들
insert into money (income, user_id)
values(1000,1),(2000,3); select * from money;
#이제 업데이트 해보자
update users
set user_id = 4 where user_id = 1; select * from users; select * from money;

#user 데이터 삭제
delete from users
where user_id = 3; select *from users; select * from money; -- money는 왜 데이터가 안지워지고 user_id열하나만 지워지죠
