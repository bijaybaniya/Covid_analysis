--creating view for visualisation using tableau
CREATE VIEW vaccination_per_population AS
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