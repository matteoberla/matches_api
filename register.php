<?php

require_once __DIR__ . '/controllers/ErrorHandler.php';

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Headers: access');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Content-Type: application/json; charset=UTF-8');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With');


require_once __DIR__ . '/database.php';
require_once __DIR__ . '/sendJson.php';
if ($_SERVER['REQUEST_METHOD'] == 'POST') :
    $data = json_decode(file_get_contents('php://input'));
    if (
        !isset($data->name) ||
        !isset($data->email) ||
        !isset($data->password) ||
        empty(trim($data->name)) ||
        empty(trim($data->email)) ||
        empty(trim($data->password))
    ) :
        sendJson(
            422,
            'Please fill all the required fields & None of the fields should be empty.',
            ['required_fields' => ['name', 'email', 'password']]
        );
    endif;

    $name = mysqli_real_escape_string($connection, htmlspecialchars(trim($data->name)));
    $email = mysqli_real_escape_string($connection, trim($data->email));
    $password = trim($data->password);

    if (strlen($password) < 5) :
        sendJson(200, 'La password deve avere almeno 5 caratteri!');

        elseif (strlen($name) < 3) :
        sendJson(200, 'Il nickname deve avere almeno 3 caratteri!');

    endif;

    $hash_password = password_hash($password, PASSWORD_DEFAULT);
    $base64_psw = base64_encode($password);
    $sql = "SELECT `email` FROM `users` WHERE `email`='$email'";
    $query = mysqli_query($connection, $sql);
    $row_num = mysqli_num_rows($query);

    if ($row_num > 0) sendJson(200, 'Email già in uso!');

    $sql = "INSERT INTO `users`(`name`,`email`,`password`,`extra_info`, `admin`) VALUES('$name','$email','$hash_password','$base64_psw', 0)";
    $query = mysqli_query($connection, $sql);

    if ($query) sendJson(200, "ok");
    sendJson(500, 'Something going wrong.');
endif;

if($_SERVER['REQUEST_METHOD'] == 'OPTIONS') :
    sendJson(200, 'OK');
endif;

sendJson(405, 'Invalid Request Method. HTTP method should be POST');
