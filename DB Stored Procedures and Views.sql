use TravelAgency

create view [Customer Addresses]
as
	select Customers.customer_name as [Name], Customers.customer_addesss as [Address], Customer_Cities.city_name as [City], Customer_Cities.city_state as [State], City_Countries.country_name as [Country]
		from Customers
		join Customer_Cities
		on Customers.fk_customer_city_id = Customer_Cities.pk_customer_city_id
		join City_Countries
		on Customer_Cities.fk_city_country_id = City_Countries.pk_city_country_id

create view [All Bookings]
as
	select Bookings.pk_booking_id as [Booking Number], Hotels.hotel_name as [Hotel], Room_Types.room_type as [Room Type], startDate.booking_date_string as [Start Date], endDate.booking_date_string as [End Date], Customers.customer_name as [Customer], Booking_Methods.booking_method as [Transaction Method], Payment_Types.payment_type as [Payment Type] 
		from Bookings
		join Hotels
		on Bookings.fk_booking_hotel_id = Hotels.pk_hotel_id
		join Room_Types
		on Bookings.fk_booking_room_type_id = Room_Types.pk_room_type_id
		join Booking_Dates startDate
		on Bookings.fk_booking_start_date_id = startDate.pk_booking_date_id
		join Booking_Dates endDate
		on Bookings.fk_booking_end_date_id = endDate.pk_booking_date_id
		join Customers
		on Bookings.fk_booking_customer_id = Customers.pk_customer_id
		join Booking_Methods
		on Bookings.fk_booking_method_id = Booking_Methods.pk_booking_method_id
		join Payment_Types
		on Bookings.fk_booking_payment_type_id = Payment_Types.pk_payment_type_id

select * from [All Bookings]