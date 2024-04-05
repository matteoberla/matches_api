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
    $girone = null;
    if(isset($_GET['girone'])){
        //singolo girone
        $girone = $_GET['girone'];
        $sql = "SELECT * FROM `gironi` WHERE `girone`='$girone'";
        $query = mysqli_query($connection, $sql);
        $row = mysqli_fetch_array($query, MYSQLI_ASSOC);
        if ($row === null) sendJson(404, 'Girone not found!');
        sendJson(200, '', $row);

    }else{
        //lista partite
        $sql = "SELECT * FROM `gironi` ORDER BY `girone`";
        $query = mysqli_query($connection, $sql);

        $teamsDict = $query->fetch_all(MYSQLI_ASSOC);
        $response = ["gironi" => $teamsDict];

        sendJson(200, '', $response);
    }

endif;


if ($_SERVER['REQUEST_METHOD'] == 'POST') :
    $authHandler->checkIfAdmin($connection);
    $data = json_decode(file_get_contents('php://input'));
    if (
        !isset($data->girone) ||
        !isset($data->id_team_1) ||
        !isset($data->id_team_2) ||
        !isset($data->id_team_3) ||
        !isset($data->id_team_4) ||
        is_null(trim($data->girone)) ||
        is_null(trim($data->id_team_1)) ||
        is_null(trim($data->id_team_2)) ||
        is_null(trim($data->id_team_3)) ||
        is_null(trim($data->id_team_4))
    ) :
        sendJson(
            422,
            'Please fill all the required fields & None of the fields should be empty.',
            ['required_fields' => ['girone', 'id_team_1', 'id_team_2', 'id_team_3', 'id_team_4']]
        );
    endif;

    $girone = mysqli_real_escape_string($connection, htmlspecialchars(trim($data->girone)));
    $id_team_1 = mysqli_real_escape_string($connection, trim($data->id_team_1));
    $id_team_2 = mysqli_real_escape_string($connection, trim($data->id_team_2));
    $id_team_3 = mysqli_real_escape_string($connection, trim($data->id_team_3));
    $id_team_4 = mysqli_real_escape_string($connection, trim($data->id_team_4));

    $pos_1 = null;
    if(isset($data->pos_1)){
        $pos_1 = mysqli_real_escape_string($connection, trim($data->pos_1));
    }

    if(is_null($pos_1)){
        $pos_1 = "NULL";
    }

    $pos_2 = null;
    if(isset($data->pos_2)){
        $pos_2 = mysqli_real_escape_string($connection, trim($data->pos_2));
    }

    if(is_null($pos_2)){
        $pos_2 = "NULL";
    }

    $pos_3 = null;
    if(isset($data->pos_3)){
        $pos_3 = mysqli_real_escape_string($connection, trim($data->pos_3));
    }

    if(is_null($pos_3)){
        $pos_3 = "NULL";
    }

    $pos_4 = null;
    if(isset($data->pos_4)){
        $pos_4 = mysqli_real_escape_string($connection, trim($data->pos_4));
    }

    if(is_null($pos_4)){
        $pos_4 = "NULL";
    }

    $sql = "INSERT INTO `gironi` (`girone`,`id_team_1`,`id_team_2`,`id_team_3`,`id_team_4`,`pos_1`,`pos_2`,`pos_3`,`pos_4`) VALUES('$girone',$id_team_1,$id_team_2,$id_team_3,$id_team_4,$pos_1,$pos_2,$pos_3,$pos_4)";
    $query = mysqli_query($connection, $sql);

    if ($query) sendJson(200, 'You have successfully registered a match.');
    sendJson(500, 'Something going wrong.');
endif;

