-- Q8
-- Query succeeded | 54s
-- Affected rows: 14
/* Output:
    day_of_week avg_flights1 ave_flights2
    Monday Chicago IL 2171.750000
    Monday Atlanta GA 2132.750000
    Tuesday Chicago IL 2400.750000
    Tuesday Atlanta GA 2334.500000
    Wednesday Chicago IL 2450.000000
    Wednesday Atlanta GA 2372.750000
    Thursday Chicago IL 2452.500000
    Thursday Atlanta GA 2348.250000
    Friday Chicago IL 2447.000000
    Friday Atlanta GA 2350.600000
    Saturday Chicago IL 2308.800000
    Saturday Atlanta GA 2286.000000
    Sunday Chicago IL 2320.000000
    Sunday Atlanta GA 2276.600000
*/
WITH AverageTable AS   
    (SELECT F1.weekday AS weekday, F1.dest_city as dest_city, AVG(F1.num_flights) as average
    FROM
        (SELECT F.day_of_week_id AS weekday, F.dest_city AS dest_city, 
            F.month_id AS curr_month, F.day_of_month AS curr_day, 1.0 * COUNT(*) AS num_flights
        FROM FLIGHTS AS F
        GROUP BY F.day_of_week_id, F.dest_city, F.month_id, F.day_of_month) AS F1
    GROUP BY F1.weekday, F1.dest_city)
SELECT W.day_of_week AS day_of_week, ATT.dest_city AS dest_city, ATT.average AS avg_flights
FROM    AverageTable AS ATT
        FULL OUTER JOIN
            (SELECT MAX1.weekday AS day_of_week, MAX1.first1 AS avg_flights1, MAX2.second2 AS avg_flights2
            FROM    (SELECT AT2.weekday AS weekday, MAX(AT2.average) AS first1
                    FROM AverageTable AS AT2
                    GROUP BY AT2.weekday) AS MAX1,
                    (SELECT AT1.weekday AS weekday, MAX(AT1.average) AS second2
                    FROM AverageTable AS AT1
                    WHERE AT1.average NOT IN
                        (SELECT MAX(average)
                        FROM AverageTable
                        GROUP BY weekday)
                    GROUP BY AT1.weekday) AS MAX2
            WHERE MAX1.weekday = MAX2.weekday) AS MAX12
        ON MAX12.day_of_week = ATT.weekday,
        WEEKDAYS AS W
WHERE W.did = ATT.weekday AND ATT.average >= MAX12.avg_flights2
ORDER BY W.did ASC, ATT.average DESC