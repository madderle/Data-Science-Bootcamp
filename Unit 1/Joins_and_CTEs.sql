/* What are the three longest trips on rainy days? */

-- Setup rainy days query
WITH
  rainy
AS (
    SELECT Date
    from weather
    WHERE Events='Rain'
  )
-- Main Query
SELECT
  trip_id
  ,duration

fROM trips
JOIN rainy ON rainy.Date=date(trips.start_date)
GROUP BY trip_id
ORDER BY duration DESC
LIMIT 3

/*Which station is empty most often? */
SELECT
status.station_id
,stations.name
,COUNT(timestamp) as Seconds_Elapsed

from status
JOIN stations ON `status`.station_id=stations.station_id
WHERE bikes_available=0

GROUP BY status.station_id

ORDER BY Seconds_Elapsed DESC
LIMIT 1

/*Return a list of stations with a count of number of trips starting at that station but ordered by dock count */
SELECT
trips.start_station
,COUNT(trips.trip_id) as Trip_Count
,stations.dockcount
from trips
JOIN stations ON trips.start_station=stations.name

GROUP BY trips.start_station

ORDER BY stations.dockcount desc

/* (Challenge) What's the length of the longest trip for each day it rains anywhere? */

-- Setup rainy days query
WITH
  rainy
AS (
    SELECT Date
    from weather
    WHERE Events='Rain'
  )
-- Main Query
SELECT
  trips.start_date as `Date`
  ,MAX(duration) as `Longest_trip`

fROM trips
JOIN rainy ON rainy.Date=date(trips.start_date)
  -- Need to group by day
GROUP BY date(trips.start_date)
ORDER BY trips.start_date