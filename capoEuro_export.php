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
                capo_euro_bet.id AS bet_id,
                users.id AS user_id,
                users.name AS user_name,
                capo_euro_bet.bet_num,
                capo_euro_bet.value,
                capo_euro_bet.is_valid,
                capo_euro_bet.points
            FROM
                capo_euro_bet
            INNER JOIN users ON capo_euro_bet.user_id = users.id

            ORDER BY capo_euro_bet.user_id, capo_euro_bet.bet_num;";
    $query = mysqli_query($connection, $sql);

    $betsDict = $query->fetch_all(MYSQLI_ASSOC);

    $value["bets"] = $betsDict;


    //lista dati
    $response = ["capo_euro_export" => $value];

    sendJson(200, '', $response);

endif;
