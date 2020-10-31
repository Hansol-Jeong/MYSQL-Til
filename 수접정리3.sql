#functions

#ceil, round, truncate

select ceil(12.345); select ceil(12.345 *100) /100;
select round(12.345); select round(12.345,2);
select truncate(12.345,2);

use world;
#국가별 언어 사용 비율을 올림, 반올림, 버림
select countrycode, language, ceil(percentage), round(percentage), truncate(percentage,0) from countrylanguage; 
#Date format
use sakila;
select sum(amount) as income, date_format(payment_date, "%M-%H") as monthly from payment -- %H가의미하는 건 뭘까
#월별 수입으로 바꾸고 싶다.
group by monthly
order by income desc; -- 월별 피크타임 (월별로 묶었는데 시간으로 정렬)

use world;
#100만 이상의 인구를 가신 도시 중, 500만이 넘으면 big city 아니면 small city
select CountryCode, name, population, if(population >5000000, "big city", "small city") from city where population >1000000;

#ifnull
#독립연도가 없으면 0으로 표시
select name, ifnull(indepYear,0) from country;

# case when then end (조건이 여러개 있을 때)
# 국가 인구가 10억 이상 "level 3", 1억 이상 "level 2", 1억 이하 "level 1"
select code, name, population, case 
when population > 1000000000 then "level3" 
when population > 100000000 then "levle2"
else "level1" end scale
from country order by population desc;

# 미국과 한국의 국가 코드와 인구수, gnp출력, 피봇팅해서 출력(x,y반전)
select code, name, population, gnp from country where code in ("USA", "KOR"); -- ?뭐였지이거

#Join
use jbs;
create database test;
use test;
create table user (
name varchar(20),
addr varchar(20)
);
create table money2 (
	name varchar(20),
    income int
);
insert into user (name, addr)
values ("A", "seoul"), ("A", "pusan"),("B","London"), ("C", "incheon");

insert into money2 (name, income)
values ("A",1000),("A", 2000),("C",3000),("D",4000);

#이너조인 - 가장 많이 쓰인다
select * from user
join money2 on user.name = money2.name;

#left join
select * from user
left join money2 on user.name = money2.name; -- user.name 기준

#right join
select * from user
right join money2 on user.name = money2.name; -- money.name 기준

#city 테이블과 country 테이블을 조인해서
#city 인구가 500만이 넘는 도시의 국가코드, 국가이름, 도시이름, 인구수를 출력
use world;
select country.code, country.name, city.name, city.population
from city join country on country.code = city.countrycode where city.population >5000000;

#국가별, 도시별, 언어 사용률을 출력
select code, country.name, city.name, countrylanguage.language, countrylanguage.percentage
from country, city, countrylanguage where country.code = city.countrycode and city.countrycode = countrylanguage.countrycode; -- 코드가 같은걸 찾으면 도시가 여러개 나오지, 코드가같은 언어도여러개 나오지, 곱한거만큼 나옴
select * from country; select * from countrylanguage; select *from city;

#아까 그 문제를 한국과 미국에 국한되서 풀어봐라
select code, country.name, city.name, countrylanguage.language, countrylanguage.percentage
from city, country, countrylanguage where code in ("USA", "KOR") and (city.countrycode = country.code and country.code = countrylanguage.countrycode)
order by percentage;

#union : select 결과를 합쳐서 출력 할 때 사용
#union : 자동으로 중복제거
#union all : 자동으로 중복제거 X
use test;
select * from user;
select * from money2;

select name from user union select name from money2; 
#아우터 조인하기 전에 조인 한번 더 보자
select * from user join money2 on user.name = money2.name;
select * from user left join money2 on user.name = money2.name;
select * from user right join money2 on user.name = money2.name;

select * from user left join money2 on user.name = money2.name
union
select * from user right join money2 on user.name = money2.name;  -- left right join 하지만 중간에 중복되는 거 제거하고 전부 출력







