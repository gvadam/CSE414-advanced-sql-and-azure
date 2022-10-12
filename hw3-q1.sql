-- #1
-- Affected rows: 1
-- Query succeeded | 122s
/* Output: 
	num_connected_cities
	2351
*/
WITH PAIRS AS (
	SELECT DISTINCT F1.origin_city, F1.dest_city
	FROM FLIGHTS AS F1
	WHERE F1.origin_city > F1.dest_city
		OR NOT EXISTS (
			SELECT * 
			FROM FLIGHTS AS F2 
			WHERE F2.origin_city = F1.dest_city AND F2.dest_city = F1.origin_city 
		)
)
SELECT COUNT(*) AS num_connected_cities
FROM PAIRS
