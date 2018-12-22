
/* SQL CHALLENGE LOCATED HERE: sqlzoo.net/wiki/SQL_Tutorial */



/* 0 SELECT basics */
    
    /* 1. Introducing the world table of countries */
SELECT population FROM world
    WHERE name = 'Germany';

    /* 2. Scandinavia */
SELECT name, population FROM world
    WHERE name IN ('Sweden', 'Norway', 'Denmark');

    /* 3. Just the right size */
SELECT name, area FROM world
    WHERE area BETWEEN 200000 AND 250000;



/* 1 SELECT from WORLD Tutorial */

    /* 1. Introduction */
SELECT name, continent, population FROM world;

    /* 2. Large Countries */
SELECT name FROM world
    WHERE (population / 1000000) >= 200;

    /* 3. Per Capita GDP */
SELECT name, gdp/population FROM world
    WHERE (population / 1000000) >= 200;

    /* 4. South America in Millions */
SELECT name, population / 1000000 FROM world
    WHERE continent = 'South America';

    /* 5. France, Germany, Italy */
SELECT name, population FROM world
    Where name = 'France' OR name = 'Germany' OR name = 'Italy';

    /* 6. United */
SELECT name, FROM world
    WHERE name LIKE "%United%";

    /* 7. Two ways to be big */
SELECT name, population, area FROM world
    WHERE (area / 1000000) > 3 OR (population / 1000000) > 250;
    
    /* 8. One or the other (but not both) */
SELECT name, population, area FROM world
    WHERE ((area / 1000000) > 3 AND (population / 1000000) < 250) OR ((area / 1000000) < 3 AND (population / 1000000) > 250);

    /* 9. Rounding */
SELECT name, ROUND(population / 1000000, 2), ROUND(gdp / 1000000000, 2)
FROM world
WHERE continent = 'South America';

    /* 10. Trillion dollar economies */
SELECT name, ROUND(gdp, population, -3) FROM WORLD
    WHERE gdp >= 1000000000000;

    /* 11. Name and capital have the same length */
SELECT name, capital FROM world
    WHERE LENGTH(name) = LENGTH(capital);

    /* 12. Matching name and capital */
SELECT name, capital FROM world
    WHERE LEFT(name, 1) = LEFT(capital, 1) AND name != capital;

    /* 13. All the vowels */
SELECT name FROM world
    WHERE name LIKE '%a%'
    AND name LIKE '%e%'
    AND name LIKE '%i%'
    AND name LIKE '%o%'
    AND name LIKE '%u%'
    AND name NOT LIKE '% %';



/* 2 SELECT from Nobel Tutorial */

    /* 1.  Winners from 1950 */
SELECT yr, subject, winner FROM nobel
    WHERE yr = 1950;

    /* 2. 1962 Literature */
SELECT winner FROM nobel
WHERE yr = 1962
    AND subject = 'Literature';

    /* 3. Albert Einstein */
SELECT yr, subject FROM nobel
    WHERE winner = 'Albert Einstein';

    /* 4. Recent Peace Prizes */
SELECT winner FROM nobel
    WHERE subject = 'Peace' AND yr >= 2000;

    /* 5. Literature in the 1980's */
SELECT yr, subject, winner FROM nobel
    WHERE subject = 'Literature' AND yr >= 1980 AND yr <= 1989;

    /* 6. Only Presidents */
SELECT * FROM nobel
    WHERE winner = 'Theodore Roosevelt'
    OR winner = 'Woodrow Wilson'
    OR winner = 'Jimmy Carter'
    OR winner = 'Barack Obama';

    /* 7. John */
SELECT winner FROM nobel
    WHERE winner LIKE 'John%';

    /* 8. Chemistry and Physics from different years */
SELECT yr, subject, winner FROM nobel
    WHERE (subject = 'Physics' AND yr = 1980)
    OR (subject = 'Chemistry' AND yr = 1984);

    /* 9. Exclude Chemists and Medics */
SELECT yr, subject, winner FROM nobel
    WHERE subject != 'Chemistry'
    AND subject != 'Medicine'
    AND yr = 1980;

    /* 10. Early Medicine, Late Literature */
SELECT yr, subject, winner FROM nobel
    WHERE (subject = 'Medicine' AND yr < 1910)
    OR (subject = 'Literature' AND yr >= 2004);

    /* 11. Umlaut */
SELECT * FROM nobel
    WHERE winner LIKE 'Peter Gr_nberg';

    /* 12. Apostrophe */
SELECT * FROM nobel
    WHERE winner LIKE 'Eugene O''Neill';

    /* 13. Knights of the realm */
