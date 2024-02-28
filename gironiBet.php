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
    $girone = null;
    $loggedUserId = $authHandler->getLoggedUserId();
    if(isset($_GET['girone'])){
        //singola scommessa girone
        $girone = $_GET['girone'];
        $sql = "SELECT * FROM `gironi_bet` WHERE `girone`='$girone' AND `user_id`='$loggedUserId'";
        $query = mysqli_query($connection, $sql);
        $row = mysqli_fetch_array($query, MYSQLI_ASSOC);
        if ($row === null) sendJson(404, 'Girone bet not found!');
        sendJson(200, '', $row);

    }else{
        //lista scommesse partite
        $sql = "SELECT * FROM `gironi_bet` WHERE `user_id`='$loggedUserId'";
        $query = mysqli_query($connection, $sql);

        $teamsDict = $query->fetch_all(MYSQLI_ASSOC);
        $response = ["gironi_bet" => $teamsDict];

        sendJson(200, '', $response);
    }

endif;


if ($_SERVER['REQUEST_METHOD'] == 'POST') :
    $data = json_decode(file_get_contents('php://input'));
    if (
        !isset($data->user_id) ||
        !isset($data->girone) ||
        !isset($data->pos_1) ||
        !isset($data->pos_2) ||
        !isset($data->pos_3) ||
        !isset($data->pos_4) ||
        is_null(trim($data->user_id)) ||
        is_null(trim($data->girone)) ||
        is_null(trim($data->pos_1)) ||
        is_null(trim($data->pos_2)) ||
        is_null(trim($data->pos_3)) ||
        is_null(trim($data->pos_4)) 
    ) :
        sendJson(
            422,
            'Please fill all the required fields & None of the fields should be empty.',
            ['required_fields' => ['user_id', 'girone', 'pos_1', 'pos_2', 'pos_3', 'pos_4']]
        );
    endif;

    $user_id = mysqli_real_escape_string($connection, htmlspecialchars(trim($data->user_id)));
    $girone = mysqli_real_escape_string($connection, trim($data->girone));
    $pos_1 = mysqli_real_escape_string($connection, trim($data->pos_1));
    $pos_2 = mysqli_real_escape_string($connection, trim($data->pos_2));
    $pos_3 = mysqli_real_escape_string($connection, trim($data->pos_3));
    $pos_4 = mysqli_real_escape_string($connection, trim($data->pos_4));

    $sql = "INSERT INTO `gironi_bet` (`user_id`,`girone`,`pos_1`,`pos_2`,`pos_3`,`pos_4`) VALUES($user_id,'$girone',$pos_1,$pos_2,$pos_3,$pos_4)";
    $query = mysqli_query($connection, $sql);
    
    if ($query) sendJson(200, 'You have successfully registered a girone bet.');
    sendJson(500, 'Something going wrong.');
endif;

if ($_SERVER['REQUEST_METHOD'] == 'PUT') :
    $data = json_decode(file_get_contents('php://input'));
    if (
        !isset($data->id) ||
        !isset($data->user_id) ||
        !isset($data->girone) ||
        !isset($data->pos_1) ||
        !isset($data->pos_2) ||
        !isset($data->pos_3) ||
        !isset($data->pos_4) ||
        is_null(trim($data->user_id)) ||
        is_null(trim($data->girone)) ||
        is_null(trim($data->pos_1)) ||
        is_null(trim($data->pos_2)) ||
        is_null(trim($data->pos_3)) ||
        is_null(trim($data->pos_4)) 
    ) :
        sendJson(
            422,
            'Please fill all the required fields & None of the fields should be empty.',
            ['required_fields' => ['user_id', 'girone', 'pos_1', 'pos_2', 'pos_3', 'pos_4']]
        );
    endif;

    $id = $data->id;
    $user_id = mysqli_real_escape_string($connection, htmlspecialchars(trim($data->user_id)));
    $girone = mysqli_real_escape_string($connection, trim($data->girone));
    $pos_1 = mysqli_real_escape_string($connection, trim($data->pos_1));
    $pos_2 = mysqli_real_escape_string($connection, trim($data->pos_2));
    $pos_3 = mysqli_real_escape_string($connection, trim($data->pos_3));
    $pos_4 = mysqli_real_escape_string($connection, trim($data->pos_4));

    $sql = "SELECT `id` FROM `gironi_bet` WHERE `id`= $id";
    $query = mysqli_query($connection, $sql);
    $row_num = mysqli_num_rows($query);

    if ($row_num == 0) sendJson(404, 'This Girone bet doesn\'t exists!');

    $sql = "UPDATE `gironi_bet` SET `user_id`='$user_id',`girone`='$girone',`pos_1`=$pos_1,`pos_2`=$pos_2,`pos_3`='$pos_3',`pos_4`='$pos_4'  WHERE `id` = $id";
    $query = mysqli_query($connection, $sql);
    
    if ($query) sendJson(200, 'You have successfully updated a girone bet.');
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

    $sql = "DELETE FROM `gironi_bet` WHERE `id` = $id";
    $query = mysqli_query($connection, $sql);
    
    if ($query) sendJson(200, 'You have successfully deleted a girone bet.');
    sendJson(500, 'Something going wrong.');
endif;


sendJson(405, 'Invalid Request Method. HTTP method should be POST');
