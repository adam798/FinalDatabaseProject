
-- Schema PROJECT2_W23
-- -----------------------------------------------------

USE `PROJECT2_W23` ;

---------------------------------------------------------------------
-- 1. How many students have taken “Introduction to Database Systems”?
---------------------------------------------------------------------
SELECT count(distinct coursetaken.StudentID) 
FROM course 
Join coursetaken
on course.CourseCode = coursetaken.CourseCode 
where course.Description='Introduction to Database Systems';

------------------------------------------------------------------------------
-- 2. For the given year, what courses did not have a final exam as an assessment?
------------------------------------------------------------------------------
SELECT distinct(Course.Description) 
FROM course_assessment join course on course_assessment.CourseCode=course.CourseCode
WHERE Not Course.CourseCode = ANY
  (SELECT CourseCode
  FROM exam) And year='2023';

------------------------------------------------------------------------------
-- 3-  Find all the courses that the given question has been used to assess the students. The
-- description of the question is given (i.e. question attribute in the Questions table)
------------------------------------------------------------------------------
Select * from course where CourseCode=ANY 
(SELECT distinct(coursetaken.CourseCode) 
FROM coursetaken join questions on coursetaken.CourseCode=questions.CourseCode
WHERE questions.Question='Mid term Question');


-------------------------------------------------------------------------
-- 4-  Which professor has used “seminar” as an assessment at least once?
-------------------------------------------------------------------------
select distinct(professor.PName)
from professor join professor_has_course on professor_has_course.Professor_PID=professor.pid
where  professor_has_course.Course_Code=ANY
(select distinct(course_assessment.CourseCode)
from course_assessment
join assessment on course_assessment.AssessmentID=assessment.AssessmentID
where assessment.AssessmentType= 'seminar');



-------------------------------------------------------------------------
-- 5-  For the given course, what CLOs and GAIs have been assessed?
-------------------------------------------------------------------------
select questions.clo, questions.gai
from questions join course on questions.CourseCode=course.CourseCode
where Course.Description='Introduction to Database Systems';

-----------------------------------------------------------------------------
-- follow up q If “question” does not have attribute “GAI” (if there is no attribute “CLO” in table “Questions”) 
 -- then we can write query like as follows:
-----------------------------------------------------------------------------
select gai, clo 
from graduateattribute
where gai=ANY(select questions.gai
from questions join course on questions.CourseCode=course.CourseCode
where Course.Description='Introduction to Database Systems');


-------------------------------------------------------------------------
-- 6. What percentage of students passed a given course. 
-- The course code is given to solve this problem.
-------------------------------------------------------------------------
select (select count(distinct(StudentID))
from exam 
where CourseCode=204 and NOT GradeReceived >50)/
(select count(distinct(StudentID))
from exam 
where CourseCode=204)*100 as Passed_Percent;

------------------------------------------------------------------------------
-- 7. What percentage of the assessment for the given course, meets the given learning outcome.
-- The course code and CLO is given.
------------------------------------------------------------------------------


select (select count(distinct(q.AssessmentID))
from questions q
 join learningoutcome l 
 on q.CLO=l.Clo 
where q.CourseCode=201
 and l.clo='4')/ 
(select count(distinct(AssessmentID))
from questions 
where CourseCode=201)*100 as Mached_Percent;

----------------------------------------------------------------------------------
-- follow up question 7. |The query that find the percentage of “students” will be:
------------------------------------------------------------------------------------
select(select count(distinct(StudentID))
from coursetaken
where CourseCode=201)/
(select count(distinct(c.StudentID))
from coursetaken c join questions q on c.CourseCode=q.CourseCode
where q.CourseCode=201 
and q.CLO=
(select clo from learningoutcome where 
description="Analysis"))*100 as Mached_Percent;






------------------------------------------------------------------------------
-- 8. What types of assessments have been offered by the given course in a given year and term.
------------------------------------------------------------------------------
select distinct(a.assessmenttype)
from assessment a NATURAL join course_assessment c
where c.CourseCode=202 and c.year=2023 and c.term="Spring";

------------------------------------------------------------------------------
-- 9. What students have been assessed for the given CLO at least once 
-- in any of the courses that they have taken
------------------------------------------------------------------------------ 
select distinct(s.Name) from student s natural join coursetaken c
where c.CourseCode=ANY
(select c.CourseCode 
from questions q natural join coursetaken c
where q.CLO=(select clo from learningoutcome where 
Description='Evaluation'));

------------------------------------------------------------------------------ 
-- 10- Find the student who has received either the minimum or the maximum grade for the given
-- course and assessment. Course code and assessment id is given.
-------------------------------------------------------------------------------
select s.name, e.GradeReceived as Minimum_grade 
from exam e join student s on e.StudentID = s.StudentID
where e.CourseCode=205
ORDER BY e.GradeReceived
LIMIT 1;

show databases;

use project2_W23;

show tables;
select * from coursetaken;

select * from course;

select * from course_Assessment;

select * from assessment;

select * from Professor_has_Course;

select * from professor;


select * from GraduateAttribute;

select * from LearningOutcome;

select * from questions;

select * from exam;

select studentID, name from student;






