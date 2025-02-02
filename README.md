# Retail Sales Analysis Project
 This project has been developed to help you understand, clean, and analyze retail sales data using a variety of SQL techniques. It consists of creating a retail sales database, performing exploratory data analysis (EDA), and responding to business questions using SQL queries. This type of analysis is a useful skill to develop if you work in retail sales or in related business roles. The main objective of this project is to introduce you to the world of data analytics and help you improve your data analysis skills using SQL.

**Project Objectives:**
 1. Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
 2. Data Cleaning: Identify and remove any records with missing or null values.
 3. Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
 4. Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.

**Project Structure:**
 1. Database Setup
    * Database Creation: The project starts by creating a database named p1_retail_db.
    * Table Creation: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.
  
   ```SQL
   
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

```

   
 2.  Data Exploration & Cleaning
Record Count: Determine the total number of records in the dataset.
Customer Count: Find out how many unique customers are in the dataset.
Category Count: Identify all unique product categories in the dataset.
Null Value Check: Check for any null values in the dataset and delete records with missing data.


```SQL
select * from sales 
where transactions_id is null;

select * from sales 
where sale_date is null;

select * from sales 
where sale_time is null;

```


4. Data Analysis & Findings
The following SQL queries were developed to answer specific business questions:
 
 Q1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:

 ```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```


Q2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

```SQL
select
 category,
 sum(quantiy) from sales 
 where quantiy>2
 and
 category="Clothing"
 and
 date_format(sale_date," %Y-%M")= "2022-11"
 group by category ;
```
 Q3. WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM THE "BEAUTY" CATEGORY?

 ```SQL
 select round(avg(age),2) as average_age from sales where category ="Beauty";
```


Q4. Write a SQL query to retrieve all columns for sales made on '2022-11-05:

```SQL
select category, sum(total_sale) as net_sales ,
count(*) as total_orders 
from sales
 group by category;
```

Q5. Write a SQL query to calculate the total sales (total_sale) for each category.:

```SQL
select  category, gender ,count(*) as total_trans from sales group by  category , gender order by category;
```



Q6. Write a SQL query to find all transactions where the total_sale is greater than 1000.:
```SQL

select * from sales where total_sale>=1000;
```

Q7. Write a SQL query to calculate the average sale for each month. Find out the best selling month in each year:

```SQL
 select round(avg(age),2) as average_age from sales where category ="Beauty";
```

Q8. **Write a SQL query to find the top 5 customers based on the highest total sales**:

```SQL
select 
customer_id,
sum(total_sale) as total
 from sales
 group by customer_id
 order by total desc
 limit 5;
```

Q9. Write a SQL query to find the number of unique customers who purchased items from each category.:

```SQL
select 
 category ,
 count(distinct customer_id) as unique_customer
 from sales 
 group by category;
```

Q10. Write a SQL query to create each shift and the number of orders for each (Example: Morning <12, Afternoon Between 12 & 17, Evening >17):


  ```SQL
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
```
Q11. WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALES FOR EACH MONTH FIND THE BEST SELLING MONTH IN EACH YEAR?
 
 ```SQL
 select * from 
	 (select year(sale_date) as year,
	 month(sale_date) as month,
	 rank() over(partition by year(sale_date)) as sales_rank,
	 round(avg(total_sale),2) as avg_sales
	 from sales
	 group by year,month)
 as t1 where sales_rank=1
 order by year,avg_sales desc;
```

**Findings**:

Customer Demographics: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
High-Value Transactions: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
Sales Trends: Monthly analysis shows variations in sales, helping identify peak seasons.
Customer Insights: The analysis identifies the top-spending customers and the most popular product categories.


**Reports**:

Sales Summary: 
A detailed report summarizing total sales, customer demographics, and category performance.

Trend Analysis:
Insights into sales trends across different months and shifts.

Customer Insights:
Reports on top customers and unique customer counts per category.


**Conclusion**

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.



**How to Use**

Clone the Repository: Clone this project repository from GitHub.
Set Up the Database: Run the SQL scripts provided in the database_setup.sql file to create and populate the database.
Run the Queries: Use the SQL queries provided in the analysis_queries.sql file to perform your analysis.
Explore and Modify: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.
