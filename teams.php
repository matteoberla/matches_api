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
    $id = null;
    if(isset($_GET['id'])){
        //singola squadra
        $id = $_GET['id'];
        $sql = "SELECT * FROM `teams` WHERE `id`='$id'";
        $query = mysqli_query($connection, $sql);
        $row = mysqli_fetch_array($query, MYSQLI_ASSOC);
        if ($row === null) sendJson(404, 'Team not found!');
        sendJson(200, '', $row);

    }else{
        //lista squadre
        $sql = "SELECT * FROM `teams` ORDER BY `girone`, `name`";
        $query = mysqli_query($connection, $sql);

        $teamsDict = $query->fetch_all(MYSQLI_ASSOC);
        $response = ["teams" => $teamsDict];

        sendJson(200, '', $response);
    }

endif;


if ($_SERVER['REQUEST_METHOD'] == 'POST') :
    $authHandler->checkIfAdmin($connection);
    $data = json_decode(file_get_contents('php://input'));
    if (
        !isset($data->name) ||
        !isset($data->iso) ||
        !isset($data->girone) ||
        empty(trim($data->name)) ||
        empty(trim($data->iso)) ||
        empty(trim($data->girone))
    ) :
        sendJson(
            422,
            'Please fill all the required fields & None of the fields should be empty.',
            ['required_fields' => ['name', 'iso', 'girone']]
        );
    endif;

    $name = mysqli_real_escape_string($connection, htmlspecialchars(trim($data->name)));
    $iso = mysqli_real_escape_string($connection, trim($data->iso));
    $girone = mysqli_real_escape_string($connection, trim($data->girone));

    $hash_password = password_hash($password, PASSWORD_DEFAULT);
    $sql = "SELECT `name` FROM `teams` WHERE `name`='$name'";
    $query = mysqli_query($connection, $sql);
    $row_num = mysqli_num_rows($query);

    if ($row_num > 0) sendJson(422, 'This Team already exists!');

    $sql = "INSERT INTO `teams` (`name`,`iso`,`girone`) VALUES('$name','$iso','$girone')";
    $query = mysqli_query($connection, $sql);
    
    if ($query) sendJson(200, 'You have successfully registered a team.');
    sendJson(500, 'Something going wrong.');
endif;

if ($_SERVER['REQUEST_METHOD'] == 'PUT') :
    $authHandler->checkIfAdmin($connection);
    $data = json_decode(file_get_contents('php://input'));
    if (
        !isset($data->id) ||
        !isset($data->name) ||
        !isset($data->iso) ||
        !isset($data->girone) ||
        is_null(trim($data->id)) ||
        empty(trim($data->name)) ||
        empty(trim($data->iso)) ||
        empty(trim($data->girone))
    ) :
        sendJson(
            422,
            'Please fill all the required fields & None of the fields should be empty.',
            ['required_fields' => ['id', 'name', 'iso', 'girone']]
        );
    endif;

    $id = $data->id;
    $name = mysqli_real_escape_string($connection, htmlspecialchars(trim($data->name)));
    $iso = mysqli_real_escape_string($connection, trim($data->iso));
    $girone = mysqli_real_escape_string($connection, trim($data->girone));

    $sql = "SELECT `id` FROM `teams` WHERE `id`= $id";
    $query = mysqli_query($connection, $sql);
    $row_num = mysqli_num_rows($query);

    if ($row_num == 0) sendJson(404, 'This Team doesn\'t exists!');

    $sql = "UPDATE `teams` SET `name`='$name',`iso`='$iso',`girone`='$girone' WHERE `id` = $id";
    $query = mysqli_query($connection, $sql);
    
    if ($query) sendJson(200, 'You have successfully updated a team.');
    sendJson(500, 'Something going wrong.');

endif;

if ($_SERVER['REQUEST_METHOD'] == 'DELETE') :
    $authHandler->checkIfAdmin($connection);
    $data = json_decode(file_get_contents('php://input'));
    if (
        !isset($data->id) ||
        is_null(trim($data->id))
    ) :
        sendJson(
            422,
            'Please fill all the required fields & None of the fields should be empty.',
            ['required_fields' => ['id']]
        );
    endif;

    $id = $data->id;

    $sql = "DELETE FROM `teams` WHERE `id` = $id";
    $query = mysqli_query($connection, $sql);
    
    if ($query) sendJson(200, 'You have successfully deleted a team.');
    sendJson(500, 'Something going wrong.');
endif;


if($_SERVER['REQUEST_METHOD'] == 'OPTIONS') :
    sendJson(200, 'OK');
endif;

sendJson(405, 'Invalid Request Method. HTTP method should be POST');
