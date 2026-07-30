SELECT *
FROM grocery_data;
select COUNT(*) AS total_transactions,
round(sum(final_amount),2) as total_revenue,
round(avg(final_amount),2) as avg_transaction,
round(sum(discount_amount)) as total_discounts
from grocery_data;
SELECT store_name,
ROUND(SUM(final_amount),2) as store_revenue,
count(*) AS transaction_count,
dense_rank() OVER(ORDER BY SUM(final_amount) desc) as store_rank
FROM grocery_data
GROUP BY store_name
ORDER BY store_revenue desc;
SELECT MONTH(transaction_date) as month,
COUNT(*) AS monthly_transactions,
ROUND(SUM(final_amount),2) as monthly_revenue,
ROUND(
		SUM(final_amount)-LAG(SUM(final_amount)) OVER (ORDER BY MONTH(transaction_date))
        ,2) as monthly_change
FROM grocery_data
GROUP BY MONTH(transaction_date)
ORDER BY month;
WITH CTE AS (SELECT aisle,
product_name,
SUM(quantity) as total_units,
ROUND(SUM(final_amount),2) as total_rev,
DENSE_RANK() OVER(PARTITION BY aisle Order by SUM(quantity) DESC) as category_rank
from grocery_data
GROUP BY aisle,product_name)
SELECT * 
from CTE 
where category_rank<=5
ORDER BY aisle,category_rank;
SELECT customer_id,
COUNT(*) AS purchase_freq,
ROUND(SUM(final_amount),2) as total_rev
from grocery_data
group by customer_id
order by total_rev desc;


