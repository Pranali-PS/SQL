create database walmart;
use walmart;
select * from sales;
select * from Products;
select * from inventory;

# 1 Retrieve the unique store names from the "Store" table
select distinct(storename)
from inventory;

# 2.Retrieve the total quantity available for each product:
select*from products,inventory,sales;

select productid ,sum(quantity) as quantity
from sales
group by productid;

# 3 Retrieve the product details along with the corresponding store information:

select p.productid,p.productname,p.supplier,i.storeid,i.storename,i.address
from products as p
inner join inventory as i
on p.productid = i.productid;

# 4 Retrieve the sales details including product and store information:

select p.productid,p.productname,p.supplier,p.productcost,
s.salesid,s.storeid,s.unitprice,s.quantity
from products as p
inner join sales as s on p.productid = s.productid
inner join inventory as i on p.productid = i.productid;




# 5.Find the total sales amount for each store:

select i.storename,i.storeid ,sum(s.unitprice * s.quantity)
 as Totalsales
from sales as s
inner join inventory as i
on s.storeid = i.storeid
group by i.storename,i.storeid;


# 6 Find the average product cost for each supplier
select productname,supplier,avg(productcost)
as average 
from products
group by supplier,productname;


# 7 Find the stores where the total sales amount is greater than a specified value:
select storeid,sum(unitprice * quantity) as totalsales
from sales
group by storeid
having totalsales > 20000;


#8  products based on their total sales quantity in descending order:

select p.productname,p.productid,
sum(unitprice * quantity) as Totalsales
from products as p
left join sales as s on p.productid = s.productid
group by p.productname,p.productid
order by totalsales desc;



# 9 Retrieve all combinations of products and stores, regardless of whether there are any sales for them. Include product and store details.

select*from products
cross join inventory;

# 10 Retrieve all sales records, including those without corresponding products. Display sales details, product information, and indicate whether the product is missing (NULL) using a CASE statement.


select s.salesid,s.storeid,s.productid,s.unitprice,s.quantity,
p.productname,p.supplier,p.productcost,
 case when p.productid is null then "missing"
else "found"
end as productstatus
from sales s
right join products as p on s.productid = p.productid;

# 11. Retrieve the sales details for products with a quantity sold greater than the average quantity sold. Include products that have never been sold. Display sales information and product details.

select s.salesid,s.unitprice,s.quantity, 
p.productid,p.productname,p.supplier,productcost
from products as p
left join sales as s on p.productid = s.productid
where s.quantity > (select avg(quantity)from sales);

# 12. Retrieve sales details for products sold after a specific date
select s.salesid,s.date,p.productid,p.productname,p.supplier,s.unitprice,s.quantity
from products as p
inner join sales as s 
on p.productid = s.productid
where s.date >'2022-02-02';


# 13.Calculate the total sales amount for each store, grouping by month
select i.storeid,i.storename,
year(s.date)as  salesyear ,month(s.date),
sum(s.unitprice*s.quantity) as totalsales
from inventory as i
left join sales as s
on s.storeid = i.storeid
group by storename,storeid,year(s.date),month(s.date);



 
