<?php

$server = "localhost:3306";
$username = "prc353_1";
$password = "h3g1m8ca";

$conn = new mysqli($server, $username, $password);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>

<!doctype html>
<html>
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<style>
    body, html{
        height: 100%;
    }
    .background {
        background-image: url("welcome_background.jpg");
        filter: blur(8px);
        -webkit-filter: blur(8px);
        height: 100%;
        background-position: center;
        background-repeat: no-repeat;
        background-size: cover;
    }
</style>
<title>Welcome to the Concordia University Database System</title>
<body>
<div class="background"></div>
<div class="titleBox">

</div>

</body>
</html>


