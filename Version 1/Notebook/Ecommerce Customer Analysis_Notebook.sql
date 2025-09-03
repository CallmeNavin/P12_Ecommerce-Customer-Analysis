-- I. Data Understanding: Column Name, Type
SELECT 
  column_name
  , data_type
from information_schema.columns
WHERE table_schema = 'kisaraf01'
AND table_name = 'ecommerce_customer_data_large';
-- II. Overview: Total Rows, Time Range
SELECT 
  COUNT(*) as Total_Rows
  , MIN(purchase_date)
  , MAX(purchase_date)
from kisaraf01.ecommerce_customer_data_large;
-- III. Data Quality Check
--- %Blank/null
SELECT 
  SUM(Case When customer_id IS NULL then 1 Else 0 End)*100/COUNT(*) as pct_customer_id
  , SUM(Case When purchase_date IS NULL then 1 Else 0 End)*100/COUNT(*) as pct_purchase_date
  , SUM(Case When product_category IS NULL or product_category = '' then 1 Else 0 End)*100/COUNT(*) as pct_product_category
  , SUM(Case When product_price IS NULL then 1 Else 0 End)*100/COUNT(*) as pct_product_price
  , SUM(Case When quantity IS NULL then 1 Else 0 End)*100/COUNT(*) as pct_quantity
  , SUM(Case When total_purchase_amount IS NULL then 1 Else 0 End)*100/COUNT(*) as pct_total_purchase_amount
  , SUM(Case When payment_method IS NULL or payment_method = '' then 1 Else 0 End)*100/COUNT(*) as pct_payment_method
  , SUM(Case When customer_age IS NULL then 1 Else 0 End)*100/COUNT(*) as pct_customer_age
  , SUM(Case When returns IS NULL then 1 Else 0 End)*100/COUNT(*) as pct_returns
  , SUM(Case When customer_name IS NULL or customer_name = '' then 1 Else 0 End)*100/COUNT(*) as pct_customer_name
  , SUM(Case When age IS NULL then 1 Else 0 End)*100/COUNT(*) as pct_age
  , SUM(Case When gender IS NULL or gender = '' then 1 Else 0 End)*100/COUNT(*) as pct_gender
  , SUM(Case When churn IS NULL then 1 Else 0 End)*100/COUNT(*) as pct_churn
from kisaraf01.ecommerce_customer_data_large;
--- % Zero value
SELECT
  SUM(Case When customer_id = 0 then 1 Else 0 End)*100/COUNT(*) as pct_customer_id
  , SUM(Case When product_price = 0 then 1 Else 0 End)*100/COUNT(*) as pct_product_price
  , SUM(Case When quantity = 0 then 1 Else 0 End)*100/COUNT(*) as pct_quantity
  , SUM(Case When total_purchase_amount = 0 then 1 Else 0 End)*100/COUNT(*) as pct_total_purchase_amount
  , SUM(Case When customer_age = 0 then 1 Else 0 End)*100/COUNT(*) as pct_customer_age
  , SUM(Case When age = 0 then 1 Else 0 End)*100/COUNT(*) as pct_age
from kisaraf01.ecommerce_customer_data_large;
--- Outliers
SELECT 
  Min(customer_id) as min_customer_id
  , Max(customer_id) as max_customer_id
  , Min(product_price) as min_product_price
  , Max(product_price) as max_product_price
  , Min(quantity) as min_quantity
  , Max(quantity) as max_quantity
  , Min(total_purchase_amount) as min_total_purchase_amount
  , Max(total_purchase_amount) as max_total_purchase_amount
  , Min(customer_age) as min_customer_age
  , Max(customer_age) as max_customer_age
  , Min(age) as min_age
  , Max(age) as max_age
from kisaraf01.ecommerce_customer_data_large;
-- IV. Basic KPI
SELECT 
  COUNT(*) as Total_Orders
  , SUM(total_purchase_amount) as Total_Revenue
  , AVG(total_purchase_amount) as AOV
