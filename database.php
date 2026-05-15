<?php
$hostname = '127.0.0.1';
$username = 'root';
$password = '';
$database = 'matches_db';
$connection = mysqli_connect($hostname, $username, $password, $database);
$connection->options(MYSQLI_OPT_INT_AND_FLOAT_NATIVE, TRUE);
if (mysqli_connect_errno()) {
    echo "Connection Failed - " . mysqli_connect_error();
    exit;
}

$bearerRegExp = "/Bearer\s+(\S+)/";
// "/Bearer/s(/S+)/"

//db itxeanuf_matches_db
//user itxeanuf_wp884
//psw db netsons M]h?FHeRv(xj,v$i