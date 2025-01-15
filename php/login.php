<?php
require 'connect.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nim = $_POST['nim'];
    $password = $_POST['password'];

    // Ambil password hash dari database
    $stmt = $conn->prepare("SELECT password_hash FROM users WHERE nim = ?");
    $stmt->bind_param("s", $nim);
    $stmt->execute();
    $stmt->bind_result($password_hash);
    $stmt->fetch();
    $stmt->close();

    // Verifikasi password
    if ($password_hash && password_verify($password, $password_hash)) {
        echo "Login successful!";
    } else {
        echo "Invalid NIM or password!";
    }
}
?>
