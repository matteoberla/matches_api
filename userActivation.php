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

if($_SERVER['REQUEST_METHOD'] == 'OPTIONS') :
    sendJson(200, 'OK');
endif;
//operazioni admin
$authHandler = new AuthHandler();



if ($_SERVER['REQUEST_METHOD'] == 'GET') :
    //solo admin
    $authHandler->checkIfAdmin($connection);

    if(isset($_GET['id'])){
        //singola scommessa partita
        $id = $_GET['id'];

        $sql = "SELECT * FROM `users` WHERE `id`='$id'";
        $query = mysqli_query($connection, $sql);
        $row = mysqli_fetch_array($query, MYSQLI_ASSOC);
        if ($row === null) sendJson(404, 'User not found!');

        $userIsActive = $row["isActive"];

        if($userIsActive == 0){
            $sql = "UPDATE `users` SET `isActive`=1 WHERE `id`='$id'";
        }else{
            $sql = "UPDATE `users` SET `isActive`=0 WHERE `id`='$id'";
        }
        //aggiorno stato
        $query = mysqli_query($connection, $sql);

        $sql = "SELECT * FROM `users` WHERE `id`='$id'";
        $query = mysqli_query($connection, $sql);
        $row = mysqli_fetch_array($query, MYSQLI_ASSOC);
        sendJson(200, '', $row);

    }


endif;


?>