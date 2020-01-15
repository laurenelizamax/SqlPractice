----1. List each employee first name, last name and supervisor status along with their 
----department name. Order by department name, then by employee last name, and finally by employee first name.
--SELECT e.FirstName, e.LastName,
--CASE 
--WHEN e.IsSupervisor = 1 THEN 'Yes'
--ELSE 'No'
--END AS SupervisorStatus,
--d.[Name] AS DepartmentName
--FROM Employee e
--INNER JOIN Department d ON e.DepartmentId = d.Id
--ORDER BY d.[Name], e.LastName, e.FirstName;

----2. List each department ordered by budget amount with the highest first.
--SELECT [Name], budget
--FROM Department 
--ORDER BY budget DESC;

----3. List each department name along with any employees (full name) in that department who are supervisors.
--SELECT d.[Name] AS DepartmentName,  e.FirstName + ' ' + e.LastName as FullName
--FROM Department d
--LEFT JOIN Employee e ON d.Id = e.DepartmentId
--WHERE IsSupervisor = 1;

----4. List each department name along with a count of employees in each department.
--SELECT d.[Name] as DepartmentName, COUNT(e.Id) as EmployeeCount
--FROM Department d
--LEFT JOIN Employee e ON d.Id = e.DepartmentId
--GROUP BY d.[Name];

----5. Write a single update statement to increase each department's budget by 20%.
--UPDATE Department
--SET Budget = Budget + (Budget * 20.0 / 100.0);
--SELECT * FROM Department;

----6. List the employee full names for employees who are not signed up for any training programs.
--SELECT e.FirstName + ' ' + e.LastName AS EmployeeName 
--FROM Employee e
--LEFT JOIN EmployeeTraining et ON e.Id = et.EmployeeId
--WHERE et.Id IS NULL;

----7. List the employee full names for employees who are signed up for at least one 
----training program and include the number of training programs they are signed up for.
--SELECT e.FirstName + ' ' + e.LastName AS EmployeeName, Count(et.Id) AS TrainingPrograms
--FROM Employee e 
--LEFT JOIN EmployeeTraining et ON e.Id = et.EmployeeId
--WHERE et.Id IS NOT Null
--GROUP BY e.FirstName, e.LastName;

----8. List all training programs along with the count employees who have signed up for each.
--SELECT tp.[Name], COUNT(e.Id) AS EmployeeCount
--FROM TrainingProgram tp
--LEFT JOIN EmployeeTraining et ON tp.Id = et.TrainingProgramId
--LEFT JOIN Employee e ON et.EmployeeId = e.Id
--GROUP BY tp.[Name];

----9. List all training programs who have no more seats available.
--SELECT tp.[Name] AS TrainingProgram, tp.MaxAttendees, et.TrainingProgramId, COUNT(et.Id) AS EmployeeCount
--FROM TrainingProgram tp
--LEFT JOIN EmployeeTraining et ON tp.Id = et.TrainingProgramId
--GROUP BY tp.[Name], tp.MaxAttendees, et.TrainingProgramId
--HAVING tp.MaxAttendees = COUNT(et.Id);

----10. List all future training programs ordered by start date with the earliest date first.
---- USED GetDate() function
--SELECT tp.[Name] AS TrainingProgram, tp.StartDate, tp.EndDate
--FROM TrainingProgram tp
--WHERE tp.StartDate > GetDate()
--ORDER BY tp.StartDate;

----11. Assign a few employees to training programs of your choice.
--INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (1,2);
--INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (2,2);
--INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (3,3);
--INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (1,1);
--SELECT * FROM EmployeeTraining;

----12. List the top 3 most popular training programs. (For this question, consider each record 
---- in the training program table to be a UNIQUE training program).
--SELECT Top 3 tp.[Name], COUNT(et.Id) AS EmployeeCount
--FROM TrainingProgram tp
--LEFT JOIN EmployeeTraining et ON tp.Id = et.TrainingProgramId
--GROUP BY tp.[Name]
--ORDER BY COUNT(et.Id) DESC;

