Select *
From PortfolioProject1..CovidDeaths
order by 3,4

--Select *
--From PortfolioProject1..CovidVaccinations
--order by 3,4

--Select Data that we are going to be using

Select location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject1..CovidDeaths
order by 1,2

--Looking at total cases vs total deaths
-- Shows the likelyhood of dying if you contact covid in your country

Select location, date, total_cases, total_deaths, (total_deaths/nullif (total_cases,0)*100) as DeathPercentage
From PortfolioProject1..CovidDeaths
where location like '%states%'
order by 1,2

-- Looking at the total cases vs population
-- Shows what percentage of population got covid

Select location, date, population, total_cases, (total_cases/nullif (population,0)*100) as PercentPopulationInfected
From PortfolioProject1..CovidDeaths
--where location like '%nigeria%'
order by 1,2

-- Looking at countries with highest infection rate compared to population

Select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject1..CovidDeaths
--where location like '%nigeria%'
Group by location, population
order by PercentPopulationInfected desc

-- Showing the countries with Highest Death Count per Population

Select Location, MAX(total_deaths) as TotalDeathCount
From PortfolioProject1..CovidDeaths
--where location like '%nigeria%'
where continent is not null
Group by location
order by TotalDeathCount desc

-- LET'S BREAK THINGS DOWN BY CONTINENT

Select location, MAX(total_deaths) as TotalDeathCount
From PortfolioProject1..CovidDeaths
--where location like '%nigeria%'
where continent is null
Group by location
order by TotalDeathCount desc

-- Breaking it down by continent (MAIN)


-- Showing the continent with the highest death count per population

Select continent, MAX(total_deaths) as TotalDeathCount
From PortfolioProject1..CovidDeaths
--where location like '%nigeria%'
where continent is not null
Group by continent
order by TotalDeathCount desc

-- GLOBAL NUMBERS

-- Sorted by date
Select date, SUM(nullif (new_cases, 0)) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, (SUM(cast(new_deaths as int))/SUM(nullif (new_cases, 0)*100)) as DeathPercentage
From PortfolioProject1..CovidDeaths
-- where location like '%states%'
where continent is not null
Group by date
order by 1,2

-- Not sort by Date
Select SUM(nullif (new_cases, 0)) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, (SUM(cast(new_deaths as int))/SUM(nullif (new_cases, 0)*100)) as DeathPercentage
From PortfolioProject1..CovidDeaths
-- where location like '%states%'
where continent is not null
--Group by date
order by 1,2

-- Looking at Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population
From PortfolioProject1..CovidDeaths dea
Join PortfolioProject1..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 1,2,3
