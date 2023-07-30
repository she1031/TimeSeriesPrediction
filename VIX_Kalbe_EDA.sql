
--Berapa rata-rata umur customer jika dilihat dari marital statusnya?

select distinct "Marital Status", avg(age)
from customer
where "Marital Status" != ''
group by 1;

--Berapa rata-rata umur customer jika dilihat dari gender nya ?

select gender, AVG(age)
from customer
group by 1;

--Tentukan nama store dengan total quantity terbanyak!

with MaxQtyStores as (
  select
    st.storename,
    sum(tr.qty) as total_qty,
    rank() over (order by sum(tr.qty) desc) as rnk
  from "transaction" as tr
  left join store as st on st.storeid = tr.storeid
  group by st.storename
)
select storename, total_qty
from MaxQtyStores
where rnk = 1;

--OR

select st.storename, sum(tr.qty) as total_qty
from store as st
join "transaction" as tr
on st.storeid = tr.storeid
group by st.storename
order by total_qty desc
limit 1

--Tentukan nama produk terlaris dengan total amount terbanyak!

with MaxAmtProduct as (
  select
    pr."Product Name",
    sum(tr.totalamount) as total_amount,
    rank() over (order by sum(tr.totalamount) desc) as rnk
  from "transaction" as tr
  left join product as pr on pr.productid = tr.productid
  left join store as st on st.storeid = tr.storeid
  group by pr."Product Name"
)
select "Product Name", total_amount
from MaxAmtProduct
where rnk = 1;


--Jumlah qty dari bulan ke bulan
select
    substring("Date", 4, 2) as month,
    sum(qty) as total_qty
from
    transaction
group by
    substring("Date", 4, 2)
order by substring("Date", 4, 2);





