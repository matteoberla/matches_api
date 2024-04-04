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
                gironi.id AS match_id,
                gironi.girone,
                teams1.name AS team1_name,
                gironi.pos_1,
                teams2.name AS team2_name,
                gironi.pos_2,
                teams3.name AS team3_name,
                gironi.pos_3,
                teams4.name AS team4_name,
                gironi.pos_4
            FROM
                gironi
            LEFT JOIN teams AS teams1 ON gironi.id_team_1 = teams1.id
            LEFT JOIN teams AS teams2 ON gironi.id_team_2 = teams2.id
            LEFT JOIN teams AS teams3 ON gironi.id_team_3 = teams3.id
            LEFT JOIN teams AS teams4 ON gironi.id_team_4 = teams4.id


            ORDER BY gironi.id;";
    $query = mysqli_query($connection, $sql);

    $matchesDict = $query->fetch_all(MYSQLI_ASSOC);


    $export = array();

    foreach($matchesDict as $key => $value){

        $girone = $value["girone"];

        $sql = "SELECT
                gironi_bet.id AS bet_id,
                users.id AS user_id,
                users.name AS user_name,
                teams1.name AS team1_name,
                gironi_bet.pos_1,
                teams2.name AS team2_name,
                gironi_bet.pos_2,
                teams3.name AS team3_name,
                gironi_bet.pos_3,
                teams4.name AS team4_name,
                gironi_bet.pos_4,
                gironi_bet.points
            FROM
                gironi_bet
            INNER JOIN users ON gironi_bet.user_id = users.id
            INNER JOIN gironi ON gironi_bet.girone = gironi.girone
            LEFT JOIN teams AS teams1 ON gironi.id_team_1 = teams1.id
            LEFT JOIN teams AS teams2 ON gironi.id_team_2 = teams2.id
            LEFT JOIN teams AS teams3 ON gironi.id_team_3 = teams3.id
            LEFT JOIN teams AS teams4 ON gironi.id_team_4 = teams4.id

            WHERE gironi_bet.girone = '".$girone."'

            ORDER BY gironi_bet.user_id, gironi_bet.girone;";
        $query = mysqli_query($connection, $sql);

        $betsDict = $query->fetch_all(MYSQLI_ASSOC);

        $value["bets"] = $betsDict;
        array_push($export, $value);
    }


    //lista dati
    $response = ["gironi_export" => $export];

    sendJson(200, '', $response);

endif;