<?php

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




}