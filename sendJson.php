<?php
function sendJson(int $status, string $message, array $extra = []): void
{
    $response = [];
    if($status != 200){
        $response = ['status' => $status];
    }
    if ($message != null) $response['message'] = $message;
    http_response_code($status);
    echo json_encode(array_merge($response, $extra));
    exit;
}