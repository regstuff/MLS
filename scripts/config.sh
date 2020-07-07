#!/bin/bash

##### START ADD DESTINATION ##########
case $1 in
destination)
sudo sed -i "s|stream$3__out$4__.*|stream$3__out$4__ $(echo $2 | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g') $5 $6|" /usr/local/nginx/scripts/1data.txt;

;;

##### END DESTINATION - START STREAM CONFIG ##########

streamconfig)
sudo sed -i "s|stream$2__config__.*|stream$2__config__ $3 $4|" /usr/local/nginx/scripts/1data.txt;

;;

##### END STREAM CONFIG - START UPLOAD FILE ##########

uploadfile)
sudo wget -O $3$4 $2 && sudo chmod +x $3$4 && sudo mv $3$4 /usr/local/nginx/scripts/images

;;

##### END UPLOAD FILE - START STREAM LIST ##########
streamlist)
startline=`grep -n '***STREAM CONFIG***' /usr/local/nginx/scripts/1data.txt | cut -d: -f 1`
endline=`grep -n '***AUDIO CONFIG***' /usr/local/nginx/scripts/1data.txt | cut -d: -f 1`
rangeoflines=$startline','$endline'p'
sed -n $rangeoflines /usr/local/nginx/scripts/1data.txt

;;

##### END STREAM LIST - START DESTINATION LIST ##########
destlist)
startline=`grep -n '***DESTINATION CONFIG***' /usr/local/nginx/scripts/1data.txt | cut -d: -f 1`
endline=`grep -n '***STREAM CONFIG***' /usr/local/nginx/scripts/1data.txt | cut -d: -f 1`
rangeoflines=$startline','$endline'p'
sed -n $rangeoflines /usr/local/nginx/scripts/1data.txt

;;

##### END DESTINATION LIST - START AUDIO LIST ##########
audiolist)
startline=`grep -n '***AUDIO CONFIG***' /usr/local/nginx/scripts/1data.txt | cut -d: -f 1`
endline=`grep -n '***NEXT CONFIG***' /usr/local/nginx/scripts/1data.txt | cut -d: -f 1`
rangeoflines=$startline','$endline'p'
sed -n $rangeoflines /usr/local/nginx/scripts/1data.txt

;;

##### END AUDIO LIST - START SRT ACCEPT ##########

srtaccept)
LCK="/usr/local/nginx/scripts/tmp/srtaccept.LCK";

exec 8>$LCK;

if flock -n -x 8; then


if [ -z "$STY" ]; then
echo "Turning $2 SRT Accept"
exec screen -dm -S srtaccept /bin/bash "$0" "$1" "$2";
fi

case $2 in
off)
echo "SRT Accept is already off"
exit 0
;;

*)
while true
do
/usr/local/nginx/scripts/srt/build/srt-live-transmit "srt://:9000" "file://con" | /usr/bin/ffmpeg -re -i pipe:0 -map 0:0 -map 0:1 -vcodec libx264 -preset veryfast -profile:v high -acodec aac -f flv -strict -2 rtmp://127.0.0.1/main/stream1080
echo "Restarting SRT Accept..."
sleep .2
done
esac
#~/ffmpeg_sources/srt/build/srt-live-transmit "srt://:9000" "file://con" | /usr/bin/ffmpeg -re -i pipe:0 -map 0:0 -map 0:1 -vcodec libx264 -preset veryfast -level high -acodec aac -f flv -strict -2 rtmp://127.0.0.1/input/stream1 -map 0:0 -map 0:2 -vcodec copy -acodec aac -f flv -strict -2 rtmp://127.0.0.1/input/stream2 -map 0:0 -map 0:3 -vcodec copy -acodec aac -f flv -strict -2 rtmp://127.0.0.1/input/stream3;

else
case $2 in
off)
kill $(ps aux | grep "[S]CREEN.* srtaccept" | awk '{print $2}')
echo "Turning off SRT Accept"
;;

*)
echo "SRT Accept is already on"
esac
fi

;;

##### END SRT ACCEPT - START SRT SEND ##########

srtsend)
if [ -z "$STY" ]; then
exec screen -dm -S srtsend /bin/bash "$0" "$1";
fi
/usr/local/bin/ffmpeg -re -fflags +genpts -stream_loop -1 -i /usr/local/nginx/scripts/images/8video.mp4 -map 0:0 -map 0:1 -map 0:2 -map 0:3 -vcodec copy -acodec copy -f mpegts - | ~/ffmpeg_sources/srt/build/srt-live-transmit -v "file://con" "srt://139.59.46.142:9000"

;;

