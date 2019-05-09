#!/bin/bash
if [ -z "$STY" ]; then
exec screen -dm -S srtaccept /bin/bash "$0";
fi
while true
do
~/ffmpeg_sources/srt/build/srt-live-transmit "srt://:9000" "file://con" | /usr/bin/ffmpeg -re -i pipe:0 -map 0:0 -map 0:1 -vcodec libx264 -s 1280x720 -preset ultrafast -acodec aac -f flv -strict -2 rtmp://127.0.0.1/main/stream1080;
#~/ffmpeg_sources/srt/build/srt-live-transmit "srt://:9000" "file://con" | /usr/bin/ffmpeg -re -i pipe:0 -map 0:0 -map 0:1 -vcodec libx264 -s 1280x720 -preset ultrafast -acodec aac -f flv -strict -2 rtmp://127.0.0.1/input/stream1 -map 0:0 -map 0:2 -vcodec copy -acodec aac -f flv -strict -2 rtmp://127.0.0.1/input/stream2 -map 0:0 -map 0:3 -vcodec copy -acodec aac -f flv -strict -2 rtmp://127.0.0.1/input/stream3;
echo "Waiting to SRT Accept..."
sleep .2

done
