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

if($_SERVER['REQUEST_METHOD'] == 'OPTIONS') :
    sendJson(200, 'OK');
endif;
//operazioni admin
$authHandler = new AuthHandler();


if ($_SERVER['REQUEST_METHOD'] == 'POST') :
    $userIsAdmin = $authHandler->userIsAdmin($connection);
    $loggedUserId = $authHandler->getLoggedUserId();
    $data = json_decode(file_get_contents('php://input'));

    if(isset($data->reset)){

        //solo matteo berlato
        if($loggedUserId == 1){

            $sqlReset = "";

            $sqlDelCapoAzzBet = "DELETE FROM capo_azz_bet;";
            $sqlDelCapoEuroBet = "DELETE FROM capo_euro_bet;";
            $sqlDelGironiBet = "DELETE FROM gironi_bet;";
            $sqlDelGoalVeloceBet = "DELETE FROM goal_veloce_bet;";
            $sqlDelMatchesBet = "DELETE FROM matches_bet;";
            $sqlDelMatchesFinBet = "DELETE FROM matches_fin_bet;";
            $sqlDelTeamRivelazBet = "DELETE FROM team_rivelaz_bet;";

            $sqlUpdGironi = "UPDATE gironi SET pos_1=NULL, pos_2=NULL, pos_3=NULL, pos_4=NULL;";
            $sqlUpdGoalVeloce = "UPDATE goal_veloce SET id_team=NULL;";
            $sqlUpdMatches = "UPDATE matches SET goal_team_1=NULL, goal_team_2=NULL, result=NULL;";
            $sqlUpdMatchesFin = "UPDATE matches_fin SET id_team_1=NULL, id_team_2=NULL, goal_team_1=NULL, goal_team_2=NULL, result=NULL;";
            $sqlUpdTeamRivelaz = "UPDATE team_rivelaz SET id_team=NULL;";

            $sqlDel = $sqlDelCapoAzzBet . $sqlDelCapoEuroBet . $sqlDelGironiBet . $sqlDelGoalVeloceBet . $sqlDelMatchesBet . $sqlDelMatchesFinBet . $sqlDelTeamRivelazBet;
            $sqlUpd = $sqlUpdGironi . $sqlUpdGoalVeloce . $sqlUpdMatches . $sqlUpdMatchesFin . $sqlUpdTeamRivelaz;

            $sqlReset = $sqlDel . $sqlUpd;

            $query = mysqli_multi_query($connection, $sqlReset);

            if ($query) sendJson(200, 'RESET OK');
            sendJson(500, 'Something going wrong.');
        }

        sendJson(
            422,
            'Errore utente',
            ['User' => ['solo Utente 1']]
        );


    }

    sendJson(
        422,
        'Errore reset',
        ['required_fields' => ['reset']]
    );


endif;