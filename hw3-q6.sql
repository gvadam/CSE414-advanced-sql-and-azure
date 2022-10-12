-- #6
-- Affected rows: 4
-- Query succeeded | 80s
/* Output:
    city
    Devils Lake ND
    Hattiesburg/Laurel MS
    Seattle WA
    St. Augustine FL
*/
WITH direct AS (
    SELECT DISTINCT F.dest_city AS city
    FROM FLIGHTS AS F 
    WHERE F.origin_city = 'Seattle WA'
    ),
    oneStop AS (
    SELECT DISTINCT F.dest_city AS city 
    FROM FLIGHTS AS F, direct AS D
    WHERE D.city = F.origin_city AND F.dest_city != 'Seattle WA' 
    AND F.dest_city NOT IN (SELECT D.city FROM direct AS D)
    )
SELECT DISTINCT F.dest_city AS city
FROM FLIGHTS AS F, oneStop AS O
WHERE F.dest_city NOT IN (SELECT O.city FROM oneStop AS O) 
    AND F.dest_city NOT IN (SELECT D.city FROM direct AS D)
ORDER BY F.dest_city