##### END SRT SEND - START REMAP ##########
remap)
LCK="/usr/local/nginx/scripts/tmp/remap.LCK";

exec 8>$LCK;

if flock -n -x 8; then

if [ -z "$STY" ]; then
echo "Remapping $2 channels"
exec screen -dm -S remap /bin/bash "$0" "$1" "$2";
fi

case $2 in

2)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/main/stream1080 -filter_complex "[0:a]pan=mono|c0=c0,aresample=async=1000[a0];[0:a]pan=mono|c0=c1,aresample=async=1000[a1]" -map 0:v -map [a0] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream1 -map 0:v -map [a1] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream2
echo "Restarting remapping..."
sleep .2
done
;;

3)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/main/stream1080 -filter_complex "[0:a]pan=mono|c0=c0,aresample=async=1000[a0];[0:a]pan=mono|c0=c1,aresample=async=1000[a1];[0:a]pan=mono|c0=c2,aresample=async=1000[a2]" -map 0:v -map [a0] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream1 -map 0:v -map [a1] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream2 -map 0:v -map [a2] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream3
echo "Restarting remapping..."
sleep .2
done
;;

4)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/main/stream1080 -filter_complex "[0:a]pan=mono|c0=c0,aresample=async=1000[a0];[0:a]pan=mono|c0=c1,aresample=async=1000[a1];[0:a]pan=mono|c0=c2,aresample=async=1000[a2];[0:a]pan=mono|c0=c3,aresample=async=1000[a3]" -map 0:v -map [a0] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream1 -map 0:v -map [a1] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream2 -map 0:v -map [a2] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream3 -map 0:v -map [a3] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream4
echo "Restarting remapping..."
sleep .2
done
;;

5)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/main/stream1080 -filter_complex "[0:a]pan=mono|c0=c0,aresample=async=1000[a0];[0:a]pan=mono|c0=c1,aresample=async=1000[a1];[0:a]pan=mono|c0=c2,aresample=async=1000[a2];[0:a]pan=mono|c0=c3,aresample=async=1000[a3];[0:a]pan=mono|c0=c4,aresample=async=1000[a4]" -map 0:v -map [a0] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream1 -map 0:v -map [a1] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream2 -map 0:v -map [a2] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream3 -map 0:v -map [a3] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream4 -map 0:v -map [a4] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream5
echo "Restarting remapping..."
sleep .2
done
;;

6)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/main/stream1080 -filter_complex "[0:a]pan=mono|c0=c0,aresample=async=1000[a0];[0:a]pan=mono|c0=c1,aresample=async=1000[a1];[0:a]pan=mono|c0=c2,aresample=async=1000[a2];[0:a]pan=mono|c0=c3,aresample=async=1000[a3];[0:a]pan=mono|c0=c4,aresample=async=1000[a4];[0:a]pan=mono|c0=c5,aresample=async=1000[a5]" -map 0:v -map [a0] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream1 -map 0:v -map [a1] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream2 -map 0:v -map [a2] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream3 -map 0:v -map [a3] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream4 -map 0:v -map [a4] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream5 -map 0:v -map [a5] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream6
echo "Restarting remapping..."
sleep .2
done
;;

7)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/main/stream1080 -filter_complex "[0:a]pan=stereo|c0=c0|c1=c1,aresample=async=1000[a0];[0:a]pan=mono|c0=c2,aresample=async=1000[a1];[0:a]pan=mono|c0=c3,aresample=async=1000[a2];[0:a]pan=mono|c0=c3,aresample=async=1000[a3];[0:a]pan=mono|c0=c4,aresample=async=1000[a4];[0:a]pan=mono|c0=c5,aresample=async=1000[a5];[0:a]pan=mono|c0=c6,aresample=async=1000[a6]" -map 0:v -map [a0] -vcodec copy -acodec aac -ab 256k -f flv -strict -2 rtmp://127.0.0.1/distribute/stream1 -map 0:v -map [a1] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream20 -map 0:v -map [a2] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream3 -map 0:v -map [a3] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream4 -map 0:v -map [a4] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream5 -map 0:v -map [a5] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream6 -map 0:v -map [a6] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream7
echo "Restarting remapping..."
sleep .2
done
;;

