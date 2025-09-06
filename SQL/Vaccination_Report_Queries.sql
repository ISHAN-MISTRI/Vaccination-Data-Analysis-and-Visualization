-- creating empty tables

DROP TABLE IF EXISTS vaccination.coverage_data;

CREATE TABLE vaccination.coverage_data (
    group_type VARCHAR(50),
    code VARCHAR(50),   
    name VARCHAR(150),
    year INT,
    antigen VARCHAR(50),
    antigen_description TEXT,
    coverage_category VARCHAR(50),
    coverage_category_description TEXT,
    target_number NUMERIC,
    doses NUMERIC,
    coverage NUMERIC
);


DROP TABLE IF EXISTS vaccination.incidence_rate_data;

CREATE TABLE vaccination.incidence_rate_data (
    group_type VARCHAR(50),
    code VARCHAR(10),
    name VARCHAR(150),
    year INT,
    disease VARCHAR(50),
    disease_description TEXT,
    denominator VARCHAR(100),
    incidence_rate NUMERIC
);

DROP TABLE IF EXISTS vaccination.reported_cases_data;

CREATE TABLE vaccination.reported_cases_data (
    group_type VARCHAR(50),
    code VARCHAR(10),
    name VARCHAR(150),
    year INT,
    disease VARCHAR(50),
    disease_description TEXT,
    cases NUMERIC
);

DROP TABLE IF EXISTS vaccination.vaccine_introduction_data;

CREATE TABLE vaccination.vaccine_introduction_data (
    iso_3_code VARCHAR(10),
    countryname VARCHAR(150),
    who_region VARCHAR(20),
    year INT,
    description TEXT,
    intro VARCHAR(10)
);

DROP TABLE IF EXISTS vaccination.vaccine_schedule_data;

CREATE TABLE vaccination.vaccine_schedule_data (
    iso_3_code VARCHAR(10),
    countryname VARCHAR(150),
    who_region VARCHAR(20),
    year INT,
    vaccinecode VARCHAR(50),
    vaccine_description TEXT,
    schedulerounds NUMERIC,
    targetpop VARCHAR(50),
    targetpop_description TEXT,
    geoarea VARCHAR(50),
    ageadministered VARCHAR(50),
    sourcecomment TEXT
);


-- copying the data in tables

COPY vaccination.coverage_data
FROM 'C:/Program Files/PostgreSQL/17/data/coverage_data.csv'
DELIMITER ','
CSV HEADER;

COPY vaccination.incidence_rate_data
FROM 'C:/Program Files/PostgreSQL/17/data/incidence_rate.csv'
DELIMITER ','
CSV HEADER;

COPY vaccination.reported_cases_data
FROM 'C:/Program Files/PostgreSQL/17/data/reported_cases.csv'
DELIMITER ','
CSV HEADER;

COPY vaccination.vaccine_introduction_data
FROM 'C:/Program Files/PostgreSQL/17/data/vaccine_introduction.csv'
DELIMITER ','
CSV HEADER;

COPY vaccination.vaccine_schedule_data
FROM 'C:/Program Files/PostgreSQL/17/data/vaccine_schedule.csv'
DELIMITER ','
CSV HEADER;

-- preview of the data

SELECT COUNT(*) FROM vaccination.incidence_rate_data;
SELECT COUNT(*) FROM vaccination.reported_cases_data;
SELECT COUNT(*) FROM vaccination.vaccine_introduction_data;
SELECT COUNT(*) FROM vaccination.vaccine_schedule_data;


-- Sample preview from each table
SELECT * FROM vaccination.coverage_data LIMIT 5;
SELECT * FROM vaccination.incidence_rate_data LIMIT 5;


-- representative SQL queries answering key questions

-- Join vaccination coverage with reported cases (by country & year)
SELECT c.name, c.year, c.antigen, c.coverage, r.disease, r.cases
FROM vaccination.coverage_data c
JOIN vaccination.reported_cases_data r
    ON c.code = r.code AND c.year = r.year
LIMIT 20;

-- Average coverage by WHO region
SELECT v.who_region, AVG(c.coverage) AS avg_coverage
FROM vaccination.coverage_data c
JOIN vaccination.vaccine_introduction_data v
    ON c.code = v.iso_3_code
WHERE c.coverage IS NOT NULL
GROUP BY v.who_region
ORDER BY avg_coverage DESC;

-- Top 5 countries by average coverage
SELECT 
    name AS country,
    ROUND(AVG(coverage), 2) AS avg_coverage
FROM vaccination.coverage_data
WHERE coverage IS NOT NULL
GROUP BY name
ORDER BY avg_coverage DESC
LIMIT 5;

-- Q: Bottom 5 countries by average coverage
SELECT 
    c.name AS country,
    ROUND(AVG(c.coverage), 2) AS avg_coverage
FROM vaccination.coverage_data c
WHERE c.coverage IS NOT NULL
GROUP BY c.name
ORDER BY avg_coverage ASC
LIMIT 5;


-- Q: Global average incidence rate of Measles by year
SELECT 
    i.year,
    ROUND(AVG(i.incidence_rate), 2) AS avg_incidence
FROM vaccination.incidence_rate_data i
WHERE i.disease_description ILIKE '%measles%'
  AND i.incidence_rate IS NOT NULL
GROUP BY i.year
ORDER BY i.year;

-- Q: Relationship between measles vaccine coverage and measles incidence
-- Uses antigen MCV* (measles-containing vaccines)
SELECT 
    c.name        AS country,
    c.year,
    c.coverage    AS measles_vax_coverage,
    i.incidence_rate AS measles_incidence_rate
FROM vaccination.coverage_data c
JOIN vaccination.incidence_rate_data i
  ON c.code = i.code AND c.year = i.year
WHERE (c.antigen ILIKE 'MCV%' OR c.antigen ILIKE '%MEAS%')
  AND i.disease_description ILIKE '%measles%'
  AND c.coverage IS NOT NULL
  AND i.incidence_rate IS NOT NULL
ORDER BY c.year, country;



-- Q: Which WHO regions have the highest average disease incidence?
SELECT 
    v.who_region,
    ROUND(AVG(i.incidence_rate), 2) AS avg_incidence
FROM vaccination.incidence_rate_data i
JOIN vaccination.vaccine_introduction_data v
  ON i.code = v.iso_3_code
WHERE i.incidence_rate IS NOT NULL
GROUP BY v.who_region
ORDER BY avg_incidence DESC
LIMIT 5;

-- Q: Relationship between Polio vaccine coverage (POL3) and Polio incidence
SELECT 
    c.name        AS country,
    c.year,
    c.coverage    AS polio_vax_coverage,
    i.incidence_rate AS polio_incidence_rate
FROM vaccination.coverage_data c
JOIN vaccination.incidence_rate_data i
  ON c.code = i.code AND c.year = i.year
WHERE c.antigen = 'POL3'
  AND i.disease_description ILIKE '%polio%'
  AND c.coverage IS NOT NULL
  AND i.incidence_rate IS NOT NULL
ORDER BY c.year, country;


-- Q: Trend of TB reported cases globally over time
SELECT 
    r.year,
    SUM(r.cases) AS total_tb_cases
FROM vaccination.reported_cases_data r
WHERE r.disease_description ILIKE '%tuberculosis%'
  AND r.cases IS NOT NULL
GROUP BY r.year
ORDER BY r.year;



