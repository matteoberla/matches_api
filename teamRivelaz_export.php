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
                id_team,
                teams.name AS team_name
            FROM
                team_rivelaz
            LEFT JOIN teams AS teams ON team_rivelaz.id_team = teams.id
            ORDER BY team_rivelaz.id;";
    $query = mysqli_query($connection, $sql);

    $matchesDict = mysqli_fetch_array($query, MYSQLI_ASSOC);

    $sql = "SELECT
                team_rivelaz_bet.id AS bet_id,
                users.id AS user_id,
                users.name AS user_name,
                team_rivelaz_bet.id_team,
                teams.name AS team_name,
                team_rivelaz_bet.points
            FROM
                team_rivelaz_bet
            INNER JOIN users ON team_rivelaz_bet.user_id = users.id
            LEFT JOIN teams AS teams ON team_rivelaz_bet.id_team = teams.id


            ORDER BY team_rivelaz_bet.user_id;";
    $query = mysqli_query($connection, $sql);

    $betsDict = $query->fetch_all(MYSQLI_ASSOC);

    $matchesDict["bets"] = $betsDict;


    //lista dati
    $response = ["team_rivelaz_export" => $matchesDict];

    sendJson(200, '', $response);

endif;
