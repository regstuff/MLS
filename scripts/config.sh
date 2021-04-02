#!/bin/bash

##### START ADD DESTINATION ##########
case $1 in
destination)
sudo sed -i "s|stream$3__out$4__.*|stream$3__out$4__ $(echo $2 | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g') $5 $6|" /usr/local/nginx/scripts/config.txt;

;;

##### END DESTINATION - START STREAM CONFIG ##########

streamconfig)
sudo sed -i "s|stream$2__config__.*|stream$2__config__ $3 $4 $5|" /usr/local/nginx/scripts/config.txt;

;;

##### END STREAM CONFIG - START INSTA TEST AUTH ##########

instatestauth)
sudo php /usr/local/nginx/scripts/InstagramLive-PHP$2/testAuth.php;

;;

##### END INSTA TEST AUTH - START INSTA LOGIN ##########

instalogin)
sudo sed -i "s|'IG_USERNAME', '.*|'IG_USERNAME', '$3');|" /usr/local/nginx/scripts/InstagramLive-PHP$2/config.php;
sudo sed -i "s|'IG_PASS', '.*|'IG_PASS', '$4');|" /usr/local/nginx/scripts/InstagramLive-PHP$2/config.php;

;;

##### END INSTA LOGIN - START AUDIO CONFIG ##########

audioconfig)
sudo sed -i "s|stream$2__audio__.*|stream$2__audio__ $4 $5 $3 $6|" /usr/local/nginx/scripts/config.txt;

;;

##### END AUDIO CONFIG - START AUDIO PRESET ##########

audiopreset)

case $2 in
allmono)
sudo sed -i "s|stream1__audio__.*|stream1__audio__ c0 c2 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream2__audio__.*|stream2__audio__ c1 c4 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream3__audio__.*|stream3__audio__ c2 c6 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream4__audio__.*|stream4__audio__ c3 c8 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream5__audio__.*|stream5__audio__ c4 c10 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream6__audio__.*|stream6__audio__ c5 c12 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream7__audio__.*|stream7__audio__ c6 c14 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream8__audio__.*|stream8__audio__ c7 c16 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream9__audio__.*|stream9__audio__ c8 c18 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream10__audio__.*|stream10__audio__ c9 c20 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream11__audio__.*|stream11__audio__ c10 c22 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream12__audio__.*|stream12__audio__ c11 c24 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream13__audio__.*|stream13__audio__ c12 c26 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream14__audio__.*|stream14__audio__ c13 c28 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream15__audio__.*|stream15__audio__ c14 c30 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream16__audio__.*|stream16__audio__ c15 c32 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream17__audio__.*|stream17__audio__ c16 c34 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream18__audio__.*|stream18__audio__ c17 c36 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream19__audio__.*|stream19__audio__ c18 c38 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream20__audio__.*|stream20__audio__ c19 c40 mono main|" /usr/local/nginx/scripts/config.txt;
;;

firststereo)
sudo sed -i "s|stream1__audio__.*|stream1__audio__ c0 c1 stereo distribute|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream2__audio__.*|stream2__audio__ c2 c3 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream3__audio__.*|stream3__audio__ c3 c6 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream4__audio__.*|stream4__audio__ c4 c8 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream5__audio__.*|stream5__audio__ c5 c10 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream6__audio__.*|stream6__audio__ c6 c12 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream7__audio__.*|stream7__audio__ c7 c14 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream8__audio__.*|stream8__audio__ c8 c16 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream9__audio__.*|stream9__audio__ c9 c18 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream10__audio__.*|stream10__audio__ c10 c20 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream11__audio__.*|stream11__audio__ c11 c22 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream12__audio__.*|stream12__audio__ c12 c24 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream13__audio__.*|stream13__audio__ c13 c26 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream14__audio__.*|stream14__audio__ c14 c28 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream15__audio__.*|stream15__audio__ c15 c30 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream16__audio__.*|stream16__audio__ c16 c32 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream17__audio__.*|stream17__audio__ c17 c34 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream18__audio__.*|stream18__audio__ c18 c36 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream19__audio__.*|stream19__audio__ c19 c38 mono main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream20__audio__.*|stream20__audio__ c20 c40 mono main|" /usr/local/nginx/scripts/config.txt;
;;

