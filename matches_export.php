<?php

require_once __DIR__ . '/controllers/ErrorHandler.php';

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: access');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Content-Type: application/json; charset=UTF-8');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With');


require_once __DIR__ . '/database.php';
require_once __DIR__ . '/sendJson.php';
require_once __DIR__ . '/controllers/authHandler.php';
require_once __DIR__ . '/controllers/pointsHandler.php';

if($_SERVER['REQUEST_METHOD'] == 'OPTIONS') :
    sendJson(200, 'OK');
endif;
//operazioni admin
$authHandler = new AuthHandler();


if ($_SERVER['REQUEST_METHOD'] == 'GET') :

    $sql = "SELECT
                matches.id AS match_id,
                teams1.name AS team1_name,
                matches.goal_team_1,
                teams2.name AS team2_name,
                matches.goal_team_2,
                matches.result
            FROM
                matches
            LEFT JOIN teams AS teams1 ON matches.id_team_1 = teams1.id
            LEFT JOIN teams AS teams2 ON matches.id_team_2 = teams2.id


            ORDER BY matches.id;";
    $query = mysqli_query($connection, $sql);

    $matchesDict = $query->fetch_all(MYSQLI_ASSOC);


    $export = array();

    foreach($matchesDict as $key => $value){

        $match_id = $value["match_id"];

        $sql = "SELECT
                matches_bet.id AS bet_id,
                users.id AS user_id,
                users.name AS user_name,
                matches.id AS match_id,
                teams1.name AS team1_name,
                matches_bet.goal_team_1,
                teams2.name AS team2_name,
                matches_bet.goal_team_2,
                matches_bet.result,
                matches_bet.points
            FROM
                matches_bet
            INNER JOIN users ON matches_bet.user_id = users.id
            INNER JOIN matches ON matches_bet.match_id = matches.id
            LEFT JOIN teams AS teams1 ON matches.id_team_1 = teams1.id
            LEFT JOIN teams AS teams2 ON matches.id_team_2 = teams2.id

            WHERE matches_bet.match_id = ".$match_id."


            ORDER BY matches_bet.user_id, matches_bet.match_id;";
        $query = mysqli_query($connection, $sql);

        $betsDict = $query->fetch_all(MYSQLI_ASSOC);

        $value["bets"] = $betsDict;
        array_push($export, $value);
    }


    //lista dati
    $response = ["matches_export" => $export];

    sendJson(200, '', $response);

endif;
