-- #5
-- Affected rows: 256
-- Query succeeded | 24s
/* Output:
    city
    Aberdeen SD
    Abilene TX
    Adak Island AK
    Aguadilla PR
    Akron OH
    Albany GA
    Albany NY
    Alexandria LA
    Allentown/Bethlehem/Easton PA
    Alpena MI
    Amarillo TX
    Appleton WI
    Arcata/Eureka CA
    Asheville NC
    Ashland WV
    Aspen CO
    Atlantic City NJ
    Augusta GA
    Bakersfield CA
    Bangor ME
*/
WITH direct AS (
    SELECT DISTINCT F.dest_city AS city
    FROM FLIGHTS AS F 
    WHERE F.origin_city = 'Seattle WA'
)
SELECT DISTINCT F.dest_city AS city 
FROM FLIGHTS AS F, direct AS D
WHERE D.city = F.origin_city AND F.dest_city != 'Seattle WA' 
    AND F.dest_city NOT IN (SELECT D.city FROM direct AS D)
ORDER BY F.dest_city