SELECT winner, yr, subject FROM nobel
    WHERE winner LIKE 'Sir%';

    /* 14. Chemistry and Physics last */
SELECT winner, subject FROM nobel
    WHERE yr = 1984
    ORDER BY subject IN('Physics', 'Chemistry'), subject, winner;

/* 3. SELECT in SELECT */

    /* 1. Bigger than Russia */
SELECT name FROM world
    WHERE population > 
        (SELECT population FROM world
            WHERE name = 'Russia');

    /* 2. Richer than UK */
SELECT name FROM world
    WHERE gdp/population >
          (SELECT gdp/population FROM world
            WHERE name = 'United Kingdom') AND continent = 'Europe';

    /* 3. Neighbours of Argentina and Australia */
SELECT name, continent FROM world
    WHERE continent = 
       (SELECT continent FROM world
         WHERE name = 'Argentina') 
    OR continent = (SELECT continent FROM world
         WHERE name = 'Australia')
     ORDER BY name;

    /* 4. Between Canada and Poland */
SELECT name, population FROM world
    WHERE population > (SELECT population FROM world WHERE name = 'Canada')
    AND population < (SELECT population FROM world WHERE name = 'Poland');

    /* 5. Percentages of Germany */
SELECT name, CONCAT(ROUND(100 * population / (SELECT population
                                              FROM world
                                              WHERE name = 'Germany')), '%')
FROM world
WHERE continent = 'Europe';

    /* 6. Bigger than every country in Europe */
SELECT name FROM world
    WHERE continent != 'Europe' AND gdp > 
        ALL(SELECT gdp FROM world
            WHERE continent = 'Europe' AND gdp > 0);

    /* 7. Largest in each continent */
SELECT continent, name, area FROM world x
WHERE area >= ALL(SELECT area FROM world y
                  WHERE Y.continent = x.continent
                  AND area > 0);

    /* 8. First country of each continent (alphabetically) */
SELECT continent, name FROM world x
    WHERE name <= ALL(SELECT name FROM world y
    WHERE x.continent = y.continent);

    /* 9. Difficult Questions That Utilize Techniques Not Covered in Prior Sections */
SELECT name, continent, population FROM world
    WHERE continent NOT IN (SELECT DISTINCT continent FROM world
                            WHERE population > 25000000);

    /* 10. */
SELECT name, continent FROM world x
WHERE population > ALL(SELECT (population * 3) FROM world y
                      WHERE y.name != x.name AND y.continent = x.continent);

/* SUM and COUNT */

    /* Total world population */
SELECT SUM(population)
    FROM world;

    /* 2. List of continents */
SELECT DISTINCT continent
    FROM world;

    /* 3. GDP of Africa */
SELECT SUM(gdp) FROM world
    WHERE continent = 'Africa';

    /* 4. Count the big countries */
SELECT COUNT(name) FROM world
    WHERE area >= 1000000;

    /* 5. Baltic states population */
SELECT SUM(population) FROM world
    WHERE name IN('Estonia', 'Lativa', 'Lithuania');

    /* 6. Counting the countries of each continent */
SELECT continent, COUNT(name) FROM world
    GROUP BY continent;

    /* 7. Counting big countries in each continent */
SELECT continent, COUNT(name) FROM world
WHERE population >= 10000000
GROUP BY continent;

    /* 8. Counting big continents */
SELECT continent FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000;

/* The JOIN operation */

    /* 1. */
SELECT matchid, player FROM goal
    WHERE teamid = 'GER';

    /* 2. */
SELECT id, stadium, team1, team2
FROM game
WHERE game.id = 1012;

    /* 3. */
SELECT player, teamid, stadium, mdate
FROM game
JOIN goal ON game.id = goal.matchid
WHERE goal.teamid = 'GER';

    /* 4. */
SELECT team1, team2, player
FROM goal
JOIN game ON goal.matchid = game.id
WHERE player LIKE 'Mario%';

    /* 5. */
SELECT player, teamid, coach, gtime
FROM goal JOIN eteam on teamid=id
WHERE gtime <= 10;

    /* 6. */
SELECT mdate, teamname FROM game
JOIN eteam ON game.team1 = eteam.id
WHERE coach = 'Fernando Santos';

    /* 7. */
SELECT player FROM goal
JOIN game ON goal.matchid = game.id
WHERE stadium = 'National Stadium, Warsaw';

    /* 8. */
SELECT DISTINCT player
FROM game JOIN goal ON matchid = id
    WHERE(team1 = 'GER' OR team2 = 'GER') AND teamid != 'GER';

    /* 9. */
SELECT teamname, COUNT(*)
FROM eteam JOIN goal ON id = teamid
GROUP BY teamname;

    /* 10. */
