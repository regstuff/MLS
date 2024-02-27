<?php

$STREAM_NUM = $_ENV['STREAM_NUM'];
$OUT_NUM = $_ENV['OUT_NUM'];

$numberid = basename(__FILE__, ".php");
$id = $numberid . ".sh";

$streamno = $_GET['streamno'];
$action = $_GET['action'];
$actnumber = $_GET['actnumber'];
$state = $_GET['state'];

if ($action == "video") { #Get variables for starting holding screen
    $startmin = $_POST['startmin'];
    $startsec = $_POST['startsec'];
    $inputsec = 60 * $startmin + $startsec;
    $video_no = $_POST['video_no'];
    $output = exec("sudo /bin/bash /usr/local/nginx/scripts/\"$streamno\".sh on && sudo /bin/bash /usr/local/nginx/scripts/\"$streamno\".sh \"$video_no\" $inputsec");
    echo $output;
} elseif ($state == "turnon") { #Needed to run on and main/backup etc functions
    $output = exec("sudo /bin/bash /usr/local/nginx/scripts/\"$streamno\".sh on && sudo /bin/bash /usr/local/nginx/scripts/\"$streamno\".sh $action");
    echo $output;
} elseif ($action == "volume") {
    $vol = $_POST['vol_level'];
    $vol_level = 2 * $vol;
    $output = exec("sudo /bin/bash /usr/local/nginx/scripts/\"$streamno\".sh \"$action\" $vol_level");
    echo $output;
} elseif ($action == "super") {
    $output = exec("sudo /bin/bash /usr/local/nginx/scripts/\"$streamno\".sh \"$action\" $actnumber");
    echo $output;
} else { #For outputs
    $output = exec("sudo /bin/bash /usr/local/nginx/scripts/\"$streamno\".sh \"$action$actnumber\" $state");
    echo $output;
}

#### Global Controls - SUPERS ######
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

####END OF DESTINATIONS START INPUTS#####

if (isset($_GET['1on'])) {
    $output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id on");
    echo $output;
}
if (isset($_GET['1main'])) {
    $output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id on && sudo /bin/bash /usr/local/nginx/scripts/$id main");
    echo $output;
}
if (isset($_GET['1back'])) {
    $output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id on && sudo /bin/bash /usr/local/nginx/scripts/$id back");
    echo $output;
}
if (isset($_GET['1holding'])) {
    $output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id on && sudo /bin/bash /usr/local/nginx/scripts/$id holding 100");
    echo $output;
}
if (isset($_GET['1video'])) {
    $output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id on && sudo /bin/bash /usr/local/nginx/scripts/$id video $inputsec");
    echo $output;
}
if (isset($_GET['1playlist'])) {
    $output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id playlist");
    echo $output;
}
if (isset($_GET['1off'])) {
    $output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id off");
    echo $output;
}

####END OF INPUTS START MODS#####

if (isset($_GET['1vol'])) {
    $vol = $_POST['vol_level'];
    $vol_level = 2 * $vol;
    $output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id volume $vol_level");
    echo $output;
}

for ($i = 1; $i <= 8; $i++) {
    if (isset($_GET["1super{$i}on"])) {
        $output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id super $i");
        echo $output;
    }
}
if (isset($_GET['1superoff'])) {
    $output = exec("sudo /bin/bash /usr/local/nginx/scripts/${id} super off");
    echo $output;
}
?>
