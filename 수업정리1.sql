SELECT * FROM world.country;
use world;
Select * from country;

SELECT code, name, population
FROM country
WHERE population>=200000000;

SELECT code, name, population
FROM country
WHERE population >=200000000 AND population <=300000000;

SELECT code, name, population
FROM country
WHERE population BETWEEN 200000000 AND 300000000;

SELECT code, name, continent, population
FROM country
WHERE (continent = "Asia" or continent = "Africa") AND population >=100000000;

SELECT code, name, continent, population
FROM country
WHERE continent NOT IN ("Asia", "Africa") AND population >=100000000;

SELECT code, name, GovernmentForm
FROM country
WHERE GovernmentForm LIKE "%Republic%";

SELECT code, name, population
FROM country
ORDER BY population ASC;

SELECT code, name, population
FROM country
ORDER BY population DESC;

SELECT countryCode, name, population
FROM city
WHERE countrycode IN ("USA", "KOR", "JPN")
ORDER BY countrycode ASC, population DESC;

SELECT countrycode, name, population
FROM city
WHERE countrycode IN ("USA", "KOR", "JPN")
ORDER BY countrycode ASC, population DESC
LIMIT 5,2; #6,7위

#QUIZ 한국(KOR)의 경기도(KYONGGI)에 해당하는 도시 에서 인구가 많은 3개의 도시를 출력
SELECT countrycode, name, population
FROM city
-- WHERE countrycode IN ("KOR") AND district IN ("KYONGGI")
WHERE countrycode = "KOR" AND DISTRICT = "KYONGGI"
ORDER BY population DESC
LIMIT 3;

#동북아시아에서 인당 GNP가 높은 5개 나라 출력
SELECT code, name, GNP, population, region, (GNP/population) AS GNP_PER_PERSON
FROM country
WHERE region = "Eastern Asia"
ORDER BY GNP_PER_PERSON DESC
LIMIT 5;

#인구밀도가 높은 국가 6~10위까지 출력하세요alter
SELECT code, name, population, surfaceArea, surfaceArea/population as Density
FROM country
ORDER BY Density DESC
LIMIT 5,5;

#COUNT: city테이블에서 국가별 도시의 갯수를 출력
SELECT countrycode, count(countrycode)
FROM city
GROUP BY countrycode;

#MAX : 대륙별 인구수 GNP의 최대값을 출력
SELECT continent, MAX(GNP), MAX(population)
FROM country
GROUP BY continent;

#SUM: 대륙별 전체 인구수와 전체 GNP, 인당 GNP
SELECT continent, SUM(GNP) AS S_GNP, SUM(population) AS S_population, SUM(GNP)/SUM(population) AS per -- 대체하기로한거 같은줄엔 못쓰나 where에도 못쓴다하신거같은데
FROM country
GROUP BY continent; 

#AVG : 대륙별 평균 인구수와 평균 GNP를 출력하고 인구수 순으로 내림차순 정렬
SELECT continent, AVG(population), AVG(GNP), SUM(population) AS population
FROM country
WHERE population !=0 AND GNP !=0 -- 여기에서의 pop은 AS pop이 아니라 구성요소 pop인것이죠? 애초에 where에는 AS안들어간다 하셧죠?
GROUP BY continent
ORDER BY population DESC;

#HAVING : GROUP BY로 출력되는 결과를 필터링할 때 사용
#대륙별 전체 인구수 출력하고 대륙별 5억 이상이 되는 대륙만 출력
SELECT continent, SUM(population) AS S_POP
FROM country
GROUP BY continent
HAVING S_POP>=500000000
ORDER BY S_POP DESC;
#1. 언어별 사용하는 국가의 수를 조회하고 많이 사용되는 언어 6위~ 8위 출력
SELECT language, count(CountryCode) AS count
FROM countrylanguage
GROUP BY language
ORDER BY count DESC
LIMIT 5,3;
#2. 대륙별 나라의 갯수를 출력하고 국가가 많은 대륙 1위 ~3위까지 출력
SELECT continent, count(name) AS count
FROM country
GROUP BY continent
ORDER BY count DESC
LIMIT 3;

#3. city테이블에서 국가 코드별 총인구를 출력, 총 인구순으로 내림차순 정렬
# 총 인구가 5천만 이상인 국가코드만 출력하세요
SELECT countrycode, SUM(population) AS S_pop
FROM city
GROUP BY countrycode
HAVING S_pop >=50000000
ORDER BY S_POP DESC;

use jbs;
SELECT database(); -- 이게 뭐냐고
CREATE TABLE user1(
user_id INT,
name varchar(20),
email varchar(20),
age INT(3),
rDate DATE
);
show Tables;
desc user1;

INSERT INTO user1 (user_id, name, email, age, rDate)
values(1, "Andy", "Andy@gmail.com", 23, "2020-10-01");
SELECT * FROM user1;
SHOW TABLES;
DESC user1;--  왜 그대로 null입니까

CREATE TABLE user2 (
user_id INT PRIMARY KEY AUTO_INCREMENT,
name varchar(20) NOT NULL,
email varchar(20) unique NOT NULL,
age INT(3) DEFAULT 30,
rDate TIMESTAMP
);

INSERT INTO user2(name, email)
values("ANDY", "ANDY@gmail.com");
DESC user2;-- 의미를 잘 모르겠어

use world;
CREATE TABLE city2 (
name varchar(50),
countrycode char(3),
population INT
);
INSERT INTO city2
SELECT name, countrycode, population
FROM city
WHERE population >=8000000;

SELECT * FROM city2;

DROP TABLE city2;










