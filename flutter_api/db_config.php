<?php

$host = 'localhost'; // Database host
$user = 'root'; // Database username
$password = ''; // Database password
$database = 'flutter_db'; // Database name

$conn = new mysqli($host, $user, $password, $database); // Create connection
if($conn -> connect_error){
    die("Connection failed: " . $conn -> connect_error);
}

?>
