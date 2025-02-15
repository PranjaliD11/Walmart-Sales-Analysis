Select * from walmart limit 10;
/* Q1: Find different payment methods, number of transactions, and quantity sold by payment method*/
Select DISTINCT payment_method, count(*) as no_payment, SUM(quantity) AS no_qty_sold
FROM walmart GROUP BY payment_method
Order by no_qty_sold DESC;

/* 2: Identify the highest-rated category in each branch
-- Display the branch, category, and avg rating*/
SELECT *
FROM(SELECT
		branch, 
		category, 
		round(avg(rating),2) as avg_rating,
        RANK() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) as ranking
	FROM walmart
	GROUP BY branch, category) as ranked_data
    WHERE ranking=1;
    

/* Q3 Determine the busiest day for branch*/
SELECT *
FROM
	(SELECT 
		branch, 
		DAYNAME(STR_TO_DATE(date, '%d/%m/%y')) AS day_name, 
		COUNT(branch) AS no_transactions,
		RANK() OVER (PARTITION BY branch ORDER BY COUNT(branch) DESC) as ranking_branch
	FROM walmart
	GROUP BY branch, day_name) as ranked_branch
WHERE ranking_branch=1;

/*4: Total quantity sold by payment methods */
Select DISTINCT payment_method, 
	SUM(quantity) AS no_qty_sold
FROM walmart GROUP BY payment_method
Order by no_qty_sold DESC;

/* 5: Determine the average, minimum, and maximum rating of categories for each city*/
SELECT city, 
	 round(avg(rating),2) as average_rating,
     max(rating) as max_rating,
     min(rating) as min_rating,
     category
FROM walmart
GROUP BY city, category;
/* 6: Calculate the total profit for each category*/
SELECT category, 
round(sum(total_price*profit_margin),2) as total_profit
FROM walmart
GROUP BY category;

/* Q7: Determine the most common payment method for each branch*/
WITH cte 
AS
	(SELECT 
		branch,
		payment_method,
		RANK() OVER(PARTITION BY branch ORDER BY count(payment_method) DESC) as count_pay
	FROM walmart
	GROUP BY branch, payment_method) 
 SELECT *
 FROM cte
WHERE count_pay=1;
      
/* Q8: Categorize sales into Morning, Afternoon, and Evening shifts*/
SELECT
	branch,
   CASE 
        WHEN HOUR(time) < 12 THEN 'Morning'
        WHEN HOUR(time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
	END AS day_time,
    count(branch) as no_of_transactions
FROM walmart
GROUP BY branch,day_time
ORDER BY branch, no_of_transactions DESC;


/*Q9:  Identify the 5 branches with the highest revenue decrease ratio from last year to current year (e.g., 2022 to 2023)*/
/* revenue decrease ratio= last_yr-current_yr/last_yr *100*/


WITH revenue_2022
As
	(SELECT 
		branch,
		sum(total_price) as revenue
	FROM walmart
	WHERE YEAR(STR_TO_DATE(date, '%d/%m/%y'))=2022
	GROUP BY branch),
revenue_2023 AS
	(SELECT 
		branch,
		sum(total_price) as revenue
	FROM walmart
	WHERE YEAR(STR_TO_DATE(date, '%d/%m/%y'))=2023
	GROUP BY branch)
SELECT 
	ls_sale.branch,
	ls_sale.revenue as last_year_revenue,
    cs_sale.revenue as current_year_revenue,
    round(ls_sale.revenue-cs_sale.revenue/ls_sale.revenue*100,2) as revenue_decrease_ratio
FROM revenue_2022 as ls_sale
	join revenue_2023 as cs_sale
	on ls_sale.branch=cs_sale.branch
WHERE ls_sale.revenue>cs_sale.revenue
ORDER BY revenue_decrease_ratio DESC
LIMIT 5;
	
    