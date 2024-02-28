<?php

require_once __DIR__ . '/matchesBetHandler.php';

class GironiBetHandler {


    function checkMatchesBetAndMatchesNumber($connection){
        $matchesBetHandler = new MatchesBetHandler();

        $matchesBetNum = $matchesBetHandler->matchesBetNumberOfCurrentUser($connection);
        $matchesNum = $matchesBetHandler->matchesNumber($connection);

        //verifico che il numero match sia diverso da numero matchbet
        if($matchesBetNum != $matchesBetNum){
            return false;
        }
        return true;
    }

    function getGironiBetNumber($connection){
        $authHandler = new AuthHandler();
        $loggedUserId = $authHandler->getLoggedUserId();
        $sql = "SELECT id FROM `gironi_bet` WHERE `user_id`='$loggedUserId'";
        $query = mysqli_query($connection, $sql);
        $gironiBetDict = $query->fetch_all(MYSQLI_ASSOC);
        $gironiBetNumber = 0;
        if ($gironiBetDict != null) {
            $gironiBetNumber = count($gironiBetDict);
        }
        return $gironiBetNumber;
    }

    function createGironiBetForUser($connection){

        //prendo lista gironi
        $authHandler = new AuthHandler();
        $loggedUserId = $authHandler->getLoggedUserId();
        $sql = "SELECT * FROM `gironi`";
        $query = mysqli_query($connection, $sql);
        $gironiDict = $query->fetch_all(MYSQLI_ASSOC);

        print_r($gironiDict);

        //ciclo ogni elemento in lista
        $sql = "";
        for ($i = 0; $i < count($gironiDict); $i++) {
                $girone = $gironiDict[$i];
                $sql = "INSERT INTO `gironi_bet` (`user_id`,`girone`) VALUES($user_id,'$girone',$pos_1,$pos_2,$pos_3,$pos_4)";
            }
        //echo $sql;
        //$matchBetQuery = mysqli_multi_query($connection, $sql);

        //creo girone per utente

    }


    function checkCreationGironiBet($connection){

        //verifico corrispondenza numero matches e matchesBet dell'utente
        $matchesNumbersOk = $this->checkMatchesBetAndMatchesNumber($connection);
        if($matchesNumbersOk == false){
            //annullo operazione -> numeri diversi
            //echo "Numeri diversi";
            return;
        }

        //verifico esistenza gironibet per l'utente
        if($this->getGironiBetNumber($connection) != 0){
            //annullo operazione -> esiste già
            //echo "gironibet esistono gia";
            return;
        }

        //creazione delle gironibet per l'utente
        $this->createGironiBetForUser($connection);

    }





}