allstereo)
sudo sed -i "s|stream1__audio__.*|stream1__audio__ c0 c1 stereo main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream2__audio__.*|stream2__audio__ c2 c3 stereo main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream3__audio__.*|stream3__audio__ c4 c5 stereo main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream4__audio__.*|stream4__audio__ c6 c7 stereo main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream5__audio__.*|stream5__audio__ c8 c9 stereo main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream6__audio__.*|stream6__audio__ c10 c11 stereo main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream7__audio__.*|stream7__audio__ c12 c13 stereo main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream8__audio__.*|stream8__audio__ c14 c15 stereo main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream9__audio__.*|stream9__audio__ c16 c17 stereo main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream10__audio__.*|stream10__audio__ c18 c19 stereo main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream11__audio__.*|stream11__audio__ c20 c21 stereo main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream12__audio__.*|stream12__audio__ c22 c23 stereo main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream13__audio__.*|stream13__audio__ c24 c25 stereo main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream14__audio__.*|stream14__audio__ c26 c27 stereo main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream15__audio__.*|stream15__audio__ c28 c29 stereo main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream16__audio__.*|stream16__audio__ c30 c31 stereo main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream17__audio__.*|stream17__audio__ c32 c33 stereo main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream18__audio__.*|stream18__audio__ c34 c35 stereo main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream19__audio__.*|stream19__audio__ c36 c37 stereo main|" /usr/local/nginx/scripts/config.txt;
sudo sed -i "s|stream20__audio__.*|stream20__audio__ c38 c39 stereo main|" /usr/local/nginx/scripts/config.txt;
esac

;;

##### END AUDIO PRESET - START UPLOAD FILE ##########

uploadfile)
sudo wget -O $3$4 $2 && sudo chmod +x $3$4 && sudo mv $3$4 /usr/local/nginx/scripts/images

;;

##### END UPLOAD FILE - START UPLOAD LOWERTHIRD ##########

uploadlower)
sudo mv $2 $3;
sudo chmod 755 $3;
sudo chown root:root $3;
echo $3 uploaded
;;

##### END UPLOAD LOWERTHIRD - START STREAM LIST ##########

streamlist)
startline=`grep -n '***STREAM CONFIG***' /usr/local/nginx/scripts/config.txt | cut -d: -f 1`
endline=`grep -n '***AUDIO CONFIG***' /usr/local/nginx/scripts/config.txt | cut -d: -f 1`
rangeoflines=$startline','$endline'p'
sed -n $rangeoflines /usr/local/nginx/scripts/config.txt

;;

##### END STREAM LIST - START DESTINATION LIST ##########
destlist)
startline=`grep -n '***DESTINATION CONFIG***' /usr/local/nginx/scripts/config.txt | cut -d: -f 1`
endline=`grep -n '***STREAM CONFIG***' /usr/local/nginx/scripts/config.txt | cut -d: -f 1`
rangeoflines=$startline','$endline'p'
sed -n $rangeoflines /usr/local/nginx/scripts/config.txt

;;

##### END DESTINATION LIST - START AUDIO LIST ##########
audiolist)
startline=`grep -n '***AUDIO CONFIG***' /usr/local/nginx/scripts/config.txt | cut -d: -f 1`
endline=`grep -n '***NEXT CONFIG***' /usr/local/nginx/scripts/config.txt | cut -d: -f 1`
rangeoflines=$startline','$endline'p'
sed -n $rangeoflines /usr/local/nginx/scripts/config.txt

;;

##### END AUDIO LIST - START CONVERT RECORDING ##########
convertrecording)
#mv --backup=numbered $3/$4.mp4 $3/$4_`date +%Y%m%d-%H_%M_%S`.mp4;
mv --backup=numbered $3/$4.mp4 $3/$4_old.mp4;
ffmpeg -y -i $2 -c copy $3/$4.mp4;
rm -f $2;
echo "Recording Converted"

;;

##### END CONVERT RECORDING - START SRT ACCEPT ##########

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

LCK="/usr/local/nginx/scripts/tmp/remap$3.LCK";

exec 8>$LCK;

if flock -n -x 8; then

chcount=$2
if [ -z "$STY" ]; then
if [ $chcount == "6" ]; then
#echo "6 channel remapping is not possible due to OBS issues. Set OBS audio to 7.0 and remap in NGINX with 7. Stream 1-6 will have channels 1-6. Stream 7 will have no audio."
chcount=1000
else
echo "Remapping $2 channels of $3 audio"
exec screen -dm -S remap$3 /bin/bash "$0" "$1" "$2" "$3";
fi
fi

i=0
j=1