8)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/main/stream1080 -filter_complex "[0:a]pan=mono|c0=c0,aresample=async=1000[a0];[0:a]pan=mono|c0=c1,aresample=async=1000[a1];[0:a]pan=mono|c0=c2,aresample=async=1000[a2];[0:a]pan=mono|c0=c3,aresample=async=1000[a3];[0:a]pan=mono|c0=c4,aresample=async=1000[a4];[0:a]pan=mono|c0=c5,aresample=async=1000[a5];[0:a]pan=mono|c0=c6,aresample=async=1000[a6];[0:a]pan=mono|c0=c7,aresample=async=1000[a7]" -map 0:v -map [a0] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream1 -map 0:v -map [a1] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream2 -map 0:v -map [a2] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream3 -map 0:v -map [a3] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream4 -map 0:v -map [a4] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream5 -map 0:v -map [a5] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream6 -map 0:v -map [a6] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream7 -map 0:v -map [a7] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream8
echo "Restarting remapping..."
sleep .2
done
;;

9)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/main/stream1080 -filter_complex "[0:a]pan=stereo|c0=c0|c1=c1,aresample=async=1000[a0];[0:a]pan=mono|c0=c1,aresample=async=1000[a1];[0:a]pan=mono|c0=c2,aresample=async=1000[a2];[0:a]pan=mono|c0=c3,aresample=async=1000[a3];[0:a]pan=mono|c0=c4,aresample=async=1000[a4];[0:a]pan=mono|c0=c5,aresample=async=1000[a5];[0:a]pan=mono|c0=c6,aresample=async=1000[a6];[0:a]pan=mono|c0=c7,aresample=async=1000[a7];[0:a]pan=mono|c0=c8,aresample=async=1000[a8]" -map 0:v -map [a0] -vcodec copy -acodec aac -ac 2 -ab 256k -f flv -strict -2 rtmp://127.0.0.1/distribute/stream1 -map 0:v -map [a1] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream20 -map 0:v -map [a2] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream2 -map 0:v -map [a3] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream3 -map 0:v -map [a4] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream4 -map 0:v -map [a5] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream5 -map 0:v -map [a6] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream6 -map 0:v -map [a7] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream7 -map 0:v -map [a8] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream8
echo "Restarting remapping..."
sleep .2
done
;;

10)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/main/stream1080 -filter_complex "[0:a]pan=mono|c0=c0,aresample=async=1000[a0];[0:a]pan=mono|c0=c1,aresample=async=1000[a1];[0:a]pan=mono|c0=c2,aresample=async=1000[a2];[0:a]pan=mono|c0=c3,aresample=async=1000[a3];[0:a]pan=mono|c0=c4,aresample=async=1000[a4];[0:a]pan=mono|c0=c5,aresample=async=1000[a5];[0:a]pan=mono|c0=c6,aresample=async=1000[a6];[0:a]pan=mono|c0=c7,aresample=async=1000[a7];[0:a]pan=mono|c0=c8,aresample=async=1000[a8];[0:a]pan=mono|c0=c9,aresample=async=1000[a9]" -map 0:v -map [a0] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream1 -map 0:v -map [a1] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream2 -map 0:v -map [a2] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream3 -map 0:v -map [a3] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream4 -map 0:v -map [a4] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream5 -map 0:v -map [a5] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream6 -map 0:v -map [a6] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream7 -map 0:v -map [a7] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream8 -map 0:v -map [a8] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream9 -map 0:v -map [a9] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream10
echo "Restarting remapping..."
sleep .2
done
;;

11)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/main/stream1080 -filter_complex "[0:a]pan=mono|c0=c0,aresample=async=1000[a0];[0:a]pan=mono|c0=c1,aresample=async=1000[a1];[0:a]pan=mono|c0=c2,aresample=async=1000[a2];[0:a]pan=mono|c0=c3,aresample=async=1000[a3];[0:a]pan=mono|c0=c4,aresample=async=1000[a4];[0:a]pan=mono|c0=c5,aresample=async=1000[a5];[0:a]pan=mono|c0=c6,aresample=async=1000[a6];[0:a]pan=mono|c0=c7,aresample=async=1000[a7];[0:a]pan=mono|c0=c8,aresample=async=1000[a8];[0:a]pan=mono|c0=c9,aresample=async=1000[a9];[0:a]pan=mono|c0=c10,aresample=async=1000[a10]" -map 0:v -map [a0] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream1 -map 0:v -map [a1] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream2 -map 0:v -map [a2] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream3 -map 0:v -map [a3] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream4 -map 0:v -map [a4] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream5 -map 0:v -map [a5] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream6 -map 0:v -map [a6] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream7 -map 0:v -map [a7] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream8 -map 0:v -map [a8] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream9 -map 0:v -map [a9] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream10 -map 0:v -map [a10] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream11
echo "Restarting remapping..."
sleep .2
done
;;

