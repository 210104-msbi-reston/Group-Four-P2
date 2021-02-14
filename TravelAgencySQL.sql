
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
	pk_city_country_id int PRIMARY KEY identity,
	country_name varchar(50) not null,
	country_code varchar(2) not null
)
--end create City_Countries table

--create Customer_Addresses table
create table Customer_Cities
(
	pk_customer_city_id int PRIMARY KEY identity,
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
	booking_date_string date not null,
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
	hotel_name varchar(255) not null,
	hotel_address varchar(255) not null,
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
	FOREIGN KEY (fk_booking_hotel_id) REFERENCES Hotels(pk_hotel_id),
	FOREIGN KEY (fk_booking_start_date_id) REFERENCES Booking_Dates(pk_booking_date_id),
	FOREIGN KEY (fk_booking_end_date_id) REFERENCES Booking_Dates(pk_booking_date_id),
	FOREIGN KEY (fk_booking_customer_id) REFERENCES Customers(pk_customer_id),
	FOREIGN KEY (fk_booking_method_id) REFERENCES Booking_Methods(pk_booking_method_id),
	FOREIGN KEY (fk_booking_payment_type_id) REFERENCES Payment_Types(pk_payment_type_id),
	FOREIGN KEY (fk_booking_room_type_id) REFERENCES Room_Types(pk_room_type_id),
)
--end create Bookings table

--truncate tables
delete from Cost_Per_Night
delete from Bookings

delete from Room_Types
delete from Booking_Methods
delete from Payment_Types

delete from Customers
delete from Customer_Cities
delete from City_Countries

delete from Booking_Dates
delete from Month_Quarters

delete from Hotels

--view all tables
select * from Room_Types
select * from Booking_Methods
select * from Payment_Types

select * from Customers
select * from Customer_Cities
select * from City_Countries

select * from Hotels

select * from Booking_Dates
select * from Month_Quarters

select count(*) from Bookings

select count(*) from Cost_Per_Night

select * from Cost_Per_Night


--insert dummy data
insert into Room_Types values (1,'Two Queen')
insert into Room_Types values (2,'King')
insert into Room_Types values (3,'Suite')

insert into Payment_Types values (1,'Credit')
insert into Payment_Types values (2,'Debit')
insert into Payment_Types values (3,'Bank Transfer')
insert into Payment_Types values (4,'Rewards Points')

insert into Booking_Methods values (1,'Online')
insert into Booking_Methods values (2,'Over Phone')
insert into Booking_Methods values (3,'On Site')

insert into City_Countries values (1,'country','CC')
insert into Customer_Cities values (1,'city','state',1)
insert into Customers values (1,'name','address',1,'gender',1,'account level',1)

insert into Month_Quarters values (1,1)
insert into Booking_Dates values (1,'1/1/1',1,1,1,1)

insert into Hotels values (1,'name','address',1)

insert into Cost_Per_Night values (1,1,1,1,1)

insert into Bookings values(1,1,1,1,1,1,1,1)


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


--remove procedure
if Object_id('proc_Generate_Cost_Per_Night') is not null
	drop procedure proc_Generate_Cost_Per_Night
go


--procedure to populate cost per night table
create procedure proc_Generate_Cost_Per_Night
as
begin
	
	declare @hotel int = 0
	declare @roomtype int = 0
	declare @month int = 0
	declare @baseCost float
	declare @roomRateCost float
	declare @finalCost float	

	--loop through each hotel (169)
	while(@hotel < (select count(pk_hotel_id) from Hotels))
	begin
	
		set @hotel = @hotel + 1

		--Set base cost per hotel with Random number 80-200
		set @baseCost = (select rand()*(200-50)+50)
		
		--loop through each room type (3)
		while(@roomtype < (select count(pk_room_type_id) from Room_Types))
		begin

			set @roomtype = @roomtype + 1

			--Multiply cost by room type rate

			set @roomRateCost = @baseCost + (@baseCost * (case @roomtype
				when 1 then 0.05
				when 2 then 0.015
				when 3 then 0.50
			end))

			--loop through each month (12)
			while(@month < (select count(pk_month_id) from Month_Quarters))
			begin
			
				set @month = @month + 1

				--Multiply cost by month rate
				set @finalCost = @roomRateCost + (@roomRateCost * (case @month
					when 1 then 0.07
					when 2 then 0.12
					when 3 then 0.12
					when 4 then 0.17
					when 5 then 0.22
					when 6 then 0.27
					when 7 then 0.32
					when 8 then 0.27
					when 9 then 0.17
					when 10 then 0.12
					when 11 then 0.07
					when 12 then 0.22
				end))

				insert into Cost_Per_Night values (@hotel,@roomtype,@month,@finalCost)
				set @finalCost = @roomRateCost

			end
			set @month = 0
			set @roomRateCost = @baseCost

		end
		set @roomtype = 0

	end
	
end
go

exec proc_Generate_Cost_Per_Night