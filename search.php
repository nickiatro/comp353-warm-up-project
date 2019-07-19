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
        if (isset($_POST["search"])){
            $_SESSION["search"] = $_POST["search"];
        }
        $query = "SELECT " . $_SESSION["attributes"] . " FROM " . $_SESSION["tables"] . " " . $_SESSION["search"] . ";";

        if ($conn->query($query)) {

        }

        if (!$conn->query($query)) {
            $sqlErrorMessage = $conn->error;
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

    for ($j = 0; $j < count($columnArr); $j++) {
        $columnArr[$j] = $selectedTables[$i] . "." . $columnArr[$j];
    }

    $attributes = array_merge($attributes, $columnArr);
}

$countArray = [];

for ($i = 0; $i < count($attributes); $i++) {
    $countString = "COUNT(".$attributes[$i].")";
    array_push($countArray, $countString);
}

$attributes = array_merge($attributes, $countArray);
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

    .search {
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
        transform: translate(-50%, 140%);
        z-index: 2;
        width: 40%;
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
        <input type="submit" name="submit1">
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
        <div class="search" <?php echo $attributeSelect;?>>
            <label>Please Enter the Search Criteria <br/>
                <small><em>Please Use MySQL Syntax</em></small>
            </label>
            <input type="text" name="search"/>
            <input type="submit" name="submit2">
        </div>
    </form>
</div>
<div class="selection" <?php echo $sqlError;?>>
    <form name="tablesForm" action="./search.php" method="post">
        <label>MySQL Error Message</label>
        <?php
            echo "<p>$sqlErrorMessage</p>";
        ?>
        <a href="./home.php">Return to Homepage</a>
    </form>
</div>
<div class="selection" <?php echo $showResults;?>>
    <form name="tablesForm" action="./search.php" method="post">
        <label>Results<br /></label>
        <?php
            
        ?>
        <a href="./home.php">Return to Homepage</a>
    </form>
</div>
</body>
</html>


