# Smash Stats

Mines data from Challonge to generate player ranking system and stat tracker

## Schema

###players

column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
name        | string    | not null, unique
skill       | float     | not null
games_played| integer   | not null
wins        | integer   | not null
losses      | integer   | not null


###tournaments

column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
name        | string    | not null
date        | date      | not null

###matches

column name   | data type | details
--------------|-----------|-----------------------
id            | integer   | not null, primary key
tournament_id | integer   | not null, foreign key
player1_id    | integer   | not null, foreign key
player2_id    | integer   | not null, foreign key
score         | string    | not null



##API Endpoints

- `GET /api/players`
 -  index of players sorted by skill rating
- `GET /api/players/:id`
 - displays all of the individual players stats
 - can accept a query string to compare 2 players
- `GET /api/tournaments`
 - index of upcoming tournaments ordered by date
- `POST api/tournaments`
 - add upcoming tournaments
- `POST api/challonge`
 - adds all relevant challonge data for a tournament
