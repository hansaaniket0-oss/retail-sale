CREATE DATABASE IF NOT EXISTS retail;
 use retail;
SELECT* FROM  grocery;

ALTER TABLE grocery RENAME COLUMN cust_id
 TO customer_id;

 SELECT COUNT(*) FROM grocery;
 
 # Headlines For KPIs (Total Revenue, Orders, Avg Basket, Total Discount)
 
 SELECT 
 ROUND(SUM(final_amount),2) AS Total_Revenue,
 COUNT(*) AS Total_Orders,
 ROUND(AVG(total_amount),2) AS Avg_Basket,
 ROUND(SUM(discount_amount),2) AS Total_Discount
 FROM grocery;
 
# Store Revenue & Ranking
SELECT
dense_rank() OVER(ORDER BY SUM(final_amount) desc) as Store_Rank,
Store_Name,
SUM(quantity) AS Units_Sold,
ROUND(SUM(final_amount),2) Total_Revenue
FROM grocery
GROUP by store_name
ORDER BY total_revenue desc;

# Top 10 Products By Revenue
SELECT
Product_Name,
SUM(quantity) AS Units_Sold,
ROUND(SUM(final_amount),2) Total_Revenue
FROM grocery
GROUP by product_name
ORDER BY Total_Revenue DESC
LIMIT 10;


# Revenue By Month
SELECT DATE_FORMAT( STR_TO_DATE(transaction_date,'%d-%m-%Y'),'%Y-%M') AS Sales_Month,
COUNT(*) AS Total_Orders,
ROUND(SUM(total_amount),2) AS Total_Revenue
FROM grocery
GROUP BY Sales_Month
ORDER BY Sales_Month;


# Revenue And Discount By Aisle
SELECT
Aisle,
COUNT(*) AS Total_Orders,
ROUND(SUM(final_amount),2) AS Total_Revenue,
ROUND(SUM(discount_amount),2) AS Total_Discount
FROM grocery
GROUP BY Aisle;


#Discount Impact Analysis
SELECT
(CASE
WHEN diScount_amount>0 THEN 'Discounted'
ELSE 'Not_discounted'
END) AS Order_Type,
COUNT(*) AS Total_Orders,
ROUND(AVG(final_amount), 2)   AS Avg_Order_Value,
ROUND(SUM(final_amount), 2)   AS Total_Revenue
FROM grocery
GROUP BY order_type;

#Customer Purchase Frequency & Revenue
SELECT Customer_Id,
COUNT(*) AS Purchase_Freq,
ROUND(SUM(final_amount),2) as Total_Rev
from grocery
group by customer_id
order by total_rev desc;







