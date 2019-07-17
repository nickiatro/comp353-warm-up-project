<?php

$server = "localhost:3306";
$username = "prc353_1";
$password = "h3g1m8ca";

$conn = new mysqli($server, $username, $password);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>