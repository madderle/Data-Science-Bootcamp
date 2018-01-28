/* IDs and durations for all trips of duration greater than 500, ordered by duration: */
SELECT
trips.trip_id
,trips.duration

from trips

WHERE trips.duration > 500

ORDER BY trips.duration desc

/*Every column of the stations table for station id 84 */
SELECT *
FROM stations

WHERE station_id=84

/* The min temperatures of all the occurrences of rain in zip 94301 */
SELECT MinTemperatureF

from weather

WHERE  zip = 94301 and Events = 'Rain'