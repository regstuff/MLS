<?php

$STREAM_NUM = $_ENV['STREAM_NUM'];
$OUT_NUM = $_ENV['OUT_NUM'];

$numberid = basename(__FILE__, ".php");
$id = $numberid.".sh"; 

for ($i = 1; $i <= 100; $i++) {
    if (isset($_GET["1dest{$i}on"])) {
        $output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out{$i}");
        echo $output;
    }
    if (isset($_GET["1dest{$i}off"])) {
        $output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out{$i} off");
        echo $output;
    }
}

if (isset($_GET['instagramon'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/insta.sh on $numberid");echo $output;}
if (isset($_GET['instagramoff'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/instaoff.sh $numberid");echo $output;}

####END OF DESTINATIONS START INPUTS#####

if (isset($_GET['1on'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id on");echo $output;}
if (isset($_GET['1main'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id on && sudo /bin/bash /usr/local/nginx/scripts/$id main");echo $output;}
if (isset($_GET['1back'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id on && sudo /bin/bash /usr/local/nginx/scripts/$id back");echo $output;}
if (isset($_GET['1holding'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id on && sudo /bin/bash /usr/local/nginx/scripts/$id holding");echo $output;}
if (isset($_GET['1video'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id on && sudo /bin/bash /usr/local/nginx/scripts/$id video");echo $output;}
if (isset($_GET['1playlist'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id playlist");echo $output;}
if (isset($_GET['1off'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id off");echo $output;}

####END OF INPUTS START MODS#####

if (isset($_GET['1vol'])) {
$vol = $_POST['vol_level'];
$vol_level = 2*$vol;
$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id volume $vol_level");echo $output;}

for ($i = 1; $i <= 8; $i++) {
    if (isset($_GET["1super{$i}on"])) {
        $output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id super {$i}");
        echo $output;
    }
}
if (isset($_GET['1superoff'])) {
	$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id super off");echo $output;
    echo $output;
}

for ($j = 1; $j <= $OUT_NUM; $j++) {
    if (isset($_GET["allsuper{$j}on"])) {
        for ($i = 1; $i <= 8; $i++) {
            $output = exec("sudo /bin/bash /usr/local/nginx/scripts/{$i}.sh super {$j}");
            echo $output;
        }
    }
}
if (isset($_GET['allsuperoff'])) {
    for ($i = 1; $i <= 8; $i++) {
        $output = exec("sudo /bin/bash /usr/local/nginx/scripts/{$i}.sh super off");
        echo $output;
    }
}
?>

