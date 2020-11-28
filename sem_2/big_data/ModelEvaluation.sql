WITH eval_table AS (
  SELECT  
    trip_miles as distance,
    pickup_longitude as longitude,
    pickup_latitude as latitude,
    dropoff_longitude as drop_long,
    dropoff_latitude as drop_lat,
    trip_start_timestamp,
    trip_seconds,
  IFNULL(fare, 0) AS taxi_fare
 FROM  `bigquery-public-data.chicago_taxi_trips.taxi_trips`
 WHERE  trip_start_timestamp BETWEEN '2017-01-01 00:00:00' AND '2019-01-01 00:00:00'
      AND pickup_latitude IS NOT NULL      
      AND pickup_longitude IS NOT NULL 
      AND dropoff_longitude IS NOT NULL
      AND dropoff_latitude IS NOT NULL
      AND trip_seconds < 10800 )# Trip timing less than 3 hours
 SELECT
 *
FROM
 ML.EVALUATE(MODEL `chicago_taxi_trips.linear_reg`,
   TABLE eval_table)
