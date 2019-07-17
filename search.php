<?php

$server = "localhost:3306";
$username = "prc353_1";
$password = "h3g1m8ca";

$conn = new mysqli($server, $username, $password);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$tableNames = [];
$sqlFile = fopen("init_db.sql", "r");
$fileContents = explode(" ", fread($sqlFile, filesize("init_db.sql")));
$tableNameFound = 0;

foreach ($fileContents as $token) {
    if ($tableNameFound == 2){
        array_push($tableNames, $token);
        $tableNameFound = 0;
    }
    else if ($token == "CREATE") {
        $tableNameFound++;
    }
    else if ($token == "TABLE") {
        $tableNameFound++;
    }
}

$tablesInQuery = "";

if (isset($_POST["submit"])){
    if(isset($_POST["tables"])){
        for ($i=0; $i < count($_POST["tables"]); $i++) {
            $tablesInQuery = $tablesInQuery. $_POST["tables"][$i];
            if ($i + 1 != count($_POST["tables"])) {
                    $tablesInQuery = $tablesInQuery . ", ";
            }
        }
    }
}
$tableSelect = "";
$attributeSelect = "style = \"visibility: hidden;\"";
$enterCriteria = "style = \"visibility: hidden;\"";

if ($tablesInQuery != "") {
    $tableSelect = "style = \"visibility: hidden;\"";
    $attributeSelect = "style = \"visibility: visible;\"";
}

$attributes = [];
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
        font-family: "Cambria Math", sans-serif;
        border: 3px solid #b8860b;
        position: absolute;
        top: 22.5%;
        left: 50%;
        transform: translate(-50%, -100%);
        z-index: 2;
        width: 80%;
        padding: 20px;
        text-align: center;
    }

    .selection {
        background-color: rgb(128, 128, 128);
        background-color: rgba(128,128,128, 0.4);
        color: lightgrey;
        font-weight: bold;
        font-size: 150%;
        font-family: "Cambria Math", sans-serif;
        border: 3px solid #f1f1f1;
        position: absolute;
        top: 25%;
        left: 50%;
        transform: translate(-50%, 10%);
        z-index: 2;
        width: 80%;
        padding: 20px;
        text-align: center;
    }

    a{
        color: lightgrey;
    }

    select {
        background-color: rgb(128, 128, 128);
        background-color: rgba(128,128,128, 0.4);
        color: lightgrey;
        font-weight: bold;
        font-size: 100%;
        font-family: "Cambria Math", sans-serif;
        border: 3px solid #f1f1f1;
    }

</style>
<title>Search Records | Concordia University Database System</title>
<body>
<div class="background"></div>
<div class="titleBox">
    <p>Search Records<br />
    </p>
</div>
<div class="selection" <?php echo $tableSelect;?>>
    <form name="tablesForm" action="./search.php" method="post">
        <label>Please Select the Tables You Would Like to Search <br/>
            <small><em>Hold Down the Ctrl/Command Key to Select Multiple Tables</em></small>
        </label>
        <?php
            echo "<br/><select name=\"tables[]\" multiple>";
            foreach($tableNames as $tableName) {
                echo "<option value=\"$tableName\">$tableName</option>";
            }
            echo "</select><br/>";
            ?>
        <input type="submit" name="submit">
    </form>
</div>
<div class="selection" <?php echo $attributeSelect;?>>
    <form name="attributesForm" action="./search.php" method="post">
        <label>Please Select the Attributes You Would like to Display <br/>
            <small><em>Hold Down the Ctrl/Command Key to Select Multiple Attributes</em></small>
        </label>
        <?php
        echo "<br/><select name=\"attributes[]\" multiple>";
        foreach($attributes as $column) {
            echo "<option value=\"$column\">$column</option>";
        }
        echo "</select><br/>";
        ?>
        <input type="submit" name="submit">
    </form>
</div>
<div class="selection" <?php echo $enterCriteria;?>>
    <form name="criteriaForm" action="./search.php" method="post">
        <label>Please Enter the Search Criteria <br/>
            <small><em>Please Use MySQL Syntax</em></small>
        </label>
        <?php
        echo "<br/><select name=\"attributes[]\" multiple>";
        foreach($attributes as $column) {
            echo "<option value=\"$column\">$column</option>";
        }
        echo "</select><br/>";
        ?>
        <input type="submit" name="submit">
    </form>
</div>
</body>
</html>


