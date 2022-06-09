-- 
drop database if exists HotelDB;

create database HotelDB;

use HotelDB;

create table Guest(
	phone_number varchar(10) primary key ,
    `name` varchar(50) not null,
    address varchar(100) not null,
    State varchar(2) not null,
    city varchar(50) not null,
    zip_code varchar(5) not null
);

-- create table Guest_Reservation(
-- phone_number varchar(10),
-- reservation_id int,
-- primary key (phone_number,reservation_id)
-- );

create table Reservation(
	reservation_id int primary key auto_increment,
    guest_phone_number varchar(10),
    start_date DATE not null,
    end_date DATE not null,
    adults int not null,
    children int
);

create table Reservation_Room(
	reservation_id int,
    room_number int,
    total_cost Decimal(6,2),
    primary key (reservation_id,room_number)
);



create table Room(
	room_number int primary key,
    type_id int not null,
    standard_cap int not null,
    max_cap int not null,
    -- Wheelchair accessable ('Yes', 'No'). Could be set as a Boolean
    ADA varchar(3) not null
);

create table `Type`(
	type_id int primary key not null,
    TypeName varchar(20) not null,
    BasePrice Decimal(5,2) not null,
    AdditionalCostPerAdult Decimal(4,2)
);

create table Amenities(
AmenitiesiD int primary key auto_increment,
`name` varchar(20) not null,
AdditionalCost decimal (4,2)
); 

create table Room_Amenities(
room_number int,
AmenitiesiD int,
primary key (room_number, AmenitiesiD)
);
    
--     alter table Guest_Reservation
-- 		add constraint foreign key (phone_number) references Guest(phone_number),
--         add constraint foreign key (reservation_id) references Reservation(reservation_id);

	alter table Reservation
		add constraint foreign key (guest_phone_number) references Guest(phone_number);
        
	alter table Reservation_Room
		add constraint foreign key (reservation_id)references Reservation(reservation_id),
        add constraint foreign key(room_number) references Room(room_number);
        
	alter table Room
		add constraint foreign key (type_id) references `type`(type_id);
        
	alter table Room_Amenities
		add constraint foreign key(AmenitiesiD) references Amenities(AmenitiesiD),
        add constraint foreign key(room_number) references Room(room_number);
			
 
insert into guest (phone_number, `Name`, address, state, city, zip_code) values
	('6127327432', 'Carlos instructor', '39 5th ave S', 'MN', 'Minneapolis', '55269'), 
    ('2915530508', 'Mack Simmer', '379 Old Shore Street', 'iA', 'Council Bluffs', '51501'),
    ('4782779632', 'Bettyann Seery', '750 Wintergreen Dr', 'AK', 'Wasilla', '99654'),    					
    ('3084940198', 'Duane Cullison', '9662 Foxrun Lane', 'TX', 'Harlingen', '78552'),
    ('2147300298', 'Karie Yang', '	9378 W. West Deptford', 'NJ', 'Hopkins', '08096'),
    ('3775070974', 'Aurore Lipton', '762 Wild Rose Street', 'Mi', 'Saginaw', '48601'),
    ('8144852615', 'Zachery Luechtefeld', '7 Poplar Dr.', 'CO', 'Arvada', '80003'),
    ('2794910960', 'Jeremiah Pendergrass', '70 Oakwood St.', 'iL', 'Zion', '60099'),
    ('4463966785', 'Walter Holaway', '7556 Arrowhead St.', 'Ri', 'Cumberland', '02864'),
    ('8347271001', 'Wilfred Vise', '77 West Surrey Street', 'NY', 'Oswego', '13126'),
	('4463516860', 'Maritza Tilton', '939 Linda Rd', 'VA', 'Burke', '22015'),
    ('2318932755', 'Joleen Tison', '87 Queen St.', 'PA', 'Hopkins', '19026');

insert into Amenities (amenitiesiD, `name`, additionalCost) values
	('1', 'Microwave', null),
    ('2', 'Refrigerator',null),
    ('3', 'Jacuzzi', '25.00'),
    ('4','Oven',null);
    
insert into `Type`(type_id, TypeName, BasePrice, AdditionalCostPerAdult) values
	('1','Single', '149.99', null),
    ('2','Double', '179.99', '10.00'),
	('3','suite', '399.99', '20.00');

