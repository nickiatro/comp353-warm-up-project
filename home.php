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

    .titleBox {
        background-color: rgb(128, 128, 128);
        background-color: rgba(128,128,128, 0.8);
        color: darkred;
        font-weight: bold;
        font-size: 350%;
        font-family: "Cambria Math";
        border: 3px solid #b8860b;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -100%);
        z-index: 2;
        width: 80%;
        padding: 20px;
        text-align: center;
    }

    .searchBox {
        background-color: rgb(128, 128, 128);
        background-color: rgba(128,128,128, 0.4);
        color: lightgrey;
        font-weight: bold;
        font-size: 200%;
        font-family: "Cambria Math";
        border: 3px solid #f1f1f1;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, 10%);
        z-index: 2;
        width: 60%;
        padding: 20px;
        text-align: center;
    }
    .insertBox {
        background-color: rgb(128, 128, 128);
        background-color: rgba(128,128,128, 0.4);
        color: lightgrey;
        font-weight: bold;
        font-size: 200%;
        font-family: "Cambria Math";
        border: 3px solid #f1f1f1;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, 120%);
        z-index: 2;
        width: 60%;
        padding: 20px;
        text-align: center;
    }

    .deleteBox {
        background-color: rgb(128, 128, 128);
        background-color: rgba(128,128,128, 0.4);
        color: lightgrey;
        font-weight: bold;
        font-size: 200%;
        font-family: "Cambria Math";
        border: 3px solid #f1f1f1;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, 230%);
        z-index: 2;
        width: 60%;
        padding: 20px;
        text-align: center;
    }

    a{
        color: lightgrey;
    }

</style>
<title>Welcome to the Concordia University Database System</title>
<body>
<div class="background"></div>
<div class="titleBox">
<p>Concordia University Database System <br />
    <small>Welcome! </small> | <small>Bienvenue!</small>
</p>
</div>
<div class="searchBox">
    <a href="./search.php">Search Records</a>
</div>
<div class="insertBox">
    <a href="./insert.php">Insert Records</a>
</div>
<div class="deleteBox">
    <a href="./delete.php">Delete Records</a>
</div>
</body>
</html>


