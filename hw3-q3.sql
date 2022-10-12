-- #3
-- Affected rows: 109
-- Query succeeded | 9s
/* Output:
    city
    Aberdeen SD
    Abilene TX
    Alpena MI
    Ashland WV
    Augusta GA
    Barrow AK
    Beaumont/Port Arthur TX
    Bemidji MN
    Bethel AK
    Binghamton NY
    Brainerd MN
    Bristol/Johnson City/Kingsport TN
    Butte MT
    Carlsbad CA
    Casper WY
    Cedar City UT
    Chico CA
    College Station/Bryan TX
    Columbia MO
    Columbus GA
*/

SELECT F.origin_city AS city
FROM FLIGHTS AS F 
WHERE F.canceled = 0
GROUP BY F.origin_city
HAVING MAX(F.actual_time) < 180
ORDER BY F.origin_city
