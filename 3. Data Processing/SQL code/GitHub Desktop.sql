--1.Adding Dayname, Monthname, Dayofmonth and Revenue columns
-- 1. Checking the Date Range

-- They started collecting the data 2023-01-01
SELECT MIN(transaction_date) AS min_date 
FROM workspace.default.coffee_shop;
-- the duration of the data is 6 months
--  They last collected the data 2023-06-30

SELECT MAX(transaction_date) AS latest_date 
FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1c`;

-- 2. Checking the names of the different stores

-- we have 3 stores and their names are Lower Manhattan, Hell's Kitchen, Astoria
SELECT DISTINCT store_location
FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1c`;

SELECT COUNT(DISTINCT store_id) AS number_of_stores
FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1c`;

-- 3. Checking products sold at our stores 

SELECT DISTINCT product_category
FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1c`;

SELECT DISTINCT product_detail
FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1c`;

SELECT DISTINCT product_type
FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1c`;

SELECT DISTINCT product_category AS category,
                product_detail AS product_name
FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1c`;


-- 1. Checking product prices

SELECT MIN(unit_price) As cheapest_price
FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1c`;

SELECT MAX(unit_price) As expensive_price
FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1c`;

SELECT transaction_id,
      transaction_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,
      Dayofmonth(transaction_date) AS Day_of_month,
      transaction_time,
      transaction_qty,
      store_id,
      store_location,
      product_id,
      product_category,
      product_type,
      product_detail,
      unit_price,
      (transaction_qty*unit_price) AS revenue_per_day,
---2.Adding Weekday/Weekend column
CASE 
    WHEN Dayname(transaction_date) IN ('Sat','Sun') Then 'Weekend'
    ELSE 'Weekday'
    End AS Day_class,     
--3.Add time categories
CASE 
     WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '05:00:00' AND '08:59:59' THEN 'Early morning'
     WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '09:00:00' AND '11:59:59' THEN 'Mid morning'
     WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '15:59:59' THEN 'Afternoon'
     WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '16:00:00' AND '18:00:00' THEN 'Early evening' 
     ELSE 'Late evening'
     END AS Time_category,
--4. Add Spenders category column
CASE 
    WHEN (transaction_qty*unit_price) <=50 THEN 'Low spender'
    WHEN (transaction_qty*unit_price) BETWEEN 51 AND 200 THEN 'Medium spender'
    WHEN (transaction_qty*unit_price) BETWEEN 201 AND 300 THEN 'High spender'
    ELSE 'Exorbitant spender'
    END AS Spenders_category

FROM `workspace`.`default`.`bright_coffee_shop_analysis_case_study_1c`;
