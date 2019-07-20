<?php
session_start();

if(!isset($_SESSION)) {
    $_SESSION["attributes"] = $_SESSION["tables"] = $_SESSION["search"] = "";
}

$server = "localhost:3306";
$username = "prc353_1";
$password = "h3g1m8ca";

$conn = new mysqli($server, $username, $password, "prc353_1");

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
fclose($sqlFile);
$sqlFile = fopen("init_db.sql", "r");

$attributes = [];
$fileContents = explode("\n", fread($sqlFile, filesize("init_db.sql")));
fclose($sqlFile);

$tableSelect = "";
$attributeSelect = "style = \"visibility: hidden;\"";
$sqlError = "style = \"visibility: hidden;\"";
$showResults = "style = \"visibility: hidden;\"";

$tablesInQuery = "";
$attributesInQuery = "";
$searchCriteria = "";
$queryString = "";
$sqlErrorMessage="";

if (isset($_POST["submit1"])) {
    if (isset($_POST["tables"])) {
        for ($i = 0; $i < count($_POST["tables"]); $i++) {
            $tablesInQuery = $tablesInQuery . $_POST["tables"][$i];
            if ($i + 1 != count($_POST["tables"])) {
                $tablesInQuery = $tablesInQuery . ", ";
            }
        }

    }
    $_SESSION["tables"] = $tablesInQuery;
    $tableSelect = "style = \"visibility: hidden;\"";
    $attributeSelect = "style = \"visibility: visible;\"";
}

elseif (isset($_POST["submit2"])) {
    if (isset($_POST["attributes"])) {
        for ($i = 0; $i < count($_POST["attributes"]); $i++) {
            $attributesInQuery = $attributesInQuery . $_POST["attributes"][$i];
            if ($i + 1 != count($_POST["attributes"])) {
                $attributesInQuery = $attributesInQuery . ", ";
            }
            $_SESSION["attributes"] = $attributesInQuery;
            $tableSelect = "style = \"visibility: hidden;\"";
            $attributeSelect = "style = \"visibility: hidden;\"";}
    }
    if (isset($_POST["values"])){
        $_SESSION["values"] = $_POST["values"];
    }

    $query = "INSERT INTO ". $_SESSION["tables"] . "(" . $_SESSION["attributes"] . ") VALUES(". $_SESSION["values"] .");";
    $queryString = $query;

    if ($conn->query($query)) {
        $showResults = "style = \"visibility: visible;\"";
        $tableSelect = "style = \"visibility: hidden;\"";
    }
    else {
        $sqlErrorMessage = $conn->error;
        $showResults = "style = \"visibility: hidden;\"";
        $tableSelect = "style = \"visibility: hidden;\"";
    }

    if ($sqlErrorMessage != ""){
        $sqlError = "style = \"visibility: visible;\"";
        $tableSelect = "style = \"visibility: hidden;\"";
    }
}

$selectedTables = explode(",", $tablesInQuery);
$result = [];

for ($i = 0; $i < count($selectedTables); $i++) {
    $query = $conn->query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'prc353_1' AND TABLE_NAME = '$selectedTables[$i]'");

    while ($row = $query->fetch_assoc()) {
        $result[] = $row;
    }

    $columnArr = array_column($result, 'COLUMN_NAME');

    $attributes = array_merge($attributes, $columnArr);
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

    .results {
        background-color: rgb(128, 128, 128);
        background-color: rgba(128,128,128, 0.4);
        color: lightgrey;
        font-weight: bold;
        font-size: 100%;
        font-family: "Cambria Math", sans-serif;
        border: 3px solid #f1f1f1;
        position: absolute;
        top: 25%;
        left: 50%;
        transform: translate(-50%, 0%);
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
<title>Insert Records | Concordia University Database System</title>
<body>
<div class="background"></div>
<div class="titleBox">
    <p>Insert Records<br />
    </p>
</div>
<div class="selection" <?php echo $tableSelect;?>>
    <form name="tablesForm" action="./insert.php" method="post">
        <label>Please Select the Table into which You Would Like to Insert a Record<br/>
        </label>
        <?php
        echo "<br/><select name=\"tables[]\">";
        foreach($tableNames as $tableName) {
            echo "<option value=\"$tableName\">$tableName</option>";
        }
        echo "</select><br/>";
        ?>
        <input type="submit" name="submit1">
    </form>
</div>
<div class="selection" <?php echo $attributeSelect;?>>
    <form name="attributesForm" action="./insert.php" method="post">
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

        <label>Please Enter the Values to Insert <br/>
                <small><em>Please Use MySQL Syntax</em></small>
            </label>
            <input type="text" name="values"/>
            <input type="submit" name="submit2">
    </form>
</div>
<div class="selection" <?php echo $sqlError;?>>
    <form name="mySQLError" action="./insert.php" method="post">
        <label>MySQL Error Message</label>
        <?php
        echo "<p>$sqlErrorMessage</p>";
        ?>
        <a href="./home.php">Return to Homepage</a>
    </form>
</div>
<div class="results" <?php echo $showResults;?>>
    <form name="results" action="./insert.php" method="post">
        <label><?php echo $_SESSION["tables"]?> Table Contents<br /></label>
        <?php
        if ($showResults == "style = \"visibility: visible;\"") {

            $queryString = "SELECT * FROM " . $_SESSION["tables"].";";

            $result = $conn->query($queryString);

            echo "<table><tr>";
            for($i = 0; $i < mysqli_num_fields($result); $i++) {
                $field_info = mysqli_fetch_field($result);
                echo "<th>{$field_info->name}</th>";
            }

            while($row = mysqli_fetch_row($result)) {
                echo "<tr>";
                foreach($row as $_column) {
                    echo "<td>{$_column}</td>";
                }
                echo "</tr>";
            }

            echo "</table>";
        }
        ?>
        <a href="./home.php">Return to Homepage</a>
    </form>
</div>
</body>
</html>