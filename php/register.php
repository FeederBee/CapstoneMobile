<?php
require 'connect.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nim = $_POST['nim'];
    $password = $_POST['password'];

    // Hash password untuk keamanan
    $password_hash = password_hash($password, PASSWORD_BCRYPT);

    // Simpan ke database
    $stmt = $conn->prepare("INSERT INTO users (nim, password_hash) VALUES (?, ?)");
    $stmt->bind_param("ss", $nim, $password_hash);

    if ($stmt->execute()) {
        echo "User registered successfully!";
    } else {
        echo "Registration failed!";
    }

    $stmt->close();
}
?>