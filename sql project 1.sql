create database sales;
use sales;
create table sales (
transactions_id int primary key,
	sale_date date,
	sale_time time,
	customer_id int,
	gender varchar(10),
	age int,
	category varchar(12),
	quantiy int,
	price_per_unit int,
	cogs float,
	total_sale float);
  
  select * from sales
  limit 10;

select * from sales 
where transactions_id is null;

select * from sales 
where sale_date is null;

select * from sales 
where sale_time is null;


-- data cleaning


delete from sales;
select * from sales 
where transactions_id is null 
or 
sale_date is null
or 
sale_time is null
or
customer_id is null
or 
gender is null
or
age is null
or
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null 
or
total_sale is null;

-- data exploration.

-- How many sales we have?

select sum(total_sale) from sales;
select count(*) as total from sales;

-- how many customers?
select count(distinct customer_id) from sales;

-- how many category?
select count(distinct category) from sales;
select distinct category from sales;

-- DATA ANYLYSIS:

-- Q1 WRITE A SQL QUERY TO RETRIVW ALL DATA FROM SALES MADE ON 2022-03-12?

select sale_date ,count(quantiy)from sales group by sale_date;

select * from sales where sale_date= 2022-05-18;

-- Q2.WRITE A SQL QUERY TO RETRIVE ALL THE TRASACTIONS WHERE THE CATEGORY IS "CLOTHING" AND THE QUNATITY IS MORE THSN 10 IN MONTH OF NOV 2022--

select
 category,
 sum(quantiy) from sales 
 where quantiy>2
 and
 category="Clothing"
 and
 date_format(sale_date," %Y-%M")= "2022-11"
 group by category ;
 
 -- Q3 WRITE A SQL QUERY TO CALCULATE TOTAL SALES FOR EACH CATEGORY?
 
 select category, sum(total_sale) as net_sales ,
count(*) as total_orders 
from sales
 group by category;
 
 -- Q4  WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM THE "BEAUTY" CATEGORY?
 
 select round(avg(age),2) as average_age from sales where category ="Beauty";
 
 -- Q5 WRITE A SQL QUERY TO FIND ALL THE  THE TRANSACTIONS WHERE THE TOTAL SALE IS GREATER THAN 1000?
 
 select * from sales where total_sale>=2000;
 
 -- Q6 WRITE A SQL COMMANDE TO FIND THE TOTAL NUMBER OF TRANSACTION MADE BY EACH GENDER IN EACH CATEGORY?
 
 select  category, gender ,count(*) as total_trans from sales group by  category , gender order by category;
 
 -- Q7 WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALES FOR EACH MONTH FIND THE BEST SELLING MONTH IN EACH YEAR?
 
 
 select * from 
	 (select year(sale_date) as year,
	 month(sale_date) as month,
	 rank() over(partition by year(sale_date)) as sales_rank,
	 round(avg(total_sale),2) as avg_sales
	 from sales
	 group by year,month)
 as t1 where sales_rank=1
 order by year,avg_sales desc;
 
-- Q8 WRITE THE SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON HIGHEST TOTAL_SALES?

select 
customer_id,
sum(total_sale) as total
 from sales
 group by customer_id
 order by total desc
 limit 5;
 
 
 -- Q9 WRITE A SQL QUERY TO FIND THE NMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY?
 
 select 
 category ,
 count(distinct customer_id) as unique_customer
 from sales 
 group by category;
 
 -- Q10  WRITE A SQL QUERY TO CREATE EACH SHIFT  AND NUMBER OF ORDERS(EXAMPLE MORNING <=12,AFTERNOON BETWEEN 12 & 17)?
 
with hourly_sales
as
(
 select *,
 case
	when hour(sale_time)<12 then "morning"
    when hour(sale_time)>12 then "afternoon"
    else
    "evening"
 end as shift   
 from sales)
 select shift,count(*) as total_orders
 from hourly_sales
 group by shift;
 
 
 -- end of project
 
 
    
    
    