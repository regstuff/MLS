#!/bin/bash

case $1 in
on)
screenname="$2$(basename "$0" .sh)";
#exec screen -dm -S $screenname "php ~/InstagramLive-PHP/goLive.php";
#if [ -z "$STY" ]; then
#exec screen -dm -S insta /bin/bash "$0";
#exit 0;
#fi

#screen -dmS insta;

echo "Turning on $2insta"
screen -dmS $screenname;
sleep 1
screen -S $screenname -X stuff "/bin/bash /usr/local/nginx/scripts/instagram.sh $2
"
;;
#sleep 30
#"
#sleep 10



#screen -S $screenname -X stuff "cd ~/InstagramLive-PHP
#"


off)
screen -S $2instagram -X stuff "stop
"
sleep 5
if [ $(ps aux | grep " $2instagram" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep " $2instagram" | awk '{print $2}')
echo "Turning off $2instagram"
fi

#if [ $(ps aux | grep "$screenname" | awk '{print $2}' | wc -l) -gt 0 ]; then
#kill $(ps aux | grep "$screenname" | awk '{print $2}')
#echo "Turning off instagram"
#fi
esac
