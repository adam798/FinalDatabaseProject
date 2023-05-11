-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema PROJECT2_W23
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema PROJECT2_W23
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PROJECT2_W23` DEFAULT CHARACTER SET utf8 ;
USE `PROJECT2_W23` ;

-- -----------------------------------------------------
-- Table `PROJECT2_W23`.`Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PROJECT2_W23`.`Course` (
  `CourseCode` INT NOT NULL,
  `Description` VARCHAR(45) NULL,
  PRIMARY KEY (`CourseCode`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PROJECT2_W23`.`Assessment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PROJECT2_W23`.`Assessment` (
  `AssessmentID` INT NOT NULL,
  `AssessmentType` VARCHAR(45) NULL,
  PRIMARY KEY (`AssessmentID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PROJECT2_W23`.`Course_Assessment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PROJECT2_W23`.`Course_Assessment` (
  `CourseCode` INT NOT NULL,
  `AssessmentID` INT NOT NULL,
  `year` VARCHAR(45) NULL,
  `Term` VARCHAR(45) NULL,
  `Weight` VARCHAR(45) NULL,
  INDEX `fk1_idx` (`CourseCode` ASC) VISIBLE,
  PRIMARY KEY (`CourseCode`, `AssessmentID`),
  INDEX `fk2_idx` (`AssessmentID` ASC) VISIBLE,
  CONSTRAINT `fk1`
    FOREIGN KEY (`CourseCode`)
    REFERENCES `PROJECT2_W23`.`Course` (`CourseCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk2`
    FOREIGN KEY (`AssessmentID`)
    REFERENCES `PROJECT2_W23`.`Assessment` (`AssessmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PROJECT2_W23`.`LearningOutcome`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PROJECT2_W23`.`LearningOutcome` (
  `CLO` INT NOT NULL,
  `Description` VARCHAR(45) NULL,
  PRIMARY KEY (`CLO`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PROJECT2_W23`.`GraduateAttribute`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PROJECT2_W23`.`GraduateAttribute` (
  `GAI` INT NOT NULL,
  `Description` VARCHAR(45) NULL,
  `CLO` INT NOT NULL,
  PRIMARY KEY (`GAI`),
  INDEX `fk_GraduateAttribute_LearningOutcome1_idx` (`CLO` ASC) VISIBLE,
  CONSTRAINT `fk_GraduateAttribute_LearningOutcome1`
    FOREIGN KEY (`CLO`)
    REFERENCES `PROJECT2_W23`.`LearningOutcome` (`CLO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PROJECT2_W23`.`Questions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PROJECT2_W23`.`Questions` (
  `QuestionsID` INT NOT NULL,
  `AssessmentID` INT NOT NULL,
  `CourseCode` INT NOT NULL,
  `Question` VARCHAR(45) NULL,
  `Solution` VARCHAR(45) NULL,
  `points` VARCHAR(45) NULL,
  `CLO` INT NOT NULL,
  `GAI` INT NOT NULL,
  PRIMARY KEY (`QuestionsID`, `AssessmentID`, `CourseCode`),
  INDEX `fk1_idx` (`AssessmentID` ASC) VISIBLE,
  INDEX `fk2_idx` (`CLO` ASC) VISIBLE,
  INDEX `fk_Questions_GraduateAttribute1_idx` (`GAI` ASC) VISIBLE,
  INDEX `fk_Questions_Course_Assessment1_idx` (`CourseCode` ASC) VISIBLE,
  CONSTRAINT `fk1`
    FOREIGN KEY (`AssessmentID`)
    REFERENCES `PROJECT2_W23`.`Course_Assessment` (`AssessmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk2`
    FOREIGN KEY (`CLO`)
    REFERENCES `PROJECT2_W23`.`LearningOutcome` (`CLO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Questions_GraduateAttribute1`
    FOREIGN KEY (`GAI`)
    REFERENCES `PROJECT2_W23`.`GraduateAttribute` (`GAI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Questions_Course_Assessment1`
    FOREIGN KEY (`CourseCode`)
    REFERENCES `PROJECT2_W23`.`Course_Assessment` (`CourseCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PROJECT2_W23`.`Professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PROJECT2_W23`.`Professor` (
  `PID` INT NOT NULL,
  `PName` VARCHAR(45) NULL,
  PRIMARY KEY (`PID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PROJECT2_W23`.`Professor_has_Course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PROJECT2_W23`.`Professor_has_Course` (
  `Professor_PID` INT NOT NULL,
  `Course_Code` INT NOT NULL,
  PRIMARY KEY (`Professor_PID`, `Course_Code`),
  INDEX `fk_Professor_has_Course_Course1_idx` (`Course_Code` ASC) VISIBLE,
  CONSTRAINT `fk_Professor_has_Course_Professor1`
    FOREIGN KEY (`Professor_PID`)
    REFERENCES `PROJECT2_W23`.`Professor` (`PID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Professor_has_Course_Course1`
    FOREIGN KEY (`Course_Code`)
    REFERENCES `PROJECT2_W23`.`Course` (`CourseCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PROJECT2_W23`.`Student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PROJECT2_W23`.`Student` (
  `StudentID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`StudentID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PROJECT2_W23`.`CourseTaken`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PROJECT2_W23`.`CourseTaken` (
  `CourseCode` INT NOT NULL,
  `StudentID` INT NOT NULL,
  `term` INT NOT NULL,
  `year` INT NULL,
  PRIMARY KEY (`CourseCode`, `StudentID`, `term`),
  INDEX `fk_CourseTaken_Student1_idx` (`StudentID` ASC) VISIBLE,
  CONSTRAINT `fk_CourseTaken_Course1`
    FOREIGN KEY (`CourseCode`)
    REFERENCES `PROJECT2_W23`.`Course` (`CourseCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CourseTaken_Student1`
    FOREIGN KEY (`StudentID`)
    REFERENCES `PROJECT2_W23`.`Student` (`StudentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PROJECT2_W23`.`Exam`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PROJECT2_W23`.`Exam` (
  `QuestionID` INT NOT NULL,
  `AssessmentID` INT NOT NULL,
  `CourseCode` INT NOT NULL,
  `StudentID` INT NOT NULL,
  `GradeReceived` INT NULL,
  PRIMARY KEY (`QuestionID`, `AssessmentID`, `CourseCode`, `StudentID`),
  INDEX `fk_Exam_Student1_idx` (`StudentID` ASC) VISIBLE,
  INDEX `fk_Exam_Questions2_idx` (`AssessmentID` ASC) VISIBLE,
  INDEX `fk_Exam_Questions3_idx` (`CourseCode` ASC) VISIBLE,
  CONSTRAINT `fk_Exam_Student1`
    FOREIGN KEY (`StudentID`)
    REFERENCES `PROJECT2_W23`.`Student` (`StudentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Exam_Questions1`
    FOREIGN KEY (`QuestionID`)
    REFERENCES `PROJECT2_W23`.`Questions` (`QuestionsID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Exam_Questions2`
    FOREIGN KEY (`AssessmentID`)
    REFERENCES `PROJECT2_W23`.`Questions` (`AssessmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Exam_Questions3`
    FOREIGN KEY (`CourseCode`)
    REFERENCES `PROJECT2_W23`.`Questions` (`Question`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- -----------------------------------------------------
-- Data for table `PROJECT2_W23`.`Course`
-- -----------------------------------------------------
START TRANSACTION;
USE `PROJECT2_W23`;
INSERT INTO `PROJECT2_W23`.`Course` (`CourseCode`, `Description`) VALUES (201, 'Mathematics');
INSERT INTO `PROJECT2_W23`.`Course` (`CourseCode`, `Description`) VALUES (202, 'Human Computer Interaction');
INSERT INTO `PROJECT2_W23`.`Course` (`CourseCode`, `Description`) VALUES (203, 'Economics');
INSERT INTO `PROJECT2_W23`.`Course` (`CourseCode`, `Description`) VALUES (204, 'Introduction to Database Systems');
INSERT INTO `PROJECT2_W23`.`Course` (`CourseCode`, `Description`) VALUES (205, 'Finance');

COMMIT;

-- -----------------------------------------------------
-- Data for table `PROJECT2_W23`.`Assessment`
-- -----------------------------------------------------
START TRANSACTION;
USE `PROJECT2_W23`;
INSERT INTO `PROJECT2_W23`.`Assessment` (`AssessmentID`, `AssessmentType`) VALUES (1, 'midterm');
INSERT INTO `PROJECT2_W23`.`Assessment` (`AssessmentID`, `AssessmentType`) VALUES (2, 'final exam');
INSERT INTO `PROJECT2_W23`.`Assessment` (`AssessmentID`, `AssessmentType`) VALUES (3, 'project');
INSERT INTO `PROJECT2_W23`.`Assessment` (`AssessmentID`, `AssessmentType`) VALUES (4, 'assignment');
INSERT INTO `PROJECT2_W23`.`Assessment` (`AssessmentID`, `AssessmentType`) VALUES (5, 'quiz');
INSERT INTO `PROJECT2_W23`.`Assessment` (`AssessmentID`, `AssessmentType`) VALUES (6, 'in-class activity');
INSERT INTO `PROJECT2_W23`.`Assessment` (`AssessmentID`, `AssessmentType`) VALUES (7, 'survey');
INSERT INTO `PROJECT2_W23`.`Assessment` (`AssessmentID`, `AssessmentType`) VALUES (8, 'presentation');
INSERT INTO `PROJECT2_W23`.`Assessment` (`AssessmentID`, `AssessmentType`) VALUES (9, 'seminar');
INSERT INTO `PROJECT2_W23`.`Assessment` (`AssessmentID`, `AssessmentType`) VALUES (10, 'design');

COMMIT;


-- -----------------------------------------------------
-- Data for table `PROJECT2_W23`.`Course_Assessment`
-- -----------------------------------------------------
START TRANSACTION;
USE `PROJECT2_W23`;
INSERT INTO `PROJECT2_W23`.`Course_Assessment` (`CourseCode`, `AssessmentID`, `year`, `Term`, `Weight`) VALUES (201, 4, '2022', 'Fall', '30');
INSERT INTO `PROJECT2_W23`.`Course_Assessment` (`CourseCode`, `AssessmentID`, `year`, `Term`, `Weight`) VALUES (201, 5, '2022', 'Fall', '10');
INSERT INTO `PROJECT2_W23`.`Course_Assessment` (`CourseCode`, `AssessmentID`, `year`, `Term`, `Weight`) VALUES (201, 1, '2022', 'Winter', '20');
INSERT INTO `PROJECT2_W23`.`Course_Assessment` (`CourseCode`, `AssessmentID`, `year`, `Term`, `Weight`) VALUES (201, 2, '2022', 'Winter', '40');
INSERT INTO `PROJECT2_W23`.`Course_Assessment` (`CourseCode`, `AssessmentID`, `year`, `Term`, `Weight`) VALUES (202, 6, '2023', 'Spring', '15');
INSERT INTO `PROJECT2_W23`.`Course_Assessment` (`CourseCode`, `AssessmentID`, `year`, `Term`, `Weight`) VALUES (202, 4, '2023', 'Spring', '15');
INSERT INTO `PROJECT2_W23`.`Course_Assessment` (`CourseCode`, `AssessmentID`, `year`, `Term`, `Weight`) VALUES (202, 3, '2023', 'Summer', '20');
INSERT INTO `PROJECT2_W23`.`Course_Assessment` (`CourseCode`, `AssessmentID`, `year`, `Term`, `Weight`) VALUES (202, 9, '2023', 'Summer', '25');
INSERT INTO `PROJECT2_W23`.`Course_Assessment` (`CourseCode`, `AssessmentID`, `year`, `Term`, `Weight`) VALUES (202, 10, '2023', 'Fall', '25');
INSERT INTO `PROJECT2_W23`.`Course_Assessment` (`CourseCode`, `AssessmentID`, `year`, `Term`, `Weight`) VALUES (203, 4, '2022', 'Winter', '10');
INSERT INTO `PROJECT2_W23`.`Course_Assessment` (`CourseCode`, `AssessmentID`, `year`, `Term`, `Weight`) VALUES (203, 7, '2023', 'Winter', '20');
INSERT INTO `PROJECT2_W23`.`Course_Assessment` (`CourseCode`, `AssessmentID`, `year`, `Term`, `Weight`) VALUES (203, 9, '2023', 'Spring', '20');
INSERT INTO `PROJECT2_W23`.`Course_Assessment` (`CourseCode`, `AssessmentID`, `year`, `Term`, `Weight`) VALUES (204, 7, '2022', 'Fall', '10');
INSERT INTO `PROJECT2_W23`.`Course_Assessment` (`CourseCode`, `AssessmentID`, `year`, `Term`, `Weight`) VALUES (204, 5, '2022', 'Winter', '15');
INSERT INTO `PROJECT2_W23`.`Course_Assessment` (`CourseCode`, `AssessmentID`, `year`, `Term`, `Weight`) VALUES (204, 1, '2023', 'Spring', '15');
INSERT INTO `PROJECT2_W23`.`Course_Assessment` (`CourseCode`, `AssessmentID`, `year`, `Term`, `Weight`) VALUES (204, 9, '2023', 'Spring', '20');
INSERT INTO `PROJECT2_W23`.`Course_Assessment` (`CourseCode`, `AssessmentID`, `year`, `Term`, `Weight`) VALUES (204, 2, '2023', 'Summer', '50');
INSERT INTO `PROJECT2_W23`.`Course_Assessment` (`CourseCode`, `AssessmentID`, `year`, `Term`, `Weight`) VALUES (205, 4, '2022', 'Fall', '10');
INSERT INTO `PROJECT2_W23`.`Course_Assessment` (`CourseCode`, `AssessmentID`, `year`, `Term`, `Weight`) VALUES (205, 5, '2022', 'Winter', '20');
INSERT INTO `PROJECT2_W23`.`Course_Assessment` (`CourseCode`, `AssessmentID`, `year`, `Term`, `Weight`) VALUES (205, 2, '2023', 'Spring', '30');

COMMIT;


-- -----------------------------------------------------
-- Data for table `PROJECT2_W23`.`LearningOutcome`
-- -----------------------------------------------------
START TRANSACTION;
USE `PROJECT2_W23`;
INSERT INTO `PROJECT2_W23`.`LearningOutcome` (`CLO`, `Description`) VALUES (1, 'Knowledge');
INSERT INTO `PROJECT2_W23`.`LearningOutcome` (`CLO`, `Description`) VALUES (2, 'Comprehension');
INSERT INTO `PROJECT2_W23`.`LearningOutcome` (`CLO`, `Description`) VALUES (3, 'Application');
INSERT INTO `PROJECT2_W23`.`LearningOutcome` (`CLO`, `Description`) VALUES (4, 'Analysis');
INSERT INTO `PROJECT2_W23`.`LearningOutcome` (`CLO`, `Description`) VALUES (5, 'Synthesis');
INSERT INTO `PROJECT2_W23`.`LearningOutcome` (`CLO`, `Description`) VALUES (6, 'Evaluation');

COMMIT;


-- -----------------------------------------------------
-- Data for table `PROJECT2_W23`.`GraduateAttribute`
-- -----------------------------------------------------
START TRANSACTION;
USE `PROJECT2_W23`;
INSERT INTO `PROJECT2_W23`.`GraduateAttribute` (`GAI`, `Description`, `CLO`) VALUES (1, 'gai1', 1);
INSERT INTO `PROJECT2_W23`.`GraduateAttribute` (`GAI`, `Description`, `CLO`) VALUES (2, 'gai2', 1);
INSERT INTO `PROJECT2_W23`.`GraduateAttribute` (`GAI`, `Description`, `CLO`) VALUES (3, 'gai3', 2);
INSERT INTO `PROJECT2_W23`.`GraduateAttribute` (`GAI`, `Description`, `CLO`) VALUES (4, 'gai4', 3);
INSERT INTO `PROJECT2_W23`.`GraduateAttribute` (`GAI`, `Description`, `CLO`) VALUES (5, 'gai5', 4);
INSERT INTO `PROJECT2_W23`.`GraduateAttribute` (`GAI`, `Description`, `CLO`) VALUES (6, 'gai6', 4);
INSERT INTO `PROJECT2_W23`.`GraduateAttribute` (`GAI`, `Description`, `CLO`) VALUES (7, 'gai7', 2);
INSERT INTO `PROJECT2_W23`.`GraduateAttribute` (`GAI`, `Description`, `CLO`) VALUES (8, 'gai8', 5);
INSERT INTO `PROJECT2_W23`.`GraduateAttribute` (`GAI`, `Description`, `CLO`) VALUES (9, 'gai9', 6);
INSERT INTO `PROJECT2_W23`.`GraduateAttribute` (`GAI`, `Description`, `CLO`) VALUES (10, 'gai10', 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `PROJECT2_W23`.`Questions`
-- -----------------------------------------------------
START TRANSACTION;
USE `PROJECT2_W23`;
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (QuestionsID, AssessmentID, CourseCode, 'Question', 'Solution', 'points', CLO, GAI);
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (101, 4, 201, 'Math Question', 'Solved', 'p1', 4, 5);
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (102, 5, 201, 'Math Quiz', '', 'p2', 1, 1);
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (103, 1, 201, 'Mid term Question', 'Solved', 'p5', 6, 9);
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (104, 1, 201, 'Mid term Question2', 'Solved', 'p4', 6, 9);
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (105, 2, 201, 'Final exam Question1', 'Solved', 'p3', 6, 9);
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (106, 2, 201, 'Final exam Question2', 'Solved', 'p6', 6, 9);
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (201, 3, 202, 'project Question', '', 'p2', 2, 2);
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (202, 3, 202, 'project Question2', '', 'p3', 2, 3);
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (301, 4, 203, 'Eco Assign Ques1', 'Solved', 'p7', 3, 4);
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (302, 4, 203, 'Eco Assign Ques2', '', 'p5', 2, 3);
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (303, 7, 203, 'Eco survey', '', 'p8', 5, 10);
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (401, 5, 204, 'Database quiz', '', 'p3', 2, 7);
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (402, 1, 204, 'Database mid term1', 'Solved', 'p3', 1, 2);
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (403, 1, 204, 'Database mid term2', 'Solved', 'p4', 4, 6);
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (404, 2, 204, 'Database Final 1', 'Solved', 'p5', 6, 9);
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (405, 2, 204, 'Database Final 2', 'Solved', 'p6', 5, 8);
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (406, 2, 204, 'Database Final 3', '', 'p7', 3, 4);
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (501, 4, 205, 'Finance Assignment 1', 'Solved', 'p3', 2, 3);
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (502, 4, 205, 'Finance Assignment 2', '', 'p4', 3, 4);
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (503, 5, 205, 'Finance Quiz', '', 'p7', 1, 2);
INSERT INTO `PROJECT2_W23`.`Questions` (`QuestionsID`, `AssessmentID`, `CourseCode`, `Question`, `Solution`, `points`, `CLO`, `GAI`) VALUES (504, 2, 205, 'Finance exam', 'Solved', 'p10', 5, 9);

COMMIT;


-- -----------------------------------------------------
-- Data for table `PROJECT2_W23`.`Professor`
-- -----------------------------------------------------
START TRANSACTION;
USE `PROJECT2_W23`;
INSERT INTO `PROJECT2_W23`.`Professor` (`PID`, `PName`) VALUES (101, 'Smith');
INSERT INTO `PROJECT2_W23`.`Professor` (`PID`, `PName`) VALUES (102, 'David');
INSERT INTO `PROJECT2_W23`.`Professor` (`PID`, `PName`) VALUES (103, 'James');
INSERT INTO `PROJECT2_W23`.`Professor` (`PID`, `PName`) VALUES (104, 'Dawson');
INSERT INTO `PROJECT2_W23`.`Professor` (`PID`, `PName`) VALUES (105, 'Mike');

COMMIT;


-- -----------------------------------------------------
-- Data for table `PROJECT2_W23`.`Professor_has_Course`
-- -----------------------------------------------------
START TRANSACTION;
USE `PROJECT2_W23`;
INSERT INTO `PROJECT2_W23`.`Professor_has_Course` (`Professor_PID`, `Course_Code`) VALUES (101, 201);
INSERT INTO `PROJECT2_W23`.`Professor_has_Course` (`Professor_PID`, `Course_Code`) VALUES (101, 205);
INSERT INTO `PROJECT2_W23`.`Professor_has_Course` (`Professor_PID`, `Course_Code`) VALUES (102, 201);
INSERT INTO `PROJECT2_W23`.`Professor_has_Course` (`Professor_PID`, `Course_Code`) VALUES (103, 203);
INSERT INTO `PROJECT2_W23`.`Professor_has_Course` (`Professor_PID`, `Course_Code`) VALUES (104, 202);
INSERT INTO `PROJECT2_W23`.`Professor_has_Course` (`Professor_PID`, `Course_Code`) VALUES (104, 204);
INSERT INTO `PROJECT2_W23`.`Professor_has_Course` (`Professor_PID`, `Course_Code`) VALUES (105, 205);

COMMIT;


-- -----------------------------------------------------
-- Data for table `PROJECT2_W23`.`Student`
-- -----------------------------------------------------
START TRANSACTION;
USE `PROJECT2_W23`;
INSERT INTO `PROJECT2_W23`.`Student` (`StudentID`, `Name`) VALUES (1, 'Adan');
INSERT INTO `PROJECT2_W23`.`Student` (`StudentID`, `Name`) VALUES (2, 'John');
INSERT INTO `PROJECT2_W23`.`Student` (`StudentID`, `Name`) VALUES (3, 'William');
INSERT INTO `PROJECT2_W23`.`Student` (`StudentID`, `Name`) VALUES (4 , 'Mohammad');
INSERT INTO `PROJECT2_W23`.`Student` (`StudentID`, `Name`) VALUES (5, 'Jack');
INSERT INTO `PROJECT2_W23`.`Student` (`StudentID`, `Name`) VALUES (6, 'Harry');
INSERT INTO `PROJECT2_W23`.`Student` (`StudentID`, `Name`) VALUES (7, 'Brown');
INSERT INTO `PROJECT2_W23`.`Student` (`StudentID`, `Name`) VALUES (8, 'Davis');
INSERT INTO `PROJECT2_W23`.`Student` (`StudentID`, `Name`) VALUES (9, 'Roy');
INSERT INTO `PROJECT2_W23`.`Student` (`StudentID`, `Name`) VALUES (10, 'Anderson');
INSERT INTO `PROJECT2_W23`.`Student` (`StudentID`, `Name`) VALUES (11, 'Girard');
INSERT INTO `PROJECT2_W23`.`Student` (`StudentID`, `Name`) VALUES (12, 'Taylor');
INSERT INTO `PROJECT2_W23`.`Student` (`StudentID`, `Name`) VALUES (13, 'Thomas');
INSERT INTO `PROJECT2_W23`.`Student` (`StudentID`, `Name`) VALUES (14, 'Luis');
INSERT INTO `PROJECT2_W23`.`Student` (`StudentID`, `Name`) VALUES (15, 'Tom');

COMMIT;

-- -----------------------------------------------------
-- Data for table `PROJECT2_W23`.`CourseTaken`
-- -----------------------------------------------------
START TRANSACTION;
USE `PROJECT2_W23`;
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (202, 1, 1, 2023);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (204, 1, 2, 2023);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (201, 2, 4, 2022);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (205, 2, 1, 2023);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (203, 3, 4, 2022);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (202, 4, 1, 2023);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (204, 4, 1, 2023);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (201, 5, 3, 2022);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (204, 5, 4, 2022);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (205, 5, 1, 2023);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (204, 6, 3, 2022);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (204, 6, 4, 2023);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (201, 7, 4, 2022);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (202, 7, 1, 2022);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (203, 8, 4, 2022);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (201, 9, 4, 2022);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (203, 9, 4, 2023);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (204, 9, 1, 2023);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (201, 10, 3, 2022);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (204, 10, 2, 2023);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (203, 11, 3, 2022);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (201, 12, 3, 2022);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (202, 13, 4, 2023);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (204, 13, 4, 2023);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (203, 14, 4, 2023);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (205, 14, 1, 2023);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (201, 15, 4, 2022);
INSERT INTO `PROJECT2_W23`.`CourseTaken` (`CourseCode`, `StudentID`, `term`, `year`) VALUES (205, 15, 1, 2023);

COMMIT;


-- -----------------------------------------------------
-- Data for table `PROJECT2_W23`.`Exam`
-- -----------------------------------------------------
START TRANSACTION;
USE `PROJECT2_W23`;
INSERT INTO `PROJECT2_W23`.`Exam` (`QuestionID`, `AssessmentID`, `CourseCode`, `StudentID`, `GradeReceived`) VALUES (QuestionID, AssessmentID, CourseCode, StudentID, GradeReceived);
INSERT INTO `PROJECT2_W23`.`Exam` (`QuestionID`, `AssessmentID`, `CourseCode`, `StudentID`, `GradeReceived`) VALUES (103, 1, 201, 10, 60);
INSERT INTO `PROJECT2_W23`.`Exam` (`QuestionID`, `AssessmentID`, `CourseCode`, `StudentID`, `GradeReceived`) VALUES (103, 1, 201, 12, 45);
INSERT INTO `PROJECT2_W23`.`Exam` (`QuestionID`, `AssessmentID`, `CourseCode`, `StudentID`, `GradeReceived`) VALUES (104, 1, 201, 15, 71);
INSERT INTO `PROJECT2_W23`.`Exam` (`QuestionID`, `AssessmentID`, `CourseCode`, `StudentID`, `GradeReceived`) VALUES (105, 2, 201, 2, 34);
INSERT INTO `PROJECT2_W23`.`Exam` (`QuestionID`, `AssessmentID`, `CourseCode`, `StudentID`, `GradeReceived`) VALUES (105, 2, 201, 7, 87);
INSERT INTO `PROJECT2_W23`.`Exam` (`QuestionID`, `AssessmentID`, `CourseCode`, `StudentID`, `GradeReceived`) VALUES (106, 2, 201, 2, 90);
INSERT INTO `PROJECT2_W23`.`Exam` (`QuestionID`, `AssessmentID`, `CourseCode`, `StudentID`, `GradeReceived`) VALUES (106, 2, 201, 9, 100);
INSERT INTO `PROJECT2_W23`.`Exam` (`QuestionID`, `AssessmentID`, `CourseCode`, `StudentID`, `GradeReceived`) VALUES (401, 5, 204, 1, 57);
INSERT INTO `PROJECT2_W23`.`Exam` (`QuestionID`, `AssessmentID`, `CourseCode`, `StudentID`, `GradeReceived`) VALUES (402, 1, 204, 6, 68);
INSERT INTO `PROJECT2_W23`.`Exam` (`QuestionID`, `AssessmentID`, `CourseCode`, `StudentID`, `GradeReceived`) VALUES (403, 1, 204, 10, 92);
INSERT INTO `PROJECT2_W23`.`Exam` (`QuestionID`, `AssessmentID`, `CourseCode`, `StudentID`, `GradeReceived`) VALUES (403, 1, 204, 13, 23);
INSERT INTO `PROJECT2_W23`.`Exam` (`QuestionID`, `AssessmentID`, `CourseCode`, `StudentID`, `GradeReceived`) VALUES (404, 2, 204, 9, 67);
INSERT INTO `PROJECT2_W23`.`Exam` (`QuestionID`, `AssessmentID`, `CourseCode`, `StudentID`, `GradeReceived`) VALUES (405, 2, 204, 5, 45);
INSERT INTO `PROJECT2_W23`.`Exam` (`QuestionID`, `AssessmentID`, `CourseCode`, `StudentID`, `GradeReceived`) VALUES (406, 2, 204, 4, 78);
INSERT INTO `PROJECT2_W23`.`Exam` (`QuestionID`, `AssessmentID`, `CourseCode`, `StudentID`, `GradeReceived`) VALUES (504, 2, 205, 14, 38);
INSERT INTO `PROJECT2_W23`.`Exam` (`QuestionID`, `AssessmentID`, `CourseCode`, `StudentID`, `GradeReceived`) VALUES (504, 2, 205, 15, 76);

COMMIT;

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

select * from student;










