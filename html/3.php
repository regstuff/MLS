<?php

$id = basename(__FILE__, ".php");
$id .= ".sh"; 

if (isset($_GET['1dest1on'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out1");echo $output;}
if (isset($_GET['1dest2on'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out2");echo $output;}
if (isset($_GET['1dest3on'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out3");echo $output;}
if (isset($_GET['1dest4on'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out4");echo $output;}
if (isset($_GET['1dest5on'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out5");echo $output;}
if (isset($_GET['1dest6on'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out6");echo $output;}
if (isset($_GET['1dest7on'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out7");echo $output;}
if (isset($_GET['1dest8on'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out8");echo $output;}
if (isset($_GET['1dest9on'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out9");echo $output;}
if (isset($_GET['1dest10on'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out10");echo $output;}
if (isset($_GET['1dest11on'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out11");echo $output;}

if (isset($_GET['instagramon'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/insta.sh on");echo $output;}
if (isset($_GET['1dest99on'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out99");echo $output;}

if (isset($_GET['1dest1off'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out1 off");echo $output;}
if (isset($_GET['1dest2off'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out2 off");echo $output;}
if (isset($_GET['1dest3off'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out3 off");echo $output;}
if (isset($_GET['1dest4off'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out4 off");echo $output;}
if (isset($_GET['1dest5off'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out5 off");echo $output;}
if (isset($_GET['1dest6off'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out6 off");echo $output;}
if (isset($_GET['1dest7off'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out7 off");echo $output;}
if (isset($_GET['1dest8off'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out8 off");echo $output;}
if (isset($_GET['1dest9off'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out9 off");echo $output;}
if (isset($_GET['1dest10off'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out10 off");echo $output;}
if (isset($_GET['1dest11off'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out11 off");echo $output;}

if (isset($_GET['instagramoff'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/insta.sh off");echo $output;}
if (isset($_GET['1dest99off'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id out99 off");echo $output;}

####END OF DESTINATIONS START INPUTS#####

if (isset($_GET['1main'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id main");echo $output;}
if (isset($_GET['1back'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id back");echo $output;}
if (isset($_GET['1holding'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id holding");echo $output;}
if (isset($_GET['1video'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id video");echo $output;}
if (isset($_GET['1playlist'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id playlist");echo $output;}
if (isset($_GET['1off'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id off");echo $output;}

####END OF INPUTS START MODS#####

if (isset($_GET['1vol'])) {
$vol = $_POST['vol_level'];
$vol_level = 2*$vol;
$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id volume $vol_level");echo $output;}

if (isset($_GET['1superon'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id super on");echo $output;}
if (isset($_GET['1superoff'])) {$output = exec("sudo /bin/bash /usr/local/nginx/scripts/$id super off");echo $output;}

?>

