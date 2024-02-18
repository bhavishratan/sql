create database cars;
use  cars;
-- Read Data-- 
select *from car_dekho;

-- Show the total number of enteries--
select count(*)from car_dekho; #7927

-- The manger ask the employee how many cars are available in 2023 --
select *from car_dekho;
select count(*) from car_dekho where year=2023; #6

-- how many cars are available in 2020,2021,2022--
select count(*) from car_dekho where year between 2020 and 2022; #88
select count(*) from car_dekho where year =2020; #77
select count(*) from car_dekho where year=2021; #7
select count(*) from car_dekho where year =2022; #7

-- group by--
select count(*) from car_dekho where year in (2020,2021,2022) group by year;

-- client ask me to print the total of all the cars by year --
select year,count(*)from car_dekho group by year;

-- average selling price of car--
select *from car_dekho;
select avg(selling_price)Avg_sp from car_dekho;

-- how many deisel car there in 2020--
select count(*)from car_dekho where fuel ='Diesel' and year=2020; #20

-- how many petrol cars will be there in 2020?--
select count(*) from car_dekho where fuel ='petrol'and year =2020; #51


-- all the fuel cars come by all year--
select year, count(*) from car_dekho where fuel='petrol' group by year;
select year, count(*) from car_dekho where fuel='Diesel' group by year;
select year, count(*) from car_dekho where fuel='cng' group by year;

-- which year has more than 100 of cars;--
select year,count(*)from car_dekho group by year having count(*)>100;
select year,count(*)from car_dekho group by year having count(*)<50;

-- all cars count details between 2015 and 2023--
select count(*)from car_dekho where year between 2015 and 2023;

-- all cars details between 2015 and 2023--
select *from car_dekho where year between 2015 and 2023;

-- End --