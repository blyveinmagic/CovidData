/*
Covid Data Exploration
/*

-- Global Number of Cases and Deaths and Vaccinations 
select sum(vaccines.new_cases) as totalCases, sum(new_deaths) as totalDeaths, max(total_vaccinations) as totalVaccinations
from vaccines join deaths
on deaths.location = vaccines.location and deaths.date = vaccines.date

-- Comparing Daily Total Cases to Population for Each Country  -- 
select location, date, total_cases, population, (total_cases/population)*100 as infectionPercentage
from deaths 
where continent != ''
ORDER BY location, STR_TO_DATE(date, '%M/%D/%%%Y') 

-- Comparing Current Total Cases to Population for Each Country --
select location, population, max(total_cases) as currentTotalCases, (max(total_cases)/population)*100 as casePercentage
from deaths 
where continent != ''
group by location
order by currentTotalCases

-- Comparing Daily Deaths to Population for Each Country --
select location, date, total_deaths, population, (total_deaths/population)*100 as deathPercentage
from deaths
where continent != ''
order by location, STR_TO_DATE(date, '%M/%D/%%%Y')

-- Comparing Current Total Deaths to Population for Each Country --
select location, population, sum(new_deaths) as currentTotalDeaths, (sum(new_deaths)/population)*100 as deathPercentage
from deaths
where continent != ''
group by location 
order by currentTotalDeaths desc

-- Comparing Total Cases to Total Deaths for Each Country --
select location, sum(new_cases) as totalCases, sum(new_deaths) as totalDeaths, sum(new_deaths)/sum(new_cases)*100 as deathPercentageIfInfected
from deaths
where continent != ''
group by location 
order by deathPercentageIfInfected desc

-- Comparing Daily Vaccines to Population for Each Country --
select location, date, population, total_vaccinations as totalVaccines, (total_vaccinations/population)*100 as vaccinationPercentages 
from vaccines
where continent != ''
order by location, STR_TO_DATE(date, '%M/%D/%%%Y')

-- Comparing Current Total Vaccines to Population for Each Country --
with totVac(location, population, currentTotalVaccines)
as
(
select location, population, sum(new_vaccinations) as currentTotalVaccines
from vaccines
where continent != ''
group by location
order by currentTotalVaccines desc
)
select *, (currentTotalVaccines/population)*100 as vaccinationPercentage
from totVac

-- Comparing Median Age and Case Percentage for Each Country -- 
select location, median_age as medianAge, (sum(new_cases)/population)*100 as casePercentage
from age
where continent != ''
group by location 
order by medianAge desc

-- Comparing GDP and Case Percentage for Each Country -- 
select location, gdp_per_capita as GDP, (sum(new_cases)/population)*100 as casePercentage
from gdp 
where continent != ''
group by location 
order by GDP desc 

-- Comparing Diabetes and Case Percentage for Each Country --
select location, diabetes_prevalence as diabetes, (sum(new_cases)/population)*100 as casePercentage
from diabetes 
where continent != ''
group by location 
order by diabetes desc 

-- Comparing Handwashing Facilities and Case Percentage for Each Country --
select location, handwashing_facilities as handwashingFacilities, (sum(new_cases)/population)*100 as casePercentage
from handwashing  
where continent != ''
group by location 
order by handwashingFacilities desc 

-- Comparing Life Expectancy and Case Percentage for Each Country --
select location, life_expectancy as lifeExpectancy, (sum(new_cases)/population)*100 as casePercentage
from life 
where continent != ''
group by location 
order by lifeExpectancy desc 

-- Comparing HDI and Case Percentage for Each Country --
select location, human_development_index as HDI, (sum(new_cases)/population)*100 as casePercentage
from hdi 
where continent != ''
group by location 
order by HDI desc 




