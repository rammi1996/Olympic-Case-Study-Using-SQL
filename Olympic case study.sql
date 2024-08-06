use olympic
select * from athlete_events;

# how many games  are held in olympic 

select count(distinct Games) AS total_games  from athlete_events;

## list down all olympic games held so far;

select distinct (games),year, city ,season from athlete_events
order by year DESc;

## write a sql query to fetch total no of countries participated in each olympic?

select * from athlete_events ;
select  Games,count(distinct Team) as total_countries from athlete_events
group by games
Order by total_countries DESC


## Which year saw the highest and lowest no of countries participating in olympics



select year, count(distinct team) as countries_count , Games from athlete_events 
group by games , year
having countries_count = (select min(countries_count) from (
                           select count( distinct team) as countries_count from athlete_events group by games , year) as lowest_country)
                           Or countries_count =(select max(countries_count) from (
                           select count(distinct team)  as countries_count from athlete_events group by games , year ) as highest_country)

 
   -- Other solution 
   
 SELECT 'Highest' AS type, Year, Season, total_teams FROM (
    SELECT Year, Season, COUNT(DISTINCT Team) AS total_teams
    FROM athlete_events
    GROUP BY Year, Season
    ORDER BY total_teams DESC
    LIMIT 1
) AS highest_participation

UNION ALL

SELECT 'Lowest' AS type, Year, Season, total_teams FROM (
    SELECT Year, Season, COUNT(DISTINCT Team) AS total_teams
    FROM athlete_events
    GROUP BY Year, Season
    ORDER BY total_teams ASC
    LIMIT 1
) AS lowest_participation;



## Which nation has participated in all of the olympic games

select * from athlete_events ;

select year , team as country , count(distinct games)As participate_game_count from 
athlete_events 
group by year , country
having  participate_game_count =  (select  count(distinct games) as participate_game_count
                               from athlete_events) 
order by participate_game_count DESC 


## sql Query to fetch the list of all sports  which have been  parts of every olympic ?

select count(Distinct games) as Games, sport from athlete_events 
group by sport
having Games = (select max(Games) from ( select count(distinct games) as Games from athlete_events  group by sport) as max_games);

-- Sql query which sport were just played once a year ?
select count(distinct games)  As Games , sport from athlete_events
group by sport 
having Games= (select min(Games) from ( select count(distinct games) as Games from athlete_events group by sport) as min_games);

## write a query total no of sport played in  each olympic

select games, count(distinct sport) as total_sport_olympic
from athlete_events
group by games
order by  total_sport_olympic DESC;

## Query to fetch details of oldest athlete to win gold medal at olympic

with old_medal As(
select name, Team, count(medal) as total_medal,medal, age   from athlete_events
group by name , team ,age , medal
order by age DESC)
, t2 As (
select * , rank() over( order by age DESC) as rnk
from old_medal
where medal='gold')
select *  from t2
where rnk =1;
 
 

## sql query to find the ratio of male and female  participants 
select * from athlete_events 


SELECT 
    SUM(CASE WHEN sex = 'M' THEN 1 ELSE 0 END) AS male_count,
    SUM(CASE WHEN sex = 'F' THEN 1 ELSE 0 END) AS female_count,
    (SUM(CASE WHEN sex = 'M' THEN 1 ELSE 0 END) / SUM(CASE WHEN sex = 'F' THEN 1 ELSE 0 END)) AS male_female_ratio
FROM 
    athlete_events;

## sql query to fetch the top 5 Athletes who won the most  gold medals

select * from athlete_events ;

with medal as(
select name ,Team, count(medal) As Total_gold_medal from 
athlete_events
where medal='gold'
group by name, team
order by count(medal) DESC) 
,t2 as
     (select * , dense_rank() over(order by Total_gold_medal desc) as rnk
     from medal)
select * from t2
where rnk <=5


## Sql query to fetch thr top 5 athlete whon won the most medals (Medals include gold, silver and bronze)

with medal as (
select name , team , count(medal) as total_medal
from athlete_events 
where medal in ('gold','silver','bronze')
group by name,  team
order by count(medal) DESC )
, t2 as (
select * , dense_rank() over( order by  total_medal DESC) as rnk
from medal)
select  name , team , total_medal from t2
where rnk <=5;

## Sql query to find  5 most successful countries in olympic ( Success is defined by no of medals won.)

select * from athlete_events ;
select * from noc_regions

with medal as(
select nc.region , count(medal) as total_medal
from athlete_events  ae
join noc_regions nc
on ae.NOC=nc.NOC
where medal <>'NA'
group by nc.region
order by total_medal DESC)
,t2 as ( select *, dense_rank() over(order by total_medal DESC) as rnk
        from medal)
select * from t2
where rnk <=5;

## List down total gold, silver and bronze medals won by each country.

select nr.region AS country , 
SUM(case when ae.medal='gold' then 1 else 0 end) as Total_gold,
SUM(case when ae.medal='silver' then 1 else 0 end) as Total_silver,
SUM(Case when ae.medal='Bronze' then 1 else 0 end) as Total_bronze
from athlete_events  ae
join noc_regions nr
ON ae.NOC=nr.NOC
where medal<>'NA'
group by nr.region
order by Total_gold DESC;

## List down total gold, silver and bronze medals won by each country corresponding to each olympic games.

select nr.region as Country, ae.games,
SUM(CASE when ae.medal='gold' then 1 else 0 End) as gold_medal,
SUM(Case when ae.medal='silver' then 1 else 0 END) As silver_medal,
SUM(Case when ae.medal='Bronze' then 1 else 0 END) As bronze_silver
from athlete_events ae
join noc_regions  nr on nr.NOC=ae.NOC
where ae.medal<>'NA'
group by Country, ae.games
order by gold_medal DESC

-- Write a SQL Query to fetch details of countries which have won silver or bronze medal but never won a gold medal

with medal as (
select nr.region as country , 
Sum( Case when ae.medal='gold' then 1 else 0 end)  as gold_medals,
Sum( Case when ae.medal='silver' then 1 else 0 end)  as silver_medals,
Sum( Case when ae.medal='bronze' then 1 else 0 end)  as bronze_medals
from athlete_events ae
join noc_regions nr on ae.noc=nr.noc
where medal<>'NA'
group by country 
order by gold_medals DESC
)
select * from medal where gold_medals =0
order by country;


## - Write SQL Query to return the sport which has won  canada the highest no of medals. 

with cte1 as (select nr.region as country ,ae.sport ,count(medal) as cnt from athlete_events ae 
join noc_regions nr on
ae.noc=nr.noc
where Medal in ('gold','silver','bronze') 
group by nr.region,ae.sport
order by cnt desc)
select * from cte1 
where country='canada' and cnt=(select max(cnt) from cte1 where country='canada');