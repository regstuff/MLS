#!/bin/bash

#case $1 in
#on)
screenname="$1$(basename "$0" .sh)";
#exec screen -dm -S $screenname "php /usr/local/nginx/scripts/InstagramLive-PHP$1/goLive.php";
#if [ -z "$STY" ]; then
#exec screen -dm -S insta /bin/bash "$0";
#exit 0;
#fi

#screen -dmS insta;
echo "Turning on $1instagram"
screen -dmS $screenname;
sleep 1

i="0"
#while [ $i -lt 10 ]
while true
do
screen -S $screenname -X stuff "cd /usr/local/nginx/scripts/InstagramLive-PHP$1 && php goLive.php
"
sleep 3480
i=$[$i+1]
echo "$i hours up"
screen -S $screenname -X stuff "stop
"
sleep 10
done
#;;

#off)


#if [ $(ps aux | grep "$screenname" | awk '{print $2}' | wc -l) -gt 0 ]; then
#kill $(ps aux | grep "$screenname" | awk '{print $2}')
#echo "Turning off instagram"
#fi

#screen -S $screenname -X stuff "cd ~/InstagramLive-PHP
#"
