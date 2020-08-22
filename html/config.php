<?php
if (isset($_GET['streamlist'])) {
$output = shell_exec("sudo /bin/bash /usr/local/nginx/scripts/config.sh streamlist");
echo "<pre>$output</pre>";
#$output = file_get_contents( "../scripts/streamconfig.txt" ); // get the contents, and echo it out.
#echo "<pre>$output</pre>";
}

if (isset($_GET['streamadd'])) {
$encodeparam = $_POST['encodeparam'];
$stream_id = $_POST['stream_id'];
$stream_res = $_POST['stream_res'];
$failover_method = $_POST['failover_method'];
echo "<h2>You entered the following information:</h2>";
echo "<b>Encode Parameter: </b> $encodeparam";
echo "<br><b>Stream Id: </b> $stream_id";
echo "<br><b>Stream Reolution: </b> $stream_res";
echo "<br><b>Failover: </b> $failover_method";
echo "<br>";
$output = shell_exec("sudo /bin/bash /usr/local/nginx/scripts/config.sh streamconfig \"$stream_id\" \"$encodeparam\" \"$stream_res\" $failover_method");
echo $output;
}

if (isset($_GET['audioadd'])) {
$audioparam = $_POST['audioparam'];
$stream_id = $_POST['stream_id'];
$channel1 = $_POST['channel_1'];
$channel2 = $_POST['channel_2'];
$rtmpparam = $_POST['rtmpparam'];
echo "<h2>You entered the following information:</h2>";
echo "<b>Channel Layout: </b> $audioparam";
echo "<br><b>Stream Id: </b> $stream_id";
echo "<br><b>Channel 1: </b> $channel1";
echo "<br><b>Channel 2: </b> $channel2";
echo "<br><b>Destination: </b> $rtmpparam";
echo "<br>";
$output = shell_exec("sudo /bin/bash /usr/local/nginx/scripts/config.sh audioconfig \"$stream_id\" \"$audioparam\" \"$channel1\" \"$channel2\" $rtmpparam");
echo $output;
}

if (isset($_GET['audiopreset'])) {
$audiopreset = $_POST['audiopreset'];
echo "<b>You loaded </b> $audiopreset";
echo "<br>";
$output = shell_exec("sudo /bin/bash /usr/local/nginx/scripts/config.sh audiopreset $audiopreset");
echo $output;
}

if (isset($_GET['uploadfile'])) {
$file_url = $_POST['file_url'];
$stream_no = $_POST['stream_no'];
$type_id = $_POST['type_id'];
echo "<h2>You entered the following information:</h2>";
echo "<b>File Url: </b> $file_url";
echo "<br><b>Stream Id: </b> $stream_no";
echo "<br><b>FIle Type: </b> $type_id";
echo "<br>";
$output = shell_exec("sudo /bin/bash /usr/local/nginx/scripts/config.sh uploadfile \"$file_url\" \"$stream_no\" $type_id");
echo $output;
}

if (isset($_GET['remap'])) {
$channel = $_POST['channel_no'];
$output = exec("sudo /bin/bash /usr/local/nginx/scripts/config.sh remap $channel");echo $output;}

if (isset($_GET['audiolist'])) {
$output = shell_exec("sudo /bin/bash /usr/local/nginx/scripts/config.sh audiolist");
echo "<pre>$output</pre>";
#$output = file_get_contents( "../scripts/streamconfig.txt" ); // get the contents, and echo it out.
#echo "<pre>$output</pre>";
}

if (isset($_GET['remapoff'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/config.sh remap off");echo $output;}

if (isset($_GET['srtaccept'])) {
$output = exec("sudo /bin/bash /usr/local/nginx/scripts/config.sh srtaccept on");echo $output;}

if (isset($_GET['srtacceptoff'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/config.sh srtaccept off");echo $output;}

if (isset($_GET['destlist'])) {
$output = shell_exec("sudo /bin/bash /usr/local/nginx/scripts/config.sh destlist");
echo "<pre>$output</pre>";
#$output = file_get_contents( "../scripts/1data.txt" ); // get the contents, and echo it out.
#echo "<pre>$output</pre>";
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
$output = shell_exec("sudo /bin/bash /usr/local/nginx/scripts/config.sh destination \"$rtmp_url\" \"$stream_id\" \"$output_id\" \"$resolution\" $name_id");
echo $output;
}

if (isset($_GET['proclist'])) {
	$output = shell_exec("sudo ls -laR /var/run/screen/S-root | grep 'main\|back\|holding\|video' | cut -d ' ' -f 8,9,10,11");
	echo "<pre>$output</pre>";
	}

if (isset($_GET['instatestauth'])) {
        $insta_id = $_POST['insta_id'];
	$output = shell_exec("sudo /bin/bash /usr/local/nginx/scripts/config.sh instatestauth $insta_id");
	echo $folder_id." : <pre>$output</pre>";
	}


if (isset($_GET['uploadlower'])) {
error_reporting(E_ALL);
ini_set("display_errors", 1);
$target_dir = "/usr/local/nginx/scripts/images/lowerthird/";
$target_file = $target_dir.basename($_FILES["fileToUpload"]["name"]);
$uploadOk = 1;
$imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));
// Check if image file is a actual image or fake image
if(isset($_POST["submit"])) {
  $check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);
  if($check !== false) {
//    echo "File is an image - ".$check["mime"].".";
    $uploadOk = 1;
  } else {
    echo "File is not an image.";
    $uploadOk = 0;
  }
}
if ($_FILES["fileToUpload"]["size"] > 5000000) {
  echo "Sorry, your file is too large.";
  $uploadOk = 0;
}

// Allow certain file formats
if($imageFileType != "png" ) {
  echo "Sorry, only PNG files are allowed.";
  $uploadOk = 0;
}

// Check if $uploadOk is set to 0 by an error
if ($uploadOk == 0) {
  echo "Sorry, your file was not uploaded.";
// if everything is ok, try to upload file
} else {
$temp_filename = $_FILES["fileToUpload"]["tmp_name"];
$output = exec("sudo /bin/bash /usr/local/nginx/scripts/config.sh uploadlower $temp_filename $target_file");echo $output;
}
}

?>
