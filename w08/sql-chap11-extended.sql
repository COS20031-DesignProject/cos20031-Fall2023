-- Complex queries
-- Find all countries with life-expectancies and populations higher than their averages in the same region. Sort the result by region, life-expectancy and population (ASC).

-- (version 1) Find all countries with life-expectancies and populations higher than their averages.

SELECT name, region, lifeexpectancy, population from country
where lifeexpectancy >= (select avg(lifeexpectancy) from country)
and population >= (select avg(population) from country)
order by population, lifeexpectancy;

-- (version 2) Find all countries with life-expectancies and populations higher than their averages in the same region.

-- view 1: regionAvgLifeExpectancy
CREATE VIEW regionAvgLifeExpectancy AS
  SELECT region, avg(lifeexpectancy) as avg_life
  from country
  group by region
  order by region, avg_life;
SELECT * from regionAvgLifeExpectancy order by avg_life;

-- test regionAvgLifeExpectancy
SELECT name, region, lifeexpectancy, avg_life
from country as t1
join regionAvgLifeExpectancy as t2
  on t1.region = t2.region
where lifeexpectancy >= avg_life
order by t1.region, lifeexpectancy;

-- view 2 (similar but for population): regionAvgPopulation
CREATE VIEW regionAvgPopulation AS
  SELECT region, avg(population) as avg_pop
  from country
  group by region
  order by region, avg_pop;
  SELECT * from regionAvgPopulation order by avg_pop;

-- the query...
SELECT name, region, lifeexpectancy, population, avg_life, avg_pop
from country as t1
join regionAvgLifeExpectancy as t2
  on t1.region = t2.region
join regionAvgPopulation as t3
  on t1.region = t3.region
where lifeexpectancy >= avg_life
and population >= avg_pop
order by t1.region, lifeexpectancy, population;

