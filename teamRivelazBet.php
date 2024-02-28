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
    $id = null;
    $loggedUserId = $authHandler->getLoggedUserId();
    if(isset($_GET['id'])){
        //singola scommessa partita
        $id = $_GET['id'];
        $sql = "SELECT * FROM `team_rivelaz_bet` WHERE `id`='$id' AND `user_id`='$loggedUserId'";
        $query = mysqli_query($connection, $sql);
        $row = mysqli_fetch_array($query, MYSQLI_ASSOC);
        if ($row === null) sendJson(404, 'team rivelaz bet not found!');

        sendJson(200, '', $row);

    }else{
        //lista scommesse partite
        $sql = "SELECT * FROM `team_rivelaz_bet` WHERE `user_id`='$loggedUserId'";
        $query = mysqli_query($connection, $sql);

        $teamsDict = $query->fetch_all(MYSQLI_ASSOC);
        $response = ["team_rivelaz_bet" => $teamsDict];

        sendJson(200, '', $response);
    }

endif;


if ($_SERVER['REQUEST_METHOD'] == 'POST') :
    $data = json_decode(file_get_contents('php://input'));
    if (
        !isset($data->user_id) ||
        !isset($data->team_rivelaz_id) ||
        !isset($data->id_team) ||
        is_null(trim($data->user_id)) ||
        is_null(trim($data->team_rivelaz_id)) ||
        is_null(trim($data->id_team))
    ) :
        sendJson(
            422,
            'Please fill all the required fields & None of the fields should be empty.',
            ['required_fields' => ['user_id', 'team_rivelaz_id', 'id_team']]
        );
    endif;

    $user_id = mysqli_real_escape_string($connection, htmlspecialchars(trim($data->user_id)));
    $team_rivelaz_id = mysqli_real_escape_string($connection, trim($data->team_rivelaz_id));
    $id_team = mysqli_real_escape_string($connection, trim($data->id_team));

    $sql = "INSERT INTO `team_rivelaz_bet` (`user_id`,`team_rivelaz_id`,`id_team`) VALUES($user_id,$team_rivelaz_id,$id_team)";
    $query = mysqli_query($connection, $sql);
    
    if ($query) sendJson(200, 'You have successfully registered a team rivelaz.');
    sendJson(500, 'Something going wrong.');
endif;

if ($_SERVER['REQUEST_METHOD'] == 'PUT') :
    $data = json_decode(file_get_contents('php://input'));
    if (
        !isset($data->user_id) ||
        !isset($data->team_rivelaz_id) ||
        !isset($data->id_team) ||
        is_null(trim($data->user_id)) ||
        is_null(trim($data->team_rivelaz_id)) ||
        is_null(trim($data->id_team))
    ) :
        sendJson(
            422,
            'Please fill all the required fields & None of the fields should be empty.',
            ['required_fields' => ['user_id', 'team_rivelaz_id', 'id_team']]
        );
    endif;

    $id = $data->id;
    $user_id = mysqli_real_escape_string($connection, htmlspecialchars(trim($data->user_id)));
    $team_rivelaz_id = mysqli_real_escape_string($connection, trim($data->team_rivelaz_id));
    $id_team = mysqli_real_escape_string($connection, trim($data->id_team));

    $sql = "SELECT `id` FROM `team_rivelaz_bet` WHERE `id`= $id";
    $query = mysqli_query($connection, $sql);
    $row_num = mysqli_num_rows($query);

    if ($row_num == 0) sendJson(404, 'This team rivelaz bet doesn\'t exists!');

    $sql = "UPDATE `team_rivelaz_bet` SET `user_id`='$user_id',`team_rivelaz_id`=$team_rivelaz_id,`id_team`=$id_team  WHERE `id` = $id";
    $query = mysqli_query($connection, $sql);
    
    if ($query) sendJson(200, 'You have successfully updated a team rivelaz bet.');
    sendJson(500, 'Something going wrong.');

endif;

if ($_SERVER['REQUEST_METHOD'] == 'DELETE') :
    $data = json_decode(file_get_contents('php://input'));
    if (
        !isset($data->id) ||
        empty(trim($data->id))
    ) :
        sendJson(
            422,
            'Please fill all the required fields & None of the fields should be empty.',
            ['required_fields' => ['id']]
        );
    endif;

    $id = $data->id;

    $sql = "DELETE FROM `team_rivelaz_bet` WHERE `id` = $id";
    $query = mysqli_query($connection, $sql);
    
    if ($query) sendJson(200, 'You have successfully deleted a team rivelaz bet.');
    sendJson(500, 'Something going wrong.');
endif;




sendJson(405, 'Invalid Request Method. HTTP method should be POST');