SELECT stadium, COUNT(id)
FROM goal JOIN game ON matchid = id
GROUP BY stadium;

    /* 11. */
SELECT matchid, mdate, COUNT(teamid)
FROM game JOIN goal ON matchid = id
WHERE team1 = 'POL' OR team2 = 'POL'
GROUP BY matchid, mdate;

    /* 12. */
SELECT matchid, mdate, COUNT(teamid)
FROM game JOIN goal ON matchid = id
WHERE teamid = 'GER'
GROUP BY matchid, mdate;

/* More JOIN operations */

    /* 1. 1962 movies */
SELECT id, title
FROM movie
WHERE yr = 1962;

    /* 2.When was Citizen Kane released? */
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

    /* 3.Star Trek movies*/
SELECT id, title, yr
FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr DESC;

    /* 4. id for actor Glenn Close */
SELECT id
FROM actor
WHERE name = 'Glenn Close';

    /* 5. id for Casablanca */
SELECT id
FROM movie
WHERE title = 'Casablanca';

    /* 6. Cast list for Casablanca */
SELECT name
FROM actor
JOIN casting ON actor.id = casting.actorid
WHERE casting.movieid = '11768';

    /* 7. Alien cast list */
SELECT name
FROM actor
JOIN casting ON actor.id = casting.actorid
JOIN movie ON casting.movieid = movie.id
WHERE movie.title = 'Alien';

    /* 8. Harrison Ford movies */
SELECT title
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE actor.name = 'Harrison Ford';

   /* 9. Harrison Ford as a supporting actor */
SELECT title
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE actor.name = 'Harrison Ford' AND casting.ord > 1; 

   /* 10. Lead actors in 1962 movies */
SELECT movie.title, actor.name
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE casting.ord = 1 AND movie.yr = 1962;

    /* 11. Busy years for John Travolta */
SELECT yr, COUNT(title)
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE name = 'John Travolta'
GROUP BY yr
HAVING COUNT(title) = (SELECT MAX(c)
FROM SELECT yr, COUNT(title) AS c
FROM movie JOIN(casting ON movie.id = casting.movieid)
JOIN actor ON casting.actorid = actor.id
WHERE name = 'John Travolta'
GROUP BY yr) AS t
)

    /* 12. Lead actor in Julie Andrews movies */
SELECT title, name
FROM movie
JOIN casting ON casting.movieid = movie.id AND ord = 1
JOIN actor ON casting.actorid = actor.id
WHERE movie.id IN (SELECT movieid FROM casting
                   WHERE actorid IN (SELECT id
                                     FROM actor
                                     WHERE name = 'Julie Andrews'));

									 / * Using Null */

	/* 1. NULL, INNER JOIN, LEFT JOIN, RIGHT JOIN */
SELECT name
FROM teacher
WHERE dept IS NULL;

	/* 2. */
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)

	/* 3. */
SELECT teacher.name, dept.name
FROM teacher 
LEFT JOIN dept ON teacher.dept = dept.id;

	/* 4. */
SELECT teacher.name, dept.name
FROM teacher 
Right JOIN dept ON teacher.dept = dept.id;

	/* 5. */
SELECT teacher.name, COALESCE(teacher.mobile, '07986 444 2266')
FROM teacher;

	/* 6. */
SELECT teacher.name, COALESCE(dept.name, 'None')
FROM teacher
LEFT JOIN dept ON teacher.dept = dept.id

	/* 7. */
SELECT COUNT(teacher.name), COUNT(teacher.mobile)
FROM teacher;

	/* 8. */
SELECT dept.name, COUNT(teacher.name)
FROM teacher
RIGHT JOIN dept ON teacher.dept = dept.id
Group by dept.name;

	/* 9. */
SELECT teacher.name,
CASE WHEN teacher.dept = 1 OR teacher.dept = 2
THEN 'Sci'
ELSE 'Art'
END
FROM teacher;

	/* 10. */
SELECT teacher.name,
CASE WHEN teacher.dept = 1 OR teacher.dept = 2
THEN 'Sci'
WHEN teacher.dept = 3
THEN 'Art'
ELSE 'None'
END
FROM teacher;

/* Self join */

	/* 1. */
SELECT COUNT(*)
FROM stops;

	/* 2. */
SELECT id
FROM stops
WHERE name = 'Craiglockhart';

	/* 3. */
SELECT id, name
FROM stops
JOIN route ON id = stop
WHERE num = 4 AND company = 'LRT';

	/* 4. */
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) > 1;

	/* 5. */
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 and b.stop = 149;

	/* 6. */
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = 'London Road';