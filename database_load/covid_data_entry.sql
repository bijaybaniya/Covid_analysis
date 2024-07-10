/*

SET datestyle = 'ISO, DMY';
\copy covid_death FROM '/Users/hazard/Desktop/Data Project/Covid_analysis/data_files/covid_death.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy covid_vaccinations FROM '/Users/hazard/Desktop/Data Project/Covid_analysis/data_files/covid_vaccinations.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
*/


COPY covid_death
FROM '/Users/hazard/Desktop/Data Project/Covid_analysis/data_files/covid_death.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY covid_vaccinations
FROM '/Users/hazard/Desktop/Data Project/Covid_analysis/data_files/covid_vaccinations.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

