-- select *
-- from covid19.covid;

SELECT 
    location, total_cases, new_cases, total_deaths, population
FROM
    covid19.coviddeaths
ORDER BY 1 , 2

-- Looking at Total Cases vs Total Deaths in Europe
SELECT 
    location,
    date,
    total_cases,
    total_deaths,
    (total_deaths / total_cases) * 100 AS DeathPercentage
FROM
    covid19.coviddeaths
WHERE
    location LIKE 'Europe'
ORDER BY location , STR_TO_DATE(date, '%d.%m.%Y') , date;

-- Looking at Total Cases vs Population in Europe
-- Shows what percentage of population got Covid
SELECT 
    location,
    date,
    population,
    total_cases,
    (total_cases / population) * 100 AS TotalPercentageInfected
FROM
    covid19.coviddeaths
WHERE
    location LIKE 'Europe'
ORDER BY location , STR_TO_DATE(date, '%d.%m.%Y') , date;

-- Looking at Countries with highest infection rate to population
SELECT 
    location,
    population,
    MAX(total_cases) AS HighestInfectionCount,
    MAX((total_cases / population)) * 100 AS PercentPopulationInfected
FROM
    covid19.coviddeaths
GROUP BY location , population
ORDER BY PercentPopulationInfected DESC;

-- Showing countries with highest death count per population
SELECT 
    location, TotalDeathCount
FROM
    (SELECT 
        location,
            MAX(CAST(total_deaths AS SIGNED)) AS TotalDeathCount
    FROM
        covid19.coviddeaths
    GROUP BY location) AS subquery
ORDER BY TotalDeathCount DESC;

-- Showing continents with highest death count per population
SELECT 
    continent, TotalDeathCount
FROM
    (SELECT 
        continent,
            MAX(CAST(total_deaths AS SIGNED)) AS TotalDeathCount
    FROM
        covid19.coviddeaths
    GROUP BY continent) AS subquery
WHERE
    continent IS NOT NULL
ORDER BY TotalDeathCount DESC;