/*What's the most expensive listing? What else can you tell me about the listing? */

SELECT
  MAX(listings.price) as Price
  ,name
  ,neighbourhood
  ,property_type
  ,room_type
  ,accommodates
  ,bedrooms
  ,bathrooms
  ,minimum_nights
  ,maximum_nights

from listings

/*What neighborhoods seem to be the most popular? */
-- Define popular by listing count

SELECT
  neighbourhood
  ,COUNT(id) as Listing_Count

from listings
WHERE neighbourhood != ''
GROUP BY neighbourhood

ORDER BY Listing_Count desc
limit 10

/*What time of year is the cheapest time to go to your city? What about the busiest? */
-- Will do a group by Date week, and then count of listings and then average price.
-- May-June is cheapest time to come to city
--  May-June is also the busiest based on number of listings during that time.
SELECT
  calendar.date
  ,week(calendar.date) as Week_Number
  ,COUNT(calendar.listing_id) as Number_of_Listings
  ,AVG(calendar.price) as Average_Price

from calendar

GROUP BY week(calendar.date)