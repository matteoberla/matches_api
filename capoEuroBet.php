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
require_once __DIR__ . '/controllers/pointsHandler.php';

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

        if($id == 0){
            $sql = "SELECT * FROM `capo_euro_bet`";
            $query = mysqli_query($connection, $sql);

            $teamsDict = $query->fetch_all(MYSQLI_ASSOC);
            $response = ["capo_euro_bet" => $teamsDict];

            sendJson(200, '', $response);
        }else{
            $sql = "SELECT * FROM `capo_euro_bet` WHERE `id`='$id' AND `user_id`='$loggedUserId'";
            $query = mysqli_query($connection, $sql);
            $row = mysqli_fetch_array($query, MYSQLI_ASSOC);
            if ($row === null) sendJson(404, 'capo euro bet not found!');

            sendJson(200, '', $row);
        }

    }else{

        //lista scommesse partite
        $sql = "SELECT * FROM `capo_euro_bet` WHERE `user_id`='$loggedUserId'";


        $query = mysqli_query($connection, $sql);

        $teamsDict = $query->fetch_all(MYSQLI_ASSOC);
        $response = ["capo_euro_bet" => $teamsDict];

        sendJson(200, '', $response);
    }

endif;


if ($_SERVER['REQUEST_METHOD'] == 'POST') :
    $data = json_decode(file_get_contents('php://input'));
    if (
        !isset($data->user_id) ||
        !isset($data->bet_num) ||
        !isset($data->value) ||
        is_null(trim($data->user_id)) ||
        is_null(trim($data->bet_num)) ||
        is_null(trim($data->value))
    ) :
        sendJson(
            422,
            'Please fill all the required fields & None of the fields should be empty.',
            ['required_fields' => ['user_id', 'bet_num', 'value']]
        );
    endif;

    $user_id = mysqli_real_escape_string($connection, htmlspecialchars(trim($data->user_id)));
    $bet_num = mysqli_real_escape_string($connection, trim($data->bet_num));
    $value = mysqli_real_escape_string($connection, trim($data->value));

    $sql = "INSERT INTO `capo_euro_bet` (`user_id`,`bet_num`,`value`) VALUES($user_id,$bet_num,'$value')";
    $query = mysqli_query($connection, $sql);

    if ($query) sendJson(200, 'You have successfully registered a capoeurobet.');
    sendJson(500, 'Something going wrong.');
endif;

if ($_SERVER['REQUEST_METHOD'] == 'PUT') :
    $data = json_decode(file_get_contents('php://input'));
    if (
        !isset($data->user_id) ||
        !isset($data->bet_num) ||
        !isset($data->value) ||
        is_null(trim($data->user_id)) ||
        is_null(trim($data->bet_num)) ||
        is_null(trim($data->value))
    ) :
        sendJson(
            422,
            'Please fill all the required fields & None of the fields should be empty.',
            ['required_fields' => ['user_id', 'bet_num', 'value']]
        );
    endif;

    $id = $data->id;
    $user_id = mysqli_real_escape_string($connection, htmlspecialchars(trim($data->user_id)));
    $bet_num = mysqli_real_escape_string($connection, trim($data->bet_num));
    $value = mysqli_real_escape_string($connection, trim($data->value));

    if(!isset($data->is_valid)){
        $is_valid = 0;
    }else{
        $is_valid = mysqli_real_escape_string($connection, trim($data->is_valid));
    }


    $sql = "SELECT `id` FROM `capo_euro_bet` WHERE `id`= $id";
    $query = mysqli_query($connection, $sql);
    $row_num = mysqli_num_rows($query);

    if ($row_num == 0) sendJson(404, 'This Match bet doesn\'t exists!');

    $pointsHandler = new PointsHandler();
    $capoEuroBetPoints = $pointsHandler->calcCapoEuroBetPoints($is_valid, $bet_num);

    $sql = "UPDATE `capo_euro_bet` SET `user_id`='$user_id',`bet_num`=$bet_num,`value`='$value',`is_valid`=$is_valid,`points`=$capoEuroBetPoints  WHERE `id` = $id";
    $query = mysqli_query($connection, $sql);

    if ($query) sendJson(200, 'You have successfully updated a capoeuro bet.');
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

    $sql = "DELETE FROM `capo_euro_bet` WHERE `id` = $id";
    $query = mysqli_query($connection, $sql);

    if ($query) sendJson(200, 'You have successfully deleted a capoeuro bet.');
    sendJson(500, 'Something going wrong.');
endif;




sendJson(405, 'Invalid Request Method. HTTP method should be POST');
