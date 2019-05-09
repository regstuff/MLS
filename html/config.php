<?php
if (isset($_GET['streamlist'])) {
$output = file_get_contents( "../scripts/streamconfig.txt" ); // get the contents, and echo it out.
echo "<pre>$output</pre>";
}

if (isset($_GET['streamadd'])) {
$encodeparam = $_POST['encodeparam'];
$stream_id = $_POST['stream_id'];
echo "<h2>You entered the following information:</h2>";
echo "<b>Encode Parameter: </b> $encodeparam";
echo "<br><b>Stream Id: </b> $stream_id";
echo "<br>";
$output = shell_exec("sudo /bin/bash /usr/local/nginx/scripts/streamconfig.sh \"$stream_id\" $encodeparam");
echo $output;
}

if (isset($_GET['remap'])) {
$channel = $_POST['channel_no'];
$output = exec("sudo /bin/bash /usr/local/nginx/scripts/remap.sh $channel");echo $output;}

if (isset($_GET['remapoff'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/remap.sh off");echo $output;}

if (isset($_GET['srtaccept'])) {
$output = exec("sudo /bin/bash /usr/local/nginx/scripts/srtaccept.sh on");echo $output;}

if (isset($_GET['srtacceptoff'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/srtaccept.sh off");echo $output;}

if (isset($_GET['destlist'])) {
$output = file_get_contents( "../scripts/1data.txt" ); // get the contents, and echo it out.
echo "<pre>$output</pre>";
}

if (isset($_GET['destadd'])) {
$rtmp_url = $_POST['rtmp_url'];
$stream_id = $_POST['stream_id'];
$output_id = $_POST['output_id'];
$resolution = $_POST['resolution'];
$name_id = $_POST['name_id'];

echo "<h2>You Entered the following information:</h2>";
echo "<b>RTMP Url: </b> $rtmp_url";
echo "<br><b>Name: </b> $name_id";
echo "<br><b>Stream Id: </b> $stream_id";
echo "<br><b>Output Id: </b> $output_id";
echo "<br><b>Resolution: </b> $resolution";
echo "<br>";
$output = shell_exec("sudo /bin/bash /usr/local/nginx/scripts/adddestination.sh \"$rtmp_url\" \"$stream_id\" \"$output_id\" \"$resolution\" $name_id");
echo $output;
}
?>
