SELECT * FROM pizza_sales

SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Average_Order_Value
FROM pizza_sales

SELECT SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales

SELECT COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales


SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id)AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizza_perOrder
FROM pizza_sales


--total orders as per week days basis
SELECT DATENAME(DW, order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

--total orders as per monthly  basis
SELECT DATENAME(MONTH, order_date) AS Order_Month, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Orders DESC

--PERCENTAGE OF TOTAL SALES FOR EACH PIZZA CATEGORY for january month
SELECT pizza_category, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1) AS Percentage_Sales
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category


--PERCENTAGE OF SALES PER PIZZA SIZE FOR FIRST QUARTER
SELECT pizza_size, CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(QUARTER, order_date) = 1) AS DECIMAL(10,2)) AS Percentage_Sales
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY pizza_size
ORDER BY Percentage_Sales DESC

--TOP 5 BEST SELLING PIZZA BY REVENUE, TOTAL QUANTITY, TOTAL ORDERS
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC

SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC




