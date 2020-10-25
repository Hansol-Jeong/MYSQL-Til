#Quiz 1: Sakila 데이터 베이스에서 국가가(?) 인도 고객의 수를 출력하세요.
use sakila;
SELECT * FROM country
WHERE country = "India"; -- country_id=44

SELECT store_id, count(store_id) FROM customer GROUP BY store_id;
SELECT * FROM address;
SELECT * FROM store; -- 매장은 2개 둘중하나가 인도매장?
-- 모르겠습니다

#Quiz 2: 한국 도시중에 100만이 넘는 도시를 조회하여 인구순으로 내림차순 하세요.
-- 1. 한국도시 2.100만 3.인구순 내림차순
use world;
SELECT name, population -- 파란글씨는 무엇입니까
FROM city -- IN countrycode ="KOR"
WHERE countrycode ="KOR" AND population >=1000000
ORDER BY population DESC;

#Quiz 3: city 테이블에서 population이 800만 ~ 1000만 사이인 도시 데이터를 인구수순으로 내림차순하세요.
-- 1.city 테이블 2.population 800~1000 3.인구순 내림차순
SELECT name, countrycode, population
FROM city
WHERE population >=8000000 AND population <=10000000
ORDER BY population DESC;

#Quiz 4: country 테이블에서 1940 ~ 1950년도 사이에 독립한 국가들을 조회하고 독립한 년도 순으로 오름차순하세요.
-- 1. country테이블 2.1940~1950독립 3.독립년도 순으로 오름차순 
-- SELECT IndepYear
-- FROM country;
SELECT Name AS NameIndep, continent, population -- NameIndep에 IndepYear을 어떻게 추가합니까
FROM country
WHERE IndepYear != 0 AND IndepYear >=1940 AND IndepYear <1950
ORDER BY IndepYear;

#Quiz 5: contrylanguage 테이블에서 스페인어, 한국어, 영어를 95% 이상 사용하는 국가 코드를 Percentage로 내림차순하여 아래와 같이 조회하세요.
-- 1.countrylanguage 테이블 2.스페인어, 한국어 ,영어를 95%이상 하용하는 국가 코드-> Percentage 로 내림차순
SELECT * FROM countrylanguage
WHERE language IN ("Spanish", "English", "Korean") AND IsOfficial="T" AND Percentage>=95
ORDER BY Percentage DESC;

#Quiz 6: country 테이블에서 Code가 A로 시작하고 GovernmentForm에 Republic이 포함되는 데이터를 아래와같이 조회하세요.
-- 1. country 테이블 2.Code = A로 시작 3. GorvernmnetForm = %Republic%
SELECT Code, Name, Continent, GovernmentForm, population
From country
-- WHERE code LIKE "%A"; 뭔가 오고 A로 끝난다
WHERE code LIKE "A%" AND GovernmentForm LIKE "%Republic%"; -- A다음에 뭔가온다

#Quiz 7: Sakila actor 테이블에서 first_name이 DAN 인 배우의 수를 출력하세요.
-- 1. first_name = DAN 2. count함수로 수 출력->group by
use sakila; -- 이건 대소문자 구분해야되네
SELECT first_name, count(first_name)
FROM actor
GROUP BY first_name HAVING first_name = "DAN";

#Quiz 8: Sakila film_text 테이블에서 title이 ICE가 들어가고 description에 Drama가 들어간 데이터를 출력하세요.
-- 1. Sakila film_text 테이블 2.title LIKE %ICE% 3. description LIKE %Drama%
SELECT film_id, title, description FROM film_text
WHERE title LIKE "%ICE%" AND description LIKE "%Drama%";

#Quiz 9: Sakila 데이터 베이스의 film_list 뷰에서 price가 1 ~ 4, length가 180 이상, category는 Sci-Fi과Animation이 아닌 데이터를 출력하세요.
-- 1. film_list 뷰? 2.price = 1~4, length >=180, category != Sci-Fi과Animation

SELECT title, description, category, length, price FROM film_list
WHERE price >=1 AND price <=4 AND length >= 180 AND category NOT IN ("Animation", "Sci-Fi");
-- 결과가 10개여야하는데 13개






