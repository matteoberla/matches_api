<?php

require_once __DIR__ . '/controllers/ErrorHandler.php';

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

require_once __DIR__ . '/database.php';
require_once __DIR__ . '/controllers/jwtHandler.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') :

    $data = json_decode(file_get_contents('php://input'));

    if (
        !isset($data->email) ||
        !isset($data->password) ||
        empty(trim($data->email)) ||
        empty(trim($data->password))
    ) :
        sendJson(
            200,
            'Please fill all the required fields & None of the fields should be empty.',
            ['required_fields' => ['email', 'password']]
        );
    endif;

    $email = mysqli_real_escape_string($connection, trim($data->email));
    $password = trim($data->password);

    $sql = "SELECT users.*, (SELECT conf.datetime FROM conf WHERE conf.id=1) as dt_scadenza, (SELECT conf.value_int FROM conf WHERE conf.id=2) as app_ver FROM `users` WHERE (users.email='$email' OR users.name='$email')";
    $query = mysqli_query($connection, $sql);
    $row = mysqli_fetch_array($query, MYSQLI_ASSOC);
    if ($row === null) sendJson(200, 'Utente non trovato! (Utente / Tel. non registrati)');
    if (!password_verify($password, $row['password'])) sendJson(200, 'Email o Password errati!');

    $row["impersona"] = false;
    if(isset($data->impersona) && $data->impersona==="true"){
        $row["impersona"] = true;
    }

    $response = [
        "token" => encodeToken($row['id'])
    ];
    sendJson(200, '', array_merge($response, $row));
endif;

if($_SERVER['REQUEST_METHOD'] == 'OPTIONS') :
    sendJson(200, 'OK');
endif;

sendJson(405, 'Invalid Request Method. HTTP method should be POST');