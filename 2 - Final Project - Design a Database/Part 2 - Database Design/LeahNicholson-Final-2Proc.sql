-- Name:  Leah Nicholson
-- Date:  March 23RD, 2025
-- Description:  Final Project Part 2 - Stored Procedure





-- Check if stored procedure exists --

IF OBJECT_ID('usp_CourseOutcomes', 'P') IS NOT NULL
    DROP PROCEDURE usp_CourseOutcomes;
GO



-- Create the stored procedure --

CREATE PROCEDURE usp_CourseOutcomes
    @DivisionName NVARCHAR(255) = 'IBIT'  -- Make the default value of the parameter 'IBIT'


AS
BEGIN


    -- Select all data for the given division
    SELECT 
        Division.DivisionName, 
        Program.ProgramName, 
        ProgramChair.ProgramChairFName, 
        ProgramChair.ProgramChairLName, 
        Course.CourseID, 
        Outcome.OutcomeDescription

    FROM Division
    JOIN Program 
	ON Division.DivisionKey = Program.DivisionKey

    JOIN ProgramChairMap 
	ON Program.ProgramKey = ProgramChairMap.ProgramKey

    JOIN ProgramChair
	ON ProgramChairMap.ProgramChairKey = ProgramChair.ProgramChairKey

    JOIN Course 
	ON Program.ProgramKey = Course.ProgramKey

    JOIN CourseOutcome
	ON Course.CourseKey = CourseOutcome.CourseKey

    JOIN Outcome ON CourseOutcome.OutcomeKey = Outcome.OutcomeKey
    WHERE Division.DivisionName = @DivisionName;                  -- Pass the name of the division as an input parameter

END;
GO


-- TESTS

-- Default Value ('IBIT')
EXEC usp_CourseOutcomes;		-- 6

-- Coded default value (Division Name = IBIT)
EXEC usp_CourseOutcomes @DivisionName = 'IBIT'		-- 6

-- Division Name = Health Sciences
EXEC usp_CourseOutcomes @DivisionName = 'Health Sciences';		-- 2

-- Division Name = Social Sciences
EXEC usp_CourseOutcomes @DivisionName = 'Social Science';		-- Not "Social Sciences" plural ; 1

-- Division Name = Arts and Humanities
EXEC usp_CourseOutcomes @DivisionName = 'Arts and Humanities';		-- 7

-- Division Name = Science
EXEC usp_CourseOutcomes @DivisionName = 'Science'			-- 3