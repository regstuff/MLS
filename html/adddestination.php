<?php
if (isset($_GET['list'])) {
//$output = shell_exec("cat ../scripts/1data.txt");
//echo "$output";
$output = file_get_contents( "../scripts/1data.txt" ); // get the contents, and echo it out.
echo "<pre>$output</pre>";
}

if (isset($_GET['add'])) {
$rtmp_url = $_POST['rtmp_url'];
$stream_id = $_POST['stream_id'];
$output_id = $_POST['output_id'];
$resolution = $_POST['resolution'];
$name_id = $_POST['name_id'];
//if(empty($rtmp_url) || empty($stream_id) || empty($output_id)) {
//echo "<h2>You must fill in all fields</h2>\n" ;
//die ("Start again.");
//}
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
