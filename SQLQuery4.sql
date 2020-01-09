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

--5. Write a single update statement to increase each department's budget by 20%.
UPDATE 


