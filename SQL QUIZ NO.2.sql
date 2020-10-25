#Quiz 1: 전체 몇개의 대륙이 있는지 출력하세요.
use world;
SELECT Continent, count(Continent)
FROM country
GROUP BY Continent;
-- 모르겠습니다.

#Quiz 2: 국가 코드별 도시의 갯수를 출력하세요. (상위 5개를 출력)
-- 1. 국가 코드별 2.도시갯수 3. 상위 5개
SELECT countryCode, count(countrycode) AS count
FROM city GROUP BY countrycode ORDER BY count DESC LIMIT 5;

#Quiz 3: 대륙별 몇개의 나라가 있는지 대륙별 나라의 갯수로 내림차순하여 출력하세요.
-- 1.대륙별 나라갯수 count 2. 그걸로 내림차순
SELECT continent, count(continent) AS count FROM country GROUP BY continent ORDER BY count DESC;

#Quiz 4: 대륙별 인구가 1000만명 이상인 나라의 수와 GNP의 표준편차를 출력하세요. (GNP 표준편차로 내림차순)
-- 1.대륙별 2.인구 1000만이상인 나라수 3. GNP의 표준편차 STDDEV(표준편차) 4. 그걸로 내림차순 
SELECT continent, count(continent), STDDEV(GNP) AS std_gnp -- 1000만이상도시의  GNP들이 GROUP BY 되었을떄의 표준 편차->STDDEV
FROM country 
WHERE population >=10000000
GROUP BY continent ORDER BY std_gnp DESC; 

#Quiz 5: City 테이블에서 국가코드(CountryCode) 별로 총인구가 몇명인지 조회하고 총인구 순으로 내림차순하세요. (총인구가 5천만 이상인 도시만 출력)
-- 1. city테이블 2.국가코드별로 총인구가 몇명인지 3.총인구순으로 내림차순
SELECT countrycode, SUM(population) AS population FROM city
GROUP BY countrycode ORDER BY population DESC;

#Quiz 5: 언어별 사용하는 국가수를 조회하고 많이 사용하는 언어를 6위에서 10위까지 조회하세요.
-- 1.언어별 사용하는 국가수 2.6~7위 출력
SELECT Language, count(language) AS count FROM countrylanguage
GROUP BY language
ORDER BY count DESC
LIMIT 5,5;

#Quiz 5: 언어별 15곳 이상의 국가에서 사용되는 언어를 조회하고, 언어별 국가수에 따라 내림차순하세요.
-- 1.언어별 15곳이상에서 사용되는 언어 2.언어별 국가수에 따라 내림차순
SELECT language, count(language) AS count FROM countrylanguage GROUP BY language
HAVING count>=15 ORDER BY count DESC;

#Quiz 6: 대륙별 전체 표면적크기를 구하고 표면적 크기 순으로 내림차순하세요.
-- 1. 대륙별 전체 표면적 2.표면적 크기순으로 내림차순
SELECT continent, SUM(SurfaceArea) AS SurfaceArea FROM country
GROUP BY continent ORDER BY SurfaceArea DESC; -- 소수점은 떻게 없앱니까





