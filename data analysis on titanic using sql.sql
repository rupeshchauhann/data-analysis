--1.	What is the overall survival rate of Titanic on the Titanic?
--Calculate the percentage of Titanic who survived.
SELECT 
    SUM(Survived) AS TotalSurvived,
    COUNT(*) AS TotalOnTitanic,
    cast(SUM(Survived) * 100.0 / COUNT(*) as decimal(10,2)) AS SurvivalRatePercentage
FROM Titanic;

--2.	How does survival rate vary by gender?
--Compare the survival rates between male and female Titanic.
with cte as (SELECT 
    Sex,
    SUM(Survived) AS TotalSurvived,
    COUNT(*) AS TotalOnTitanic,
    cast(SUM(Survived) * 100.0 / COUNT(*) as decimal(10,2)) AS SurvivalRatePercentage
FROM Titanic
GROUP BY Sex)
select *, 100 - SurvivalRatePercentage 'DeathRate' from cte

--3.	Did Titanic in certain passenger classes have a better chance of survival?
--Analyze the survival rates among different passenger classes (e.g., first    class, second class, third class).
SELECT 
    Pclass,
    SUM(Survived) AS TotalSurvived,
    COUNT(*) AS TotalOnTitanic,
    cast(SUM(Survived) * 100.0 / COUNT(*) as decimal(10,2)) AS SurvivalRatePercentage
FROM Titanic
GROUP BY Pclass order by Pclass;

--4.	What was the survival rate among different age groups?
--Divide Titanic into age groups (e.g., children, adults, seniors) and analyze their survival rates.
SELECT 
    CASE
        WHEN Age < 18 THEN 'Child'
        WHEN Age >= 18 AND Age < 65 THEN 'Adult'
        ELSE 'Senior'
    END AS AgeGroup,
    SUM(Survived) AS TotalSurvived,
    COUNT(*) AS TotalOnTitanic,
    cast(SUM(Survived) * 100.0 / COUNT(*) as decimal(10,2)) AS SurvivalRatePercentage
FROM Titanic
GROUP BY
    CASE
        WHEN Age < 18 THEN 'Child'
        WHEN Age >= 18 AND Age < 65 THEN 'Adult'
        ELSE 'Senior'
    END;

--5.	Did Titanic traveling with family members have a better chance of survival?
--Compare the survival rates of Titanic traveling alone versus Titanic traveling with family members.
SELECT 
    CASE
        WHEN SibSp + Parch > 0 THEN 'With Family'
        ELSE 'Alone'
    END AS TravelStatus,
    SUM(Survived) AS TotalSurvived,
    COUNT(*) AS TotalOnTitanic,
    cast(SUM(Survived) * 100.0 / COUNT(*) as decimal(10,2)) AS SurvivalRatePercentage
FROM Titanic
GROUP BY
    CASE
        WHEN SibSp + Parch > 0 THEN 'With Family'
        ELSE 'Alone'
    END;

--6.	Were Titanic who embarked from certain ports more likely to survive?
--Analyze the survival rates among Titanic who embarked from different   ports (e.g., Southampton, Cherbourg, Queenstown).
SELECT 
    Embarked,
    SUM(Survived) AS TotalSurvived,
    COUNT(*) AS TotalOnTitanic,
    cast(SUM(Survived) * 100.0 / COUNT(*) as decimal(10,2)) AS SurvivalRatePercentage
FROM Titanic
GROUP BY Embarked;

--SELECT COUNT(*) - COUNT(Embarked) AS CountNotNullEmbarked
--FROM Titanic;


--7.	What was the survival rate among Titanic with different titles (e.g., Mr., Mrs., Miss)?
--Extract titles from passenger names and analyze the survival rates among different titles.
SELECT 
    CASE 
        WHEN Name LIKE '%Mr.%' THEN 'Mr.'
        WHEN Name LIKE '%Mrs.%' THEN 'Mrs.'
        WHEN Name LIKE '%Miss%' THEN 'Miss'
        ELSE 'Others'
    END AS Title,
    SUM(Survived) AS TotalSurvived,
    COUNT(*) AS TotalOnTitanic,
    CAST(SUM(Survived) * 100.0 / COUNT(*) as decimal(10,2)) AS SurvivalRatePercentage
FROM Titanic
GROUP BY 
    CASE 
        WHEN Name LIKE '%Mr.%' THEN 'Mr.'
        WHEN Name LIKE '%Mrs.%' THEN 'Mrs.'
        WHEN Name LIKE '%Miss%' THEN 'Miss'
        ELSE 'Others'
    END;


--8.	How did fare prices vary among different passenger classes?
--Compare the fare prices paid by Titanic in first, second, and third class.
SELECT 
    Pclass,
    AVG(Fare) AS AvgFare,
    MIN(Fare) AS MinFare,
    MAX(Fare) AS MaxFare
FROM Titanic
GROUP BY Pclass;

--9.	Did having a cabin affect the survival rate?
--Analyze the survival rates of Titanic with and without cabins.
SELECT 
    CASE
        WHEN Cabin IS NULL THEN 'Without Cabin' 
        ELSE 'With Cabin' 
    END AS Cabins,
    SUM(Survived) AS TotalSurvived,
    COUNT(*) AS TotalOnTitanic,
    CAST(SUM(Survived) * 100.0 / COUNT(*) AS DECIMAL(10, 2)) AS SurvivalRatePercentage
FROM 
    Titanic
GROUP BY 
    CASE
        WHEN Cabin IS NULL THEN 'Without Cabin' 
        ELSE 'With Cabin' 
    END;


--10.	What was the survival rate among Titanic with missing data (e.g., missing age or cabin information)?
--Analyze the survival rates of Titanic with missing data in various fields.

SELECT 
    CASE
        WHEN Age IS NULL THEN 'Missing Age'
        WHEN Embarked IS NULL THEN 'Missing Embarkation'
        ELSE 'Other Missing Data'
    END AS MissingDataCategory,
    SUM(Survived) AS TotalSurvived,
    COUNT(*) AS TotalOnTitanic,
    cast(SUM(Survived) * 100.0 / COUNT(*) as decimal(10,2)) AS SurvivalRatePercentage
FROM Titanic
WHERE Age IS NULL OR Embarked IS NULL
GROUP BY
    CASE
        WHEN Age IS NULL THEN 'Missing Age'
        WHEN Embarked IS NULL THEN 'Missing Embarkation'
        ELSE 'Other Missing Data'
    END;
