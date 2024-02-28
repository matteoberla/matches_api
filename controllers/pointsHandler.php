<?php

class PointsHandler {
    function calcMatchesBetPoints($match, $matchBet){
        //match values
        $goal1 = $match->goal_team_1;
        $goal2 = $match->goal_team_2;
        $result = $match->result;

        //matchbet values
        $goal1Bet = $matchBet["goal_team_1"];
        $goal2Bet = $matchBet["goal_team_2"];
        $resultBet = $matchBet["result"];

        //echo $goal1 . $goal2 . $result;
        //echo $goal1Bet . $goal2Bet . $resultBet;
        //echo "----";

        if($result == $resultBet){

            if($goal1 == $goal1Bet && $goal2 == $goal2Bet){
                //result ok, goal ok
                return 12;
            }else{
                //result ok, goal no
                return 4;
            }
        }
        return 0;
    }

    function calcGironiBetPoints($girone, $gironeBet){
        //girone values
        $pos1 = $girone->pos_1;
        $pos2 = $girone->pos_2;
        $pos3 = $girone->pos_3;
        $pos4 = $girone->pos_4;

        //gironebet values
        $pos1Bet = $gironeBet["pos_1"];
        $pos2Bet = $gironeBet["pos_2"];
        $pos3Bet = $gironeBet["pos_3"];
        $pos4Bet = $gironeBet["pos_4"];


        if($pos1 == $pos1Bet && $pos2 == $pos2Bet && $pos3 == $pos3Bet && $pos4 == $pos4Bet){
            //tutte ok
            return 28;
        }else if($pos1 == $pos1Bet && $pos2 == $pos2Bet){
            //1 e 2 ok
            return 15;
        }else if($pos1 == $pos2Bet && $pos2 == $pos1Bet){
            //1 e 2 invertite
            return 9;
        }else if($pos1 == $pos1Bet){
            //1 ok
            return 5;
        }else if($pos2 == $pos1Bet){
            //arrivata 2a ma impostata 1a
            return 5;
        }else if($pos2 == $pos2Bet){
            //2 ok
            return 5;
        }else if($pos1 == $pos2Bet){
            //arrivata 1a ma impostata 2a
            return 5;
        }

        //echo $pos1 . $pos2 . $pos3 . $pos4;
        //echo $pos1Bet . $pos2Bet . $pos3Bet . $pos4Bet;
        //echo "----";

        return 0;
    }

    function calcMatchesFinBetPoints($match, $matchBet){
        //match values
        $team1 = $match->id_team_1;
        $team2 = $match->id_team_2;
        $goal1 = $match->goal_team_1;
        $goal2 = $match->goal_team_2;
        $result = $match->result;

        //matchbet values
        $team1Bet = $matchBet["id_team_1"];
        $team2Bet = $matchBet["id_team_2"];
        $goal1Bet = $matchBet["goal_team_1"];
        $goal2Bet = $matchBet["goal_team_2"];
        $resultBet = $matchBet["result"];

        /*echo "match";
        echo $team1 . $team2 . $goal1 . $goal2 . $result;
        echo "\nmatch bet";
        echo $team1Bet . $team2Bet . $goal1Bet . $goal2Bet . $resultBet;
        echo "----";*/

        if($team1 == $team1Bet && $team2 == $team2Bet){
            //entrambe le squadre corrette
        }else if($team1 == $team1Bet || $team2 == $team2Bet){
            //sono una corretta
        }else{
            //nessuna
            return 0;
        }

        if($result == $resultBet){

            if($goal1 == $goal1Bet && $goal2 == $goal2Bet){
                //result ok, goal ok
                return 12;
            }else{
                //result ok, goal no
                return 4;
            }
        }
        return 0;
    }

    function calcGoalVeloceBetPoints($goalVeloce, $goalVeloceBet){
        //goal veloce values
        $idTeam = $goalVeloce->id_team;

        //goal veloce values
        $idTeamBet = $goalVeloceBet["id_team"];

        /*echo $idTeam;
        echo $idTeamBet;
        echo "----";*/

        if($idTeam == $idTeamBet){
            //result ok, goal ok
            return 12;
        }else{
            //result ok, goal no
            return 4;
        }
    }


    function calcTeamRivelazBetPoints($teamRivelaz, $teamRivelazBet){
        //goal veloce values
        $idTeam = $teamRivelaz->id_team;

        //goal veloce values
        $idTeamBet = $teamRivelazBet["id_team"];

        /*echo $idTeam;
        echo $idTeamBet;
        echo "----";*/

        if($idTeam == $idTeamBet){
            //result ok, goal ok
            return 12;
        }else{
            //result ok, goal no
            return 4;
        }
    }


    function calcCapoAzzBetPoints($is_valid) {
        if($is_valid == 1){
            return 10;
        }else if($is_valid == 0){
            return 0;
        }
    }

    function calcCapoEuroBetPoints($is_valid) {
        if($is_valid == 1){
            return 10;
        }else if($is_valid == 0){
            return 0;
        }
    }






}