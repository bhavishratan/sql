create database SalesWalmart;
use salesWalmart;
create table sales(Invoice_id varchar(40)Not null primary key,branch varchar(6)not null,city varchar(30)not null,customer_type varchar(30)not null,Gender varchar(6)not null,
product_line varchar(100)not null,Unit_price decimal(10,2)not null,quantity int not null,vat float(6,4) not null ,total decimal(12,4) not null,date datetime not null,time time not null,
payment_method varchar(40) not null, cogs decimal (10,2)not null,gross_margin_pct float (11,9)not null,gross_income decimal (12,4)not null,rating float(2,1)); 
select *from sales;

select count(*)from sales; #995

-- feature engineering   --

-- Time_of_day --

select time, case when time between '00:00:00' and '12:00:00' then 'Morning'
when time between '12:01:00' and '16:00:00' then 'Afternoon'
else 'Evening' end
as time_of_day from sales;

alter table sales add column time_of_day varchar(20);
alter table sales drop column time_of_day;

set sql_safe_updates=0;

update sales set time_of_day = (case when time between '00:00:00' and '12:00:00' then "Morning"
when time between '12:01:00'and '16:00:00' then "Afternoon"
else "Evening" end);

select *from sales;
select *from sales where time_of_day ='Morning';


 select *from sales where branch between 'A' and 'B';
 select time where time between '12:00:00' and '19:00:00';
 select time,count(*)from sales group by time;
 
 select *from sales where time between '00:00:00' and '12:00:00';

-- day name -- 

select date from sales;
select date ,DayName(date) from sales;

alter table sales add column day_name varchar(20);

update sales set day_name= dayname(date);
select *from sales; 


-- month -- 

select date,monthname(date) from sales;

alter table sales add column month_name varchar(10);

update sales set month_name = monthname(date);

select *from sales;

-- generic question -- 

-- How many unique cities does the data have?--

select distinct city from sales; 

-- In which city is each branch?-- 

select distinct city,branch from sales;

select distinct branch from sales;

-- Product-- 

-- How many unique product lines does the data have?-- 
select count(distinct product_line) from sales; #6

-- What is the most common payment method?--
select distinct payment_method from sales;

select payment_method,count(payment_method ) cnt from sales group by  payment_method order by cnt desc;


-- What is the most selling product line -- 
select product_line, count(product_line) pdl from sales group by product_line order by pdl desc;

-- What is the total revenue by month-- 
select month_name, sum(total) mnt from sales group by month_name order by mnt desc;

-- What month had the largest COGS?--
select month_name,sum(cogs) mng from sales group by month_name order by mng desc;

-- What product line had the largest revenue?--
select product_line,sum(total) largest_revenue from sales group by product_line order by largest_revenue desc;

-- What is the city with the largest revenue? --
select branch,city,sum(total) city_lrg_rev from sales group by city,branch order by city_lrg_rev;

-- What product line had the largest VAT?--
select  product_line,avg(vat) pdl_vat from sales group by product_line order by pdl_vat desc;

-- Which branch sold more products than average product sold?--
select branch,sum(quantity) qty from sales group by branch 
having sum(quantity)> (select avg(quantity) from sales); 

-- What is the most common product line by gender?--
select gender, product_line ,count(gender) total_gen from sales group by gender, product_line order by total_gen desc; 

-- What is the average rating of each product line? -- 
select product_line,round(avg(rating),2) avg_rat from sales group by product_line order by avg_rat desc;


-- sales ---


-- Number of sales made in each time of the day per weekday-- 
select time_of_day,count(*) total from sales where day_name ='monday' group by time_of_day order by total desc;

-- Which of the customer types brings the most revenue?-- 
select distinct customer_type from sales;

select customer_type, sum(total) rev from sales group by customer_type order by rev desc;


-- Which city has the largest tax percent/ VAT (Value Added Tax)?-- 
select city ,avg(vat) vat_1 from sales group by city order by vat_1 desc;

-- Which customer type pays the most in VAT?-- 
select customer_type, avg(vat) cs_vat from sales group by customer_type order by cs_vat desc; 

-------------------------------------------------------------------------------------------------------------------
-- 								Customer 																		 -- 

-- How many unique customer types does the data have?--
select distinct customer_type from sales;

-- How many unique payment methods does the data have?
select distinct payment_method from sales;

-- What is the most common customer type?--
select customer_type , count(*) cnt from sales group by customer_type order by cnt desc;

-- Which customer type buys the most?
select customer_type,count(*) from sales group by customer_type;

-- What is the gender of most of the customers? --
select gender ,count(customer_type) cst from sales group by gender order by cst ;

-- What is the gender distribution per branch?
select gender , count(*) gend from sales where branch='a' group by gender;
select gender , count(*) gend from sales where branch='b' group by gender;
select gender , count(*) gend from sales where branch='c' group by gender;


-- Which time of the day do customers give most ratings?
select time_of_day,avg(rating) rt from sales group by time_of_day order by rt desc;

-- Which time of the day do customers give most ratings per branch?
select time_of_day,avg(rating) rt from sales where branch='a' group by time_of_day order by rt desc;
select time_of_day,avg(rating) rt from sales where branch='b' group by time_of_day order by rt desc;
select time_of_day,avg(rating) rt from sales where branch='c' group by time_of_day order by rt desc;

-- Which day fo the week has the best avg ratings?
select day_name, avg(rating) rt from sales group by day_name order by rt desc;

-- Which day of the week has the best average ratings per branch?
select day_name, avg(rating) rt from sales where branch ='a' group by day_name order by rt desc;
select day_name, avg(rating) rt from sales where branch ='b' group by day_name order by rt desc;
select day_name, avg(rating) rt from sales where branch ='c' group by day_name order by rt desc;


-- Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". Good if its greater than 3

select product_line , case when avg(quantity)>3 then 'GOOD' else 'BAD' end from sales group by product_line;  


-- END ---