insert into Room(room_number, type_id, standard_cap, max_cap, ADA) values
	('201', 2, '2','4','No'), 
    ('202', 2, '2','4','Yes'),
    ('203', 2, '2','4','No'),
    ('204', 2, '2','4','Yes'),
    ('205', 1, '2','2','No'),
    ('206', 1, '2','2','Yes'),
    ('207', 1, '2','2','No'),
    ('208', 1, '2','2','Yes'),
    ('301', 2, '2','4','No'),
	('302', 2, '2','4','Yes'),
    ('303', 2, '2','4','No'),
    ('304', 2, '2','4','Yes'),
    ('305', 1, '2','2','No'),
    ('306', 1, '2','2','Yes'),
    ('307', 1, '2','2','No'),
    ('308', 1, '2','2','Yes'),
    ('401', 3, '3','8','Yes'),
    ('402', 3, '3','8','Yes');

    
insert into reservation(reservation_id,guest_phone_number,start_date,end_date,adults,children) values
	('1',2915530508, '20230202', '20230204', '1','0'),
    ('2',4782779632, '20230205', '20230210', '2	','1'),
    ('3',3084940198, '20230222', '20230224', '2','0'),
    ('4',2147300298, '20230306', '20230307', '2','2'),
    ('5',6125783728, '20230317', '20230320', '1','1'),
    ('6',3775070974, '20230318', '20230323', '3','0'),
    ('7',8144852615, '20230323', '20230331', '2','2'),
    ('8',2794910960, '20230331', '20230405', '2','0'),
    ('9',4463966785, '20230409', '20230413', '1','0'),
    ('10',8347271001, '20230423', '20230424', '1','1'),
    ('11',4463516860, '20230530', '20230602', '2','4'),
    ('12',2318932755, '20230610', '20230614', '2','0'),
    ('13',2318932755, '20230610', '20230614', '1','0'),
    ('14',3775070974, '20230617', '20230618', '3','0'),
    ('15',6125783728, '20230628', '20230702', '2','0'),
    ('16',4463966785, '20230713', '20230714', '3','1'),
    ('17',8347271001, '20230718', '20230721', '4','2'),
    ('18',4782779632, '20230728', '20230729', '2','1'),
    ('19',4782779632, '20230830', '20230901', '1','0'),
    ('20',2915530508, '20230916', '20230917', '2','0'),
    ('21',2147300298, '20230913', '20230915', '2','2'),
    ('22',3084940198, '20231122', '20231125', '2','2'),
    ('23',2915530508, '20231122', '20231125', '2','0'),
    ('24',2915530508, '20231122', '20231125', '2','2'),
    ('25',4463516860, '20231224', '20231228', '1','0');
    

insert into Reservation_Room(reservation_id, room_number, total_cost) values
	(1, 308, '299.98'),
	(2, 203, '999.95'),
    (3, 305, '349.98'),
    (4, 201, '199.99'),
    (5, 307, '524.97'),
    (6, 302, '924.95'),
    (7, 202, '349.98'),
    (8, 304, '874.95'),
    (9, 301, '799.96'),
    (10, 207, '174.99'),
    (11, 401, '1199.97'),
    (12, 206, '599.96'),-- same Guest Reservations.... fix
    (12, 208, '599.96'),-- same Guest Reservations.... fix
    (14, 304, '184.99'),
    (15, 205, '699.96'),
    (16, 204, '184.99'),
    (17, 401, '1259.97'),
	(18, 303, '199.99'),
    (19, 305, '349.98'),
    (20, 208, '149.99'),
    (21, 203, '399.98'),
    (22, 401, '1199.97'),
    (23, 206, '449.97'),
    (24, 301, '599.97'),
    (25, 302, '699.96');
    
    
insert into Room_Amenities (room_number, AmenitiesiD) values
	(201,1),
    (201,3),
    (202,2),
    (203,1),
    (203,3),
    (204,2),
    (205,1),
    (205,2),
	(205,3),
	(206,1),
    (206,2),
	(207,1),
    (207,2),
	(207,3),
    (208,1),
    (208,2),
    (301,1),
    (301,3),
    (302,2),
    (303,1),
    (303,3),
    (304,2),
    (305,1),
    (305,2),
    (305,3),
    (306,1),
    (306,2),
    (307,1),
    (307,2),
    (307,3),
    (308,1),
    (308,2),
    (401,1),
    (401,2),
    (401,4),
	(402,1),
	(402,2),
	(402,4);

    