for (( i=0; i<$chcount; i++ )); do
while true #Keep checking till mapping is not none
do
mapping=`cat /usr/local/nginx/scripts/config.txt | grep '__stream'$j'__audio__' | cut -d ' ' -f 4`
if [ $mapping == "mono" ] || [ $mapping == "stereo" ]
then
break
fi
((j=j+1))
done

c0=`cat /usr/local/nginx/scripts/config.txt | grep '__stream'$j'__audio__' | cut -d ' ' -f 2`
c1=`cat /usr/local/nginx/scripts/config.txt | grep '__stream'$j'__audio__' | cut -d ' ' -f 3`
rtmpapp=`cat /usr/local/nginx/scripts/config.txt | grep '__stream'$j'__audio__' | cut -d ' ' -f 5`
if [ $rtmpapp == "main_back" ]; then
rtmpapp=$3
fi

#Fix for OBS-ffmpeg remap diff
#To generate multi-channel files with ffmpeg for OBS use, upto 5.0 is safe. Beyond that there are mapping issues
#OBS-ffmpeg mapping match for 3,4,5,9,10,11,12,13,14. 6 seems to have lfe issue on channel 4 in OBS
#7,8 and 16 need to be remapped as below
#7 -- 1-2,2-3,3-1,4-6,5-7,6-4,7-5
#8 -- 1-2,2-3,3-1,4-6,5-7,6-8,7-4,8-5
#16 -- 1-3,2-4,3-15,4-16,5-1,6-2,7-7,8-8,9-5,10-6,11-9,12-10,13-11,14-12,15-13,16-14
case $2 in
7)
if [ $c0 == "c0" ]; then
c0="c2"
elif [ $c0 == "c1" ]; then
c0="c0"
elif [ $c0 == "c2" ]; then
c0="c1"
elif [ $c0 == "c3" ]; then
c0="c5"
elif [ $c0 == "c4" ]; then
c0="c6"
elif [ $c0 == "c5" ]; then
c0="c3"
elif [ $c0 == "c6" ]; then
c0="c4"
fi

if [ $c1 == "c0" ]; then
c1="c2"
elif [ $c1 == "c1" ]; then
c1="c0"
elif [ $c1 == "c2" ]; then
c1="c1"
elif [ $c1 == "c3" ]; then
c1="c5"
elif [ $c1 == "c4" ]; then
c1="c6"
elif [ $c1 == "c5" ]; then
c1="c3"
elif [ $c1 == "c6" ]; then
c1="c4"
fi
;;

8)
if [ $c0 == "c0" ]; then
c0="c2"
elif [ $c0 == "c1" ]; then
c0="c0"
elif [ $c0 == "c2" ]; then
c0="c1"
elif [ $c0 == "c3" ]; then
c0="c6"
elif [ $c0 == "c4" ]; then
c0="c7"
elif [ $c0 == "c5" ]; then
c0="c3"
elif [ $c0 == "c6" ]; then
c0="c4"
elif [ $c0 == "c7" ]; then
c0="c5"
fi

if [ $c1 == "c0" ]; then
c1="c2"
elif [ $c1 == "c1" ]; then
c1="c0"
elif [ $c1 == "c2" ]; then
c1="c1"
elif [ $c1 == "c3" ]; then
c1="c6"
elif [ $c1 == "c4" ]; then
c1="c7"
elif [ $c1 == "c5" ]; then
c1="c3"
elif [ $c1 == "c6" ]; then
c1="c4"
elif [ $c1 == "c7" ]; then
c1="c5"
fi
;;

16)
if [ $c0 == "c0" ]; then
c0="c4"
elif [ $c0 == "c1" ]; then
c0="c5"
elif [ $c0 == "c2" ]; then
c0="c0"
elif [ $c0 == "c3" ]; then
c0="c1"
elif [ $c0 == "c4" ]; then
c0="c8"
elif [ $c0 == "c5" ]; then
c0="c9"
#No change for c6 and c7
elif [ $c0 == "c8" ]; then
c0="c10"
elif [ $c0 == "c9" ]; then
c0="c11"
elif [ $c0 == "c10" ]; then
c0="c12"
elif [ $c0 == "c11" ]; then
c0="c13"
elif [ $c0 == "c12" ]; then
c0="c14"
elif [ $c0 == "c13" ]; then
c0="c15"
elif [ $c0 == "c14" ]; then
c0="c2"
elif [ $c0 == "c15" ]; then
c0="c3"
fi

