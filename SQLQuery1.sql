SELECT total_cases,total_deaths,
CASE when total_cases<1 then 'Null'
when total_deaths<1 then 'Null'
else (total_deaths/total_cases)
end as Case_Fatality_rate
from Covid..[covid-deaths2]

Select *
from Covid..[covid-deaths2]
where date ='8/5/2021'


--lets check the case fatality rate 
Select location,date,total_cases,total_deaths,(total_deaths/total_cases) AS case_fatality_rate
from Covid..[covid-deaths2]
where total_cases>0 AND total_deaths>0
order by 2;

--Highest positivity rate per million
Select max(new_cases_per_million) as red_alert_country
from Covid..[covid-deaths2]

--Highest deaths per million
select max(total_deaths_per_million) as Highest_deaths_per_million
from Covid..[covid-deaths2]

--Total cases vs the population
--one could see how much percent of people got covid.
SELECT location,date,population,total_cases,(total_cases/population)*100 AS 
from Covid..[covid-deaths2]
where total_cases>0 and population>0
order by date

--Lets find out in which countries infection rate was the highest and at what time to see the peak.
SELECT location,max(total_cases) AS HighestCases, max((total_cases/population))*100 AS PercentPopulationInfected
from Covid..[covid-deaths2]
where population>0
group by location
order by 3 desc

--Showing countries with highest death count per population
SELECT location,max(total_deaths),max((total_deaths/population))*100 AS HighestDeathRate
from Covid..[covid-deaths2]
where population >0
group by location
order by 2 desc

--LEts see death-rate continent wise
SELECT continent,max(total_deaths),max((total_deaths/population))*100 as Death_rate_continets
from Covid..[covid-deaths2]
where population>0 
group by continent
order by 2 desc

--Lets see countries with the  highest death count
SELECT location,max(total_deaths)
from Covid..[covid-deaths2]
order by total_deaths

--Global number
--Comparing datewise where we were in 2020 vs  where we are now in 2021
SELECT date,sum(new_cases)
from Covid..[covid-deaths2]
group by date
order by date

--Checking the world total cases and world total deaths
SELECT SUM(new_cases) AS Total_Infections,SUM(new_deaths) AS Total_deaths, (sum(new_deaths)/sum(new_cases))*100
from Covid..[covid-deaths2]

SELECT *
FROM Covid..[covid-vacc]
order by date;

--lets look at the vaccination data of different countries
SELECT dea.location,dea.date,vac.new_vaccinations
FROM Covid..[covid-deaths2] dea
JOIN Covid..[covid-vacc] vac
	on dea.location = vac.location
	and dea.date = vac.date

--lets try to find out which countries have the highest vaccinated people till now
SELECT dea.location,dea.date,sum(vac.new_vaccinations)
FROM Covid..[covid-deaths2] dea
JOIN Covid..[covid-vacc] vac
	on dea.location=vac.location
	and dea.date=vac.date
WHERE dea.location != 'World' 
group by dea.location,dea.date, vac.new_vaccinations
order by vac.new_vaccinations


--CTE(Common table expression)
with cte_cov as
(select location,date,new_cases,new_deaths
from Covid..[covid-deaths2]
where population > 0
)
select location,sum(new_cases) AS Total_cases,sum(new_deaths) AS Total_deaths
from cte_cov
group by location
order by 2 desc

--Practice queries
--select *
--from Covid..[covid-deaths2]

--select *
--from Covid..[covid-deaths2]
--where population = 0

--select location,date,new_cases,new_deaths
--from Covid..[covid-deaths2]
--where population > 0