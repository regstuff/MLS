#!/bin/bash
oldffmpegparam="/usr/bin/ffmpeg -nostdin -thread_queue_size 512 -i"
newffmpegparam="/usr/local/bin/ffmpeg -nostdin -thread_queue_size 512 -i"
outputparam="-y"
distributeparam="rtmp://127.0.0.1:1935/distribute/stream1"
inputparam="rtmp://127.0.0.1:1935/input/stream1"
backupparam="rtmp://127.0.0.1:1935/backup/stream1"

#inputencodeparam="-i /usr/local/nginx/scripts/images/lowerthird.png -af azmq,volume=2 -c:a aac -ar 44100 -filter_complex 'zmq=bind_address=tcp\\\://127.0.0.1\\\:5556,overlay=0:H' -vcodec libx264 -pix_fmt yuv420p -preset veryfast -r 25 -g 50 -b:v 6000k -maxrate 6M -minrate 6M -bufsize 6M -f flv -strict -2"
inputencodeparam="-af azmq,volume=2 -c:a aac -ar 44100 -vcodec copy -f flv -strict -2"


dest=`cat /usr/local/nginx/scripts/1data.txt | grep '__stream1__'$1'__' | cut -d ' ' -f 2`

case $1 in
####### MODIFICATION CONFIG ########
volume)
echo 'Parsed_volume_1 volume '$2 | /usr/local/bin/tools/zmqsend
sleep 0.5
;;

super)
case $2 in
off) 
echo Parsed_overlay_1 y H | /usr/local/bin/tools/zmqsend -b tcp://127.0.0.1:5556 
sleep 0.5
;;
on)
echo Parsed_overlay_1 y H-h | /usr/local/bin/tools/zmqsend -b tcp://127.0.0.1:5556 
sleep 0.5
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
$oldffmpegparam $inputparam $inputencodeparam $distributeparam $outputparam
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
$oldffmpegparam $backupparam -c copy -f flv $distributeparam $outputparam
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
/usr/local/bin/ffmpeg -nostdin -re -fflags +genpts -stream_loop -1 -i /usr/local/nginx/scripts/images/holding.mp4 -c copy -f flv $distributeparam $outputparam
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
/usr/local/bin/ffmpeg -nostdin -re -fflags +genpts -stream_loop -1 -i /usr/local/nginx/scripts/images/video.mp4 -c copy -f flv $distributeparam $outputparam
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

####### OUTPUT CONFIGURATION ######

out4)
case $2 in 
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
encodeparam="-acodec copy -vcodec libx264 -preset faster -vprofile baseline -g 50 -s 480x854 -b:v 1M"
screenname=$(basename "$0" .sh)$1
ME=`basename "$0"`;
ME=$ME"_"$1
#checkout="[f=flv]$dest|[f=flv]rtmp://127.0.0.1:1935/output/$1"
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
#echo $dest
while [ $i -lt 9000 ]
do
$oldffmpegparam $distributeparam $encodeparam -vf "transpose=1" -f flv $dest $outputparam
echo "Waiting for English input... Feed me!!!"
sleep 0.2
i=$[$i+1]
done

else echo $ME " is already running" 
fi
esac
;;

*)
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
checkout="[f=flv]$dest|[f=flv]rtmp://127.0.0.1:1935/output/stream1-$1"
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
#echo $dest
while [ $i -lt 9000 ]
do
$oldffmpegparam $distributeparam $encodeparam -f tee -map 0:v -map 0:a $checkout $outputparam
echo "Waiting for English input... Feed me!!!"
sleep 0.2
i=$[$i+1]
done

else echo $ME " is already running" 
fi
esac
########## OFF ENDS. ALL END ################
