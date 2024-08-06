# Olympic-Case-Study-Using-SQL


Olympic Case Study
Overview
This case study aims to analyze historical data from the Olympic Games to extract meaningful insights and trends. Using SQL, we will explore various aspects of the data, such as medal distribution, top-performing countries, athlete demographics, and more.

Dataset Description
The primary dataset used in this study is the athlete_events table, which contains information about athletes, events, and medals. Additionally, the noc_regions table provides information about National Olympic Committees (NOCs) and their respective regions.

athlete_events Table
Column	Data Type	Description
ID	int	Unique identifier for each athlete
Name	text	Name of the athlete
Sex	text	Gender of the athlete ('M' for Male, 'F' for Female)
Age	int	Age of the athlete during the event
Height	int	Height of the athlete in centimeters
Weight	int	Weight of the athlete in kilograms
Team	text	Team name
NOC	text	National Olympic Committee (NOC) code
Games	text	Year and season of the Olympic Games
Year	int	Year of the Olympic Games
Season	text	Season of the Olympic Games (Summer or Winter)
City	text	Host city of the Olympic Games
Sport	text	Sport in which the athlete competed
Event	text	Event in which the athlete competed
Medal	text	Type of medal won (Gold, Silver, Bronze, or NULL)
noc_regions Table
Column	Data Type	Description
NOC	text	National Olympic Committee (NOC) code
region	text	Region or country name
notes	text	Additional notes
Analysis Objectives
Total Medal Count by Country:

List the total number of gold, silver, and bronze medals won by each country.
Top Countries by Medals in Each Olympic Games:

Identify the countries that won the most gold, silver, and bronze medals in each Olympic Games.
Demographic Analysis:

Find the details of the oldest athlete to win a gold medal.
Calculate the ratio of male to female participants in the Olympic Games.
Athlete Performance:

List the top 5 athletes with the most medals.
Identify the most successful countries in the Olympics based on total medals won.
