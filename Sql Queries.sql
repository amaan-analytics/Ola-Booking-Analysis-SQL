Drop Table If Exists  Bookings ;

CREATE TABLE Bookings (
    Date DATE,
    Time TIME,
    Booking_ID VARCHAR(20) PRIMARY KEY,
    Booking_Status VARCHAR(50),
    Customer_ID VARCHAR(20),
    Vehicle_Type VARCHAR(50),
    Pickup_Location VARCHAR(100),
    Drop_Location VARCHAR(100),
    V_TAT NUMERIC(10,2),
    C_TAT NUMERIC(10,2),
    Canceled_Rides_by_Customer TEXT,
    Canceled_Rides_by_Driver TEXT,
    Incomplete_Rides VARCHAR(10),
    Incomplete_Rides_Reason TEXT,
    Booking_Value NUMERIC(10,2),
    Payment_Method VARCHAR(50),
    Ride_Distance NUMERIC(6,2),
    Driver_Ratings DECIMAL(2,1),
    Customer_Rating DECIMAL(2,1) );

COPY Bookings(
    Date, Time, Booking_ID, Booking_Status, Customer_ID, Vehicle_Type,
    Pickup_Location, Drop_Location, V_TAT, C_TAT, Canceled_Rides_by_Customer,
    Canceled_Rides_by_Driver, Incomplete_Rides, Incomplete_Rides_Reason,
    Booking_Value, Payment_Method, Ride_Distance, Driver_Ratings, Customer_Rating
)
FROM 'C:/Users/hp/Desktop/Bookings.csv'   
DELIMITER ',' 
CSV HEADER;

select * from bookings;

--1. Retrieve all successful bookings:
Create View Successful_bookings AS
Select * from Bookings 
where booking_status = 'Success';

--2. Find the average ride distance for each vehicle type:
Create View Avg_Ride_Distance AS
select vehicle_type, round(avg(ride_distance),3)
from bookings
group by vehicle_type;

--3. Get the total number of cancelled rides by customers:
Create View cancelled_rides_by_customers AS
select count(booking_status)
from bookings
where booking_status ='Canceled by Customer';


--4. List the top 5 customers who booked the highest number of rides:
Create View highest_number_of_rides AS
select customer_id, count(booking_id) as Ride_booked
from bookings
Group by customer_id
Order by count(booking_id) DESC
Limit 5;

--5. Get the number of rides cancelled by drivers due to personal and car-related issues:
Create View rides_cancelled_by_drivers AS
select count(canceled_rides_by_driver)
from bookings
where canceled_rides_by_driver = 'Personal & Car related issue';


--6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
Create View maximum_and_minimum_driver_ratings AS
select  vehicle_type, max(driver_ratings), min(driver_ratings)
from bookings
Group by vehicle_type
Having vehicle_type = 'Prime Sedan';

--7. Retrieve all rides where payment was made using UPI:
Create View UPI_Payment AS
select * 
from bookings
where payment_method = 'UPI';


--8. Find the average customer rating per vehicle type:
Create View Avg_Customer_Rating AS
select vehicle_type, Round(avg(customer_rating),2) as Avg_Rating
from bookings
group by vehicle_type
Order by Avg_Rating DESC;


--9. Calculate the total booking value of rides completed successfully:
Create View  total_booking_value AS
Select sum(booking_value) as Booking_value
from bookings
where booking_status= 'Success';

--10. List all incomplete rides along with the reason:
Create View  incomplete_rides AS
select Booking_ID, incomplete_rides_reason
from bookings
Where incomplete_rides = 'Yes';



