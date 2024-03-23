<?php
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
  $csvData = array();
  if (($handle = fopen('stream-names.csv', 'r')) !== false) {
    while (($row = fgetcsv($handle)) !== false) {
      $csvData[] = $row;
    }
    fclose($handle);
  }

  header('Content-Type: application/json');
  echo json_encode(array('csvData' => $csvData));
}
?>