12)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/main/stream1080 -filter_complex "[0:a]pan=mono|c0=c0,aresample=async=1000[a0];[0:a]pan=mono|c0=c1,aresample=async=1000[a1];[0:a]pan=mono|c0=c2,aresample=async=1000[a2];[0:a]pan=mono|c0=c3,aresample=async=1000[a3];[0:a]pan=mono|c0=c4,aresample=async=1000[a4];[0:a]pan=mono|c0=c5,aresample=async=1000[a5];[0:a]pan=mono|c0=c6,aresample=async=1000[a6];[0:a]pan=mono|c0=c7,aresample=async=1000[a7];[0:a]pan=mono|c0=c8,aresample=async=1000[a8];[0:a]pan=mono|c0=c9,aresample=async=1000[a9];[0:a]pan=mono|c0=c10,aresample=async=1000[a10];[0:a]pan=mono|c0=c11,aresample=async=1000[a11]" -map 0:v -map [a0] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream1 -map 0:v -map [a1] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream2 -map 0:v -map [a2] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream3 -map 0:v -map [a3] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream4 -map 0:v -map [a4] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream5 -map 0:v -map [a5] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream6 -map 0:v -map [a6] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream7 -map 0:v -map [a7] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream8 -map 0:v -map [a8] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream9 -map 0:v -map [a9] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream10 -map 0:v -map [a10] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream11 -map 0:v -map [a11] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream12
echo "Restarting remapping..."
sleep .2
done
;;

13)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/main/stream1080 -filter_complex "[0:a]pan=mono|c0=c0,aresample=async=1000[a0];[0:a]pan=mono|c0=c1,aresample=async=1000[a1];[0:a]pan=mono|c0=c2,aresample=async=1000[a2];[0:a]pan=mono|c0=c3,aresample=async=1000[a3];[0:a]pan=mono|c0=c4,aresample=async=1000[a4];[0:a]pan=mono|c0=c5,aresample=async=1000[a5];[0:a]pan=mono|c0=c6,aresample=async=1000[a6];[0:a]pan=mono|c0=c7,aresample=async=1000[a7];[0:a]pan=mono|c0=c8,aresample=async=1000[a8];[0:a]pan=mono|c0=c9,aresample=async=1000[a9];[0:a]pan=mono|c0=c10,aresample=async=1000[a10];[0:a]pan=mono|c0=c11,aresample=async=1000[a11];[0:a]pan=mono|c0=c12,aresample=async=1000[a12]" -map 0:v -map [a0] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream1 -map 0:v -map [a1] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream2 -map 0:v -map [a2] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream3 -map 0:v -map [a3] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream4 -map 0:v -map [a4] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream5 -map 0:v -map [a5] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream6 -map 0:v -map [a6] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream7 -map 0:v -map [a7] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream8 -map 0:v -map [a8] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream9 -map 0:v -map [a9] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream10 -map 0:v -map [a10] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream11 -map 0:v -map [a11] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream12 -map 0:v -map [a12] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream13
echo "Restarting remapping..."
sleep .2
done
;;

14)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/main/stream1080 -filter_complex "[0:a]pan=mono|c0=c0,aresample=async=1000[a0];[0:a]pan=mono|c0=c1,aresample=async=1000[a1];[0:a]pan=mono|c0=c2,aresample=async=1000[a2];[0:a]pan=mono|c0=c3,aresample=async=1000[a3];[0:a]pan=mono|c0=c4,aresample=async=1000[a4];[0:a]pan=mono|c0=c5,aresample=async=1000[a5];[0:a]pan=mono|c0=c6,aresample=async=1000[a6];[0:a]pan=mono|c0=c7,aresample=async=1000[a7];[0:a]pan=mono|c0=c8,aresample=async=1000[a8];[0:a]pan=mono|c0=c9,aresample=async=1000[a9];[0:a]pan=mono|c0=c10,aresample=async=1000[a10];[0:a]pan=mono|c0=c11,aresample=async=1000[a11];[0:a]pan=mono|c0=c12,aresample=async=1000[a12];[0:a]pan=mono|c0=c13,aresample=async=1000[a13]" -map 0:v -map [a0] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream1 -map 0:v -map [a1] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream2 -map 0:v -map [a2] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream3 -map 0:v -map [a3] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream4 -map 0:v -map [a4] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream5 -map 0:v -map [a5] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream6 -map 0:v -map [a6] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream7 -map 0:v -map [a7] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream8 -map 0:v -map [a8] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream9 -map 0:v -map [a9] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream10 -map 0:v -map [a10] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream11 -map 0:v -map [a11] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream12 -map 0:v -map [a12] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream13 -map 0:v -map [a13] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream14
echo "Restarting remapping..."
sleep .2
done
;;

