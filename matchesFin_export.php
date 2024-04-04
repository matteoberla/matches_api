<?php

require_once __DIR__ . '/controllers/ErrorHandler.php';

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: access');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Content-Type: application/json; charset=UTF-8');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With');


require_once __DIR__ . '../database.php';
require_once __DIR__ . '../sendJson.php';
require_once __DIR__ . '../controllers/authHandler.php';
require_once __DIR__ . '../controllers/pointsHandler.php';

if($_SERVER['REQUEST_METHOD'] == 'OPTIONS') :
    sendJson(200, 'OK');
endif;
//operazioni admin
$authHandler = new AuthHandler();


if ($_SERVER['REQUEST_METHOD'] == 'GET') :

    $sql = "SELECT
                matches_fin.id AS match_id,
                matches_fin.date AS date,
                matches_fin.n_match AS n_match,
                matches_fin.des_1 AS des_1,
                teams1.name AS team1_name,
                matches_fin.goal_team_1,
                matches_fin.des_2 AS des_2,
                teams2.name AS team2_name,
                matches_fin.goal_team_2,
                matches_fin.result
            FROM
                matches_fin
            LEFT JOIN teams AS teams1 ON matches_fin.id_team_1 = teams1.id
            LEFT JOIN teams AS teams2 ON matches_fin.id_team_2 = teams2.id


            ORDER BY matches_fin.date;";
    $query = mysqli_query($connection, $sql);

    $matchesDict = $query->fetch_all(MYSQLI_ASSOC);


    $export = array();

    foreach($matchesDict as $key => $value){

        $match_id = $value["match_id"];

        $sql = "SELECT
                matches_fin_bet.id AS bet_id,
                users.id AS user_id,
                users.name AS user_name,
                matches_fin_bet.match_id AS match_id,
                teams1.name AS team1_name,
                matches_fin_bet.goal_team_1,
                teams2.name AS team2_name,
                matches_fin_bet.goal_team_2,
                matches_fin_bet.result,
                matches_fin_bet.points
            FROM
                matches_fin_bet
            INNER JOIN users ON matches_fin_bet.user_id = users.id
            LEFT JOIN teams AS teams1 ON matches_fin_bet.id_team_1 = teams1.id
            LEFT JOIN teams AS teams2 ON matches_fin_bet.id_team_2 = teams2.id

            WHERE matches_fin_bet.match_id = ".$match_id."


            ORDER BY matches_fin_bet.user_id, matches_fin_bet.match_id;";
        $query = mysqli_query($connection, $sql);

        $betsDict = $query->fetch_all(MYSQLI_ASSOC);

        $value["bets"] = $betsDict;
        array_push($export, $value);

    }

    $response = ["matches_fin_export" => $export];

    sendJson(200, '', $response);

endif;