if [ $c1 == "c0" ]; then
c1="c4"
elif [ $c1 == "c1" ]; then
c1="c5"
elif [ $c1 == "c2" ]; then
c1="c0"
elif [ $c1 == "c3" ]; then
c1="c1"
elif [ $c1 == "c4" ]; then
c1="c8"
elif [ $c1 == "c5" ]; then
c1="c9"
#No change for c6 and c7
elif [ $c1 == "c8" ]; then
c1="c10"
elif [ $c1 == "c9" ]; then
c1="c11"
elif [ $c1 == "c10" ]; then
c1="c12"
elif [ $c1 == "c11" ]; then
c1="c13"
elif [ $c1 == "c12" ]; then
c1="c14"
elif [ $c1 == "c13" ]; then
c1="c15"
elif [ $c1 == "c14" ]; then
c1="c2"
elif [ $c1 == "c15" ]; then
c1="c3"
fi
esac
#OBS-ffmpeg remap adjustment complete

if [[ $mapping = "mono" ]]
then
stream[i+1]="-map 0:v -map [a$i] -vcodec copy -acodec aac -ab 128k -f flv -strict -2 rtmp://127.0.0.1/$rtmpapp/stream$j"
map[i]="[0:a]pan=mono|c0=$c0,aresample=async=1000[a$i]"
elif [[ $mapping = "stereo" ]]
then
stream[i+1]="-map 0:v -map [a$i] -vcodec copy -acodec aac -ac 2 -ab 256k -f flv -strict -2 rtmp://127.0.0.1/$rtmpapp/stream$j"
map[i]="[0:a]pan=stereo|c0=$c0|c1=$c1,aresample=async=1000[a$i]"
((chcount=chcount-1))
else
:
fi
((j=j+1))
done

case $chcount in
0)
echo "You don't have enough channels to do that!"; exec bash
;;

1)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/$3/stream1080 -filter_complex "${map[0]}" ${stream[1]}
echo "Restarting remapping..."
sleep .2
done
;;

2)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/$3/stream1080 -filter_complex "${map[0]};${map[1]}" ${stream[1]} ${stream[2]}
echo "Restarting remapping..."
sleep .2
done
;;

3)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/$3/stream1080 -filter_complex "${map[0]};${map[1]};${map[2]}" ${stream[1]} ${stream[2]} ${stream[3]}
echo "Restarting remapping..."
sleep .2
done
;;

4)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/$3/stream1080 -filter_complex "${map[0]};${map[1]};${map[2]};${map[3]}" ${stream[1]} ${stream[2]} ${stream[3]} ${stream[4]}
echo "Restarting remapping..."
sleep .2
done
;;

5)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/$3/stream1080 -filter_complex "${map[0]};${map[1]};${map[2]};${map[3]};${map[4]}" ${stream[1]} ${stream[2]} ${stream[3]} ${stream[4]} ${stream[5]}
echo "Restarting remapping..."
sleep .2
done
;;

6)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/$3/stream1080 -filter_complex "${map[0]};${map[1]};${map[2]};${map[3]};${map[4]};${map[5]}" ${stream[1]} ${stream[2]} ${stream[3]} ${stream[4]} ${stream[5]} ${stream[6]}
echo "Restarting remapping..."
sleep .2
done
;;

7)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/$3/stream1080 -filter_complex "${map[0]};${map[1]};${map[2]};${map[3]};${map[4]};${map[5]};${map[6]}" ${stream[1]} ${stream[2]} ${stream[3]} ${stream[4]} ${stream[5]} ${stream[6]} ${stream[7]}
echo "Restarting remapping..."
sleep .2
done
;;

8)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/$3/stream1080 -filter_complex "${map[0]};${map[1]};${map[2]};${map[3]};${map[4]};${map[5]};${map[6]};${map[7]}" ${stream[1]} ${stream[2]} ${stream[3]} ${stream[4]} ${stream[5]} ${stream[6]} ${stream[7]} ${stream[8]}
echo "Restarting remapping..."
sleep .2
done
;;

9)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/$3/stream1080 -filter_complex "${map[0]};${map[1]};${map[2]};${map[3]};${map[4]};${map[5]};${map[6]};${map[7]};${map[8]}" ${stream[1]} ${stream[2]} ${stream[3]} ${stream[4]} ${stream[5]} ${stream[6]} ${stream[7]} ${stream[8]} ${stream[9]}
echo "Restarting remapping..."
sleep .2
done
;;

