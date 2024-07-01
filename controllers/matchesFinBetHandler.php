<?php

class MatchesFinBetHandler {


    public $matchesConnections = array(
        //match id, match id successivo, posizione team nel team successivo
        //quarti
        "39"=> array(45, 1),
        "37"=> array(45, 2),

        "41"=> array(46, 1),
        "42"=> array(46, 2),

        "43"=> array(47, 1),
        "44"=> array(47, 2),

        "40"=> array(48, 1),
        "38"=> array(48, 2),

        //semifinali
        "45"=> array(49, 1),
        "46"=> array(49, 2),

        "47"=> array(50, 1),
        "48"=> array(50, 2),

        //finale
        "49"=> array(51, 1),
        "50"=> array(51, 2),

    );

    function autocompileFinMatches($connection, $user_id, $match_id){
        //match
        $match = $this->getMatchFinById($connection, $match_id);
        $nMatch = $match["n_match"];

        //match bet appena compilata
        $matchBet = $this->getMatchFinBetByUserAndMatch($connection, $user_id, $match_id);

        //squadra vincente
        $winnerTeam = $this->getWinnerTeamFromMatchBet($matchBet);

        if($winnerTeam != null){
            //numero partita successiva
            $next_match_num = $this->matchesConnections[$nMatch][0];


            if(!is_null($next_match_num)){
                //partita successiva
                $next_match = $this->getMatchFinByNMatch($connection, $next_match_num);
                //id partita successiva
                $next_match_id = $next_match["id"];
                //compilazione scommessa
                $this->compileNextBet($connection, $user_id,$next_match_id, $winnerTeam, $this->matchesConnections[$nMatch][1]);
                //ciclo per la partita successiva
                $this->autocompileFinMatches($connection, $user_id, $next_match_id);
            }
        }
    }


    function getMatchFinById($connection, $match_id){
        $sql = "SELECT * FROM `matches_fin` WHERE `id`='$match_id'";
        $query = mysqli_query($connection, $sql);
        $row = mysqli_fetch_array($query, MYSQLI_ASSOC);
        return $row;
    }

    function getMatchFinByNMatch($connection, $n_match){
        $sql = "SELECT * FROM `matches_fin` WHERE `n_match`='$n_match'";
        $query = mysqli_query($connection, $sql);
        $row = mysqli_fetch_array($query, MYSQLI_ASSOC);
        return $row;
    }

    function getMatchFinBetByUserAndMatch($connection, $user_id, $match_id){
        $sql = "SELECT * FROM `matches_fin_bet` WHERE `match_id`='$match_id' AND `user_id`='$user_id'";
        $query = mysqli_query($connection, $sql);
        $row = mysqli_fetch_array($query, MYSQLI_ASSOC);
        return $row;
    }

    function getWinnerTeamFromMatchBet($matchBet){
        $result = $matchBet["result"];
        $winnerTeam = null;
        if($result == "1"){
            $winnerTeam = $matchBet["id_team_1"];
        }else if($result == "2"){
            $winnerTeam = $matchBet["id_team_2"];
        }else if($result == "X"){
            //con pareggio verifico la squadra impostata dall'utente come vincitrice
            $final_result = $matchBet["final_result"];
            if($final_result == "1"){
                $winnerTeam = $matchBet["id_team_1"];
            }else if($final_result == "2"){
                $winnerTeam = $matchBet["id_team_2"];
            }
        }
        return $winnerTeam;
    }

    function compileNextBet($connection, $user_id, $next_match_id, $teamId, $teamPos){
        //get bet
        $nextMatchBet = $this->getMatchFinBetByUserAndMatch($connection, $user_id, $next_match_id);

        if(is_null($nextMatchBet)){
            //INSERISCO BET
            //echo "ins";

            $sql = "INSERT INTO `matches_fin_bet` (`user_id`,`match_id`,`id_team_".$teamPos."`) VALUES($user_id,$next_match_id,$teamId)";
            mysqli_query($connection, $sql);

        }else{
            //AGGIORNO ESISTENTE
            //echo "upd";

            $sql = "UPDATE `matches_fin_bet` SET `id_team_".$teamPos."`=$teamId  WHERE `match_id` = $next_match_id AND `user_id` = $user_id";
            mysqli_query($connection, $sql);

        }

    }


}