if ($_SERVER['REQUEST_METHOD'] == 'PUT') :
    $authHandler->checkIfAdmin($connection);
    $data = json_decode(file_get_contents('php://input'));
    if (
        !isset($data->girone) ||
        !isset($data->id_team_1) ||
        !isset($data->id_team_2) ||
        !isset($data->id_team_3) ||
        !isset($data->id_team_4) ||
        is_null(trim($data->girone)) ||
        is_null(trim($data->id_team_1)) ||
        is_null(trim($data->id_team_2)) ||
        is_null(trim($data->id_team_3)) ||
        is_null(trim($data->id_team_4))
    ) :
        sendJson(
            422,
            'Please fill all the required fields & None of the fields should be empty.',
            ['required_fields' => ['girone', 'id_team_1', 'id_team_2', 'id_team_3', 'id_team_4']]
        );
    endif;

    $id = $data->id;
    $girone = mysqli_real_escape_string($connection, htmlspecialchars(trim($data->girone)));
    $id_team_1 = mysqli_real_escape_string($connection, trim($data->id_team_1));
    $id_team_2 = mysqli_real_escape_string($connection, trim($data->id_team_2));
    $id_team_3 = mysqli_real_escape_string($connection, trim($data->id_team_3));
    $id_team_4 = mysqli_real_escape_string($connection, trim($data->id_team_4));

    $pos_1 = null;
    if(isset($data->pos_1)){
        $pos_1 = mysqli_real_escape_string($connection, trim($data->pos_1));
    }

    if(is_null($pos_1)){
        $pos_1 = "NULL";
    }

    $pos_2 = null;
    if(isset($data->pos_2)){
        $pos_2 = mysqli_real_escape_string($connection, trim($data->pos_2));
    }

    if(is_null($pos_2)){
        $pos_2 = "NULL";
    }

    $pos_3 = null;
    if(isset($data->pos_3)){
        $pos_3 = mysqli_real_escape_string($connection, trim($data->pos_3));
    }

    if(is_null($pos_3)){
        $pos_3 = "NULL";
    }

    $pos_4 = null;
    if(isset($data->pos_4)){
        $pos_4 = mysqli_real_escape_string($connection, trim($data->pos_4));
    }

    if(is_null($pos_4)){
        $pos_4 = "NULL";
    }

    $sql = "SELECT `id` FROM `gironi` WHERE `id`= $id";
    $query = mysqli_query($connection, $sql);
    $row_num = mysqli_num_rows($query);

    if ($row_num == 0) sendJson(404, 'This Girone doesn\'t exists!');

    $sql = "UPDATE `gironi` SET `girone`='$girone',`id_team_1`=$id_team_1,`id_team_2`=$id_team_2,`id_team_3`=$id_team_3,`id_team_4`=$id_team_4,`pos_1`=$pos_1,`pos_2`=$pos_2,`pos_3`=$pos_3,`pos_4`=$pos_4  WHERE `id` = $id";
    $query = mysqli_query($connection, $sql);

    if ($query) {
        //updates successfully
        //update points of bets

        $sql = "SELECT * FROM `gironi_bet` WHERE `girone`='$girone'";
        $query = mysqli_query($connection, $sql);

        $gironiBetDict = $query->fetch_all(MYSQLI_ASSOC);

        $sql = "";
        for ($i = 0; $i < count($gironiBetDict); $i++) {
            $gironeBet = $gironiBetDict[$i];
            $gironeBetId = $gironeBet["id"];
            $pointsHandler = new PointsHandler();
            $gironeBetPoints = $pointsHandler->calcGironiBetPoints($data, $gironeBet);
            //echo $gironeBetPoints;
            $sql .= "UPDATE `gironi_bet` SET `points`= '$gironeBetPoints' WHERE `id`='$gironeBetId';";
        }
        //echo $sql;
        $gironeBetQuery = mysqli_multi_query($connection, $sql);

        if($gironeBetQuery)sendJson(200, 'You have successfully updated a girone.');
        sendJson(500, 'Something going wrong.');
    }
    sendJson(500, 'Something going wrong.');

endif;

if ($_SERVER['REQUEST_METHOD'] == 'DELETE') :
    $authHandler->checkIfAdmin($connection);
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

    $sql = "DELETE FROM `gironi` WHERE `id` = $id";
    $query = mysqli_query($connection, $sql);

    if ($query) sendJson(200, 'You have successfully deleted a match.');
    sendJson(500, 'Something going wrong.');
endif;

sendJson(405, 'Invalid Request Method. HTTP method should be POST');