10)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/$3/stream1080 -filter_complex "${map[0]};${map[1]};${map[2]};${map[3]};${map[4]};${map[5]};${map[6]};${map[7]};${map[8]};${map[9]}" ${stream[1]} ${stream[2]} ${stream[3]} ${stream[4]} ${stream[5]} ${stream[6]} ${stream[7]} ${stream[8]} ${stream[9]} ${stream[10]}
echo "Restarting remapping..."
sleep .2
done
;;

11)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/$3/stream1080 -filter_complex "${map[0]};${map[1]};${map[2]};${map[3]};${map[4]};${map[5]};${map[6]};${map[7]};${map[8]};${map[9]};${map[10]}" ${stream[1]} ${stream[2]} ${stream[3]} ${stream[4]} ${stream[5]} ${stream[6]} ${stream[7]} ${stream[8]} ${stream[9]} ${stream[10]} ${stream[11]}
echo "Restarting remapping..."
sleep .2
done
;;

12)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/$3/stream1080 -filter_complex "${map[0]};${map[1]};${map[2]};${map[3]};${map[4]};${map[5]};${map[6]};${map[7]};${map[8]};${map[9]};${map[10]};${map[11]}" ${stream[1]} ${stream[2]} ${stream[3]} ${stream[4]} ${stream[5]} ${stream[6]} ${stream[7]} ${stream[8]} ${stream[9]} ${stream[10]} ${stream[11]} ${stream[12]}
echo "Restarting remapping..."
sleep .2
done
;;

13)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/$3/stream1080 -filter_complex "${map[0]};${map[1]};${map[2]};${map[3]};${map[4]};${map[5]};${map[6]};${map[7]};${map[8]};${map[9]};${map[10]};${map[11]};${map[12]}" ${stream[1]} ${stream[2]} ${stream[3]} ${stream[4]} ${stream[5]} ${stream[6]} ${stream[7]} ${stream[8]} ${stream[9]} ${stream[10]} ${stream[11]} ${stream[12]} ${stream[13]}
echo "Restarting remapping..."
sleep .2
done
;;

14)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/$3/stream1080 -filter_complex "${map[0]};${map[1]};${map[2]};${map[3]};${map[4]};${map[5]};${map[6]};${map[7]};${map[8]};${map[9]};${map[10]};${map[11]};${map[12]};${map[13]}" ${stream[1]} ${stream[2]} ${stream[3]} ${stream[4]} ${stream[5]} ${stream[6]} ${stream[7]} ${stream[8]} ${stream[9]} ${stream[10]} ${stream[11]} ${stream[12]} ${stream[13]} ${stream[14]}
echo "Restarting remapping..."
sleep .2
done
;;

15)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/$3/stream1080 -filter_complex "${map[0]};${map[1]};${map[2]};${map[3]};${map[4]};${map[5]};${map[6]};${map[7]};${map[8]};${map[9]};${map[10]};${map[11]};${map[12]};${map[13]};${map[14]}" ${stream[1]} ${stream[2]} ${stream[3]} ${stream[4]} ${stream[5]} ${stream[6]} ${stream[7]} ${stream[8]} ${stream[9]} ${stream[10]} ${stream[11]} ${stream[12]} ${stream[13]} ${stream[14]} ${stream[15]}
echo "Restarting remapping..."
sleep .2
done
;;

16)
while true
do
/usr/bin/ffmpeg -re -i rtmp://127.0.0.1/$3/stream1080 -filter_complex "${map[0]};${map[1]};${map[2]};${map[3]};${map[4]};${map[5]};${map[6]};${map[7]};${map[8]};${map[9]};${map[10]};${map[11]};${map[12]};${map[13]};${map[14]};${map[15]}" ${stream[1]} ${stream[2]} ${stream[3]} ${stream[4]} ${stream[5]} ${stream[6]} ${stream[7]} ${stream[8]} ${stream[9]} ${stream[10]} ${stream[11]} ${stream[12]} ${stream[13]} ${stream[14]} ${stream[15]} ${stream[16]}
echo "Restarting remapping..."
sleep .2
done
;;

*)
echo "6 channel remapping is not possible due to OBS issues. Set OBS audio to 7.0 and remap in NGINX with 7. Stream 1-6 will have channels 1-6. Stream 7 will have no audio."
exit 0
esac

else
case $2 in
off)
kill $(ps aux | grep "[S]CREEN.* remap$3" | awk '{print $2}')
echo "Turning off $3 remapping"
;;

*)
echo "$3 audio is already being remapped with $2 channels"
esac
fi

esac
