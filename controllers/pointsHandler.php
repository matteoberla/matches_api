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
                return 13;
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

        $results = array();
        $results[0] = 0;
        $results[$pos1] = $pos1Bet;
        $results[$pos2] = $pos2Bet;
        $results[$pos3] = $pos3Bet;
        $results[$pos4] = $pos4Bet;

        if(!isset($results[1]) || !isset($results[2]) || !isset($results[3]) || !isset($results[4])){
            return 0;
        }


        if($results[1] == 1 && $results[2] == 2 && $results[3] == 3 && $results[4] == 4){
            //tutte ok
            return 28;
        }else if($results[1] == 1 && $results[2] == 2){
            //1 e 2 ok
            return 15;
        }else if($results[1] == 2 && $results[2] == 1){
            //1 e 2 invertite
            return 9;
        }else if($results[1] == 1){
            //1 ok
            return 4;
        }else if($results[2] == 1){
            //arrivata 2a ma impostata 1a
            return 4;
        }else if($results[2] == 2){
            //2 ok
            return 4;
        }else if($results[1] == 2){
            //arrivata 1a ma impostata 2a
            return 4;
        }

        //echo $pos1 . $pos2 . $pos3 . $pos4;
        //echo $pos1Bet . $pos2Bet . $pos3Bet . $pos4Bet;
        //echo "----";

        return 0;
    }

    function calcMatchesFinBetPoints($match, $matchBet){
        //match values
        $fase = $match->fase;
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

        if($team1 === null || $team2 === null){
            return null;
        }

        if($goal1 === null || $goal2 === null){
            return null;
        }


        /*echo "match";
        echo $team1 . $team2 . $goal1 . $goal2 . $result;
        echo "\nmatch bet";
        echo $team1Bet . $team2Bet . $goal1Bet . $goal2Bet . $resultBet;
        echo "----";*/

        $points = 0;

        if($fase != 5){
            //qualsiasi altra fase
            if($team1 == $team1Bet && $team2 == $team2Bet){
                //entrambe le squadre corrette
                if($result == $resultBet){

                    if($goal1 == $goal1Bet && $goal2 == $goal2Bet){
                        //result ok, goal ok
                        $points += 19;
                    }else{
                        //result ok, goal no
                        $points += 6;
                    }
                }
            }else if($team1 == $team1Bet || $team2 == $team2Bet){
                //solo una corretta
            }else{
                //nessuna
            }

        }else{
            //fase finale
            if($team1 == $team1Bet && $team2 == $team2Bet){
                //entrambe le squadre corrette
                if($result == $resultBet){

                    if($goal1 == $goal1Bet && $goal2 == $goal2Bet){
                        //result ok, goal ok
                        $points += 32;
                    }else{
                        //result ok, goal no
                        $points += 17;
                    }
                }
            }else if($team1 == $team1Bet || $team2 == $team2Bet){
                //solo una corretta
            }else{
                //nessuna
            }


            //bonus vincente fase finale
            if($team1 == $team1Bet && $result == $resultBet && $result == "1"){
                $points += 12;
            }

            if($team2 == $team2Bet && $result == $resultBet && $result == "2"){
                $points += 12;
            }

        }

        return $points;
    }

    function calcMatchesBetBonus($connection, $match, $matchBet){
        $fase = $match->fase;

        //squadre impostate nella scommessa
        $team1Bet = $matchBet["id_team_1"];
        $team2Bet = $matchBet["id_team_2"];

        //guardo lista partite della fase
        $sql = "SELECT
                id_team_1,
                id_team_2
            FROM
                matches_fin
            WHERE fase = ".$fase.";";
        $query = mysqli_query($connection, $sql);

        $matchesDict = $query->fetch_all(MYSQLI_ASSOC);

        $bonus = 0;
        //ricavo lista squadre
        if($fase >= 3){
            foreach($matchesDict as $value){

                //squadre della partita effettiva
                $team1 = $value["id_team_1"];
                $team2 = $value["id_team_2"];

                if($team1 === null || $team2 === null){
                    continue;
                }

                //se le squadre del $matchBet sono presenti tra la lista di squadre assegno punti
                if($team1 == $team1Bet || $team1 == $team2Bet){
                    if($fase == 3){
                        //quart
                        $bonus += 10;
                    }else if($fase == 4){
                        //semi
                        $bonus += 15;
                    }else if($fase == 5){
                        //finale
                        $bonus += 25;
                    }
                }
                if($team2 == $team1Bet || $team2 == $team2Bet){
                    if($fase == 3){
                        //quart
                        $bonus += 10;
                    }else if($fase == 4){
                        //semi
                        $bonus += 15;
                    }else if($fase == 5){
                        //finale
                        $bonus += 25;
                    }
                }
            }
        }else{
            //bonus migliori terze
            $team1 = $match->id_team_1;
            $team2 = $match->id_team_2;
            $des1 = $match->des_1;
            $des2 = $match->des_2;

            //bonus migliore 3a
            if(str_contains($des1, "3")){
                if($team1 == $team1Bet){
                    $bonus += 5;
                }
            }

            //bonus migliore 3a
            if(str_contains($des2, "3")){
                if($team2 == $team2Bet){
                    $bonus += 5;
                }
            }


        }

        return $bonus;
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
            //squadra ok
            return 25;
        }else{
            //squadra no
            return 0;
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
            //squadra ok
            return 30;
        }else{
            //squadra no
            return 0;
        }
    }


    function calcCapoAzzBetPoints($is_valid, $bet_num) {
        if($is_valid == 1){
            //valido -> verifico numero scommessa
            if($bet_num == 1){
                return 10;
            }else{
                return 7;
            }
        }else if($is_valid == 0){
            return 0;
        }
    }

    function calcCapoEuroBetPoints($is_valid, $bet_num) {
        if($is_valid == 1){
            //valido -> verifico numero scommessa
            if($bet_num == 1){
                return 30;
            }else{
                return 20;
            }
        }else if($is_valid == 0){
            return 0;
        }
    }

}