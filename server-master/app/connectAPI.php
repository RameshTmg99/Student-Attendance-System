<?php
//connect to db 
$conn = new mysqli("localhost","root","","sas");
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>

