USE northwind;

-- 1) List the product id, product name, unit price and category name of all products.
-- Order by category name and within that, by product name.
SELECT
	P.ProductID,
    ProductName,
    UnitPrice,
    CategoryName
FROM
	products AS P
JOIN categories AS C
	ON (C.CategoryID = P.CategoryID)
    ORDER BY CategoryName ASC, ProductName ASC;
    
    
-- 2) List the product id, product name, unit price and supplier name of all
-- products that cost more than $75. Order by product name.
SELECT
	ProductID,
    ProductName,
    UnitPrice,
    CompanyName
FROM
	products AS P
JOIN Suppliers AS S
	ON (S.SupplierID = P.SupplierID)
WHERE 
	UnitPrice > 75
ORDER BY ProductName;


-- 3) List the product id, product name, unit price, category name, and supplier
-- name of every product. Order by product name
SELECT
	ProductID,
    ProductName,
    UnitPrice,
    CategoryName,
    CompanyName
FROM
	products AS P
JOIN Suppliers AS S
	ON (S.SupplierID = P.SupplierID)
JOIN categories AS C
	ON (C.CategoryID = P.CategoryID)
ORDER BY ProductName;


-- 4) What is the product name(s) and categories of the most expensive products? 
-- HINT: Find the max price in a subquery and then use that in
-- your more complex query that joins products with categories.
SELECT
	ProductName,
    UnitPrice,
    CategoryName
FROM
	products AS P
JOIN categories AS C
	ON (C.CategoryID = P.CategoryID)
WHERE UnitPrice = (SELECT
		MAX(UnitPrice)
	FROM
		products);


-- 5) List the order id, ship name, ship address, and shipping company name of
-- every order that shipped to Germany.
SELECT
	OrderID,
    ShipName,
    ShipAddress,
    CompanyName
FROM
	orders AS O
JOIN shippers as S
	ON (S.ShipperID = O.ShipVia)
WHERE ShipCountry LIKE "Germany";


-- 6) List the order id, order date, ship name, ship address of all orders that ordered "Sasquatch Ale"?
SELECT
	O.OrderID,
    OrderDate,
    ShipName,
    ShipAddress
FROM
	orders AS O
JOIN `order details` AS OD
	ON (OD.OrderID = O.OrderID)
JOIN products AS P
	ON (P.ProductID = OD.ProductID)
WHERE P.ProductName = "Sasquatch Ale";