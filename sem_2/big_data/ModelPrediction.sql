select *
from
  ml.predict(model `chicago_taxi_trips.linear_reg`, (
  select     
    trip_miles as distance,
    longitude,
    latitude,
    drop_long,
    drop_lat,  
    trip_seconds,
    taxi_fare,
  from 
    (
    select 
      row_number() over (order by trip_start_timestamp),
      trip_miles,
  pickup_longitude as longitude,
  pickup_latitude as latitude,
  dropoff_longitude as drop_long,
  dropoff_latitude as drop_lat,
  trip_start_timestamp,
  trip_seconds,
  (fare) as taxi_fare
    from
      `bigquery-public-data.chicago_taxi_trips.taxi_trips`
    )
  where
    taxi_fare > 0 and 
    trip_miles > 0 and
    trip_seconds > 0 and    
    latitude is not null and 
    longitude is not null and
    drop_lat is not null and
    drop_long is not null and 
    WHERE  trip_start_timestamp BETWEEN '2020-01-01 00:00:00' AND '2020-05-01 00:00:00'
));
