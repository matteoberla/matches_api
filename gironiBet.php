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
        $sql = "SELECT 
                    gb.*,

                    s1.pt        AS pt_1,
                    s1.gol_fatti AS gol_fatti_1,
                    s1.gol_sub   AS gol_subiti_1,

                    s2.pt        AS pt_2,
                    s2.gol_fatti AS gol_fatti_2,
                    s2.gol_sub   AS gol_subiti_2,

                    s3.pt        AS pt_3,
                    s3.gol_fatti AS gol_fatti_3,
                    s3.gol_sub   AS gol_subiti_3,

                    s4.pt        AS pt_4,
                    s4.gol_fatti AS gol_fatti_4,
                    s4.gol_sub   AS gol_subiti_4

                FROM gironi_bet gb
                JOIN gironi g ON g.girone = gb.girone

                LEFT JOIN (
                    SELECT 
                        mb.user_id,
                        m.id_team_1 AS team_id,
                        gb2.id AS girone_bet_id,
                        SUM(CASE 
                            WHEN m.id_team_1 = g2.id_team_1 AND mb.result = '1' THEN 3
                            WHEN m.id_team_1 = g2.id_team_1 AND mb.result = 'X' THEN 1
                            WHEN m.id_team_2 = g2.id_team_1 AND mb.result = '2' THEN 3
                            WHEN m.id_team_2 = g2.id_team_1 AND mb.result = 'X' THEN 1
                            ELSE 0
                        END) AS pt,
                        SUM(CASE
                            WHEN m.id_team_1 = g2.id_team_1 THEN mb.goal_team_1
                            WHEN m.id_team_2 = g2.id_team_1 THEN mb.goal_team_2
                        END) AS gol_fatti,
                        SUM(CASE
                            WHEN m.id_team_1 = g2.id_team_1 THEN mb.goal_team_2
                            WHEN m.id_team_2 = g2.id_team_1 THEN mb.goal_team_1
                        END) AS gol_sub
                    FROM gironi_bet gb2
                    JOIN gironi g2 ON g2.girone = gb2.girone
                    JOIN matches m ON (m.id_team_1 = g2.id_team_1 OR m.id_team_2 = g2.id_team_1)
                    JOIN matches_bet mb ON mb.match_id = m.id AND mb.user_id = gb2.user_id
                    WHERE gb2.user_id = '$loggedUserId'
                    GROUP BY gb2.id, mb.user_id
                ) s1 ON s1.girone_bet_id = gb.id

                LEFT JOIN (
                    SELECT 
                        mb.user_id,
                        gb2.id AS girone_bet_id,
                        SUM(CASE 
                            WHEN m.id_team_1 = g2.id_team_2 AND mb.result = '1' THEN 3
                            WHEN m.id_team_1 = g2.id_team_2 AND mb.result = 'X' THEN 1
                            WHEN m.id_team_2 = g2.id_team_2 AND mb.result = '2' THEN 3
                            WHEN m.id_team_2 = g2.id_team_2 AND mb.result = 'X' THEN 1
                            ELSE 0
                        END) AS pt,
                        SUM(CASE
                            WHEN m.id_team_1 = g2.id_team_2 THEN mb.goal_team_1
                            WHEN m.id_team_2 = g2.id_team_2 THEN mb.goal_team_2
                        END) AS gol_fatti,
                        SUM(CASE
                            WHEN m.id_team_1 = g2.id_team_2 THEN mb.goal_team_2
                            WHEN m.id_team_2 = g2.id_team_2 THEN mb.goal_team_1
                        END) AS gol_sub
                    FROM gironi_bet gb2
                    JOIN gironi g2 ON g2.girone = gb2.girone
                    JOIN matches m ON (m.id_team_1 = g2.id_team_2 OR m.id_team_2 = g2.id_team_2)
                    JOIN matches_bet mb ON mb.match_id = m.id AND mb.user_id = gb2.user_id
                    WHERE gb2.user_id = '$loggedUserId'
                    GROUP BY gb2.id, mb.user_id
                ) s2 ON s2.girone_bet_id = gb.id

                LEFT JOIN (
                    SELECT 
                        mb.user_id,
                        gb2.id AS girone_bet_id,
                        SUM(CASE 
                            WHEN m.id_team_1 = g2.id_team_3 AND mb.result = '1' THEN 3
                            WHEN m.id_team_1 = g2.id_team_3 AND mb.result = 'X' THEN 1
                            WHEN m.id_team_2 = g2.id_team_3 AND mb.result = '2' THEN 3
                            WHEN m.id_team_2 = g2.id_team_3 AND mb.result = 'X' THEN 1
                            ELSE 0
                        END) AS pt,
                        SUM(CASE
                            WHEN m.id_team_1 = g2.id_team_3 THEN mb.goal_team_1
                            WHEN m.id_team_2 = g2.id_team_3 THEN mb.goal_team_2
                        END) AS gol_fatti,
                        SUM(CASE
                            WHEN m.id_team_1 = g2.id_team_3 THEN mb.goal_team_2
                            WHEN m.id_team_2 = g2.id_team_3 THEN mb.goal_team_1
                        END) AS gol_sub
                    FROM gironi_bet gb2
                    JOIN gironi g2 ON g2.girone = gb2.girone
                    JOIN matches m ON (m.id_team_1 = g2.id_team_3 OR m.id_team_2 = g2.id_team_3)
                    JOIN matches_bet mb ON mb.match_id = m.id AND mb.user_id = gb2.user_id
                    WHERE gb2.user_id = '$loggedUserId'
                    GROUP BY gb2.id, mb.user_id
                ) s3 ON s3.girone_bet_id = gb.id

                LEFT JOIN (
                    SELECT 
                        mb.user_id,
                        gb2.id AS girone_bet_id,
                        SUM(CASE 
                            WHEN m.id_team_1 = g2.id_team_4 AND mb.result = '1' THEN 3
                            WHEN m.id_team_1 = g2.id_team_4 AND mb.result = 'X' THEN 1
                            WHEN m.id_team_2 = g2.id_team_4 AND mb.result = '2' THEN 3
                            WHEN m.id_team_2 = g2.id_team_4 AND mb.result = 'X' THEN 1
                            ELSE 0
                        END) AS pt,
                        SUM(CASE
                            WHEN m.id_team_1 = g2.id_team_4 THEN mb.goal_team_1
                            WHEN m.id_team_2 = g2.id_team_4 THEN mb.goal_team_2
                        END) AS gol_fatti,
                        SUM(CASE
                            WHEN m.id_team_1 = g2.id_team_4 THEN mb.goal_team_2
                            WHEN m.id_team_2 = g2.id_team_4 THEN mb.goal_team_1
                        END) AS gol_sub
                    FROM gironi_bet gb2
                    JOIN gironi g2 ON g2.girone = gb2.girone
                    JOIN matches m ON (m.id_team_1 = g2.id_team_4 OR m.id_team_2 = g2.id_team_4)
                    JOIN matches_bet mb ON mb.match_id = m.id AND mb.user_id = gb2.user_id
                    WHERE gb2.user_id = '$loggedUserId'
                    GROUP BY gb2.id, mb.user_id
                ) s4 ON s4.girone_bet_id = gb.id

                WHERE gb.user_id = '$loggedUserId'
        ";
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
