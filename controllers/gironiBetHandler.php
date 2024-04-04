<?php

require_once __DIR__ . '/matchesBetHandler.php';

class GironiBetHandler {


    function checkMatchesBetAndMatchesNumber($connection){
        $matchesBetHandler = new MatchesBetHandler();

        $matchesBetNum = $matchesBetHandler->matchesBetNumberOfCurrentUser($connection);
        $matchesNum = $matchesBetHandler->matchesNumber($connection);

        //verifico che il numero match sia diverso da numero matchbet
        if($matchesNum != $matchesBetNum){
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

}