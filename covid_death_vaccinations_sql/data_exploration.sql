SELECT
    location,
    date,
    total_cases,
    new_cases,
    total_deaths,
    population
FROM covid_death
ORDER BY 1,2;



-- looking at total cases vs total deaths 
--which shows the percentage of people dying of Covid in Australia

SELECT
    location,
    date,
    total_cases,
    total_deaths,
    (total_deaths::FLOAT/total_cases)*100 AS death_percentage
FROM covid_death
WHERE location like '%Australia%'
AND continent IS NOT NULL
ORDER BY 1,2;


-- looking at total cases vs population
--to show what percentage of population have caught covid
SELECT
    location,
    date,
    total_cases,
    population,
    (total_cases::FLOAT/population)*100 AS infected_population_percentage
FROM covid_death
--WHERE location like '%States%'
ORDER BY 1,2;

--countries with highest infection rate compared to population
SELECT
    location,
    population,
    MAX(total_cases) AS total_infection_count,
    MAX((total_cases::FLOAT/population))*100 AS infected_population_percentage
FROM covid_death
GROUP BY location, population
HAVING  MAX((total_cases::FLOAT/population))*100 IS NOT NULL
ORDER BY infected_population_percentage DESC;


--To show countries with highest death count per population
SELECT
    location,
    MAx(total_deaths) AS total_death_count
FROM covid_death
WHERE continent IS NOT NULL
GROUP BY location
HAVING MAx(total_deaths) IS NOT NULL
ORDER BY total_death_count DESC;

--CONTINENT

--Continent with highest death count per population

SELECT
    continent,
    MAx(total_deaths::INT) AS total_death_count
FROM covid_death
WHERE continent IS NOT NULL
GROUP BY continent
HAVING MAx(total_deaths::INT) IS NOT NULL
ORDER BY total_death_count DESC;


-- Death percentages around the world
SELECT
    SUM(new_cases) AS new_total_cases,
    SUM(new_deaths) AS new_total_death,
    SUM(new_deaths)/SUM(new_cases)*100 as world_death_percent
FROM covid_death
WHERE continent IS NOT NULL
ORDER BY 1,2;


-- Joining the tables of death and vaccinations
--Checking what population has got vaccinations
SELECT 
     cd.continent,
     cd.location,
     cd.date,
     cd.population,
     cv.new_vaccinations,
     SUM(cv.new_vaccinations) OVER(PARTITION BY cd.location ORDER BY cd.location, cd.date) as PeopleVaccinated
FROM covid_death cd
JOIN covid_vaccinations cv 
    ON cd.location = cv.location
    AND cd.date = cv.date
WHERE cd.continent IS NOT NULL
ORDER BY 2,3;


--Creating CTEs to complete the above code 

WITH VacinatedPopulation (continent, location, date, population,new_vaccinations, PeopleVaccinated)
AS(
    SELECT 
        cd.continent,
        cd.location,
        cd.date,
        cd.population,
        cv.new_vaccinations,
        SUM(cv.new_vaccinations) OVER(PARTITION BY cd.location ORDER BY cd.location, cd.date) as PeopleVaccinated
    FROM covid_death cd
    JOIN covid_vaccinations cv 
        ON cd.location = cv.location
        AND cd.date = cv.date
    WHERE cd.continent IS NOT NULL
    ORDER BY 2,3
)

SELECT 
    *,
    (VacinatedPopulation/population)*100 AS vaccination_per_population
FROM VacinatedPopulation;




--For Tableau
SELECT
    location,
    SUM(new_deaths) AS new_total_death
FROM covid_death
WHERE continent IS NULL
AND location NOT IN ('World','European Union','International')
GROUP BY location
ORDER BY new_total_death DESC;

SELECT
    location, 
    population, 
    MAX(total_cases) AS HighestInfectionCount,  
    Max((total_cases::FLOAT/population))*100 AS PercentPopulationInfected
FROM covid_death
GROUP BY 
    location, 
    population
ORDER BY PercentPopulationInfected DESC;


Select 
    location,
    population,
    date,
    MAX(total_cases) AS HighestInfectionCount,  
    Max((total_cases::FLOAT/population))*100 as PercentPopulationInfected
From covid_death
GROUP BY
    location, 
    population,
    date
ORDER BY PercentPopulationInfected DESC;
