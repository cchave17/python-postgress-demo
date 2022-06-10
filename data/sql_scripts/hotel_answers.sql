USE hotelDB;

-- 1) list of reservations that end in July 2023, including 
-- the name of the guest, the room number(s), and the reservation dates.
select 
	g.name, 
	rm.room_number,
	r.start_date,
	r.end_date
from guest g
inner join reservation r on g.phone_number= r.guest_phone_number
inner join reservation_room rr on r.reservation_id=rr.reservation_id
inner join room rm on rm.room_number= rr.room_number
where end_date<20230801 and end_date>20230701;

-- 2) Write a query that returns a list of all reservations for rooms with a jacuzzi, 
-- displaying the guest's name, the room number, and the dates of the reservation.

select 
	g.name,
	rm.room_number,
	r.start_date,
	r.end_date
from Guest g
inner join reservation r on g.phone_number= r.guest_phone_number
inner join reservation_room rr on r.reservation_id=rr.reservation_id
inner join room rm on rm.room_number= rr.room_number
inner join room_amenities ra on ra.room_number= rm.room_number 
inner join amenities a on a.amenities_id = ra.amenities_id
where a.amenities_id=3;
    

-- 3) Write a query that returns all the rooms reserved for a specific guest, including the guest's name, the room(s) reserved,
-- the starting date of the reservation, and how many people were included in the reservation. 
-- (Choose a guest's name from the existing data.)

select 
	g.name, 
	rm.room_number,
	r.start_date,
--     r.adults,
--     r.children,
	r.adults+r.children AS `total Guests`
from guest g
inner join reservation r on g.phone_number= r.guest_phone_number
inner join reservation_room rr on r.reservation_id=rr.reservation_id
inner join room rm on rm.room_number= rr.room_number
where g.name = 'Carlos Chavez';


update Reservation set adults=3 where reservation_Id=2; 


-- 4) write a query that returns a list of rooms, reservation ID, and per-room cost for each reservation. 
-- The results should include all rooms, whether or not there is a reservation associated with the room.

select
	r.room_number,
    res.reservation_id,
    rr.total_cost
from room r
left join Reservation_Room rr on r.room_number=rr.room_number
left join Reservation res on rr.reservation_id=res.reservation_id;


-- 5) Write a query that returns all the rooms accommodating at 
-- least three guests and that are reserved on any date in April 2023.

select
	rr.room_number,
    r.adults,
    r.children,
    r.adults+r.children As total
    
from reservation_room rr
inner join reservation r on rr.reservation_id=r.reservation_id
where  start_date>20230401 and end_date<20230501 and r.adults+r.children>3;



-- 6) Write a query that returns a list of all guest names and the number of reservations per guest,
--  sorted starting with the guest with the most reservations and then by the guest's last name.

use hoteldb;
select 
g.name,
count(r.guest_phone_number) As amount_of_reservations
from reservation r
inner join guest g on r.guest_phone_number=g.phone_number;


-- 7) Write a query that displays the name, address, and phone number of a guest based on their phone number.
--  (Choose a phone number from the existing data.)

select 
	name,
    address,
    phone_number
    from guest
where phone_number=6125783728;