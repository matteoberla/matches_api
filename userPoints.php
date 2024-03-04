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
        //singolo utente
        $id = $_GET['id'];

        $sql = "SELECT
        u.id AS user_id,
        u.name AS username,
        u.isActive,
        COALESCE(mb.total_points, 0) AS total_matches_points,
        COALESCE(gb.total_points, 0) AS total_gironi_points,
        COALESCE(mfb.total_points, 0) AS total_matches_fin_points,
        COALESCE(gvb.total_points, 0) AS total_goal_veloce_points,
        COALESCE(trb.total_points, 0) AS total_team_rivelaz_points,
        COALESCE(cab.total_points, 0) AS total_capo_azz_points,
        COALESCE(ceb.total_points, 0) AS total_capo_euro_points,
        COALESCE(mb.total_points, 0) + COALESCE(gb.total_points, 0) + COALESCE(mfb.total_points, 0) + COALESCE(gvb.total_points, 0) + COALESCE(trb.total_points, 0) + COALESCE(cab.total_points, 0) + COALESCE(ceb.total_points, 0) AS total_points
        FROM
            users u
        LEFT JOIN
            (
                SELECT
                    user_id,
                    SUM(points) AS total_points
                FROM
                    matches_bet
                GROUP BY
                    user_id
            ) mb ON u.id = mb.user_id
        LEFT JOIN
            (
                SELECT
                    user_id,
                    SUM(points) AS total_points
                FROM
                    gironi_bet
                GROUP BY
                    user_id
            ) gb ON u.id = gb.user_id
        LEFT JOIN
            (
                SELECT
                    user_id,
                    SUM(points) AS total_points
                FROM
                    matches_fin_bet
                GROUP BY
                    user_id
            ) mfb ON u.id = mfb.user_id
        LEFT JOIN
            (
                SELECT
                    user_id,
                    SUM(points) AS total_points
                FROM
                    goal_veloce_bet
                GROUP BY
                    user_id
            ) gvb ON u.id = gvb.user_id
        LEFT JOIN
            (
                SELECT
                    user_id,
                    SUM(points) AS total_points
                FROM
                    team_rivelaz_bet
                GROUP BY
                    user_id
            ) trb ON u.id = trb.user_id
        LEFT JOIN
            (
                SELECT
                    user_id,
                    SUM(points) AS total_points
                FROM
                    capo_azz_bet
                GROUP BY
                    user_id
            ) cab ON u.id = cab.user_id
        LEFT JOIN
        (
            SELECT
                user_id,
                SUM(points) AS total_points
            FROM
                capo_euro_bet
            GROUP BY
                user_id
        ) ceb ON u.id = ceb.user_id
        WHERE
            u.id = '$id'
        ORDER BY
            total_points DESC;";

        $query = mysqli_query($connection, $sql);
        $row = mysqli_fetch_array($query, MYSQLI_ASSOC);
        if ($row === null) sendJson(404, 'User points non found!');
        sendJson(200, '', $row);

    }else{
        //$authHandler->checkIfAdmin($connection);
        //lista utenti

        $sql = "SELECT
        u.id AS user_id,
        u.name AS username,
        u.isActive,
        COALESCE(mb.total_points, 0) AS total_matches_points,
        COALESCE(gb.total_points, 0) AS total_gironi_points,
        COALESCE(mfb.total_points, 0) AS total_matches_fin_points,
        COALESCE(gvb.total_points, 0) AS total_goal_veloce_points,
        COALESCE(trb.total_points, 0) AS total_team_rivelaz_points,
        COALESCE(cab.total_points, 0) AS total_capo_azz_points,
        COALESCE(ceb.total_points, 0) AS total_capo_euro_points,
        COALESCE(mb.total_points, 0) + COALESCE(gb.total_points, 0) + COALESCE(mfb.total_points, 0) + COALESCE(gvb.total_points, 0) + COALESCE(trb.total_points, 0) + COALESCE(cab.total_points, 0) + COALESCE(ceb.total_points, 0) AS total_points
        FROM
            users u
        LEFT JOIN
            (
                SELECT
                    user_id,
                    SUM(points) AS total_points
                FROM
                    matches_bet
                GROUP BY
                    user_id
            ) mb ON u.id = mb.user_id
        LEFT JOIN
            (
                SELECT
                    user_id,
                    SUM(points) AS total_points
                FROM
                    gironi_bet
                GROUP BY
                    user_id
            ) gb ON u.id = gb.user_id
        LEFT JOIN
            (
                SELECT
                    user_id,
                    SUM(points) AS total_points
                FROM
                    matches_fin_bet
                GROUP BY
                    user_id
            ) mfb ON u.id = mfb.user_id
        LEFT JOIN
            (
                SELECT
                    user_id,
                    SUM(points) AS total_points
                FROM
                    goal_veloce_bet
                GROUP BY
                    user_id
            ) gvb ON u.id = gvb.user_id
        LEFT JOIN
            (
                SELECT
                    user_id,
                    SUM(points) AS total_points
                FROM
                    team_rivelaz_bet
                GROUP BY
                    user_id
            ) trb ON u.id = trb.user_id
        LEFT JOIN
            (
                SELECT
                    user_id,
                    SUM(points) AS total_points
                FROM
                    capo_azz_bet
                GROUP BY
                    user_id
            ) cab ON u.id = cab.user_id
        LEFT JOIN
        (
            SELECT
                user_id,
                SUM(points) AS total_points
            FROM
                capo_euro_bet
            GROUP BY
                user_id
        ) ceb ON u.id = ceb.user_id
        ORDER BY
            u.isActive DESC,
            total_points DESC;";

        $query = mysqli_query($connection, $sql);

        $pointsDict = $query->fetch_all(MYSQLI_ASSOC);
        $response = ["points" => $pointsDict];

        sendJson(200, '', $response);
    }

endif;
