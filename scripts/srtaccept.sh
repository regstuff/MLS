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
#/root/ffmpeg_sources/srt/build/srt-live-transmit "srt://:9000" "file://con" | /usr/bin/ffmpeg -re -i pipe:0 -map 0:0 -map 0:1 -vcodec libx264 -preset veryfast -profile:v high -acodec aac -f flv -strict -2 rtmp://127.0.0.1/main/stream1080
#/root/ffmpeg_sources/srt/build/srt-live-transmit "srt://:9000" "file://con" | /usr/bin/ffmpeg -re -i pipe:0 -map 0 -acodec copy -vcodec libx264 -preset ultrafast -profile:v high -s 1280x720 -f flv - | /usr/bin/ffmpeg -re -f flv -i - -map 0:0 -map 0:1 -vcodec copy -acodec aac -strict -2 rtmp://127.0.0.1/main/stream1 -map 0:0 -map 0:2 -vcodec copy -acodec aac -f flv -strict -2 rtmp://127.0.0.1/main/stream2
/root/ffmpeg_sources/srt/build/srt-live-transmit "srt://:9000" "file://con" | /usr/bin/ffmpeg -re -i pipe:0 -filter_complex "[0:1]pan=mono|c0=c0,aresample=async=1000[a1];[0:1]pan=mono|c0=c1,aresample=async=1000[a2];[0:2]pan=mono|c0=c0,aresample=async=1000[a3];[0:2]pan=mono|c0=c1,aresample=async=1000[a4];[0:3]pan=mono|c0=c0,aresample=async=1000[a5];[0:3]pan=mono|c0=c1,aresample=async=1000[a6];[0:4]pan=mono|c0=c0,aresample=async=1000[a7];[0:4]pan=mono|c0=c1,aresample=async=1000[a8];[0:5]pan=mono|c0=c0,aresample=async=1000[a9];[0:5]pan=mono|c0=c1,aresample=async=1000[a10]" -vcodec copy -map 0:0 -map [a1] -acodec aac -strict -2 -f flv rtmp://127.0.0.1/main/stream1 -map 0:0 -map [a2] -vcodec copy -acodec aac -strict -2 -f flv rtmp://127.0.0.1/main/stream2 -map 0:0 -map [a3] -vcodec copy -acodec aac -strict -2 -f flv rtmp://127.0.0.1/main/stream3 -map 0:0 -map [a4] -vcodec copy -acodec aac -strict -2 -f flv rtmp://127.0.0.1/main/stream4 -map 0:0 -map [a5] -vcodec copy -acodec aac -strict -2 -f flv rtmp://127.0.0.1/main/stream5 -map 0:0 -map [a6] -vcodec copy -acodec aac -strict -2 -f flv rtmp://127.0.0.1/main/stream6 -map 0:0 -map [a7] -vcodec copy -acodec aac -strict -2 -f flv rtmp://127.0.0.1/main/stream7 -map 0:0 -map [a8] -vcodec copy -acodec aac -strict -2 -f flv rtmp://127.0.0.1/main/stream8 -map 0:0 -map [a9] -vcodec copy -acodec aac -strict -2 -f flv rtmp://127.0.0.1/main/stream9 -map 0:0 -map [a10] -vcodec copy -acodec aac -strict -2 -f flv rtmp://127.0.0.1/main/stream10
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


