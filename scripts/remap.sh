#!/bin/bash

LCK="/usr/local/nginx/scripts/tmp/remap.LCK";

exec 8>$LCK;

if flock -n -x 8; then

if [ -z "$STY" ]; then
echo "Remapping $1 channels"
exec screen -dm -S remap /bin/bash "$0" "$1";
fi

case $1 in

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
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/main/stream1080 -filter_complex "[0:a]pan=mono|c0=c0,aresample=async=1000[a0];[0:a]pan=mono|c0=c1,aresample=async=1000[a1];[0:a]pan=mono|c0=c2,aresample=async=1000[a2];[0:a]pan=mono|c0=c3,aresample=async=1000[a3];[0:a]pan=mono|c0=c4,aresample=async=1000[a4];[0:a]pan=mono|c0=c5,aresample=async=1000[a5];[0:a]pan=mono|c0=c6,aresample=async=1000[a6]" -map 0:v -map [a0] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream1 -map 0:v -map [a1] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream2 -map 0:v -map [a2] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream3 -map 0:v -map [a3] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream4 -map 0:v -map [a4] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream5 -map 0:v -map [a5] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream6 -map 0:v -map [a6] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream7
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
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/main/stream1080 -filter_complex "[0:a]pan=mono|c0=c0,aresample=async=1000[a0];[0:a]pan=mono|c0=c1,aresample=async=1000[a1];[0:a]pan=mono|c0=c2,aresample=async=1000[a2];[0:a]pan=mono|c0=c3,aresample=async=1000[a3];[0:a]pan=mono|c0=c4,aresample=async=1000[a4];[0:a]pan=mono|c0=c5,aresample=async=1000[a5];[0:a]pan=mono|c0=c6,aresample=async=1000[a6];[0:a]pan=mono|c0=c7,aresample=async=1000[a7];[0:a]pan=mono|c0=c8,aresample=async=1000[a8]" -map 0:v -map [a0] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream1 -map 0:v -map [a1] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream2 -map 0:v -map [a2] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream3 -map 0:v -map [a3] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream4 -map 0:v -map [a4] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream5 -map 0:v -map [a5] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream6 -map 0:v -map [a6] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream7 -map 0:v -map [a7] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream8 -map 0:v -map [a8] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream9
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
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/main/stream1080 -filter_complex "[0:a]pan=mono|c0=c0,aresample=async=1000[a0];[0:a]pan=mono|c0=c1,aresample=async=1000[a1];[0:a]pan=mono|c0=c2,aresample=async=1000[a2];[0:a]pan=mono|c0=c3,aresample=async=1000[a3];[0:a]pan=mono|c0=c4,aresample=async=1000[a4];[0:a]pan=mono|c0=c5,aresample=async=1000[a5];[0:a]pan=mono|c0=c6,aresample=async=1000[a6];[0:a]pan=mono|c0=c7,aresample=async=1000[a7];[0:a]pan=mono|c0=c8,aresample=async=1000[a8];[0:a]pan=mono|c0=c9,aresample=async=1000[a9];[0:a]pan=mono|c0=c10,aresample=async=1000[a10];[0:a]pan=mono|c0=c11,aresample=async=1000[a11];[0:a]pan=mono|c0=c12,aresample=async=1000[a12];[0:a]pan=mono|c0=c13,aresample=async=1000[a13];[0:a]pan=mono|c0=c14,aresample=async=1000[a14]" -map 0:v -map [a0] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream1 -map 0:v -map [a1] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream2 -map 0:v -map [a2] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream3 -map 0:v -map [a3] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream4 -map 0:v -map [a4] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream5 -map 0:v -map [a5] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream6 -map 0:v -map [a6] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream7 -map 0:v -map [a7] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream8 -map 0:v -map [a8] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream9 -map 0:v -map [a9] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream10 -map 0:v -map [a10] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream11 -map 0:v -map [a11] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream12 -map 0:v -map [a12] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream13 -map 0:v -map [a13] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream14 -map 0:v -map [a14] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream15
echo "Restarting remapping..."
sleep .2
done
;;

16)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/main/stream1080 -filter_complex "[0:a]pan=mono|c0=c0,aresample=async=1000[a0];[0:a]pan=mono|c0=c1,aresample=async=1000[a1];[0:a]pan=mono|c0=c2,aresample=async=1000[a2];[0:a]pan=mono|c0=c3,aresample=async=1000[a3];[0:a]pan=mono|c0=c4,aresample=async=1000[a4];[0:a]pan=mono|c0=c5,aresample=async=1000[a5];[0:a]pan=mono|c0=c6,aresample=async=1000[a6];[0:a]pan=mono|c0=c7,aresample=async=1000[a7];[0:a]pan=mono|c0=c8,aresample=async=1000[a8];[0:a]pan=mono|c0=c9,aresample=async=1000[a9];[0:a]pan=mono|c0=c10,aresample=async=1000[a10];[0:a]pan=mono|c0=c11,aresample=async=1000[a11];[0:a]pan=mono|c0=c12,aresample=async=1000[a12];[0:a]pan=mono|c0=c13,aresample=async=1000[a13];[0:a]pan=mono|c0=c14,aresample=async=1000[a14];[0:a]pan=mono|c0=c15,aresample=async=1000[a15]" -map 0:v -map [a0] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream1 -map 0:v -map [a1] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream2 -map 0:v -map [a2] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream3 -map 0:v -map [a3] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream4 -map 0:v -map [a4] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream5 -map 0:v -map [a5] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream6 -map 0:v -map [a6] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream7 -map 0:v -map [a7] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream8 -map 0:v -map [a8] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream9 -map 0:v -map [a9] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream10 -map 0:v -map [a10] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream11 -map 0:v -map [a11] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream12 -map 0:v -map [a12] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream13 -map 0:v -map [a13] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream14 -map 0:v -map [a14] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream15 -map 0:v -map [a15] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/main/stream16
echo "Restarting remapping..."
sleep .2
done
;;

*)
echo "Remapping is already off"
exit 0
esac

else
case $1 in
off)
kill $(ps aux | grep "[S]CREEN.* remap" | awk '{print $2}')
echo "Turning off remapping"
;;

*)
echo "Audio is already being remapped with $1 channels"
esac
fi


