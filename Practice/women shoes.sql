--create database shoes
--go

drop table Shoe_model
create table Shoe_model (
	id int primary key,
	name nvarchar(50),
	season nvarchar(50)
)

drop table Shoe
create table Shoe (
	id int primary key identity,
	price float,
	shoe_model int foreign key references Shoe_model(id)
)

create table Presentation_shop (
	id int primary key,
	name nvarchar(50),
	city nvarchar(50)
)

create table Presentation_shop_Shoe_bridge (
	shop int foreign key references Presentation_shop(id),
	shoe int foreign key references Shoe(id),
	amount int,
	primary key(shop, shoe)
)

create table Woman (
	id int primary key,
	name nvarchar(50),
	max_amount float
)

drop table Woman_Shoe_bridge 
create table Woman_Shoe_bridge (
	woman int foreign key references Woman(id),
	shoe int foreign key references Shoe(id),
	pairs int,
	spent float,
	primary key(woman, shoe)
)
go

create or alter procedure add_shoe 
@shoe int, @shop int, @amount int
as
	insert into Presentation_shop_Shoe_bridge values
		(@shop, @shoe, @amount)
go

create or alter view women_bought_more_than_2
as
	select *
	from Woman
	where id in (
		select woman
		from Woman_Shoe_bridge
		inner join Shoe on Woman_Shoe_bridge.shoe = Shoe.id
		where pairs >= 2 and Shoe.shoe_model = 'dinala'
		group by woman
	)
go


create or alter function shoes_in_N_shops (@T int)
returns @Shoes_in_N_shops table (id int, price float, shoe_model int) 
as
begin
	if @T < 1
		return

	insert into @Shoes_in_N_shops
	select *
	from Shoe
	where @T <= (
		select count(*)
		from Presentation_shop_Shoe_bridge
		where Shoe.id = Presentation_shop_Shoe_bridge.shoe
	)
	return
end
go

select *
from shoes_in_N_shops (2)
