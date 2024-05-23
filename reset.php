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

    if(isset($data->reset) && $data->reset == true){

        //solo matteo berlato
        if($loggedUserId == 1){
            $sqlDel = "";
            if(isset($data->reset_bet) && $data->reset_bet == true){
                //verifica presenza user id
                $userId = null;
                $sqlWhere = "";
                if(isset($data->user_id)){
                    $userId = $data->user_id;
                    $sqlWhere = " WHERE user_id = ". $userId;
                }

                //eliminazioni bet
                $sqlDelCapoAzzBet = "DELETE FROM capo_azz_bet ". $sqlWhere .";";
                $sqlDelCapoEuroBet = "DELETE FROM capo_euro_bet ". $sqlWhere .";";
                $sqlDelGironiBet = "DELETE FROM gironi_bet ". $sqlWhere .";";
                $sqlDelGoalVeloceBet = "DELETE FROM goal_veloce_bet ". $sqlWhere .";";
                $sqlDelMatchesBet = "DELETE FROM matches_bet ". $sqlWhere .";";
                $sqlDelMatchesFinBet = "DELETE FROM matches_fin_bet ". $sqlWhere .";";
                $sqlDelTeamRivelazBet = "DELETE FROM team_rivelaz_bet ". $sqlWhere .";";

                $sqlDel = $sqlDelCapoAzzBet . $sqlDelCapoEuroBet . $sqlDelGironiBet . $sqlDelGoalVeloceBet . $sqlDelMatchesBet . $sqlDelMatchesFinBet . $sqlDelTeamRivelazBet;
            }

            $sqlUpd = "";
            if(isset($data->reset_data) && $data->reset_data == true){
                $sqlUpdGironi = "UPDATE gironi SET pos_1=NULL, pos_2=NULL, pos_3=NULL, pos_4=NULL;";
                $sqlUpdGoalVeloce = "UPDATE goal_veloce SET id_team=NULL;";
                $sqlUpdMatches = "UPDATE matches SET goal_team_1=NULL, goal_team_2=NULL, result=NULL;";
                $sqlUpdMatchesFin = "UPDATE matches_fin SET id_team_1=NULL, id_team_2=NULL, goal_team_1=NULL, goal_team_2=NULL, result=NULL;";
                $sqlUpdTeamRivelaz = "UPDATE team_rivelaz SET id_team=NULL;";

                $sqlUpd = $sqlUpdGironi . $sqlUpdGoalVeloce . $sqlUpdMatches . $sqlUpdMatchesFin . $sqlUpdTeamRivelaz;

            }

            $sqlReset = $sqlDel . $sqlUpd;
            if($sqlReset != ""){
                $query = mysqli_multi_query($connection, $sqlReset);
                if(!$query) sendJson(500, 'Something going wrong.');
            }

            $response = array();
            $response['reset'] = $data->reset;
            $response['user_id'] = null;
            if(isset($data->user_id)){
                $response['user_id'] = $data->user_id;
            }

            $response['reset_bet'] = null;
            if(isset($data->reset_bet)){
                $response['reset_bet'] = $data->reset_bet;
            }

            $response['reset_data'] = null;
            if(isset($data->reset_data)){
                $response['reset_data'] = $data->reset_data;
            }



            sendJson(200, '', $response);
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