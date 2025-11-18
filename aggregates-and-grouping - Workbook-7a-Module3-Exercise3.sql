USE northwind;

-- 1) How many suppliers are there? Use a query!
SELECT 
	COUNT(*)
FROM
	suppliers;


-- 2) What is the sum of all the employee's salaries?
SELECT 
	CONCAT("$", FORMAT(SUM(Salary), 2))
FROM
	employees;
    

-- 3) What is the price of the cheapest item that Northwind sells?
SELECT 
    CONCAT("$", FORMAT(MIN(UnitPrice), 2)) AS CheapestItem
FROM
	products;
    

-- 4) What is the average price of items that Northwind sells?
SELECT
	CONCAT("$", FORMAT (AVG(UnitPrice), 2)) AS AveragePrice
FROM
	products;
    
    
-- 5) What is the price of the most expensive item that Northwind sells?
SELECT
	CONCAT("$", FORMAT (MAX(UnitPrice), 2)) AS ExpensiveItem
FROM
	products;
    
-- 6) What is the supplier ID of each supplier and the number of items they supply? 
-- You can answer this query by only looking at the Products table.
SELECT
	SupplierID,
    COUNT(ProductID) AS NumProductsSupplied
FROM
	products
GROUP BY 
	SupplierID;

    
-- 7) What is the category ID of each category and the average price of each item
-- in the category? You can answer this query by only looking at the Products table.
SELECT
	CategoryID,
    CONCAT("$", FORMAT(AVG(UnitPrice),2)) AS AverageItemPrice
FROM
	products
GROUP BY 
	CategoryID;


-- 8) For suppliers that provide at least 5 items to Northwind, what is the
-- supplier ID of each supplier and the number of items they supply? 
-- You can answer this query by only looking at the Products table.
SELECT
	SupplierID,
    COUNT(ProductID) AS NumProductsSupplied
FROM
	products
GROUP BY 
	SupplierID
HAVING 
	COUNT(ProductID) > 4;


-- 9) List the product id, product name, and inventory value (calculated by
-- multiplying unit price by the number of units on hand). Sort the results in
-- descending order by value. If two or more have the same value, order by product name.
SELECT
	ProductID,
    ProductName,
    CONCAT("$", FORMAT(SUM(UnitPrice * UnitsInStock), 2)) AS "Inventory Value"
FROM
	products
GROUP BY 
	ProductID
ORDER BY 
	"Inventory Value" DESC, ProductName ASC;