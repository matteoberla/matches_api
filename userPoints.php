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
    }

    //verifico se filtrare per utente
    $whereCase = "";
    if($id != null){
        $whereCase = "WHERE u.id = '$id'";
    }

    $sql = "SELECT
        u.id AS user_id,
        u.name AS username,
        u.isActive,
        COALESCE(mb.total_points, 0) AS total_matches_points,
        COALESCE(gb.total_points, 0) AS total_gironi_points,
        COALESCE(mfb.total_points, 0) AS total_matches_fin_points,
        COALESCE(mfb_bonus_o.total_bonus, 0) AS total_matches_fin_bonus_ottavi_migliori_terze,
        COALESCE(mfb_bonus_q.total_bonus, 0) AS total_matches_fin_bonus_quarti,
        COALESCE(mfb_bonus_s.total_bonus, 0) AS total_matches_fin_bonus_semi,
        COALESCE(mfb_bonus_f.total_bonus, 0) AS total_matches_fin_bonus_final,
        COALESCE(mfb_bonus_tot.total_bonus, 0) AS total_matches_fin_bonus_total,
        COALESCE(gvb.total_points, 0) AS total_goal_veloce_points,
        COALESCE(trb.total_points, 0) AS total_team_rivelaz_points,
        COALESCE(cab.total_points, 0) AS total_capo_azz_points,
        COALESCE(ceb.total_points, 0) AS total_capo_euro_points,
        COALESCE(mb.total_points, 0) + COALESCE(gb.total_points, 0) + COALESCE(mfb.total_points, 0) + COALESCE(mfb_bonus_tot.total_bonus, 0) + COALESCE(gvb.total_points, 0) + COALESCE(trb.total_points, 0) + COALESCE(cab.total_points, 0) + COALESCE(ceb.total_points, 0) AS total_points
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
                    SUM(bonus) AS total_bonus
                FROM
                    matches_fin_bet
                GROUP BY
                    user_id
            ) mfb_bonus_tot ON u.id = mfb_bonus_tot.user_id
        LEFT JOIN
            (
                SELECT
                    user_id,
                    SUM(bonus) AS total_bonus
                FROM
                    matches_fin_bet as mfb
                JOIN
                    matches_fin AS mf ON mfb.match_id = mf.id
                WHERE
                    mf.fase = 2
                GROUP BY
                    user_id
            ) mfb_bonus_o ON u.id = mfb_bonus_o.user_id
        LEFT JOIN
            (
                SELECT
                    user_id,
                    SUM(bonus) AS total_bonus
                FROM
                    matches_fin_bet as mfb
                JOIN
                    matches_fin AS mf ON mfb.match_id = mf.id
                WHERE
                    mf.fase = 3
                GROUP BY
                    user_id
            ) mfb_bonus_q ON u.id = mfb_bonus_q.user_id
         LEFT JOIN
            (
                SELECT
                    user_id,
                    SUM(bonus) AS total_bonus
                FROM
                    matches_fin_bet as mfb
                JOIN
                    matches_fin AS mf ON mfb.match_id = mf.id
                WHERE
                    mf.fase = 4
                GROUP BY
                    user_id
            ) mfb_bonus_s ON u.id = mfb_bonus_s.user_id
        LEFT JOIN
            (
                SELECT
                    user_id,
                    SUM(bonus) AS total_bonus
                FROM
                    matches_fin_bet as mfb
                JOIN
                    matches_fin AS mf ON mfb.match_id = mf.id
                WHERE
                    mf.fase = 5
                GROUP BY
                    user_id
            ) mfb_bonus_f ON u.id = mfb_bonus_f.user_id
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
        ".$whereCase."
        ORDER BY
            u.isActive DESC,
            total_points DESC;";


    //eseguo query
    if($id != null){
        $query = mysqli_query($connection, $sql);
        $row = mysqli_fetch_array($query, MYSQLI_ASSOC);
        if ($row === null) sendJson(404, 'User points non found!');
        sendJson(200, '', $row);
    }else{
        $query = mysqli_query($connection, $sql);

        $pointsDict = $query->fetch_all(MYSQLI_ASSOC);
        $response = ["points" => $pointsDict];

        sendJson(200, '', $response);
    }


endif;
