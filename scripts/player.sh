#!/bin/bash
streamid="stream"$1;
ffscreen="fftots"$1;

case $2 in
on)
if [ $(ps aux | grep "wstoff" | awk '{print $2}' | wc -l) -eq 1 ]; then
screen -dm -S wstoff
screen -S wstoff -p 0 -X stuff 'node /usr/local/nginx/html/websocket-relay.js supersecret 8031 443\n';
fi

LCK="/usr/local/nginx/scripts/tmp/${streamid}.LCK";
exec 8>$LCK;

if flock -n -x 8; then
if [ -z "$STY" ]; then
kill $(ps aux | grep "fftots" | awk '{print $2}')
echo "Turning on $streamid player"
#sleep .2
exec screen -dm -S $ffscreen /bin/bash "$0" "$1" "$2"
fi

while true
do
ffmpeg -i rtmp://127.0.0.1/distribute/$streamid -f mpegts -acodec mp2 -ar 44100 -ac 1 -b:a 96k -vcodec mpeg1video -r 25 -bf 0 -s 320x180 -b:v 200k -muxdelay 0.001 http://localhost:8031/supersecret
echo "Restarting ffmpeg..."
sleep .2
done

else
echo $streamid " player is already on"
fi
;;

off)
if [ $(ps aux | grep $ffscreen | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep $ffscreen | awk '{print $2}')
fi

#if [ $(ps aux | grep "wstoff" | awk '{print $2}' | wc -l) -gt 0 ]; then
#kill $(ps aux | grep "wstoff" | awk '{print $2}')
#fi
echo "Turning off $streamid player"

esac
