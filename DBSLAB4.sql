-- Q1)For all employees in France, display employee number, first name, last name, city, phone number and postal code.
SELECT employeeNumber,firstname,lastname,employees.officeCode,city,phone,postalCode
	FROM employees JOIN offices ON employees.officeCode = offices.officeCode
    WHERE country = 'France';
-- Q2)a)Create a view (vwCustomerOrder) to  list all orders with the following data for all customers:  
-- Customer Number, Order number, order date, product name, quantity ordered, and price for each product in every order. 
CREATE VIEW `CustomerOrder` AS
SELECT 	c.customerNumber,o.orderNumber,orderDate,od.quantityOrdered,priceEach,p.productName
	FROM customers c INNER JOIN orders o ON c.customerNumber = o.customerNumber
		INNER JOIN orderdetails od ON o.orderNumber = od.orderNumber
        INNER JOIN products p ON p.productCode = od.productCode
-- b) Write a statement to view the results of the view just created
SELECT DISTINCT * FROM vwCustomerOrder;
-- Q3 Using the vwCustomerOrder  view, display the order information for customer number 124. Sort the output based on order number and then order line number
ALTER VIEW vwCustomerOrder AS
	SELECT cus.customerNumber, ord.orderNumber, orderDate, productName, quantityOrdered, priceEach, orderLineNumber
FROM customers cus INNER JOIN orders ord
ON ord.customerNumber = cus.customerNumber
INNER JOIN orderdetails ordd
ON ord.orderNumber = ordd.orderNumber
INNER JOIN products prod
ON ordd.productCode = prod.productCode;
SELECT DISTINCT * FROM vwCustomerOrder
WHERE customerNumber = 124
ORDER BY orderNumber ASC, orderLineNumber ASC;

-- Q4 Display customer number, first name, last name, phone, and credit limits for all customers who do not have any orders.
SELECT DISTINCT cus.customerNumber , cus.contactFirstName, cus.contactLastName, cus.phone, cus.creditLimit
FROM customers cus LEFT OUTER JOIN orders ord
ON cus.customerNumber = ord.customerNumber
WHERE ord.customerNumber IS NULL;

-- Q5 Create a view (vwEmployeeManager) to display all information of all employees and the name and the last name of their managers if there is any manager that the employee reports to.  Include All employees, include those whom do not report to anyone.
CREATE VIEW vwEmployeeManager AS
SELECT DISTINCT emp.employeeNumber, emp.lastName, emp.firstName, emp.extension, emp.email, emp.officeCode, CONCAT(emp.reportsTo, ' ', manag.firstName, ' ' , manag.lastName) AS reportsTo, emp.jobTitle
FROM employees emp LEFT OUTER JOIN employees manag
ON manag.employeeNumber = emp.reportsTo;

-- Q6 Modify the employee_manager view so the view returns only employee information for employees who have a manager. Do not DROP and recreate the view – modify it.
ALTER VIEW vwEmployeeManager AS 
SELECT DISTINCT emp.employeeNumber, emp.lastName, emp.firstName, emp.extension, emp.email, emp.officeCode, CONCAT(emp.reportsTo,' ', manag.firstName, ' ', manag.lastName) AS reportsTo, emp.jobTitle
FROM employees emp INNER JOIN employees manag
ON manag.employeeNumber = emp.reportsTo;
SELECT DISTINCT * FROM vwEmployeeManager;

-- Q7 Drop both customer_order and employee_manager views
DROP VIEW vwCustomerOrder, vwEmployeeManager;
     
   
   