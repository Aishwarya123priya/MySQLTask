-- Aishwarya Priya
-- A766639

-- first let's create the database

drop database if exists onlinetask;
create database onlinetask;
use onlinetask;

-- creating tables
create table manager (
    managerid int primary key,
    name varchar(50),
    empid int
);

create table employee (
    empid int primary key,
    firstname varchar(50),
    lastname varchar(50),
    managerid int,
    foreign key (managerid) references manager(managerid)
);

-- Insert data into the manager table
INSERT INTO manager (managerid, name) VALUES
(1, 'Ramesh Gupta'),
(2, 'Suresh Agarwal'),
(3, 'Meena Singh'),
(4, 'Amitabh Desai'),
(5, 'Rajiv Sharma');

-- Insert data into the employee table
-- Managers as employees, each reporting to another manager
-- Managers listed in employee table with manager assigned
INSERT INTO employee (empid, firstname, lastname, managerid) VALUES
(101, 'Ramesh', 'Gupta', 2),  -- Ramesh reports to Suresh
(102, 'Suresh', 'Agarwal', 3), -- Suresh reports to Meena
(103, 'Meena', 'Singh', 4),    -- Meena reports to Amitabh
(104, 'Amitabh', 'Desai', 5),  -- Amitabh reports to Rajiv
(105, 'Rajiv', 'Sharma', 1),  -- Rajiv reports back to Ramesh
(106, 'Amit', 'Patel', 1),
(107, 'Sunita', 'Sharma', 1),
(108, 'Rajesh', 'Kumar', 1),
(109, 'Priya', 'Verma', 2),
(110, 'Vikram', 'Singh', 2),
(111, 'Anjali', 'Mehta', 2),
(112, 'Ravi', 'Chopra', 3),
(113, 'Sanjay', 'Joshi', 3),
(114, 'Kiran', 'Desai', 3),
(115, 'Pooja', 'Nair', 4),
(116, 'Manoj', 'Pandey', 4),
(117, 'Neha', 'Kapoor', 4),
(118, 'Sumit', 'Sharma', 5),
(119, 'Ritu', 'Patil', 5),
(120, 'Ashok', 'Deshmukh', 5),
(121, 'Meena', 'Garg', NULL),
(122, 'Rohit', 'Yadav', NULL),
(123, 'Sneha', 'Bhatt', NULL),
(124, 'Arun', 'Malhotra', NULL),
(125, 'Kavita', 'Bhatia', NULL);

-- 1.get all employees under each manager
select manager.name as manager_name, employee.firstname, employee.lastname
from employee 
join manager on employee.managerid = employee.managerid
order by manager.managerid;

-- 2. how many employees are there in under manager Alice or any name
select manager.name as manager_name, count(employee.empid) as employee_count
from manager 
left join employee on employee.managerid = manager.managerid
where manager.name = 'Ramesh Gupta'
group by manager.name;

-- 3.get all managers details
select * from manager;

-- little variation into it, like getting the details of manager from employee table
select distinct manager.managerid, manager.name
from employee 
join manager on employee.managerid = manager.managerid;

-- 4. find any employee is there till not assign any manager
select * from employee
where managerid is null;
-- other way to do same task 
SELECT * FROM employee
LEFT JOIN manager ON employee.managerid = manager.managerid
WHERE employee.managerid IS NULL;

-- 5.write a function to get fullname (first_name +lastname)

DELIMITER $$
create function get_fullname(firstname varchar(50), lastname varchar(50))
returns varchar(100)
deterministic
begin
return CONCAT(firstname, ' ', lastname);
end $$
DELIMITER ;

select empid, get_fullname(firstname, lastname) as fullname from employee;
