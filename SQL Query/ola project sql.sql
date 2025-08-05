-- create Table --

CREATE TABLE ride_bookings (
    booking_date DATE,
    booking_time TIME,
    booking_id VARCHAR,
    booking_status VARCHAR,
    customer_id VARCHAR,
    vehicle_type VARCHAR,
    pickup_location VARCHAR,
    drop_location VARCHAR,
    v_tat INTERVAL,  -- Turnaround Time
    c_tat INTERVAL, -- Turnaround Time
    canceled_rides_by_customer INT,
    canceled_rides_by_driver INT,
    incomplete_rides INT,
    incomplete_ride_reason TEXT,
    booking_value NUMERIC,
    payment_method VARCHAR,
    ride_distance NUMERIC,
    driver_ratings NUMERIC,
    customer_rating NUMERIC
);

-- Import table --

COPY ride_bookings
FROM 'C:\Users\Asus\OneDrive\Desktop\bookings.csv'
DELIMITER ','
CSV HEADER;

drop table ride_bookings;

CREATE TABLE ride_bookings (
    date TIMESTAMP,
    time TIME,
    booking_id VARCHAR,
    booking_status VARCHAR,
    customer_id VARCHAR,
    vehicle_type VARCHAR,
    pickup_location VARCHAR,
    drop_location VARCHAR,
    v_tat FLOAT,
    c_tat FLOAT,
    canceled_rides_by_customer VARCHAR,
    canceled_rides_by_driver VARCHAR,
    incomplete_rides VARCHAR,
    incomplete_rides_reason TEXT,
    booking_value INTEGER,
    payment_method VARCHAR,
    ride_distance INTEGER,
    driver_ratings FLOAT,
    customer_rating FLOAT
);


COPY ride_bookings 
FROM 'C:\Users\Asus\OneDrive\Desktop\Bookings.csv' 
DELIMITER ',' 
CSV HEADER;

COPY ride_bookings FROM 'C:\Users\Asus\OneDrive\Desktop\Bookings.csv' 
DELIMITER ',' CSV HEADER;

-- 1. Retrieve all successful bookings --

create view success_booking as
SELECT * FROM ride_bookings WHERE Booking_Status = 'Success';

select * from success_booking;

ALTER TABLE ride_bookings RENAME TO bookings;

-- 2.Find the average ride distance for each vehicle type --
 SELECT Vehicle_Type, AVG(Ride_Distance) as avg_distance FROM bookings GROUP BY
 Vehicle_Type;

-- 3. Get the total number of cancelled rides by customers --
SELECT COUNT(*) FROM bookings WHERE Booking_Status = 'Canceled by Customer';

select * from bookings;

-- 4. List the top 5 customers who booked the highest number of rides--
 SELECT Customer_ID, COUNT(Booking_ID) as total_rides FROM bookings GROUP BY
 Customer_ID ORDER BY total_rides DESC LIMIT 5;

-- 5.Get the number of rides cancelled by drivers due to personal and car-related issues --
SELECT COUNT(*) FROM bookings WHERE canceled_Rides_by_Driver = 'Personal & Car related issue';

-- 6.Find the maximum and minimum driver ratings for Prime Sedan bookings --
SELECT MAX(Driver_Ratings) as max_rating, MIN(Driver_Ratings) as min_rating FROM bookings WHERE Vehicle_Type = 'Prime Sedan';

-- 7. Retrieve all rides where payment was made using UPI --
SELECT * FROM bookings WHERE Payment_Method = 'UPI';

-- 8.  Find the average customer rating per vehicle type --
SELECT Vehicle_Type, AVG(Customer_Rating) as avg_customer_rating FROM bookings GROUP BY Vehicle_Type; 

-- 9.  Calculate the total booking value of rides completed successfully --
SELECT SUM(Booking_Value) as total_successful_value FROM bookings WHERE Booking_Status = 'Success';

-- 10. List all incomplete rides along with the reason --
SELECT Booking_ID, Incomplete_Rides_Reason FROM bookings WHERE Incomplete_Rides ='Yes';



