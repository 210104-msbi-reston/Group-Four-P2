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

create procedure proc_newCustomer(@p_custId int, @p_custName varchar(50), @p_custAddress varchar(50), @p_custAge int, @p_custGender varchar(20), @p_custRewards int, @p_custAcct varchar(20), @p_custCity varchar(50), @p_custState varchar(50), @p_custCountry varchar(50))
as
begin
	declare @cityId int
	set @cityId = (select Customer_Cities.pk_customer_city_id 
	from Customer_Cities
	join City_Countries
	on Customer_Cities.fk_city_country_id = City_Countries.pk_city_country_id
	where Customer_Cities.city_name = @p_custCity and City_Countries.country_name = @p_custCountry)
	if @cityId is null
	begin
		insert into City_Countries values(@p_custCountry, '')
		insert into Customer_Cities values(@p_custCity, @p_custState, SCOPE_IDENTITY())
		select @cityId = SCOPE_IDENTITY()
	end
	insert into Customers values(@p_custId, @p_custName, @p_custAddress, @p_custAge, @p_custGender, @p_custRewards, @p_custAcct, @cityId)
end

create procedure proc_newBooking(@p_bookingId int, @p_hotId int, @p_stDateId int, @p_eDateId int, @p_custId int, @p_methodId int, @p_payId int, @p_roomId int)
as
begin
	insert into Bookings values(@p_bookingId, @p_hotId, @p_stDateId, @p_eDateId, @p_custId, @p_methodId, @p_payId, @p_roomId)
end

create procedure proc_newHotel(@p_hotId int, @p_hotName varchar(255), @p_hotAddress varchar(255), @p_hotNumRooms int)
as
begin
	insert into Hotels values(@p_hotId, @p_hotName, @p_hotAddress, @p_hotNumRooms)
end