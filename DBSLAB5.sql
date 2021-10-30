
-- Q1.
create table L5_MOVIES (
	id int PRIMARY KEY,
    title varchar(35) not null unique,
    year int not null,
    director int not null,
    score decimal(3,2) check (score<5 and score>0)
    
);

create table L5_ACTORS (
	id int PRIMARY KEY,
    firstName varchar(20) not null unique,
    lastName varchar(30) not null unique
    
    );
    
create table L5_CASTINGS (
	movieid INT,
	actorid INT,
	PRIMARY KEY(movieid,actorid),
    FOREIGN KEY (actorid) REFERENCES L5_ACTORS(id),
    FOREIGN KEY (movieid) REFERENCES L5_MOVIES(id)

   );
    
create table L5_DIRECTORS (
	id int PRIMARY KEY,
    name varchar(20) not null unique,
    Lastname varchar(30) not null unique
    );
-- Q2 	Modify the movies table to create a foreign key constraint that refers to table directors.
ALTER TABLE L5_MOVIES
	ADD CONSTRAINT movies_directors_fk FOREIGN KEY (Director) REFERENCES L5_DIRECTORS(id);
-- Q3 Modify the movies table to create a new constraint so the uniqueness of the movie title is guaranteed.
ALTER TABLE L5_MOVIES
	ADD CONSTRAINT movies_title UNIQUE(title);
-- Q4.	Write insert statements to add the following data to table directors and movies.
	INSERT INTO L5_DIRECTORS(id, name, LastName) VALUES(1010, 'Rob' , 'Minkoff')  ;
    INSERT INTO L5_DIRECTORS(id, name, LastName) VALUES(1020, 'Bill', 'Condon');
    INSERT INTO L5_DIRECTORS(id, name, LastName) VALUES(1050, 'Josh', 'Cooley');
    INSERT INTO L5_DIRECTORS(id, name, LastName) VALUES(2010, 'Brad', 'Bird');
    INSERT INTO L5_DIRECTORS(id, name, LastName) VALUES(3020, 'Lake', 'Bell');
     
	INSERT INTO L5_MOVIES VALUES (100, 'The Lion King', 2019, 3020, 3.50);
    INSERT INTO L5_MOVIES VALUES (200,'Beauty and the Beast',2017, 1050,4.20);
    INSERT INTO L5_MOVIES VALUES (300, 'Toy Story 4', 2019, 1020,4.50);
    INSERT INTO L5_MOVIES VALUES (400, 'Mission Impossible', 2018, 2010, 5.00);
    INSERT INTO L5_MOVIES VALUES (500, 'The Secret Life of Pets', 2016,1010,3.90);
-- Q5 Write a SQL statement to remove all above tables. Is the order of tables important when removing? Why?
	DROP TABLE L5_CASTINGS;
	DROP TABLE L5_ACTORS;
	DROP TABLE L5_MOVIES;
	DROP TABLE L5_DIRECTORS;

-- Part B
-- Q6 Create a new empty table employee2 exactly the same as table employees.
	CREATE TABLE employee2(
		employeeNumber INT PRIMARY KEY,
        lastName varchar(50),
        firstName varchar(50),
        extension varchar(10),
        email varchar(100),
        officeCode varchar(10),
        reportsTo INT(11),
        jobTitle varchar(50),
        CONSTRAINT employee2_fk FOREIGN KEY(officeCode) REFERENCES offices(officeCode),
        CONSTRAINT employee2_fk2 FOREIGN KEY(reportsTo) REFERENCES employee2(employeeNumber)
	);

-- Q7 Modify table employee2 and add a new column username to this table. The value of this column is not required and does not have to be unique.
	ALTER TABLE employee2
		ADD username varchar(30);
-- Q8 Insert all student data from the employees table into your new table employee2. 
	INSERT INTO employee2 (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
		SELECT * FROM employees;
-- Q9 In table employee2, write a SQL statement to change the first name and the last name of employee with ID 1002 to your name. 
	UPDATE employee2
		SET firstName='Anatoliy', lastName='Serputov'
		WHERE employeeNumber = 1002;
-- Q10 In table employee2, generate the email address for column username for each student by concatenating the first character of employee’s first name and the employee’s last name. For instance, the username of employee Peter Stone will be pstone. NOTE: the username is in all lower case letters.  
	 UPDATE employee2
		SET username = CONCAT(LEFT(lower(firstName), 1), lower(lastName));
        
-- Q11 In table employee2, remove all employees with office code 4. 
	 SET foreign_key_checks = 0;
		DELETE FROM employee2
			WHERE employee2.officeCode = '4';
		SET foreign_key_checks = 1;

-- Q12 Drop table employee2. 
	 DROP TABLE employee2;
		






