-- #7
-- Affected rows: 4
-- Query succeeded | 4s
/* Output:
    name
    Alaska Airlines Inc.
    SkyWest Airlines Inc.
    United Air Lines Inc.
    Virgin America
*/
SELECT C.name
FROM CARRIERS AS C, FLIGHTS AS F 
WHERE F.carrier_id = C.cid
    AND F.origin_city = 'Seattle WA' AND F.dest_city = 'San Francisco CA'
GROUP BY C.cid, C.name
ORDER BY C.name 