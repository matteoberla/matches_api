<?php

require_once './database.php';
require_once __DIR__.'/jwtHandler.php';

class AuthHandler {

    private function getAuthorizationHeader() {
        $headers = getallheaders();
        foreach ($headers as $key => $value) {
            if (strtolower($key) === 'authorization') {
                return $value;
            }
        }

        if(isset($_SERVER["REDIRECT_HTTP_AUTHORIZATION"])){
            //apache
            return $_SERVER["REDIRECT_HTTP_AUTHORIZATION"];
        }

        return null;
    }

    function checkAuth() {
        $authHeader = $this->getAuthorizationHeader();
        if ($authHeader && preg_match('/Bearer\s(\S+)/', $authHeader, $matches)) {
            $data = decodeToken($matches[1]);
            if (!is_numeric($data)) return false;
            return true;
        }
        return false;
    }

    function userIsAdmin($connection) {
        $authHeader = $this->getAuthorizationHeader();
        if ($authHeader && preg_match('/Bearer\s(\S+)/', $authHeader, $matches)) {
            $data = decodeToken($matches[1]);
            $userId = (int) $data;
            if (!is_numeric($data)) return false;
            $sql = "SELECT * FROM `users` WHERE `id`='$userId'";
            $query = mysqli_query($connection, $sql);
            $row = mysqli_fetch_array($query, MYSQLI_ASSOC);
            if ($row === null) return false;
            if ($row['admin'] == true) {
                return true;
            }
        }
        return false;
    }

    function checkIfAdmin($connection) {
        $isAdmin = $this->userIsAdmin($connection);
        if (!$isAdmin) {
            sendJson(401, 'Unauthorized');
        }
    }

    function isSameUser($record_user_id) {
        $authHeader = $this->getAuthorizationHeader();
        if ($authHeader && preg_match('/Bearer\s(\S+)/', $authHeader, $matches)) {
            $data = decodeToken($matches[1]);
            $userId = (int) $data;
            if ($userId == $record_user_id) {
                return true;
            }
        }
        return false;
    }

    function checkIfSameUser($record_user_id) {
        $isSameUser = $this->isSameUser($record_user_id);
        if (!$isSameUser) {
            sendJson(401, 'Unauthorized');
        }
    }

    function getLoggedUserId() {
        $authHeader = $this->getAuthorizationHeader();
        if ($authHeader && preg_match('/Bearer\s(\S+)/', $authHeader, $matches)) {
            $data = decodeToken($matches[1]);
            $userId = (int) $data;
            return $userId;
        }
        return -1;
    }
}

// Check login token
$authHandler = new AuthHandler();
$valid = $authHandler->checkAuth();

if (!$valid) {
    if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
        sendJson(200, 'OK');
    } else {
        sendJson(401, 'Unauthorized');
    }
}

?>
