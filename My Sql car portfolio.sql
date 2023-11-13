create database cars;
use cars;
# Read Data
select * from car_dekho;
# total cars : to get a count of total records
select count(*) from car_dekho;

# The manager aksed the emp how many cars will avilable in 2023
select count(*) from car_dekho 
where year = 2023;

# The manager aksed the emp how many cars will avilable in other year
select count(*) 
from car_dekho
where year in  (2020,2021,2022)
group by year;

#client asked me to print total of all cars by year i do not see the details 
select year, count(*)
from car_dekho
group by year;

#client aksed to car dealer agent how many disel cars willbe in 2020
select count(*) from car_dekho
where year =2020 and fuel = "diesel";

# client requested to car dealer agent how many petrol cars will be there in 2020
select count(*)from car_dekho
where year = 2020 and fuel = "Petrol";

# The manager told me employee  to give a print all the fuel cars (petrol,diseal,and CNG)COME BY ALL YEAR
select year,count(*)from car_dekho where fuel = "Petrol" group by year;
select year,count(*)from car_dekho where fuel = "Diseal" group by year;
select year,count(*)from car_dekho where fuel = "CNG" group by year;


  
# manager said there were more than 100 cars in given year which year has more than 100 cars 

select year ,count(*)
from car_dekho
group by year having count(*)>100;

select year ,count(*)
from car_dekho
group by year having count(*)<50;


# the manager said to the emp  all cars count detials betwwen 2015 and 2023we need  a complete list 
  
select *
from car_dekho
where year between 2015 and 2023;