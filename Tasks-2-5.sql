#Task 2
#Query 1
SELECT 
	firstName, 
    surname, 
    studentID, 
    email 
FROM student 
WHERE suburb LIKE '%Everton%';
#Query 2
SELECT
	firstName, 
	surname 
FROM student WHERE buddyID IS NOT NULL
ORDER BY surname ASC;
#Query 3
SELECT 
	tutor.staffID,
	tutor.firstName,
    tutor.surname,
    COUNT(unittutor.staffID) AS number_of_units
FROM 
	tutor LEFT JOIN unittutor
	ON tutor.staffID = unittutor.staffID
GROUP BY tutor.staffID;
#Query 4
SELECT 
	assignment.assignmentID,
    assignment.assignmentName,
    MIN(grade.grade) as min,
    AVG(grade.grade) as avg,
    MAX(grade.grade) as max,
    COUNT(grade.grade) as submissions
FROM
	assignment LEFT JOIN grade
    ON assignment.assignmentID = grade.assignmentID
GROUP BY assignment.assignmentID;
#Query 5
SELECT
	concat(tutor.firstName, ' ', tutor.surname) as fullName,
	tutor.email
    FROM
    tutor LEFT JOIN unittutor
	ON tutor.staffID = unittutor.staffID
    LEFT JOIN unit
    on unittutor.unitID = unit.unitID
    WHERE tutor.staffID NOT IN (select distinct staffID 
	from unittutor where unitID in (SELECT unitID FROM unit where semester = 2));
	

#Query 6
SELECT
	student.studentID,
	student.firstName,
    student.surname,
    grade.grade
FROM
	student LEFT JOIN sleeppatterns
    ON student.studentID = sleeppatterns.studentID
    INNER JOIN grade
    ON sleeppatterns.studentID = grade.studentID
WHERE MONTH(sleeppatterns.date) = '4'
GROUP BY student.studentID
HAVING AVG(sleeppatterns.timeAsleep) < 6;

#Task 3
SET SQL_SAFE_UPDATES = 0; # safe mode command
#Insert

INSERT INTO Unit ( unitName, unitCode, semester, year)
VALUES('Advanced Database Management' , 'IFB801',1, 2019);
# Delete 
DELETE FROM phoneNumber WHERE phoneNumber LIKE '02%';
# update 
UPDATE student 
SET streetNumber = '72', 
	streetName  = 'Evergreen Terrace', 
	suburb = 'Springfield'
WHERE surname = 'Smith' AND 
 streetNumber = '180' AND 
 streetName = 'Zelda Street' AND
 suburb = 'Linkburb';
 
 
 #task 4
 CREATE INDEX idx_assignment ON assignment (assignmentName);
 
 CREATE VIEW  enrolments_view AS 
SELECT
	firstname, 
    surname,
    studentid  
FROM student where studentID NOT IN (SELECT studentID FROM enrolments);
#Task 5

CREATE USER Nikki
IDENTIFIED BY 'secret';

create user Jake
 IDENTIFIED BY 'secret1';

grant insert 
ON pulselearning.student
 To Nikki;

grant delete 
ON pulselearning.student 
To Nikki;

grant insert 
ON pulselearning.student
 To Jake;
revoke insert 
ON pulselearning.student 
from Jake;

grant delete 
ON pulselearning.student 
To Jake;
revoke delete
 ON pulselearning.student
 from Jake;