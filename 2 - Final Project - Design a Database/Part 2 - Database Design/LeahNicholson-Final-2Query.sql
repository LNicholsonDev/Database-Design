-- Name:  Leah Nicholson
-- Date:  March 23RD, 2025
-- Description:  Final Project Part 2 - SQL Query (join all the tables + make it relevant to viewer)


USE zCourseOutcomes;

SELECT 

	Division.DivisionName AS 'DIVISION',
	Program.ProgramName AS 'PROGRAM',
	(ProgramChair.ProgramChairFName + ' ' + ProgramChair.ProgramChairLName) AS 'CHAIR',
	Course.CourseID AS 'COURSE ID',
	Outcome.OutcomeDescription AS 'OUTCOME'

FROM Program
INNER JOIN Division
on Program.DivisionKey = Division.DivisionKey

INNER JOIN Course
on Program.ProgramKey = Course.ProgramKey

INNER JOIN CourseOutcome
on Course.CourseKey = CourseOutcome.CourseKey

INNER JOIN Outcome
on CourseOutcome.OutcomeKey = Outcome.OutcomeKey

INNER JOIN ProgramChairMap
on Program.ProgramKey = ProgramChairMap.ProgramKey

INNER JOIN ProgramChair
on ProgramChairMap.ProgramChairKey = ProgramChair.ProgramChairKey

ORDER BY DIVISION;