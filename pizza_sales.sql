/*-- Thêm cột mới dạng DATE để lưu kết quả đã convert
ALTER TABLE dbo.data_sales 
ADD clean_order_date DATE,
    dayweek varchar(50),
	monthly int,
    daily int;

-- Cập nhật từ chuỗi định dạng dd-MM-yyyy
UPDATE dbo.data_sales
SET clean_order_date = TRY_CONVERT(DATE, order_date, 105),
    dayweek = DATENAME(WEEKDAY, TRY_CONVERT(DATE, order_date, 105)),
	monthly = datepart(month, clean_order_date),
	daily = datepart(day, clean_order_date);*/

--total price
select total_price = sum(total_price)
from dbo.data_sales

--average_ord
select avg_ord = sum(total_price)/count(distinct order_id)
from dbo.data_sales

--sum quantity
select total_quantity = sum(quantity)
from dbo.data_sales

--count order_id
select total_orderID = count(distinct order_id)
from dbo.data_sales

--quantity_per_order
select quantity_per_order = sum(quantity)/count(distinct order_id)
from dbo.data_sales

--total order - dayweek
select dayweek,
       total_orderID = count(distinct order_id)
from dbo.data_sales
group by dayweek

--total order - monthly
select monthly,
	   total_ord_monthly = count(distinct order_id)
from dbo.data_sales
group by monthly

--revenue - monthly
select monthly,
	   revenue_monthly = cast(sum(total_price) as decimal(10,2))
from dbo.data_sales
group by monthly

--% of Sales by Pizza Category
select pizza_category,
       total_price_category = cast(sum(total_price) as decimal (10,2)),
	   PC_of_category =cast((sum(total_price)/(select sum(total_price) from dbo.data_sales))*100 as decimal (10,2))
from dbo.data_sales
group by pizza_category

--% of Sales by Pizza Size
select pizza_size,
       total_price_category = cast(sum(total_price) as decimal (10,2)),
	   PC_of_size =cast((sum(total_price)/(select sum(total_price) from dbo.data_sales))*100 as decimal (10,2))
from dbo.data_sales
group by pizza_size

--Total Pizzas Sold by Pizza Category
select pizza_category,
       total_pizza_sold = count(quantity)
from dbo.data_sales 
group by pizza_category

--Top 5 Pizzas by Revenue
select top 5 
	   pizza_name,
       revenue = cast(sum(total_price) as decimal(10,2))
from dbo.data_sales
group by pizza_name
order by revenue desc

--Bottom 5 Pizzas by Revenue
select top 5 
	   pizza_name,
       revenue = cast(sum(total_price) as decimal(10,2))
from dbo.data_sales
group by pizza_name
order by revenue asc

--Top 5 Pizzas by Quantity
select top 5 
	   pizza_name,
       total_quantity = count(quantity)
from dbo.data_sales
group by pizza_name
order by total_quantity desc

--Bottom 5 Pizzas by Quantity
select top 5 
	   pizza_name,
       total_quantity = count(quantity)
from dbo.data_sales
group by pizza_name
order by total_quantity asc

-- Top 5 Pizzas by Total Orders
select top 5 
	   pizza_name,
       total_orders = count(distinct(order_id))
from dbo.data_sales
group by pizza_name
order by total_orders desc

--Borrom 5 Pizzas by Total Orders
select top 5 
	   pizza_name,
       total_orders = count(distinct(order_id))
from dbo.data_sales
group by pizza_name
order by total_orders asc
--

select * from dbo.data_sales
