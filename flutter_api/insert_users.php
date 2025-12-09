<?php

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

include 'db_config.php'; // Include database configuration

$name = $_POST['name'] ?? ''; // Get name from POST request
$email = $_POST['email'] ?? ''; // Get email from POST request
$password = password_hash($_POST['password'] ?? '', PASSWORD_BCRYPT,); // Hash the password

$sql = "INSERT INTO users (name, email, password) VALUES ('$name', '$email', '$password')"; // SQL query to insert new user

if ($conn -> query($sql) === TRUE) { // Execute the query and check for success
    echo json_encode(["message" => "New record created successfully"]);
} else {
    echo json_encode(["message" => $conn -> error]);
}

?>