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
    if(isset($_GET['id'])){
        //singola partita
        $id = $_GET['id'];
        $sql = "SELECT * FROM `goal_veloce` WHERE `id`='$id'";
        $query = mysqli_query($connection, $sql);
        $row = mysqli_fetch_array($query, MYSQLI_ASSOC);
        if ($row === null) sendJson(404, 'Goal veloce not found!');
        sendJson(200, '', $row);

    }else{
        //lista partite
        $sql = "SELECT * FROM `goal_veloce`";
        $query = mysqli_query($connection, $sql);

        $teamsDict = $query->fetch_all(MYSQLI_ASSOC);
        $response = ["goal_veloce" => $teamsDict];

        sendJson(200, '', $response);
    }

endif;


if ($_SERVER['REQUEST_METHOD'] == 'POST') :
    $authHandler->checkIfAdmin($connection);
    $data = json_decode(file_get_contents('php://input'));
    if (
        !isset($data->id_team) ||
        is_null(trim($data->id_team))
    ) :
        sendJson(
            422,
            'Please fill all the required fields & None of the fields should be empty.',
            ['required_fields' => ['id_team']]
        );
    endif;


    $id_team = mysqli_real_escape_string($connection, trim($data->id_team));

    $sql = "INSERT INTO `goal_veloce` (`id_team`) VALUES($id_team)";
    $query = mysqli_query($connection, $sql);

    if ($query) sendJson(200, 'You have successfully registered a goal veloce.');
    sendJson(500, 'Something going wrong.');
endif;

if ($_SERVER['REQUEST_METHOD'] == 'PUT') :
    $authHandler->checkIfAdmin($connection);
    $data = json_decode(file_get_contents('php://input'));
    if (
        !isset($data->id_team) ||
        is_null(trim($data->id_team))
    ) :
        sendJson(
            422,
            'Please fill all the required fields & None of the fields should be empty.',
            ['required_fields' => ['id_team']]
        );
    endif;

    $id = $data->id;
    $id_team = mysqli_real_escape_string($connection, trim($data->id_team));


    $sql = "SELECT `id` FROM `goal_veloce` WHERE `id`= $id";
    $query = mysqli_query($connection, $sql);
    $row_num = mysqli_num_rows($query);

    if ($row_num == 0) sendJson(404, 'This Goal veloce doesn\'t exists!');

    $sql = "UPDATE `goal_veloce` SET `id_team`=$id_team  WHERE `id` = $id";
    $query = mysqli_query($connection, $sql);

    if ($query) {
        //updates successfully
        //update points of bets

        $sql = "SELECT * FROM `goal_veloce_bet` WHERE `goal_veloce_id`='$id'";
        $query = mysqli_query($connection, $sql);

        $goalVeloceBetDict = $query->fetch_all(MYSQLI_ASSOC);

        $sql = "";
        for ($i = 0; $i < count($goalVeloceBetDict); $i++) {
            $goalVeloceBet = $goalVeloceBetDict[$i];
            $goalVeloceBetId = $goalVeloceBet["id"];
            $pointsHandler = new PointsHandler();

            //calcolo punti
            $goalVelocePoints = $pointsHandler->calcGoalVeloceBetPoints($data, $goalVeloceBet);

            //echo $matchBetPoints;
            $sql .= "UPDATE `goal_veloce_bet` SET `points`= '$goalVelocePoints' WHERE `id`='$goalVeloceBetId';";
        }
        //echo $sql;
        $goalVeloceBetQuery = mysqli_multi_query($connection, $sql);

        if($goalVeloceBetQuery)sendJson(200, 'You have successfully updated a match.');
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

    $sql = "DELETE FROM `goal_veloce` WHERE `id` = $id";
    $query = mysqli_query($connection, $sql);

    if ($query) sendJson(200, 'You have successfully deleted a match.');
    sendJson(500, 'Something going wrong.');
endif;

sendJson(405, 'Invalid Request Method. HTTP method should be POST');
