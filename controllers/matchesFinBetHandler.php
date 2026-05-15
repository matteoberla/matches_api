<?php

class MatchesFinBetHandler {


    public $matchesConnections = array(
        //match id, match id successivo, posizione team nel team successivo

        //ottavi
        "73"=> array(90, 1),
        "75"=> array(90, 2),

        "74"=> array(89, 1),
        "77"=> array(89, 2),

        "83"=> array(93, 1),
        "84"=> array(93, 2),

        "81"=> array(94, 1),
        "82"=> array(94, 2),

        "76"=> array(91, 1),
        "78"=> array(91, 2),

        "79"=> array(92, 1),
        "80"=> array(92, 2),

        "86"=> array(95, 1),
        "88"=> array(95, 2),

        "85"=> array(96, 1),
        "87"=> array(96, 2),


        //quarti
        "89"=> array(97, 1),
        "90"=> array(97, 2),

        "93"=> array(98, 1),
        "94"=> array(98, 2),

        "91"=> array(99, 1),
        "92"=> array(99, 2),

        "95"=> array(100, 1),
        "96"=> array(100, 2),

        //semifinali
        "97"=> array(101, 1),
        "98"=> array(101, 2),

        "99"=> array(102, 1),
        "100"=> array(102, 2),

        // finalina
        /*"101"=> array(103, 1),
        "102"=> array(103, 2),*/

        //finale
        "101"=> array(104, 1),
        "102"=> array(104, 2),

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
