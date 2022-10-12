-- Q4
-- Affected rows: 327
-- Query succeeded | 17s
/* Output:
    origin_city percentage
    Aberdeen SD 100.000000000000
    Abilene TX 100.000000000000
    Adak Island AK 88.235294117647
    Aguadilla PR 28.897338403041
    Akron OH 94.972067039106
    Albany GA 99.428571428571
    Albany NY 95.166666666666
    Albuquerque NM 90.593124291650
    Alexandria LA 99.551569506726
    Allentown/Bethlehem/Easton PA 98.969072164948
    Alpena MI 100.000000000000
    Amarillo TX 99.560632688927
    Anchorage AK 31.812080536912
    Appleton WI 99.367088607594
    Arcata/Eureka CA 99.558498896247
    Asheville NC 99.428571428571
    Ashland WV 100.000000000000
    Aspen CO 97.233201581027
    Atlanta GA 88.683685111237
    Atlantic City NJ 99.307159353348
*/
SELECT F1.origin_city AS origin_city,
    ISNULL((100.0 * F2.selected / F1.total), 0) AS percentage
FROM (SELECT origin_city AS origin_city, COUNT(*) AS total
    FROM FLIGHTS
    WHERE canceled = 0
    GROUP BY origin_city) AS F1
    LEFT OUTER JOIN
    (SELECT origin_city AS origin_city, COUNT(*) AS selected
    FROM FLIGHTS
    WHERE canceled = 0 AND actual_time < 180
    GROUP BY origin_city) AS F2
    ON F1.origin_city = F2.origin_city
ORDER BY F1.origin_city