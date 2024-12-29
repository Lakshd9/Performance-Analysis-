create database ipl;
use ipl;

select * from matches;
select * from deliveries;
drop table deliveries;

# Questions on the matches Table

-- List all matches played in the 2024 IPL season.
SELECT * 
FROM matches 
WHERE season = 2024;

-- Find the total number of matches played in the 2024 IPL.
SELECT COUNT(*) AS total_matches 
FROM matches 
WHERE season = 2024;

-- Find matches where the toss winner chose to bat.
SELECT * 
FROM matches 
WHERE toss_decision = 'Bat';

-- List all neutral venue matches.
SELECT * 
FROM matches 
WHERE neutralvenue = 'Yes';

-- Find the venue that hosted the most matches.
SELECT venue, COUNT(*) AS match_count 
FROM matches 
GROUP BY venue 
ORDER BY match_count DESC 
LIMIT 1;

-- Find the team that won the most matches in 2024.
SELECT winner, COUNT(*) AS total_wins 
FROM matches 
GROUP BY winner 
ORDER BY total_wins DESC;

 -- List all matches where the toss winner also won the match.
 SELECT * 
FROM matches 
WHERE toss_winner = winner;

-- Find matches with the highest margin of victory in terms of runs.
SELECT * 
FROM matches 
ORDER BY winner_runs DESC 
LIMIT 1;

-- Get the number of matches played in each city.
SELECT city, COUNT(*) AS matches_played 
FROM matches 
GROUP BY city 
ORDER BY matches_played DESC;

-- Get the match with the highest winning margin in terms of wickets.
SELECT * 
FROM matches 
ORDER BY winner_wickets DESC 
LIMIT 1;


# Questions on the deliveries Table

-- Get the total runs scored by each team.
SELECT batting_team, SUM(batsman_runs + extras) AS total_runs 
FROM deliveries 
GROUP BY batting_team 
ORDER BY total_runs DESC;


-- Find the top 5 bowlers with the most wickets.
SELECT bowler, COUNT(*) AS wickets 
FROM deliveries 
WHERE is_wicket = 1 
GROUP BY bowler 
ORDER BY wickets DESC 
LIMIT 5;

 -- Find the batsman with the highest runs in the season.
 SELECT batsman, SUM(batsman_runs) AS total_runs 
FROM deliveries 
GROUP BY batsman 
ORDER BY total_runs DESC 
LIMIT 1;

 -- Get the total number of fours and sixes hit by each batsman.
 SELECT batsman, 
       COUNT(CASE WHEN batsman_runs = 4 THEN 1 END) AS fours, 
       COUNT(CASE WHEN batsman_runs = 6 THEN 1 END) AS sixes 
FROM deliveries 
GROUP BY batsman 
ORDER BY fours DESC, sixes DESC;

-- List all bowlers who bowled a no-ball.
SELECT DISTINCT bowler 
FROM deliveries 
WHERE isNoBall = 1;

-- Find the total number of extras conceded by each team.
SELECT bowling_team, SUM(extras) AS total_extras 
FROM deliveries 
GROUP BY bowling_team 
ORDER BY total_extras DESC;

-- Get the top 5 highest-scoring matches by total runs.
SELECT matchId, SUM(batsman_runs + extras) AS total_runs 
FROM deliveries 
GROUP BY matchId 
ORDER BY total_runs DESC 
LIMIT 5;

-- Find the number of dot balls bowled by each bowler.
SELECT bowler, COUNT(*) AS dot_balls 
FROM deliveries 
WHERE batsman_runs = 0 AND extras = 0 
GROUP BY bowler 
ORDER BY dot_balls DESC;

-- Get the dismissal types and their counts.
SELECT dismissal_kind, COUNT(*) AS dismissals 
FROM deliveries 
WHERE is_wicket = 1 
GROUP BY dismissal_kind 
ORDER BY dismissals DESC;

 -- List the players dismissed the most by a single bowler.
 SELECT bowler, player_dismissed, COUNT(*) AS dismissals 
FROM deliveries 
WHERE is_wicket = 1 
GROUP BY bowler, player_dismissed 
ORDER BY dismissals DESC 
LIMIT 5;


# Questions Combining matches and deliveries Tables

 -- Get the total runs scored in each match.
 SELECT m.matchId, m.venue, SUM(d.batsman_runs + d.extras) AS total_runs 
FROM matches m 
JOIN deliveries d ON m.matchId = d.matchId 
GROUP BY m.matchId, m.venue 
ORDER BY total_runs DESC;

-- Find the Player of the Match for the highest-scoring match.
SELECT m.matchId, m.player_of_match, SUM(d.batsman_runs + d.extras) AS total_runs 
FROM matches m 
JOIN deliveries d ON m.matchId = d.matchId 
GROUP BY m.matchId, m.player_of_match 
ORDER BY total_runs DESC 
LIMIT 1;

-- Get the number of matches won by each team along with their home venues.
SELECT winner, venue, COUNT(*) AS total_wins 
FROM matches 
GROUP BY winner, venue 
ORDER BY total_wins DESC;

-- Find the total runs scored by the winning team in each match.
SELECT m.matchId, m.winner, SUM(d.batsman_runs + d.extras) AS total_runs 
FROM matches m 
JOIN deliveries d ON m.matchId = d.matchId 
WHERE d.batting_team = m.winner 
GROUP BY m.matchId, m.winner 
ORDER BY total_runs DESC;


























