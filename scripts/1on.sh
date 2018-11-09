#!/bin/bash
inputparam="/usr/bin/ffmpeg -nostdin -i"
outputparam="-y -async 1 -vsync 1"
inputloc1="rtmp://127.0.0.1:1935/distribute/1in"
dest=`cat /usr/local/nginx/scripts/1data.txt | grep '__stream1__'$1'__' | cut -d ' ' -f 2`

case $1 in
####### OUTPUT CONFIGURATION ######
out1)
#dest="rtmp://a.rtmp.youtube.com/live2/x6x2-p8m7-0e2q-3scr"
case $2 in

source)
encodeparam="-c copy"
;;

720p)
encodeparam="-acodec copy -vcodec libx264 -pix_fmt yuv420p -r 25 -g 50 -s 1280x720 -b:v 3000k -preset veryfast"
;;

off)
ME=$(basename "$0" .sh);
ME="[S]CREEN.*$ME"$1
#screenname=$(basename "$0" .sh)$1
#echo $ME
if [ $(ps aux | grep $ME | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep $ME | awk '{print $2}')
echo "Turning off "$1
sleep 0.5
else
echo $1" is already off"
sleep 0.5
fi
exit 0
;;

*)
echo "Output parameters are either source/720p/off"
exit 1
esac

screenname=$(basename "$0" .sh)$1
ME=`basename "$0"`;
ME=$ME"_"$1
LCK="/usr/local/nginx/scripts/tmp/${ME}.LCK";
exec 8>$LCK;
#echo "After LCK"

if flock -n -x 8; then
#echo "In flck"
i="0"
echo $ME "has started at "$2" resolution"
if [ -z "$STY" ];
then
#echo "above screen"
exec screen -dm -S $screenname /bin/bash "$0" "$1" "$2"; 
fi
echo $dest
while [ $i -lt 9000 ]
do
$inputparam $inputloc1 $encodeparam -f flv $dest $outputparam
echo "Waiting for English input... Feed me!!!"
sleep 0.2
i=$[$i+1]
echo $2
done

else echo $ME " is already running" 
fi
;;

out2)
#dest="rtmp://live-api-s.facebook.com:80/rtmp/1355110834623486?s_ps=1&s_sw=0&s_vt=api-s&a=AbwIlJCdCU4GoAS8"
case $2 in
source)
encodeparam="-c copy"
;;

720p)
encodeparam="-acodec copy -vcodec libx264 -pix_fmt yuv420p -r 25 -g 50 -s 1280x720 -b:v 3000k -preset veryfast"
;;

off)
ME=$(basename "$0" .sh);
ME="[S]CREEN.*$ME"$1
#screenname=$(basename "$0" .sh)$1
#echo $ME
if [ $(ps aux | grep $ME | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep $ME | awk '{print $2}')
echo "Turning off "$1
sleep 0.5
else
echo $1" is already off"
sleep 0.5
fi
exit 0
;;

*)
echo "Output parameters are either source/720p/off"
exit 1
esac

screenname=$(basename "$0" .sh)$1
ME=`basename "$0"`;
ME=$ME"_"$1
LCK="/usr/local/nginx/scripts/tmp/${ME}.LCK";
exec 8>$LCK;
#echo "After LCK"

if flock -n -x 8; then
#echo "In flck"
i="0"
echo $ME "has started at "$2" resolution"
if [ -z "$STY" ];
then
#echo "above screen"
exec screen -dm -S $screenname /bin/bash "$0" "$1" "$2"; 
fi
echo $dest
while [ $i -lt 9000 ]
do
$inputparam $inputloc1 $encodeparam -f flv $dest $outputparam
echo "Waiting for English input... Feed me!!!"
sleep 0.2
i=$[$i+1]
echo $2
done

else echo $ME " is already running" 
fi
;;

