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
        $sql = "SELECT * FROM `matches` WHERE `id`='$id'";
        $query = mysqli_query($connection, $sql);
        $row = mysqli_fetch_array($query, MYSQLI_ASSOC);
        if ($row === null) sendJson(404, 'Match not found!');
        sendJson(200, '', $row);

    }else{
        //lista partite
        $sql = "SELECT * FROM `matches` ORDER BY `date`";
        $query = mysqli_query($connection, $sql);

        $teamsDict = $query->fetch_all(MYSQLI_ASSOC);
        $response = ["matches" => $teamsDict];

        sendJson(200, '', $response);
    }

endif;


if ($_SERVER['REQUEST_METHOD'] == 'POST') :
    $authHandler->checkIfAdmin($connection);
    $data = json_decode(file_get_contents('php://input'));
    if (
        !isset($data->date) ||
        !isset($data->id_team_1) ||
        !isset($data->id_team_2) ||
        !isset($data->fase) ||
        empty(trim($data->date)) ||
        is_null(trim($data->id_team_1)) ||
        is_null(trim($data->id_team_2)) ||
        is_null(trim($data->fase))
    ) :
        sendJson(
            422,
            'Please fill all the required fields & None of the fields should be empty.',
            ['required_fields' => ['date', 'id_team_1', 'id_team_2', 'fase']]
        );
    endif;

    $date = mysqli_real_escape_string($connection, htmlspecialchars(trim($data->date)));
    $id_team_1 = mysqli_real_escape_string($connection, trim($data->id_team_1));
    $id_team_2 = mysqli_real_escape_string($connection, trim($data->id_team_2));
    $fase = mysqli_real_escape_string($connection, trim($data->fase));
    $goal_team_1 = null;
    if(isset($data->goal_team_1)){
        $goal_team_1 = mysqli_real_escape_string($connection, trim($data->goal_team_1));
    }

    if(is_null($goal_team_1)){
        $goal_team_1 = "NULL";
    }

    $goal_team_2 = null;
    if(isset($data->goal_team_2)){
        $goal_team_2 = mysqli_real_escape_string($connection, trim($data->goal_team_2));
    }

    if(is_null($goal_team_2)){
        $goal_team_2 = "NULL";
    }

    $result = null;
    if(isset($data->result)){
        $result = mysqli_real_escape_string($connection, trim($data->result));
        $result = "'$result'";
    }

    if(is_null($result)){
        $result = "NULL";
    }

    $sql = "INSERT INTO `matches` (`date`,`id_team_1`,`id_team_2`,`fase`,`goal_team_1`,`goal_team_2`,`result`) VALUES('$date',$id_team_1,$id_team_2,$fase,$goal_team_1,$goal_team_1,$result)";
    $query = mysqli_query($connection, $sql);
    
    if ($query) sendJson(200, 'You have successfully registered a match.');
    sendJson(500, 'Something going wrong.');
endif;

if ($_SERVER['REQUEST_METHOD'] == 'PUT') :
    $authHandler->checkIfAdmin($connection);
    $data = json_decode(file_get_contents('php://input'));
    if (
        !isset($data->date) ||
        !isset($data->id_team_1) ||
        !isset($data->id_team_2) ||
        !isset($data->fase) ||
        empty(trim($data->date)) ||
        is_null(trim($data->id_team_1)) ||
        is_null(trim($data->id_team_2)) ||
        is_null(trim($data->fase))
    ) :
        sendJson(
            422,
            'Please fill all the required fields & None of the fields should be empty.',
            ['required_fields' => ['date', 'id_team_1', 'id_team_2', 'fase']]
        );
    endif;

    $id = $data->id;
    $date = mysqli_real_escape_string($connection, htmlspecialchars(trim($data->date)));
    $id_team_1 = mysqli_real_escape_string($connection, trim($data->id_team_1));
    $id_team_2 = mysqli_real_escape_string($connection, trim($data->id_team_2));
    $fase = mysqli_real_escape_string($connection, trim($data->fase));
    $goal_team_1 = null;
    if(isset($data->goal_team_1)){
        $goal_team_1 = mysqli_real_escape_string($connection, trim($data->goal_team_1));
    }

    if(is_null($goal_team_1)){
        $goal_team_1 = "NULL";
    }

    $goal_team_2 = null;
    if(isset($data->goal_team_2)){
        $goal_team_2 = mysqli_real_escape_string($connection, trim($data->goal_team_2));
    }

    if(is_null($goal_team_2)){
        $goal_team_2 = "NULL";
    }

    $result = null;
    if(isset($data->result)){
        $result = mysqli_real_escape_string($connection, trim($data->result));
        $result = "'$result'";
    }

    if(is_null($result)){
        $result = "NULL";
    }

    $sql = "SELECT `id` FROM `matches` WHERE `id`= $id";
    $query = mysqli_query($connection, $sql);
    $row_num = mysqli_num_rows($query);

    if ($row_num == 0) sendJson(404, 'This Match doesn\'t exists!');

    $sql = "UPDATE `matches` SET `date`='$date',`id_team_1`=$id_team_1,`id_team_2`=$id_team_2,`fase`=$fase,`goal_team_1`=$goal_team_1,`goal_team_2`=$goal_team_2,`result`=$result  WHERE `id` = $id";
    $query = mysqli_query($connection, $sql);
    
    if ($query) {
        //updates successfully
        //update points of bets

        $sql = "SELECT * FROM `matches_bet` WHERE `match_id`='$id'";
        $query = mysqli_query($connection, $sql);

        $matchesBetDict = $query->fetch_all(MYSQLI_ASSOC);
        
        $sql = "";
        for ($i = 0; $i < count($matchesBetDict); $i++) {
                $matchBet = $matchesBetDict[$i];
                $matchBetId = $matchBet["id"];
                $pointsHandler = new PointsHandler();
                $matchBetPoints = $pointsHandler->calcMatchesBetPoints($data, $matchBet);
                //echo $matchBetPoints;
                $sql .= "UPDATE `matches_bet` SET `points`= '$matchBetPoints' WHERE `id`='$matchBetId';";
        }
        //echo $sql;
        $matchBetQuery = mysqli_multi_query($connection, $sql);

        if($matchBetQuery)sendJson(200, 'You have successfully updated a match.');
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

    $sql = "DELETE FROM `matches` WHERE `id` = $id";
    $query = mysqli_query($connection, $sql);
    
    if ($query) sendJson(200, 'You have successfully deleted a match.');
    sendJson(500, 'Something going wrong.');
endif;

sendJson(405, 'Invalid Request Method. HTTP method should be POST');
