#!/bin/bash
LCK="/usr/local/nginx/scripts/tmp/srtaccept.LCK";

exec 8>$LCK;

if flock -n -x 8; then


if [ -z "$STY" ]; then
echo "Turning $1 SRT Accept"
exec screen -dm -S srtaccept /bin/bash "$0" "$1";
fi

case $1 in
off)
echo "SRT Accept is already off"
exit 0
;;

*)
while true
do
~/ffmpeg_sources/srt/build/srt-live-transmit "srt://:9000" "file://con" | /usr/bin/ffmpeg -re -i pipe:0 -map 0:0 -map 0:1 -vcodec libx264 -preset veryfast -profile:v high -acodec aac -f flv -strict -2 rtmp://127.0.0.1/main/stream1080
echo "Restarting SRT Accept..."
sleep .2
done
esac
#~/ffmpeg_sources/srt/build/srt-live-transmit "srt://:9000" "file://con" | /usr/bin/ffmpeg -re -i pipe:0 -map 0:0 -map 0:1 -vcodec libx264 -preset veryfast -level high -acodec aac -f flv -strict -2 rtmp://127.0.0.1/input/stream1 -map 0:0 -map 0:2 -vcodec copy -acodec aac -f flv -strict -2 rtmp://127.0.0.1/input/stream2 -map 0:0 -map 0:3 -vcodec copy -acodec aac -f flv -strict -2 rtmp://127.0.0.1/input/stream3;

else
case $1 in
off)
kill $(ps aux | grep "[S]CREEN.* srtaccept" | awk '{print $2}')
echo "Turning off SRT Accept"
;;

*)
echo "SRT Accept is already on"
esac
fi
