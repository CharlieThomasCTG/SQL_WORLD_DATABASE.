
/* Specifying the Database Context*/
Use SalesDW2;

/*Stored procedure to rename the column 'code' to 'CountryCODE' */
--EXEC sp_rename 'dbo.country.code', 'CountryCode', 'COLUMN';

/* inspecting the table dbo.city*/
Select * from dbo.city;

/* inspecting the table dbo.country*/
Select * from dbo.country;

/* inspecting the table dbo.countryLanguage*/
Select * from dbo.countryLanguage;


/* Updating the Column'Population' in Country table where the Country population is less than City Population */

UPDATE dbo.country
SET Population = CI.Population
FROM Country as C
JOIN City As CI  ON C.CountryCode = CI.CountryCode
WHERE CI.CountryCode in(
                        SELECT
							C.CountryCode
						FROM 
							dbo.country AS C
						JOIN 
							dbo.city AS CI ON C.countrycode = CI.Countrycode
						where C.name = C.name  
						Group by 
							C.Name, C.Countrycode, c.Population 
						Having 
							(C.Population - sum(CI.Population)) <= 0);

/* ASSIGNMENT QUESTION*/


/*1. Count Cities in USA: Scenario: You've been tasked with conducting a 
     demographic analysis of cities in the United States. Your first step 
	 is to determine the total number of cities within the country to provide 
	 a baseline for further analysis.
*/

SELECT 
	COUNT( DISTINCT name) as [Total Number of Cities in USA]
FROM 
	dbo.city
WHERE 
	CountryCode = 'USA';

/*2. Country with Highest Life Expectancy: Scenario: As part of a global health
     initiative, you've been assigned to identify the country with the highest 
	 life expectancy. This information will be crucial for prioritizing healthcare 
	 resources and interventions.
*/

SELECT 
	TOP 1 name AS [Country name], Lifeexpectancy AS [Life expectancy in years] 
FROM 
	dbo.country 
ORDER BY 
	lifeexpectancy DESC;

/*3. "New Year Promotion: Featuring Cities with 'New : Scenario: In anticipation of the upcoming New Year, 
      your travel agency is gearing up for a special promotion featuring cities with names including the word 'New'. 
	  You're tasked with swiftly compiling a list of all cities from around the world. This curated selection will be
	  essential in creating promotional materials and enticing travellers with exciting destinations to kick off the 
	  New Year in style.
*/

SELECT 
	name AS [City Name that includes 'New' word] 
FROM 
	dbo.city 
WHERE
	name like '%new%'
ORDER BY 
	name ASC;

/*4. Display Columns with Limit (First 10 Rows): Scenario: You're tasked with providing a brief overview of the most populous
     cities in the world. To keep the report concise, you're instructed to list only the first 10 cities by population from the database.
*/

SELECT 
	top 10 name AS [Cities with highest Population],Population 
FROM 
	dbo.city 
ORDER BY 
	population DESC;

/*5. Cities with Population Larger than 2,000,000: Scenario: A real estate developer is interested in cities with substantial population sizes 
     for potential investment opportunities. You're tasked with identifying cities from the database with populations exceeding 2 million to focus
	 their research efforts.
*/

SELECT 
	name AS [Cities with population over 2 million],Population 
FROM 
	dbo.city 
WHERE
	population > 2000000
ORDER BY 
	population DESC;

/*6. Cities Beginning with 'Be' Prefix: Scenario: A travel blogger is planning a series of articles featuring cities with unique names. 
     You're tasked with compiling a list of cities from the database that start with the prefix 'Be' to assist in the blogger's content creation process.
*/
SELECT 
	Distinct name AS [Cities Beginning  with 'Be'] 
FROM 
	dbo.city 
WHERE
	name LIKE 'Be%'
ORDER BY 
	name;

/*7. Cities with Population Between 500,000-1,000,000: Scenario: An urban planning committee needs to identify mid-sized cities suitable for infrastructure 
     development projects. You're tasked with identifying cities with populations ranging between 500,000 and 1 million to inform their decision-making process.
*/
SELECT 
	Distinct name AS [Cities with population(500K to 1 Million)],Population 
FROM 
	dbo.city 
WHERE
	population BETWEEN 500000 AND 1000000
ORDER BY 
	population DESC;

/*8. Display Cities Sorted by Name in Ascending Order: Scenario: A geography teacher is preparing a lesson on alphabetical order using city names. You're tasked 
     with providing a sorted list of cities from the database in ascending order by name to support the lesson plan.
*/
SELECT 
	Distinct name AS [City Name] 
FROM 
	dbo.city 
ORDER BY 
	name ASC;


/*9. Most Populated City: Scenario: A real estate investment firm is interested in cities with significant population densities for potential development projects. 
     You're tasked with identifying the most populated city from the database to guide their investment decisions and strategic planning.
*/
SELECT 
	Top 1 name AS [Most Populated City],Population 
FROM 
	dbo.city 
ORDER BY 
	population DESC;

/*10. City Name Frequency Analysis: Supporting Geography Education Scenario: In a geography class, students are learning about the distribution of city names around 
      the world. The teacher, in preparation for a lesson on city name frequencies, wants to provide students with a list of unique city names sorted alphabetically, 
	  along with their respective counts of occurrences in the database. You're tasked with this sorted list to support the geography teacher's l
*/
SELECT 
	name AS [City Name], Count(Name) as [Frequency]
