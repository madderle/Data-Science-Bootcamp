/*What was the hottest day in our data set? Where was that?What was the hottest day in our data set? Where was that? */
SELECT MAX(MaxTemperatureF) as Hottest_Temp
  ,ZIP
,Date

from weather

/*How many trips started at each station? */

SELECT COUNT(trip_id) as Num_Trips
,start_station

from trips
GROUP BY start_station

/* Whats the shortest trip that happened? */
SELECT trip_id
,MIN(duration) as Shortest_Trip

from trips

/* What is the average trip duration, by end station */

SELECT AVG(duration) as Avg_Duration
, end_station

from trips
GROUP BY end_station