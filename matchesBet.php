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
        $sql = "SELECT * FROM `matches_bet` WHERE `id`='$id' AND `user_id`='$loggedUserId'";
        $query = mysqli_query($connection, $sql);
        $row = mysqli_fetch_array($query, MYSQLI_ASSOC);
        if ($row === null) sendJson(404, 'Match bet not found!');

        sendJson(200, '', $row);

    }else{
        //lista scommesse partite
        $sql = "SELECT * FROM `matches_bet` WHERE `user_id`='$loggedUserId'";
        $query = mysqli_query($connection, $sql);

        $teamsDict = $query->fetch_all(MYSQLI_ASSOC);
        $response = ["matches_bet" => $teamsDict];

        sendJson(200, '', $response);
    }

endif;


if ($_SERVER['REQUEST_METHOD'] == 'POST') :
    $data = json_decode(file_get_contents('php://input'));
    if (
        !isset($data->user_id) ||
        !isset($data->match_id) ||
        !isset($data->goal_team_1) ||
        !isset($data->goal_team_2) ||
        !isset($data->result) ||
        is_null(trim($data->user_id)) ||
        is_null(trim($data->match_id)) ||
        is_null(trim($data->goal_team_1)) ||
        is_null(trim($data->goal_team_2)) ||
        is_null(trim($data->result))
    ) :
        sendJson(
            422,
            'Please fill all the required fields & None of the fields should be empty.',
            ['required_fields' => ['user_id', 'match_id', 'goal_team_1', 'goal_team_2', 'result']]
        );
    endif;

    $user_id = mysqli_real_escape_string($connection, htmlspecialchars(trim($data->user_id)));
    $match_id = mysqli_real_escape_string($connection, trim($data->match_id));
    $goal_team_1 = mysqli_real_escape_string($connection, trim($data->goal_team_1));
    $goal_team_2 = mysqli_real_escape_string($connection, trim($data->goal_team_2));
    $result = mysqli_real_escape_string($connection, trim($data->result));

    $sql = "INSERT INTO `matches_bet` (`user_id`,`match_id`,`goal_team_1`,`goal_team_2`,`result`) VALUES($user_id,$match_id,$goal_team_1,$goal_team_2,'$result')";
    $query = mysqli_query($connection, $sql);
    
    if ($query) sendJson(200, 'You have successfully registered a match.');
    sendJson(500, 'Something going wrong.');
endif;

if ($_SERVER['REQUEST_METHOD'] == 'PUT') :
    $data = json_decode(file_get_contents('php://input'));
    if (
        !isset($data->id) ||
        !isset($data->user_id) ||
        !isset($data->match_id) ||
        !isset($data->goal_team_1) ||
        !isset($data->goal_team_2) ||
        !isset($data->result) ||
        is_null(trim($data->id)) ||
        is_null(trim($data->user_id)) ||
        is_null(trim($data->match_id)) ||
        is_null(trim($data->goal_team_1)) ||
        is_null(trim($data->goal_team_2)) ||
        is_null(trim($data->result))
    ) :
        sendJson(
            422,
            'Please fill all the required fields & None of the fields should be empty.',
            ['required_fields' => ['user_id', 'match_id', 'goal_team_1', 'goal_team_2', 'result']]
        );
    endif;

    $id = $data->id;
    $user_id = mysqli_real_escape_string($connection, htmlspecialchars(trim($data->user_id)));
    $match_id = mysqli_real_escape_string($connection, trim($data->match_id));
    $goal_team_1 = mysqli_real_escape_string($connection, trim($data->goal_team_1));
    $goal_team_2 = mysqli_real_escape_string($connection, trim($data->goal_team_2));
    $result = mysqli_real_escape_string($connection, trim($data->result));

    $sql = "SELECT `id` FROM `matches_bet` WHERE `id`= $id";
    $query = mysqli_query($connection, $sql);
    $row_num = mysqli_num_rows($query);

    if ($row_num == 0) sendJson(404, 'This Match bet doesn\'t exists!');

    $sql = "UPDATE `matches_bet` SET `user_id`='$user_id',`match_id`=$match_id,`goal_team_1`=$goal_team_1,`goal_team_2`=$goal_team_2,`result`='$result'  WHERE `id` = $id";
    $query = mysqli_query($connection, $sql);
    
    if ($query) sendJson(200, 'You have successfully updated a match bet.');
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

    $sql = "DELETE FROM `matches_bet` WHERE `id` = $id";
    $query = mysqli_query($connection, $sql);
    
    if ($query) sendJson(200, 'You have successfully deleted a match bet.');
    sendJson(500, 'Something going wrong.');
endif;




sendJson(405, 'Invalid Request Method. HTTP method should be POST');
