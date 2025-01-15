// get_scores.php
header('Content-Type: application/json');
$result = $conn->query("SELECT name, completion_time FROM scores ORDER BY completion_time ASC");
echo json_encode($result->fetch_all(MYSQLI_ASSOC));
?>