---- 13.List the top 3 most popular training programs. (For this question consider 
---- training programs with the same name to be the SAME training program).
--SELECT Top 3 tp.[Name], COUNT(et.Id) AS EmployeeCount
--FROM TrainingProgram tp
--INNER JOIN EmployeeTraining et ON tp.Id = et.TrainingProgramId
--GROUP BY tp.[Name]
--ORDER BY COUNT(et.Id) DESC;

---- 14. List all employees who do not have computers.
--SELECT e.FirstName, e.LastName, ce.ComputerId
--FROM Employee e
--LEFT JOIN ComputerEmployee ce ON e.Id = ce.EmployeeId
--WHERE ce.EmployeeId IS NULL;

---- 15. List all employees along with their current computer information make and manufacturer 
---- combined into a field entitled ComputerInfo. If they do not have a computer, 
---- this field should say "N/A".
---- USED IsNull with N/A
--SELECT e.FirstName, e.LastName, IsNull(c.Make + ' ' + c.Manufacturer, 'N/A') AS Computer
--FROM Employee e
--LEFT JOIN ComputerEmployee ce ON e.Id = ce.EmployeeId
--LEFT JOIN Computer c ON ce.ComputerId = c.Id;

---- 16.List all computers that were purchased before July 2019 that are have not been decommissioned.
---- Used < plus date
--SELECT c.Id, c.PurchaseDate
--FROM Computer c
--WHERE c.PurchaseDate < '07/01/2019'

---- 17. List all employees along with the total number of computers they have ever had.
--SELECT e.FirstName, e.LastName, COUNT(ce.ComputerId) AS NumberOfComputers
--FROM Employee e 
--LEFT JOIN ComputerEmployee ce ON e.Id = ce.EmployeeId
--GROUP BY e.FirstName, e.LastName;

---- 18. List the number of customers using each payment type
--SELECT cu.FirstName + ' ' + cu.LastName AS CustomerName, COUNT(pt.Id) AS PaymentTypeCount
--FROM Customer cu 
--LEFT JOIN PaymentType pt ON cu.Id = pt.CustomerId
--GROUP BY cu.FirstName, cu.LastName;

---- 19. List the 10 most expensive products and the names of the seller
--SELECT Top 10 cu.FirstName + ' ' + cu.LastName AS Seller, p.Title AS Product, p.Price
--FROM Product p
--LEFT JOIN Customer cu ON p.CustomerId = cu.Id
--ORDER BY p.Price DESC;

---- 20. List the 10 most purchased products and the names of the seller
--SELECT TOP 10 p.Title, p.Quantity, p.Price, COUNT(op.Id) AS ProductsOrdered, 
--c.FirstName + ' ' + c.LastName AS Seller 
--FROM Product p 
--INNER JOIN OrderProduct op ON p.Id = op.ProductId
--INNER JOIN Customer c ON p.CustomerId = c.Id
--GROUP BY p.Title, p.Quantity, p.Price, c.FirstName, c.LastName
--ORDER BY COUNT(op.Id) DESC


---- 21. Find the name of the customer who has made the most purchases
--SELECT Top 5 cu.FirstName + ' ' + cu.LastName AS Customer, COUNT(o.Id) AS OrderCount
--FROM Customer cu
--LEFT JOIN [Order] o ON cu.Id = o.CustomerId
--GROUP BY cu.FirstName, cu.LastName
--ORDER BY COUNT(o.Id) DESC;

---- 22. List the amount of total sales by product type
--SELECT pt.Id AS ProductTypeId, pt.[Name] AS ProductType, ISNULL(SUM(sales.Price),0) AS TotalSales
--FROM ProductType pt
--LEFT JOIN (SELECT 
----------------------------------FINISH #22

---- 23. List the total amount made from all sellers
----------------------------------FINISH #23

