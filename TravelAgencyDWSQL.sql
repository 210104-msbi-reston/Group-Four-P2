--if database not created execute this
use master
if Object_id('TravelAgencyDW') is not null
	drop database TravelAgencyDW
go
create database TravelAgencyDW

use TravelAgencyDW


--truncate tables
delete from factBookings
delete from dimCustomer
delete from dimBookingMethod
delete from dimDate
delete from dimHotel
delete from dimPaymentTypes
delete from dimRoomTypes
delete from dimBookingMethod

--query all tables
select * from dimCustomer
select * from dimBookingMethod
select * from dimDate
select * from dimHotel
select * from dimPaymentTypes
select * from dimRoomTypes
select * from dimBookingMethod
select count(*) from [factBookings]
select * from factBookings order by factBookingId desc

select * from dimCustomer order by custId desc

select * from dimCustomer where [custId] = 14104

--create [dimBookingMethod] table
CREATE TABLE [dbo].[dimBookingMethod](
	[bookingMethodId] [int] primary key,
	[bookingMethodType] [varchar](255) NULL
)
--end create [dimBookingMethod] table

--create [dimCustomer] table
CREATE TABLE [dbo].[dimCustomer](
	[custId] [int] primary key,
	[custName] [varchar](255) NULL,
	[custAddress] [varchar](255) NULL,
	[custCity] [varchar](255) NULL,
	[custState] [varchar](255) NULL,
	[custCountry] [varchar](255) NULL,
	[custCountryCode] [varchar](255) NULL,
	[custAge] [int] NULL,
	[custGender] [varchar](255) NULL,
	[custRewardMemberLevel] [int] NULL,
	[custAccountType] [varchar](50) NULL
)
--end create [dimCustomer] table

--create [dimDate] table
CREATE TABLE [dbo].[dimDate](
	[dateId] [int] primary key,
	[date] [varchar](50) NULL,
	[dateYear] [int] NULL,
	[dateMonth] [int] NULL,
	[dateWeek] [int] NULL,
	[dateDay] [int] NULL,
	[dateQuarter] [int] NULL
) 
--end create [dimDate] table

--create [dimHotel] table
CREATE TABLE [dbo].[dimHotel](
	[id] [int] primary key,
	[hotelName] [varchar](255) NULL,
	[hotelAddress] [varchar](255) NULL,
	[hotelNumRooms] [int] NULL
)
--end create [dimHotel] table

--create [dimPaymentTypes] table
CREATE TABLE [dbo].[dimPaymentTypes](
	[paymentTypeId] [int] primary key,
	[paymentType] [varchar](255) NULL
) 
--end create [dimPaymentTypes] table

--create [dimRoomTypes] table
CREATE TABLE [dbo].[dimRoomTypes](
	[roomTypeId] [int] primary key,
	[roomType] [varchar](255) NULL
)
--end create [dimRoomTypes] table

--create [factBookings] table
CREATE TABLE [factBookings] (
    [factBookingId] int,
    [hotelId] int,
    [startDateId] int,
    [endDateId] int,
    [custId] int,
    bookingMethodId int,
    [paymentTypeId] int,
    [roomTypeId] int,
    [cost] int,
    FOREIGN KEY ( [hotelId]) REFERENCES dimHotel([Id]),
    FOREIGN KEY ([startDateId]) REFERENCES dimDate([dateId]),
    FOREIGN KEY ([endDateId]) REFERENCES dimDate([dateId]),
    FOREIGN KEY ( [custId]) REFERENCES dimCustomer([custId]),
    FOREIGN KEY ([bookingMethodId]) REFERENCES dimBookingMethod([bookingMethodId]),
    FOREIGN KEY ( [paymentTypeId]) REFERENCES dimPaymentTypes( [paymentTypeId]),
    FOREIGN KEY ( [roomTypeId] ) REFERENCES dimRoomTypes( [roomTypeId] )
)
--end create [factBookings] table


--delete all tables
if Object_id('[factBookings]') is not null
	drop table [factBookings]
go
if Object_id('[dimBookingMethod]') is not null
	drop table [dimBookingMethod]
go
if Object_id('[dimCustomer]') is not null
	drop table [dimCustomer]
go
if Object_id('[dimDate]') is not null
	drop table [dimDate]
go
if Object_id('[dimHotel]') is not null
	drop table [dimHotel]
go
if Object_id('[dimPaymentTypes]') is not null
	drop table [dimPaymentTypes]
go
if Object_id('[dimRoomTypes]') is not null
	drop table [dimRoomTypes]
go