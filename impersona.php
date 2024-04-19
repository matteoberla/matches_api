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


//operazioni admin
$authHandler = new AuthHandler();

if ($_SERVER['REQUEST_METHOD'] == 'GET') :

    $authHandler->checkIfAdmin($connection);

    $id = null;
    if(isset($_GET['id'])){
        //singolo utente
        $id = $_GET['id'];
    }

    $sql = "SELECT email, extra_info FROM `users` WHERE `id`='$id'";
    $query = mysqli_query($connection, $sql);
    $row = mysqli_fetch_array($query, MYSQLI_ASSOC);

    if ($row === null) sendJson(404, 'User not found!');

    $row["password"] = base64_decode($row["extra_info"]);
    unset($row["extra_info"]);

    sendJson(200, '', $row);


endif;
