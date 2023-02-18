--all the queries here are the answers to questions asked while learning SQL from UDACITY--
--Skills used: Basic SQL functions, Joins, Aggregate Functions, subqueries--



SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC 
LIMIT 5;

--all columns from the orders table that have a dollar amount of gloss_amt_usd greater than or equal to 1000--
SELECT *
FROM orders
WHERE gloss_amt_usd>=1000;


--Filter the accounts table to include the company name, website, and the primary point of contact (primary_poc) just for the Exxon Mobil company in the accounts table--
SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';


--Find the percentage of revenue that comes from poster paper for each order-- 
SELECT id, account_id, poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd)*100 AS revenue
FROM orders;


--All the companies whose names start with 'C'--
SELECT name
FROM accounts
WHERE name LIKE 'C%';


--All the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0--
SELECT *
FROM orders
WHERE standard_qty>1000 AND poster_qty = 0 AND gloss_qty = 0;


-- All the companies whose names do not start with 'C' and end with 's'--
SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';


--Display the order date and gloss_qty data for all orders where gloss_qty is between-- 
SELECT ordered_at, gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29;


--Find all information regarding individuals who were contacted via the organic or adwords channels, and started their account at any point in 2016, sorted from newest to oldest--
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occured BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred _at DESC;


--Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price--
SELECT r.name region, a.name account, o.total_amt_usd/(total+0.01) AS unit_price 
FROM region r
JOIN sales_reps s
ON s.region_id=r.id
JOIN accounts a
ON a.sales_rep_id= s.id
JOIN orders o
ON a.id= o.account_id;


--Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name--
SELECT r.name AS region, s.name AS sales_rep, a.name AS account_name
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
On s.id = a.sales_rep_id
WHERE r.name ='Midwest'
ORDER BY a.name;


--Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first--
SELECT r.name region_name, a.name account_name, o.total_amt_usd/(o.total + 0.01) AS unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;


--Find out the different channels used by account id 1001? Your final table should have only 2 columns: account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values--
SELECT DISTINCT a.name, w.channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE a.id = '1001';

