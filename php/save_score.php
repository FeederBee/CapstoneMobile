<?php
require 'connect.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = $_POST['name'];
    $time = $_POST['completion_time'];

    $stmt = $conn->prepare("INSERT INTO scores (name, completion_time) VALUES (?, ?)");
    $stmt->bind_param("sd", $name, $time);
    $stmt->execute();
    $stmt->close();

    echo "Score saved!";
}
?>