FROM
	city
GROUP BY
	name
ORDER BY
	name;
/*11. City with the Lowest Population: Scenario: A census bureau is conducting an analysis of urban population distribution. You're tasked with identifying the city
      with the lowest population from the database to provide a comprehensive overview of demographic trends.
*/
SELECT 
	TOP 1 name AS [Least Populated City],Population 
FROM 
	dbo.city 
ORDER BY 
	population ASC;


/*12. Country with Largest Population: Scenario: A global economic research institute requires data on countries with the largest populations for a comprehensive analysis.
      You're tasked with identifying the country with the highest population from the database to provide valuable insights into demographic trends.
*/
SELECT 
	TOP 1 name AS [Most Populated Country], Population 
FROM 
	dbo.country 
ORDER BY 
	population DESC;

/*13. Capital of Spain: Scenario: A travel agency is organizing tours across Europe and needs accurate information on capital cities. You're tasked with identifying the 
      capital of Spain from the database to ensure itinerary accuracy and provide travellers with essential destination information.
*/

SELECT 
    C.Name AS Country,
    CI.Name AS CapitalCity
FROM 
    dbo.country AS C
JOIN 
    dbo.city AS CI ON CI.ID = C.Capital
WHERE
	C.countrycode='ESP';

/*14. Country with Highest Life Expectancy: Scenario: A healthcare foundation is conducting research on global health indicators. You're tasked with identifying the country
      with the highest life expectancy from the database to inform their efforts in improving healthcare systems and policies.
*/

SELECT 
	TOP 1 name AS [Country name], Lifeexpectancy AS [Life expectancy in years] 
FROM 
	dbo.country 
ORDER BY 
	lifeexpectancy DESC;

/*15. Cities in Europe: Scenario: A European cultural exchange program is seeking to connect students with cities across the continent. You're tasked with compiling a list 
      of cities located in Europe from the database to facilitate program planning and student engagement.
*/
SELECT 
	C.name AS [European City Name]
FROM 
	dbo.city AS C 
INNER JOIN
	dbo.country AS Co
ON
	C.CountryCode = Co.CountryCode
WHERE 
	CO.continent = 'Europe'
Order by
	C.name;
;
/*16. Average Population by Country: Scenario: A demographic research team is conducting a comparative analysis of population distributions across countries. You're tasked
      with calculating the average population for each country from the database to provide valuable insights into global population trends.
*/
SELECT Cast(round(AVG(CAST(Population AS DECIMAL(30, 2))),0) AS INT) AS [Total Population] FROM dbo.country;

/*17. Capital Cities Population Comparison: Scenario: A statistical analysis firm is examining population distributions between capital cities worldwide. You're tasked with
      comparing the populations of capital cities from different countries to identify trends and patterns in urban demographics.
*/
SELECT 
    C.Name AS Country,
    CI.Name AS CapitalCity,
    CI.Population AS Population
FROM 
    dbo.country AS C
JOIN 
    dbo.city AS CI ON CI.ID = C.Capital
ORDER BY 
     CI.Population DESC;


  
/*18. Countries with Low Population Density: Scenario: An agricultural research institute is studying countries with low population densities for potential agricultural
      development projects. You're tasked with identifying countries with sparse populations from the database to support the institute's research efforts.
*/
 SELECT name, CAST(ROUND((Population/SurfaceArea),2) AS DECIMAL(10,2)) AS Density from dbo.country
 WHERE (Population/SurfaceArea) between 0.1 and 10
 Order by (Population/SurfaceArea); 

/*19. Cities with High GDP per Capita: Scenario: An economic consulting firm is analyzing cities with high GDP per capita for investment opportunities. You're tasked with
      identifying cities with above-average GDP per capita from the database to assist the firm in identifying potential investment destinations.*/
SELECT 
    CI.Name AS City,
	C.Name AS Country,
    CAST(round((((C.GNP*1000000)*(CAST ((CI.population) AS decimal(10,2))/ C.population)))/CI.Population,2)AS decimal(10,2)) as [GDP per Capita]

FROM 
    dbo.country AS C
JOIN 
    dbo.city AS CI ON C.countrycode = CI.Countrycode
WHERE   CAST(round((((C.GNP*1000000)*(CAST ((CI.population) AS decimal(10,2))/ C.population)))/CI.Population,2)AS decimal(10,2))>(SELECT 
						AVG(CAST(round((((C.GNP*1000000)*(CAST ((CI.population) AS decimal(10,2))/ C.population)))/CI.Population,2)AS decimal(10,2)))
				   FROM 
                        dbo.country AS C
                   JOIN 
                        dbo.city AS CI ON C.countrycode = CI.Countrycode)
ORDER BY
	[GDP per Capita] DESC;

                                           
/*20. Display Columns with Limit (Rows 31-40): Scenario: A market research firm requires detailed information on cities beyond the top rankings for a comprehensive analysis.
      You're tasked with providing data on cities ranked between 31st and 40th by population to ensure a thorough understanding of urban demographics.
*/
SELECT 
    Name AS [City Name],
    Population
FROM 
    dbo.city
ORDER BY 
    Population DESC
OFFSET 30 ROWS
FETCH NEXT 10 ROWS ONLY;

