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
require_once __DIR__ . '/controllers/compilaGironiHandler.php';

if($_SERVER['REQUEST_METHOD'] == 'OPTIONS') :
    sendJson(200, 'OK');
endif;
//operazioni admin
$authHandler = new AuthHandler();


if ($_SERVER['REQUEST_METHOD'] == 'GET') :

    $currentUserId = $authHandler->getLoggedUserId();

    $girone = null;
    if(isset($_GET["girone"])){
        $girone = $_GET["girone"];
    }
    if(!isset($girone)){
        sendJson(404, 'Girone not found!');
    }

    $compilaGironiHandler = new CompilaGironiHandler();
    $pointsDict = $compilaGironiHandler->calcPosGironi($connection, $currentUserId, $girone);
    //sendJson(200, '', $pointsDict);

    $response = array();
    $pos = 1;
    foreach ($pointsDict as $key => $row)
    {
        $positionInfo = array("team_id" => $row['team_id'], "pos"=> $pos);
        array_push($response, $positionInfo);
        $pos++;
    }

    sendJson(200, '', $response);

endif;

?>