15)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/main/stream1080 -filter_complex "[0:a]pan=stereo|c0=c0|c1=c1,aresample=async=1000[a0];[0:a]pan=mono|c0=c2,aresample=async=1000[a1];[0:a]pan=mono|c0=c3,aresample=async=1000[a2];[0:a]pan=mono|c0=c4,aresample=async=1000[a3];[0:a]pan=mono|c0=c5,aresample=async=1000[a4];[0:a]pan=mono|c0=c6,aresample=async=1000[a5];[0:a]pan=mono|c0=c7,aresample=async=1000[a6];[0:a]pan=mono|c0=c8,aresample=async=1000[a7];[0:a]pan=mono|c0=c9,aresample=async=1000[a8];[0:a]pan=mono|c0=c10,aresample=async=1000[a9];[0:a]pan=mono|c0=c11,aresample=async=1000[a10];[0:a]pan=mono|c0=c12,aresample=async=1000[a11];[0:a]pan=mono|c0=c13,aresample=async=1000[a12];[0:a]pan=mono|c0=c14,aresample=async=1000[a13];[0:a]pan=mono|c0=c15,aresample=async=1000[a14]" -map 0:v -map [a0] -vcodec copy -acodec aac -ab 256k -ac 2 -f flv -strict -2 rtmp://127.0.0.1/distribute/stream1 -map 0:v -map [a1] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream2 -map 0:v -map [a2] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream3 -map 0:v -map [a3] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream4 -map 0:v -map [a4] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream5 -map 0:v -map [a5] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream6 -map 0:v -map [a6] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream7 -map 0:v -map [a7] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream8 -map 0:v -map [a8] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream9 -map 0:v -map [a9] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream10 -map 0:v -map [a10] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream11 -map 0:v -map [a11] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream12 -map 0:v -map [a12] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream13 -map 0:v -map [a13] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream14 -map 0:v -map [a14] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream15
echo "Restarting remapping..."
sleep .2
done
;;

16)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/main/stream1080 -filter_complex "[0:a]pan=mono|c0=c0,aresample=async=1000[a0];[0:a]pan=mono|c0=c1,aresample=async=1000[a1];[0:a]pan=mono|c0=c2,aresample=async=1000[a2];[0:a]pan=mono|c0=c3,aresample=async=1000[a3];[0:a]pan=mono|c0=c4,aresample=async=1000[a4];[0:a]pan=mono|c0=c5,aresample=async=1000[a5];[0:a]pan=mono|c0=c6,aresample=async=1000[a6];[0:a]pan=mono|c0=c7,aresample=async=1000[a7];[0:a]pan=mono|c0=c8,aresample=async=1000[a8];[0:a]pan=mono|c0=c9,aresample=async=1000[a9];[0:a]pan=mono|c0=c10,aresample=async=1000[a10];[0:a]pan=mono|c0=c11,aresample=async=1000[a11];[0:a]pan=mono|c0=c12,aresample=async=1000[a12];[0:a]pan=mono|c0=c13,aresample=async=1000[a13];[0:a]pan=mono|c0=c14,aresample=async=1000[a14];[0:a]pan=mono|c0=c15,aresample=async=1000[a15]" -map 0:v -map [a0] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream3 -map 0:v -map [a1] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream4 -map 0:v -map [a2] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream15 -map 0:v -map [a3] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream16 -map 0:v -map [a4] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream1 -map 0:v -map [a5] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream2 -map 0:v -map [a6] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream7 -map 0:v -map [a7] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream8 -map 0:v -map [a8] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream5 -map 0:v -map [a9] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream6 -map 0:v -map [a10] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream9 -map 0:v -map [a11] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream10 -map 0:v -map [a12] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream11 -map 0:v -map [a13] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream12 -map 0:v -map [a14] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream13 -map 0:v -map [a15] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream14
echo "Restarting remapping..."
sleep .2
done
;;

*)
echo "Remapping is already off"
exit 0
esac

else
case $2 in
off)
kill $(ps aux | grep "[S]CREEN.* remap" | awk '{print $2}')
echo "Turning off remapping"
;;

*)
echo "Audio is already being remapped with $2 channels"
esac
fi

esac
