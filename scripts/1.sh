#!/bin/bash
id="$(basename "$0" .sh)";
streamid="stream"$id;

oldffmpegparam="/usr/bin/ffmpeg -nostdin -thread_queue_size 512 -i";
newffmpegparam="/usr/local/bin/ffmpeg -nostdin -thread_queue_size 512 -i";
ffmpegtsparam="/usr/local/bin/ffmpeg -nostdin -thread_queue_size 512 -fflags +genpts+igndts+ignidx -avoid_negative_ts make_zero -use_wallclock_as_timestamps 1 -i";
outputparam="-y";

mainparam="rtmp://127.0.0.1:1935/main/"$streamid;
backupparam="rtmp://127.0.0.1:1935/backup/"$streamid;
inputparam="rtmp://127.0.0.1:1935/input/"$streamid;
distributeparam="rtmp://127.0.0.1:1935/distribute/"$streamid;

advideo=$id"video.mp4";
holdingvideo=$id"holding.mp4";
lowerthird=$id"lowerthird.png";
videoport=`expr 5554 + 2 \* $id`;
audioport=`expr 5553 + 2 \* $id`;

encoding=`cat /usr/local/nginx/scripts/streamconfig.txt | grep '__'$streamid'__' | cut -d ' ' -f 2`

case $encoding in
none)
inputencodeparam="-acodec aac -af aresample=44100:async=1 -vcodec copy -f flv -strict -2";
;;

audio)
inputencodeparam="-af azmq=bind_address=tcp\\\://127.0.0.1\\\:"$audioport",volume=2,aresample=44100:async=1 -c:a aac -ar 44100 -vcodec copy -f flv -strict -2";
;;

*)
inputencodeparam="-i /usr/local/nginx/scripts/images/$lowerthird -af azmq=bind_address=tcp\\\://127.0.0.1\\\:"$audioport",volume=2,aresample=44100:async=1 -c:a aac -filter_complex zmq=bind_address=tcp\\\://127.0.0.1\\\:"$videoport",overlay=0:H -vcodec libx264 -pix_fmt yuv420p -preset veryfast -r 25 -g 50 -b:v 6M -maxrate 6M -minrate 6M -bufsize 6M -vsync 1 -f flv -strict -2";
esac


#inputencodeparam="-i /usr/local/nginx/scripts/images/$lowerthird -af azmq=bind_address=tcp\\\://127.0.0.1\\\:"$audioport",volume=2 -c:a aac -ar 44100 -filter_complex zmq=bind_address=tcp\\\://127.0.0.1\\\:"$videoport",overlay=0:H -vcodec libx264 -pix_fmt yuv420p -preset veryfast -r 25 -g 50 -b:v 6000k -maxrate 6M -minrate 6M -bufsize 6M -f flv -strict -2";
#inputencodeparam="-af azmq=bind_address=tcp\\\://127.0.0.1\\\:"$audioport",volume=2 -c:a aac -ar 44100 -vcodec copy -f flv -strict -2";


dest=`cat /usr/local/nginx/scripts/1data.txt | grep '__'$streamid'__'$1'__' | cut -d ' ' -f 2`
resolution=`cat /usr/local/nginx/scripts/1data.txt | grep '__'$streamid'__'$1'__' | cut -d ' ' -f 3`
streamname=`cat /usr/local/nginx/scripts/1data.txt | grep '__'$streamid'__'$1'__' | cut -d ' ' -f 4`

screenon="[S]CREEN.* "$id"on";
screenmain="[S]CREEN.* "$id"main";
screenback="[S]CREEN.* "$id"back";
screenholding="[S]CREEN.* "$id"holding";
screenvideo="[S]CREEN.* "$id"video";
screenplaylist="[S]CREEN.* "$id"playlist";

case $1 in
####### MODIFICATION CONFIG ########
volume)
echo 'Parsed_volume_1 volume '$2 | /usr/local/bin/tools/zmqsend -b tcp://127.0.0.1:$audioport
sleep 0.5
;;

