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

if (isset($_GET['proclist'])) {$output = exec("sudo screen -ls | grep 'main\|back\|holding\|video' | cut -f 1,2,3 | cut -d '.
' -f 2");echo $output;}


if (isset($_GET['upload'])) {
	$target_dir = "../scripts/images/";
$target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);
$uploadOk = 1;
$imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));

// Check if file already exists
if (file_exists($target_file)) {
    echo "Sorry, file already exists.";
    $uploadOk = 0;
}
// Check file size
if ($_FILES["fileToUpload"]["size"] > 20000000) {
    echo "Sorry, your file is too large.";
    $uploadOk = 0;
}
// Allow certain file formats
if($imageFileType != "mp4") {
    echo "Sorry, only mp4 file is allowed.";
    $uploadOk = 0;
}
// Check if $uploadOk is set to 0 by an error
if ($uploadOk == 0) {
    echo "Sorry, your file was not uploaded.";
// if everything is ok, try to upload file
} else {
    if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
        echo "The file ". basename( $_FILES["fileToUpload"]["name"]). " has been uploaded.";
    } else {
        echo "Sorry, there was an error uploading your file.";
    }
}
}
?>
