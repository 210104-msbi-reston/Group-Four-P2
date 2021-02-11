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
select * from [factBookings]

--create [dimBookingMethod] table
CREATE TABLE [dbo].[dimBookingMethod](
	[Copy of bookingMethodId] [int] primary key,
	[Copy of bookingMethodType] [varchar](255) NULL
)
--end create [dimBookingMethod] table

--create [dimCustomer] table
CREATE TABLE [dbo].[dimCustomer](
	[Copy of custId] [int] primary key,
	[Copy of custName] [varchar](255) NULL,
	[Copy of custAddress] [varchar](255) NULL,
	[Copy of custCity] [varchar](255) NULL,
	[Copy of custState] [varchar](255) NULL,
	[Copy of custCountry] [varchar](255) NULL,
	[Copy of custCountryCode] [varchar](255) NULL,
	[Copy of custAge] [int] NULL,
	[Copy of custGender] [varchar](255) NULL,
	[Copy of custRewardMemberLevel] [int] NULL,
	[Copy of custAccountType] [varchar](50) NULL
)
--end create [dimCustomer] table

--create [dimDate] table
CREATE TABLE [dbo].[dimDate](
	[Copy of dateId] [int] primary key,
	[Copy of date] [varchar](50) NULL,
	[Copy of dateYear] [int] NULL,
	[Copy of dateMonth] [int] NULL,
	[Copy of dateWeek] [int] NULL,
	[Copy of dateDay] [int] NULL,
	[Copy of dateQuarter] [int] NULL
) 
--end create [dimDate] table

--create [dimHotel] table
CREATE TABLE [dbo].[dimHotel](
	[Copy of id] [int] primary key,
	[Copy of hotelName] [varchar](255) NULL,
	[Copy of hotelAddress] [varchar](255) NULL,
	[Copy of hotelNumRooms] [int] NULL
)
--end create [dimHotel] table

--create [dimPaymentTypes] table
CREATE TABLE [dbo].[dimPaymentTypes](
	[Copy of paymentTypeId] [int] primary key,
	[Copy of paymentType] [varchar](255) NULL
) 
--end create [dimPaymentTypes] table

--create [dimRoomTypes] table
CREATE TABLE [dbo].[dimRoomTypes](
	[Copy of roomTypeId] [int] primary key,
	[Copy of roomType] [varchar](255) NULL
)
--end create [dimRoomTypes] table

--create [factBookings] table
CREATE TABLE [factBookings] (
    [Copy of factBookingId] int,
    [Copy of hotelId] int,
    [Copy of startDateId] int,
    [Copy of endDateId] int,
    [Copy of custId] int,
    [Copy of bookingMethodId] int,
    [Copy of paymentTypeId] int,
    [Copy of roomTypeId] int,
    [Copy of cost] int,
    FOREIGN KEY ( [Copy of hotelId]) REFERENCES dimHotel([Copy of Id]),
    FOREIGN KEY ([Copy of startDateId]) REFERENCES dimDate([Copy of dateId]),
    FOREIGN KEY ([Copy of endDateId]) REFERENCES dimDate([Copy of dateId]),
    FOREIGN KEY ( [Copy of custId]) REFERENCES dimCustomer([Copy of custId]),
    FOREIGN KEY ([Copy of bookingMethodId]) REFERENCES dimBookingMethod([Copy of bookingMethodId]),
    FOREIGN KEY ( [Copy of paymentTypeId]) REFERENCES dimPaymentTypes( [Copy of paymentTypeId]),
    FOREIGN KEY ( [Copy of roomTypeId] ) REFERENCES dimRoomTypes( [Copy of roomTypeId] )
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