super)
case $2 in
off) 
echo Parsed_overlay_1 y H | /usr/local/bin/tools/zmqsend -b tcp://127.0.0.1:$videoport
sleep 0.5
;;
on)
echo Parsed_overlay_1 y H-h | /usr/local/bin/tools/zmqsend -b tcp://127.0.0.1:$videoport
sleep 0.5
;;
*)
echo "Usage is on.sh super on/off"
esac
;;

###### INPUT CONFIGURATION #######
on)
screenname=$id"on";
LCK="/usr/local/nginx/scripts/tmp/${screenname}.LCK";

exec 8>$LCK;

if flock -n -x 8; then
if [ -z "$STY" ]; then
echo "Turning on $streamid"
exec screen -dm -S $screenname /bin/bash "$0" on;
fi

while true
do
$ffmpegtsparam $inputparam $inputencodeparam $distributeparam $outputparam
echo "Restarting ffmpeg..."
sleep .2
done

else
echo $screenname " is already running"
fi
;;

########## TURN ON ENDS. MAIN BEGINS ################

main)
screenname=$id"main";
LCK="/usr/local/nginx/scripts/tmp/${screenname}.LCK";

exec 8>$LCK;

if flock -n -x 8; then
if [ $(ps aux | grep "$screenback" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenback" | awk '{print $2}')
echo "Turning off $streamid backup input"
fi

if [ $(ps aux | grep "$screenplaylist" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenplaylist" | awk '{print $2}')
echo "Turning off $streamid playlist"
fi

if [ $(ps aux | grep "$screenholding" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenholding" | awk '{print $2}')
echo "Turning off $streamid holding screen"
fi

if [ $(ps aux | grep "$screenvideo" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenvideo" | awk '{print $2}')
echo "Turning off $streamid ad video"
fi

if [ -z "$STY" ]; then
echo "Turning on $streamid main input"
exec screen -dm -S $screenname /bin/bash "$0" main;
fi

while true
do
$oldffmpegparam $mainparam -c copy -f flv $inputparam $outputparam
echo "Restarting ffmpeg..."
sleep .2
done

else
echo $screenname " is already running"
fi
;;
########## MAIN ENDS. BACKUP BEGINS ################

back)
#ME=`basename "$0"`;
#ME=$id"back";
screenname=$id"back";
LCK="/usr/local/nginx/scripts/tmp/${screenname}.LCK";


exec 8>$LCK;

if flock -n -x 8; then
if [ $(ps aux | grep "$screenmain" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenmain" | awk '{print $2}')
echo "Turning off $streamid main input"
fi

if [ $(ps aux | grep "$screenplaylist" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenplaylist" | awk '{print $2}')
echo "Turning off $streamid playlist"
fi

if [ $(ps aux | grep "$screenholding" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenholding" | awk '{print $2}')
echo "Turning off $streamid holding screen"
fi

if [ $(ps aux | grep "$screenvideo" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenvideo" | awk '{print $2}')
echo "Turning off $streamid ad video"
fi

if [ -z "$STY" ]; then
echo "Turning on $streamid backup input"
exec screen -dm -S $screenname /bin/bash "$0" back;
fi

while true
do
$oldffmpegparam $backupparam -c copy -f flv $inputparam $outputparam
echo "Restarting ffmpeg..."
sleep .2
done

else
echo $screenname " is already running"
fi
;;
########## BACKUP ENDS. HOLDING BEGINS ################

holding)
#ME=`basename "$0"`;
#ME=$streamid"holding";
screenname=$id"holding";
LCK="/usr/local/nginx/scripts/tmp/${screenname}.LCK";

exec 8>$LCK;

if flock -n -x 8; then
if [ $(ps aux | grep "$screenback" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenback" | awk '{print $2}')
echo "Turning off $streamid backup input"
fi

if [ $(ps aux | grep "$screenplaylist" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenplaylist" | awk '{print $2}')
echo "Turning off $streamid playlist"
fi

if [ $(ps aux | grep "$screenmain" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenmain" | awk '{print $2}')
echo "Turning off $streamid main input"
fi

if [ $(ps aux | grep "$screenvideo" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenvideo" | awk '{print $2}')
echo "Turning off $streamid ad video"
fi

if [ -z "$STY" ]; then
echo "Turning on $streamid holding screen"
exec screen -dm -S $screenname /bin/bash "$0" holding;
fi

while true
do
/usr/local/bin/ffmpeg -nostdin -re -fflags +genpts -stream_loop -1 -i /usr/local/nginx/scripts/images/$holdingvideo -c copy -f flv $inputparam $outputparam
echo "Restarting ffmpeg..."
sleep .2
done

else
echo $screenname " is already running"
fi
;;
########## HOLDING ENDS. AD VIDEO BEGINS ################

video)
#ME=`basename "$0"`;
#ME=$streamid"video";
screenname=$id"video";
LCK="/usr/local/nginx/scripts/tmp/${screenname}.LCK";

exec 8>$LCK;

if flock -n -x 8; then
if [ $(ps aux | grep "$screenback" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenback" | awk '{print $2}')
echo "Turning off $streamid backup input"
fi

if [ $(ps aux | grep "$screenplaylist" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenplaylist" | awk '{print $2}')
echo "Turning off $streamid playlist"
fi

if [ $(ps aux | grep "$screenholding" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenholding" | awk '{print $2}')
echo "Turning off $streamid holding screen"
fi

if [ $(ps aux | grep "$screenmain" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenmain" | awk '{print $2}')
echo "Turning off $streamid main input"
fi

if [ -z "$STY" ]; then
echo "Turning on $streamid Ad video"
exec screen -dm -S $screenname /bin/bash "$0" video;
fi

while true
do
/usr/local/bin/ffmpeg -nostdin -re -fflags +genpts -stream_loop -1 -i /usr/local/nginx/scripts/images/$advideo -c copy -f flv $inputparam $outputparam
echo "Restarting ffmpeg..."
sleep .2
done

else
echo $ME " is already running"
fi
;;

########## AD VIDEO ENDS. PLAYLIST BEGINS ################

playlist)
#ME=`basename "$0"`;
#ME=$streamid"video";
screenname=$id"playlist";
LCK="/usr/local/nginx/scripts/tmp/${screenname}.LCK";

exec 8>$LCK;

if flock -n -x 8; then
if [ $(ps aux | grep "$screenback" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenback" | awk '{print $2}')
echo "Turning off $streamid backup input"
fi

if [ $(ps aux | grep "$screenholding" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenholding" | awk '{print $2}')
echo "Turning off $streamid holding screen"
fi

if [ $(ps aux | grep "$screenvideo" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenvideo" | awk '{print $2}')
echo "Turning off $streamid video"
fi

if [ $(ps aux | grep "$screenmain" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenmain" | awk '{print $2}')
echo "Turning off $streamid main input"
fi

if [ -z "$STY" ]; then
echo "Turning on $streamid playlist"
exec screen -dm -S $screenname /bin/bash "$0" playlist;
fi

while true
do
/usr/bin/ffmpeg -nostdin -thread_queue_size 512 -re -f concat -safe 0 -i /usr/local/nginx/scripts/images/set/list.txt -c copy -f flv $inputparam
echo "Restarting ffmpeg..."
sleep .2
done

else
echo $ME " is already running"
fi
;;
########## AD VIDEO ENDS. TURN OFF BEGINS ################

off)
#ME=`basename "$0"`;
ME=$id"off";
echo $screenmain
LCK="/usr/local/nginx/scripts/tmp/${ME}.LCK";

exec 8>$LCK;

if flock -n -x 8; then

if [ $(ps aux | grep "$screenon" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenon" | awk '{print $2}')
echo "Turning off $streamid"
fi

if [ $(ps aux | grep "$screenback" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenback" | awk '{print $2}')
echo "Turning off $streamid backup input"


elif [ $(ps aux | grep "$screenholding" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenholding" | awk '{print $2}')
echo "Turning off $streamid holding screen"


elif [ $(ps aux | grep "$screenvideo" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenvideo" | awk '{print $2}')
echo "Turning off $streamid ad video"

elif [ $(ps aux | grep "$screenplaylist" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenplaylist" | awk '{print $2}')
echo "Turning off $streamid playlist"


elif [ $(ps aux | grep "$screenmain" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$screenmain" | awk '{print $2}')
echo "Turning off $streamid main input"

else
echo "$streamid is already off"
fi

else
echo "You're already trying to turn off $streamid. Hold on!"
fi

sleep 0.5
;;

####### OUTPUT CONFIGURATION ######

out99)
case $2 in 
off)
#ME=$id;
ME="[S]CREEN.* "$id$1;
#screenname=$id$1
#echo $ME
if [ $(ps aux | grep "$ME" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$ME" | awk '{print $2}')
echo "Turning off "$streamid $1
sleep 0.5
else
echo $streamid $1" is already off"
sleep 0.5
fi
exit 0
;;

*)
encodeparam="-acodec copy -vcodec libx264 -pix_fmt yuv420p -r 25 -g 50 -s 480x854 -b:v 1000k -preset veryfast -flags +global_header"
screenname=$id$1;
#ME=`basename "$0"`;
#ME=$id$1
checkout="-flags +global_header [f=flv]$dest|[f=flv]rtmp://127.0.0.1:1935/output/$streamid-$streamname"
#checkout="-f flv $dest"
#echo $checkout;
LCK="/usr/local/nginx/scripts/tmp/${screenname}.LCK";
exec 8>$LCK;
#echo "After LCK"

if flock -n -x 8; then
#echo "In flck"
i="0"
echo $streamid $1 " has started at "$resolution" resolution"
if [ -z "$STY" ];
then
#echo "above screen"
exec screen -dm -S $screenname /bin/bash "$0" "$1" "$2"; 
fi
#echo $dest
while [ $i -lt 9000 ]
do
$oldffmpegparam $distributeparam $encodeparam -vf "transpose=1" -f tee -map 0:v -map 0:a $checkout $outputparam;
echo "Waiting for input... Feed me!!!"
sleep 0.2
i=$[$i+1]
done

else echo $streamid $1 " is already running" 
fi
esac
;;

*)
case $resolution in

source)
#encodeparam="-acodec aac -af aresample=44100:async=1 -vcodec copy -vsync 0"
encodeparam="-c copy"
;;

720p)
encodeparam="-acodec copy -vcodec libx264 -pix_fmt yuv420p -r 25 -g 50 -s 1280x720 -b:v 1300k -preset veryfast -flags +global_header"
;;

540p)
encodeparam="-acodec aac -async 1 -ar 44100 -vcodec libx264 -pix_fmt yuv420p -r 25 -g 50 -s 960x540 -b:v 1000k -preset veryfast -flags +global_header"
;;

576p)
encodeparam="-acodec copy -vcodec libx264 -pix_fmt yuv420p -r 25 -g 50 -s 720x576 -b:v 800k -preset veryfast -flags +global_header"
esac

case $2 in

off)
#ME=$id;
ME="[S]CREEN.* $id$1";
#screenname=$id$1
echo $ME
if [ $(ps aux | grep "$ME" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "$ME" | awk '{print $2}')
echo "Turning off "$streamid $1
sleep 0.5
else
echo $streamid $1 " is already off"
sleep 0.5
fi
exit 0
#;;

#*)
#echo "Output parameters are either source/720p/off"
#exit 1
esac

screenname=$id$1;
#ME=`basename "$0"`;
#ME=$id$1
checkout="[f=flv]$dest|[f=flv]rtmp://127.0.0.1:1935/output/$streamid-$streamname"
LCK="/usr/local/nginx/scripts/tmp/${screenname}.LCK";
exec 8>$LCK;
#echo "After LCK"

if flock -n -x 8; then
#echo "In flck"
i="0"
echo $streamid $1 " has started at "$resolution" resolution"
if [ -z "$STY" ];
then
#echo "above screen"
exec screen -dm -S $screenname /bin/bash "$0" "$1"; 
fi
#echo $dest
while [ $i -lt 9000 ]
do
$oldffmpegparam $distributeparam $encodeparam -strict -2 -f tee -map 0:v -map 0:a "$checkout" $outputparam
echo "Waiting for English input... Feed me!!!"
sleep 0.2
i=$[$i+1]
done

else echo $streamid $1 " is already running" 
fi
esac
########## OFF ENDS. ALL END ################
