<?php
require_once "vendor/autoload.php";
require_once "sendJson.php";

use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use Firebase\JWT\ExpiredException;
use Firebase\JWT\SignatureInvalidException;

$tokenSecret = '%p9nZb"X;obOEzMS|p77xPw<ZRV%i#{Gc+*~>dISLA!%adR5@Ux6Fuv/Ncmu`"a';

function encodeToken($data)
{
    global $tokenSecret;
    $token = array(
        'iss' => 'http://localhost/matches_api/',
        'iat' => time(),
        'exp' => time() + 36000, // 1hr
        'data' => $data
    );
    return JWT::encode($token, $tokenSecret, 'HS256');
}

function decodeToken($token)
{
    global $tokenSecret;
    try {
        $decode = JWT::decode($token, new Key($tokenSecret, 'HS256'));
        return $decode->data;
    } catch (ExpiredException | SignatureInvalidException $e) {
        sendJson(401, $e->getMessage());
    } catch (UnexpectedValueException | Exception $e) {
        sendJson(400, $e->getMessage());
    }
}