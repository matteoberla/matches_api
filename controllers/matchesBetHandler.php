<?php

require_once __DIR__ . '/compilaGironiHandler.php';

class MatchesBetHandler {

    function matchesBetNumberOfCurrentUser($connection){
        $authHandler = new AuthHandler();
        $loggedUserId = $authHandler->getLoggedUserId();
        $sql = "SELECT id FROM `matches_bet` WHERE `user_id`='$loggedUserId'";
        $query = mysqli_query($connection, $sql);
        $matchesBetDict = $query->fetch_all(MYSQLI_ASSOC);
        $matchesBetNumber = 0;
        if ($matchesBetDict != null) {
            $matchesBetNumber = count($matchesBetDict);
        }
        return $matchesBetNumber;
    }

    function matchesNumber($connection){
        $sql = "SELECT id FROM `matches`";
        $query = mysqli_query($connection, $sql);
        $matchesDict = $query->fetch_all(MYSQLI_ASSOC);
        $matchesNumber = 0;
        if ($matchesDict != null) {
            $matchesNumber = count($matchesDict);
        }
        return $matchesNumber;
    }

    function gironeOfMatchId($connection, $match){
        $sql = "SELECT 
                    t.girone
                FROM `matches` m
                JOIN teams t ON m.id_team_1 = t.id
                WHERE m.`id`='$match'";
        $query = mysqli_query($connection, $sql);
        $gironeOfMatchDict = $query->fetch_all(MYSQLI_ASSOC);
        
        return $gironeOfMatchDict[0]["girone"];
    }


    public function autocompilaGironeMatch($connection, $userId, $match){

        $girone = $this->gironeOfMatchId($connection, $match);

        //echo $girone;

        $compilaGironiHandler = new CompilaGironiHandler();
        $pointsDict = $compilaGironiHandler->calcPosGironi($connection, $userId, $girone);

        $teamPos = array();
        $pos = 1;
        foreach ($pointsDict as $key => $row)
        {
            $positionInfo = array("team_id" => $row['team_id'], "pos"=> $pos);
            array_push($teamPos, $positionInfo);
            $pos++;
        }

        print_r($teamPos);

        //rimuovo eventuale girone bet esistente
        $sql = "DELETE FROM `gironi_bet` WHERE `user_id` = $userId AND `girone` = 'Girone $girone'";
        $query = mysqli_query($connection, $sql);

        // se ho tutte e 4 le posizioni delle squadre inserisco la bet
        if(count($teamPos) == 4){
            //recupero il girone
            $sql = "SELECT 
                        *
                    FROM `gironi`
                    WHERE `girone`='Girone $girone'";
            $query = mysqli_query($connection, $sql);
            $gironeDict = $query->fetch_all(MYSQLI_ASSOC);
            
            if(count($gironeDict) == 1){
                $gironeInfo = $gironeDict[0];

                $pos_1 = null;
                $pos_2 = null;
                $pos_3 = null;
                $pos_4 = null;

                //ciclo il teamPos per cercare id_team_X -> pos_X
                foreach($teamPos as $pos){
                    if($pos["team_id"] == $gironeInfo["id_team_1"]){
                        $pos_1 = mysqli_real_escape_string($connection, $pos["pos"]);
                    } else if($pos["team_id"] == $gironeInfo["id_team_2"]){
                        $pos_2 = mysqli_real_escape_string($connection, $pos["pos"]);
                    } else if($pos["team_id"] == $gironeInfo["id_team_3"]){
                        $pos_3 = mysqli_real_escape_string($connection, $pos["pos"]);
                    } else if($pos["team_id"] == $gironeInfo["id_team_4"]){
                        $pos_4 = mysqli_real_escape_string($connection, $pos["pos"]);
                    }
                }

                $sql = "INSERT INTO `gironi_bet` (`user_id`,`girone`,`pos_1`,`pos_2`,`pos_3`,`pos_4`) VALUES($userId,'Girone $girone',$pos_1,$pos_2,$pos_3,$pos_4)";
                $query = mysqli_query($connection, $sql);   
            }
        }
    }



}