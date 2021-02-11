
--if database not created execute this
use master
if Object_id('TravelAgency') is not null
	drop database TravelAgency
go
create database TravelAgency
--end create database

use TravelAgency

--create City_Countries table
create table City_Countries
(
	pk_city_country_id int PRIMARY KEY,
	country_name varchar(50) not null,
	country_code char(2) not null,
	country_tax float
)
--end create City_Countries table

--create Customer_Addresses table
create table Customer_Cities
(
	pk_customer_city_id int PRIMARY KEY,
	city_name varchar(50) not null,
	city_state varchar(50),
	fk_city_country_id int not null,
	FOREIGN KEY (fk_city_country_id) REFERENCES City_Countries(pk_city_country_id)
)
--end create Customer_Addresses table

--create Customers table
create table Customers
(
	pk_customer_id int PRIMARY KEY,
	customer_name varchar(50) not null,
	customer_addesss varchar(50) not null,
	customer_age int,
	customer_gender varchar(20),
	customer_rewards_level int,
	customer_account_type varchar(20),
	fk_customer_city_id int not null,
	FOREIGN KEY (fk_customer_city_id) REFERENCES Customer_Cities(pk_customer_city_id)
)
--end create Customers table

--create Month_Quarters table
create table Month_Quarters
(
	pk_month_id int PRIMARY KEY,
	quarter_id int
)
--end create Month_Quarters table

--create Booking_Dates table
create table Booking_Dates
(
	pk_booking_date_id int PRIMARY KEY,
	booking_date_string varchar(50) not null,
	booking_day int not null,
	booking_week int not null,
	fk_booking_month int not null,
	booking_year int not null,
	FOREIGN KEY (fk_booking_month) REFERENCES Month_Quarters(pk_month_id)
)
--end create Booking_Dates table

--create Hotels table
create table Hotels
(
	pk_hotel_id int PRIMARY KEY,
	hotel_name varchar(50) not null,
	hotel_address varchar(50) not null,
	hotel_num_rooms int
)
--end create Hotels table

--create Room_Types table
create table Room_Types
(
	pk_room_type_id int PRIMARY KEY,
	room_type varchar(20) not null
)
--end create Payment_Types table


--create Hotels table
create table Cost_Per_Night
(
	pk_cost_id int Primary key,
	fk_hotel_id int,
	fk_room_type_id int,
	fk_booking_month int,
	cost_per_night float not null,
	FOREIGN KEY (fk_hotel_id) REFERENCES Hotels(pk_hotel_id),
	FOREIGN KEY (fk_room_type_id) REFERENCES Room_Types(pk_room_type_id),
	FOREIGN KEY (fk_booking_month) REFERENCES Month_Quarters(pk_month_id)
)
--end create Hotels table

--create Booking_Methods table
create table Booking_Methods
(
	pk_booking_method_id int PRIMARY KEY,
	booking_method varchar(20) not null
)
--end create Booking_Methods table

--create Payment_Types table
create table Payment_Types
(
	pk_payment_type_id int PRIMARY KEY,
	payment_type varchar(20) not null
)
--end create Payment_Types table

--create Bookings table
create table Bookings
(
	pk_booking_id int PRIMARY KEY,
	fk_booking_hotel_id int,
	fk_booking_start_date_id int,
	fk_booking_end_date_id int,
	fk_booking_customer_id int,
	fk_booking_method_id int,
	fk_booking_payment_type_id int,
	fk_booking_room_type_id int,
	booking_cost float,
	FOREIGN KEY (fk_booking_hotel_id) REFERENCES Hotels(pk_hotel_id),
	FOREIGN KEY (fk_booking_start_date_id) REFERENCES Booking_Dates(pk_booking_date_id),
	FOREIGN KEY (fk_booking_end_date_id) REFERENCES Booking_Dates(pk_booking_date_id),
	FOREIGN KEY (fk_booking_customer_id) REFERENCES Customers(pk_customer_id),
	FOREIGN KEY (fk_booking_method_id) REFERENCES Booking_Methods(pk_booking_method_id),
	FOREIGN KEY (fk_booking_payment_type_id) REFERENCES Payment_Types(pk_payment_type_id),
	FOREIGN KEY (fk_booking_room_type_id) REFERENCES Room_Types(pk_room_type_id),
)
--end create Bookings table

select * from Room_Types

insert into Room_Types values (1,'Two Queen')
insert into Room_Types values (2,'King')
insert into Room_Types values (3,'Suite')


if Object_id('Cost_Per_Night') is not null
	drop table Cost_Per_Night
go

if Object_id('Bookings') is not null
	drop table Bookings
go

if Object_id('Customers') is not null
	drop table Customers
go

if Object_id('Room_Types') is not null
	drop table Room_Types
go

if Object_id('Payment_Types') is not null
	drop table Payment_Types
go

if Object_id('Booking_Methods') is not null
	drop table Booking_Methods
go

if Object_id('Hotels') is not null
	drop table Hotels
go

if Object_id('Booking_Dates') is not null
	drop table Booking_Dates
go

if Object_id('Customer_Cities') is not null
	drop table Customer_Cities
go

if Object_id('City_Countries') is not null
	drop table City_Countries
go

if Object_id('Month_Quarters') is not null
	drop table Month_Quarters
go