from kisaraf01.ecommerce_customer_data_large;
-- V. Breakdown
--- 5.1. By Category
SELECT 
  product_category
  , COUNT(*) as Total_Orders
  , SUM(total_purchase_amount) as Total_Revenue
  , AVG(total_purchase_amount) as AOV
from kisaraf01.ecommerce_customer_data_large
GROUP BY product_category
ORDER BY Total_Revenue DESC;
--- 5.2. By Payment Method
SELECT 
  payment_method 
  , COUNT(*) as Total_Orders
  , SUM(total_purchase_amount) as Total_Revenue
  , AVG(total_purchase_amount) as AOV
from kisaraf01.ecommerce_customer_data_large
Group by payment_method
Order by Total_Revenue DESC;
--- 5.3. By both
SELECT 
  product_category 
  , payment_method 
  , COUNT(*) as Total_Orders
  , SUM(total_purchase_amount) as Total_Revenue
  , AVG(total_purchase_amount) as AOV
from kisaraf01.ecommerce_customer_data_large
Group by 1, 2
Order by Total_Revenue;
-- VI. Trends by Month
SELECT 
  DATE_TRUNC('month', purchase_date) as Month
  , COUNT(*) as Total_Orders
  , SUM(total_purchase_amount) as Total_Revenue
  , AVG(total_purchase_amount) as AOV
FROM kisaraf01.ecommerce_customer_data_large
Group by Month
Order by Month ASC;
-- VII. Top/Bottom Ranking
--- 7.1. Top 10 Customers
SELECT 
  customer_name
  , SUM(total_purchase_amount) as Total_Revenue
from kisaraf01.ecommerce_customer_data_large
Group by 1
Order by Total_Revenue DESC 
Limit 10;
--- 7.2. Top 1 Product Category
SELECT 
  product_category
  , COUNT(*) as Total_Orders
from kisaraf01.ecommerce_customer_data_large
GROUP By 1
Order by Total_Orders DESC 
LIMIT 1;
-- VIII. Advance: RFM (Recency - Frequency - Monetary) Scoring & Segmentation
With Customer_Agg AS (
  SELECT 
    customer_id
    , MAX(purchase_date) as Last_Purchase
    , COUNT(*) as Frequency
    , SUM(total_purchase_amount) as Monetary
  FROM kisaraf01.ecommerce_customer_data_large
  Group by 1),
  RFM_Base AS (
    SELECT
      customer_id
      , DATE_PART('day', CURRENT_DATE - Last_Purchase) As Recency_Days
      , Frequency
      , Monetary
    FROM Customer_Agg),
  RFM_Score AS(
    SELECT
      customer_id
      , Recency_Days
      , Frequency 
      , Monetary 
      , NTILE(5) OVER(ORDER BY Recency_Days ASC) as R_Score
      , NTILE(5) OVER(ORDER BY Frequency DESC) as F_Score
      , NTILE(5) OVER(ORDER BY Monetary DESC) as M_Score
    FROM RFM_Base),
  RFM_Segment AS(
    SELECT
      customer_id
      , R_Score 
      , F_Score 
      , M_Score 
      , CASE 
        WHEN R_Score >= 4 And F_Score >= 4 And M_Score >= 4 Then 'Champions'
        WHEN R_Score Between 3 And 4 And F_Score >= 4 And M_Score >= 4 Then 'Loyal'
        WHEN R_Score >= 4 And F_Score <= 2 And M_Score BETWEEN 2 and 3 Then 'Potential'
        WHEN R_Score <= 2 And F_Score >= 4 And M_Score BETWEEN 2 and 3 Then 'At risk'
        WHEN R_Score <= 2 And F_Score <= 2 And M_Score <= 2 Then 'Lost'
        ELSE 'Others'
      END AS Segment
    FROM RFM_Score)
SELECT 
  Segment
  , COUNT(*) as Total_Customers
  , ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS pct_of_customers
FROM RFM_Segment
Group By 1
Order By Pct_of_Customers DESC 