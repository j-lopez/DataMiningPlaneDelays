
SQL QUERIES
Queries denoted by number in front to determine which question they refer to

-- preprocessing --
UPDATE f 
SET DESTINATION_AIRPORT = l.Code
FROM flights f INNER JOIN number_airport_codes n ON f.DESTINATION_AIRPORT = n.Code INNER JOIN letter_airport_codes l ON n.[Description] = l.[Description]
WHERE ISNUMERIC(f.DESTINATION_AIRPORT) = 1

-- 1. Total amount of flights per airline  -- 
SELECT AIRLINE, COUNT(dbo.flights.AIRLINE)
FROM dbo.flights
GROUP BY dbo.flights.AIRLINE order by dbo.flights.AIRLINE 

-- 1. Total amount of cancelled flights per airline  -- 
SELECT AIRLINE, COUNT(dbo.flights.CANCELLED) 
FROM dbo.flights
WHERE CANCELLED = 1 
GROUP BY dbo.flights.AIRLINE order by dbo.flights.AIRLINE 

-- 1. Total amount of delayed flights per airline -- 
SELECT AIRLINE, COUNT(dbo.flights.DEPARTURE_DELAY) 
FROM dbo.flights
WHERE DEPARTURE_DELAY > 15 AND DEPARTURE_TIME != '' AND ARRIVAL_TIME != ''
GROUP BY dbo.flights.AIRLINE order by dbo.flights.AIRLINE 
 
-- 2. Example of cancellations per years with a specific airline code --
SELECT [MONTH], COUNT(dbo.flights.CANCELLED)
FROM dbo.flights
WHERE AIRLINE = 'HA' AND CANCELLED = 1
GROUP BY dbo.flights.[MONTH] order by dbo.flights.[MONTH]

-- 2. Example of delays per years with a specific airline code --
SELECT [MONTH], COUNT(dbo.flights.DEPARTURE_DELAY)
FROM dbo.flights
WHERE AIRLINE = 'VX' AND DEPARTURE_DELAY > 15 AND DEPARTURE_TIME != '' AND ARRIVAL_TIME != ''
GROUP BY dbo.flights.[MONTH] order by dbo.flights.[MONTH]

-- 3. Total amount of flights cancelled due to weather –
SELECT AIRLINE, COUNT(dbo.flights.CANCELLED)
FROM dbo.flights
WHERE CANCELLED = 1 AND CANCELLATION_REASON = 'B'
GROUP BY dbo.flights.AIRLINE order by dbo.flights.AIRLINE

-- 3. Total amount of flights delayed due to weather
SELECT AIRLINE, COUNT(dbo.flights.DEPARTURE_DELAY)
FROM dbo.flights
WHERE DEPARTURE_DELAY > 15 AND DEPARTURE_TIME != '' AND ARRIVAL_TIME != '' AND WEATHER_DELAY > 0
GROUP BY dbo.flights.AIRLINE order by dbo.flights.AIRLINE

-- 4. Cancellations by airport -- 
SELECT ORIGIN_AIRPORT, COUNT(dbo.flights.CANCELLED)
FROM dbo.flights
WHERE CANCELLED = 1
GROUP BY ORIGIN_AIRPORT order by COUNT(dbo.flights.ORIGIN_AIRPORT) desc

-- 4. Cancellations by longitude, one example shown -- 
SELECT COUNT(dbo.flights.CANCELLED)
FROM dbo.flights, dbo.airports as air
WHERE CANCELLED = 1 AND ORIGIN_AIRPORT = air.IATA_CODE AND LONGITUDE > -180.0 AND LONGITUDE < -110.0

-- 4. Delays by longitude, one example shown -- 
SELECT COUNT(dbo.flights.CANCELLED)
FROM dbo.flights, dbo.airports as air
WHERE DEPARTURE_DELAY > 15 AND ORIGIN_AIRPORT = air.IATA_CODE AND LONGITUDE > -180.0 AND LONGITUDE < -110.0

-- 4. Total number of flights per longitude, one example shown -- 
SELECT COUNT(dbo.airports.AIRPORT)
FROM dbo.airports 
WHERE LONGITUDE > -180.0 AND LONGITUDE < -110.0

-- 5. Amount of flights cancelled per distance group -- 
SELECT COUNT(dbo.flights.AIRLINE)
  FROM [FlightDatabase_HW].[dbo].[flights] 
  WHERE CANCELLED = 1 AND dbo.flights.long > 0 AND LONGITUDE <= 300.0
  
-- 5. Amount of flights cancelled per distance group -- 
SELECT COUNT(dbo.flights.CANCELLED)
  FROM [FlightDatabase_HW].[dbo].[flights] 
  WHERE CANCELLED = 1 AND DISTANCE > 0 AND DISTANCE <= 300.0

-- 5. Amount of flights per distance group -- 
SELECT COUNT(dbo.flights.AIRLINE)
  FROM [FlightDatabase_HW].[dbo].[flights] 
  WHERE DISTANCE > 0 AND DISTANCE <= 300.0
  
-- 6. Most popular cancellation reason -- 
SELECT CANCELLATION_REASON, COUNT(dbo.flights.CANCELLED)
FROM dbo.flights
WHERE CANCELLED = 1 AND CANCELLATION_REASON != ''
GROUP BY dbo.flights.CANCELLATION_REASON order by dbo.flights.CANCELLATION_REASON

-- 6. Cancellation reason broken down by month, one example shown -- 
SELECT [MONTH], COUNT(dbo.flights.CANCELLED)
FROM dbo.flights
WHERE CANCELLED = 1 AND CANCELLATION_REASON = 'C'
GROUP BY dbo.flights.[MONTH] order by dbo.flights.[MONTH] 


