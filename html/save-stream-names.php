<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $data = json_decode(file_get_contents('php://input'), true);
  $csvData = $data['csvData'];

  $file = fopen('stream-names.csv', 'w');
  foreach ($csvData as $row) {
    fputcsv($file, $row);
  }
  fclose($file);

  echo 'Stream names saved successfully.';
}
?>
