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

    $currentUserId = $authHandler->getLoggedUserId();

    $girone = null;
    if(isset($_GET["girone"])){
        $girone = $_GET["girone"];
    }
    if(!isset($girone)){
        sendJson(404, 'Girone not found!');
    }


    $sql = "SELECT mb.*, t.girone
            FROM matches_bet mb
            JOIN matches m ON mb.match_id = m.id
            JOIN teams t ON m.id_team_1 = t.id

        WHERE  mb.user_id='$currentUserId'
            AND t.girone = '" . $girone . "'";
    $query = mysqli_query($connection, $sql);
    $matchesBetDict = $query->fetch_all(MYSQLI_ASSOC);


    $pointsDict = array();

    //inserimento dati
    for ($i = 0; $i < count($matchesBetDict); $i++) {
        $matchBet = $matchesBetDict[$i];
        $matchId = $matchBet["match_id"];
        $sql = "SELECT * FROM `matches` WHERE `id`='$matchId'";
        $query = mysqli_query($connection, $sql);
        $row = mysqli_fetch_array($query, MYSQLI_ASSOC);

        $team1Id = $row["id_team_1"];
        $team2Id = $row["id_team_2"];

        $goalTeam1 = $matchBet["goal_team_1"];
        $goalTeam2 = $matchBet["goal_team_2"];

        $matchWinner = $matchBet["result"];

        //inizializzazione array
        if(!array_key_exists($team1Id, $pointsDict)){
            $pointsDict[$team1Id] = array("team_id"=> $team1Id, "pts" => 0, "goal_fatti"=>0, "goal_subiti"=>0, "order"=>0, "win"=>array() );
        }
        if(!array_key_exists($team2Id, $pointsDict)){
            $pointsDict[$team2Id] = array("team_id"=> $team2Id, "pts" => 0, "goal_fatti"=>0, "goal_subiti"=>0, "order"=>0, "win"=>array() );
        }


        //inserimento punti
        if($matchWinner == "1"){
            $pointsDict[$team1Id]["pts"] += 3;
            array_push($pointsDict[$team1Id]["win"], $team2Id);
        }else if($matchWinner == "2"){
            $pointsDict[$team2Id]["pts"] += 3;
            array_push($pointsDict[$team2Id]["win"], $team1Id);
        }else if($matchWinner == "X"){
            $pointsDict[$team1Id]["pts"] += 1;
            $pointsDict[$team2Id]["pts"] += 1;
        }

        //
        $pointsDict[$team1Id]["goal_fatti"] += $goalTeam1;
        $pointsDict[$team1Id]["goal_subiti"] += $goalTeam2;
        //
        $pointsDict[$team2Id]["goal_fatti"] += $goalTeam2;
        $pointsDict[$team2Id]["goal_subiti"] += $goalTeam1;

    }

    //ordinamento per punti
    $points = array();
    foreach ($pointsDict as $key => $row)
    {
        $points[$key] = $row['pts'];
    }
    array_multisort($points, SORT_DESC, $pointsDict);

    //sendJson(200, '', $pointsDict);

    //verifica ordinamento punti finchè non ci sono più sistemazioni da fare
    $has_changes = false;
    do{
        $has_changes = false;
        $prevKey = null;

        foreach ($pointsDict as $key => $row)
        {
            if(is_null($prevKey)){
                $prevKey = $key;
                continue;
            }

            $prevTeamInfo = $pointsDict[$prevKey];
            $currentTeamInfo = $row;

            //stesso punteggio
            if($prevTeamInfo["pts"] == $currentTeamInfo["pts"]){
                //echo $prevTeamInfo["team_id"] . " uguale " . $currentTeamInfo["team_id"];

                //verifico scontro diretto
                if(in_array($currentTeamInfo["team_id"], $pointsDict[$prevKey]["win"])){
                    //se squadra corrente è nelle vittorie della squadra precedente -> ha vinto la squadra precedente
                    $pointsDict[$prevKey]["order"] += 1;
                }else if(in_array($prevTeamInfo["team_id"], $pointsDict[$key]["win"])){
                    //se squadra precente è nelle vittorie della squadra corrente -> ha vinto la squadra corrente
                    $pointsDict[$key]["order"] += 1;
                }else{
                    //in caso di pareggio

                    $totFatti1 = $prevTeamInfo["goal_fatti"];
                    $totSubiti1 = $prevTeamInfo["goal_subiti"];
                    $diff1 = $totFatti1 - $totSubiti1;
                    $order1 = $prevTeamInfo["order"];

                    $totFatti2 = $currentTeamInfo["goal_fatti"];
                    $totSubiti2 = $currentTeamInfo["goal_subiti"];
                    $diff2 = $totFatti2 - $totSubiti2;
                    $order2 = $currentTeamInfo["order"];

                    if($diff1 > $diff2 && $order1 <= $order2){
                        //squadra prev con maggiore diff reti e ordinamento scombinato
                        $pointsDict[$prevKey]["order"] += 1;
                        $has_changes = true;
                    }else if($diff2 > $diff1 && $order2 <= $order1){
                        //squadra corrente con maggiore diff reti
                        $pointsDict[$key]["order"] += 1;
                        $has_changes = true;
                    }else if($diff1 == $diff2){
                        //differenza reti uguali -> guarto tot goal

                        if($totFatti1 > $totFatti2 && $order1 <= $order2){
                            //squadra prev con maggiori goal
                            $pointsDict[$prevKey]["order"] += 1;
                            $has_changes = true;
                        }else if($totFatti2 > $totFatti1 && $order2 <= $order1){
                            //squadra corrente con maggiori goal
                            $pointsDict[$key]["order"] += 1;
                            $has_changes = true;
                        }else{
                            //non gestito
                        }

                    }
                }

            }

            //salvo elemento corrente su prevKey
            $prevKey = $key;

        }

        //ordinamento per punti + order
        $points = array();
        $order = array();
        foreach ($pointsDict as $key => $row)
        {
            $points[$key] = $row['pts'];
            $order[$key] = $row['order'];
        }
        array_multisort($points, SORT_DESC, $order, SORT_DESC, $pointsDict);
    }while(!($has_changes == false));//esci se non ci sono state modifiche


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