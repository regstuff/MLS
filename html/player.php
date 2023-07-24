<?php
$STREAM_NUM = $_ENV['STREAM_NUM'];
$OUT_NUM = $_ENV['OUT_NUM'];

$streamno = $_GET['streamname'];
$streamapp = $_GET['appname'];
$output = exec("sudo /bin/bash /usr/local/nginx/scripts/player.sh $streamno $streamapp on");echo $output;

for ($i = 1; $i <= $STREAM_NUM; $i++) {
    if (isset($_GET[$i . 'on'])) {
        $output = exec("sudo /bin/bash /usr/local/nginx/scripts/player.sh $i on");
        echo $output;
    }
    if (isset($_GET[$i . 'off'])) {
        $output = exec("sudo /bin/bash /usr/local/nginx/scripts/player.sh $i off");
        echo $output;
    }
}

?>