####### MODIFICATION CONFIG ########
volume)
case $2 in
0)
echo 'Parsed_volume_1 volume 0' | /usr/local/bin/tools/zmqsend
sleep 0.5
;;
2)
echo 'Parsed_volume_1 volume 2' | /usr/local/bin/tools/zmqsend
sleep 0.5
;;
4)
echo 'Parsed_volume_1 volume 4' | /usr/local/bin/tools/zmqsend sleep 0.5
;;
*)
echo "Only mute, single and double volume are used"
esac
;;
super)
case $2 in
off) 
echo Parsed_overlay_1 y H | /usr/local/bin/tools/zmqsend -b tcp://127.0.0.1:5556 sleep 0.5
;;
on)
echo Parsed_overlay_1 y H-h | /usr/local/bin/tools/zmqsend -b tcp://127.0.0.1:5556 sleep 0.5
;;
*)
echo "Usage is on.sh super on/off"
esac
;;

###### INPUT CONFIGURATION #######
main)
ME=`basename "$0"`;
ME=$ME"_main";
LCK="/usr/local/nginx/scripts/tmp/${ME}.LCK";

screenname=$(basename "$0" .sh)"_main"
exec 8>$LCK;

if flock -n -x 8; then
if [ $(ps aux | grep '[S]CREEN.*1on_back' | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep '[S]CREEN.*1on_back' | awk '{print $2}')
echo "Turning off 1backon.sh"
fi

if [ $(ps aux | grep '[S]CREEN.*1on_holding' | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep '[S]CREEN.*1on_holding' | awk '{print $2}')
echo "Turning off 1holdingon.sh"
fi

if [ $(ps aux | grep '[S]CREEN.*1on_video' | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep '[S]CREEN.*1on_video' | awk '{print $2}')
echo "Turning off 1videoon.sh"
fi

if [ -z "$STY" ]; then
echo $ME "has started"
exec screen -dm -S $screenname /bin/bash "$0" main;
fi

while true
do
/usr/bin/ffmpeg -nostdin -thread_queue_size 1024 -i rtmp://127.0.0.1:1935/stream1/input -i /usr/local/nginx/scripts/images/lowerthird.png -af azmq,volume=2 -c:a aac -filter_complex 'zmq=bind_address=tcp\\\://127.0.0.1\\\:5556,overlay=0:H' -vcodec libx264 -pix_fmt yuv420p -preset veryfast -r 25 -g 50 -b:v 6000k -maxrate 6M -minrate 6M -bufsize 6M -f flv -strict -2 rtmp://127.0.0.1:1935/distribute/1in -y -async 1 -vsync 1
echo "Restarting ffmpeg..."
sleep .2
done

else
echo $ME " is already running"
fi
;;
########## MAIN ENDS. BACKUP BEGINS ################

back)
ME=`basename "$0"`;
ME=$ME"_back";
LCK="/usr/local/nginx/scripts/tmp/${ME}.LCK";

screenname=$(basename "$0" .sh)"_back"
exec 8>$LCK;

if flock -n -x 8; then
if [ $(ps aux | grep '[S]CREEN.*1on_main' | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep '[S]CREEN.*1on_main' | awk '{print $2}')
echo "Turning off 1on.sh"
fi

if [ $(ps aux | grep '[S]CREEN.*1on_holding' | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep '[S]CREEN.*1on_holding' | awk '{print $2}')
echo "Turning off 1holdingon.sh"
fi

if [ $(ps aux | grep '[S]CREEN.*1on_video' | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep '[S]CREEN.*1on_video' | awk '{print $2}')
echo "Turning off 1videoon.sh"
fi

if [ -z "$STY" ]; then
echo $ME "has started"
exec screen -dm -S $screenname /bin/bash "$0" back;
fi

while true
do
/usr//bin/ffmpeg -nostdin -re -i rtmp://127.0.0.1:1935/stream1/backup -c copy -f flv rtmp://127.0.0.1:1935/distribute/1in -y -async 1 -vsync 1
echo "Restarting ffmpeg..."
sleep .2
done

else
echo $ME " is already running"
fi
;;
########## BACKUP ENDS. HOLDING BEGINS ################

holding)
ME=`basename "$0"`;
ME=$ME"_holding";
LCK="/usr/local/nginx/scripts/tmp/${ME}.LCK";

screenname=$(basename "$0" .sh)"_holding"
exec 8>$LCK;

if flock -n -x 8; then
if [ $(ps aux | grep '[S]CREEN.*1on_back' | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep '[S]CREEN.*1on_back' | awk '{print $2}')
echo "Turning off 1backon.sh"
fi

if [ $(ps aux | grep '[S]CREEN.*1on_main' | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep '[S]CREEN.*1on_main' | awk '{print $2}')
echo "Turning off 1mainon.sh"
fi

if [ $(ps aux | grep '[S]CREEN.*1on_video' | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep '[S]CREEN.*1on_video' | awk '{print $2}')
echo "Turning off 1videoon.sh"
fi

if [ -z "$STY" ]; then
echo $ME "has started"
exec screen -dm -S $screenname /bin/bash "$0" holding;
fi

while true
do
/usr/local/bin/ffmpeg -nostdin -re -fflags +genpts -stream_loop -1 -i /usr/local/nginx/scripts/images/holding.mp4 -c copy -f flv rtmp://127.0.0.1:1935/distribute/1in -y
echo "Restarting ffmpeg..."
sleep .2
done

else
echo $ME " is already running"
fi
;;
########## HOLDING ENDS. AD VIDEO BEGINS ################

video)
ME=`basename "$0"`;
ME=$ME"_video";
LCK="/usr/local/nginx/scripts/tmp/${ME}.LCK";

screenname=$(basename "$0" .sh)"_video"
exec 8>$LCK;

if flock -n -x 8; then
if [ $(ps aux | grep '[S]CREEN.*1on_back' | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep '[S]CREEN.*1on_back' | awk '{print $2}')
echo "Turning off 1backon.sh"
fi

if [ $(ps aux | grep '[S]CREEN.*1on_holding' | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep '[S]CREEN.*1on_holding' | awk '{print $2}')
echo "Turning off 1holdingon.sh"
fi

if [ $(ps aux | grep '[S]CREEN.*1on_main' | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep '[S]CREEN.*1on_main' | awk '{print $2}')
echo "Turning off 1mainon.sh"
fi

if [ -z "$STY" ]; then
echo $ME "has started"
exec screen -dm -S $screenname /bin/bash "$0" video;
fi

while true
do
/usr/local/bin/ffmpeg -nostdin -re -fflags +genpts -stream_loop -1 -i /usr/local/nginx/scripts/images/video.mp4 -c copy -f flv rtmp://127.0.0.1:1935/distribute/1in -y
echo "Restarting ffmpeg..."
sleep .2
done

else
echo $ME " is already running"
fi
;;
########## AD VIDEO ENDS. TURN OFF BEGINS ################

off)
ME=`basename "$0"`;
ME=$ME"_off";
LCK="/usr/local/nginx/scripts/tmp/${ME}.LCK";

exec 8>$LCK;

if flock -n -x 8; then
if [ $(ps aux | grep '[S]CREEN.*1on_back' | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep '[S]CREEN.*1on_back' | awk '{print $2}')
echo "Turning off 1backon.sh"
fi

if [ $(ps aux | grep '[S]CREEN.*1on_holding' | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep '[S]CREEN.*1on_holding' | awk '{print $2}')
echo "Turning off 1holdingon.sh"
fi

if [ $(ps aux | grep '[S]CREEN.*1on_video' | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep '[S]CREEN.*1on_video' | awk '{print $2}')
echo "Turning off 1videoon.sh"
fi

if [ $(ps aux | grep '[S]CREEN.*1on_main' | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep '[S]CREEN.*1on_main' | awk '{print $2}')
echo "Turning off 1mainon.sh"
fi

else
echo "Stream1 is already off"
fi

sleep 0.5
;;

*)
echo "Usage options are main/back/holding/video/volume/super/out1,2,3 etc..."
esac
########## OFF ENDS. ALL END ################
