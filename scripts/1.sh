#!/bin/bash
#Create variables/get variables from config.txt
id="$(basename "$0" .sh)"                                                                                #Which stream
streamid="stream"$id                                                                                     #Same as above, just added stream to the id
encoding=$(cat /usr/local/nginx/scripts/config.txt | grep '__'$streamid'__config__' | cut -d ' ' -f 2)   #None, audio or both, defined in stream config
streamres=$(cat /usr/local/nginx/scripts/config.txt | grep '__'$streamid'__config__' | cut -d ' ' -f 3)  #Resolution of input stream defined in stream config
failmethod=$(cat /usr/local/nginx/scripts/config.txt | grep '__'$streamid'__config__' | cut -d ' ' -f 4) #Failover method defined in stream config
dest=$(cat /usr/local/nginx/scripts/config.txt | grep '__'$streamid'__'$1'__' | cut -d ' ' -f 2)         #Rtmp destination defined in destination config
dest=${dest//-+-+/ }                                                                                     #Necessary in case login and password are used
resolution=$(cat /usr/local/nginx/scripts/config.txt | grep '__'$streamid'__'$1'__' | cut -d ' ' -f 3)   #Output resolution defined in destination config
streamname=$(cat /usr/local/nginx/scripts/config.txt | grep '__'$streamid'__'$1'__' | cut -d ' ' -f 4)   #Output name defined in destination config

#Only newffmpegparam is needed. The rest are legacy
oldffmpegparam="/usr/bin/ffmpeg -nostdin -thread_queue_size 512 -i"
newffmpegparam="/usr/local/bin/ffmpeg -nostdin -thread_queue_size 512 -i"
ffmpegtsparam="/usr/local/bin/ffmpeg -nostdin -thread_queue_size 512 -fflags +genpts+igndts+ignidx -avoid_negative_ts make_zero -use_wallclock_as_timestamps 1 -i"

#Create pipe interface between inputs and distribute
inputparam="/usr/local/nginx/scripts/tmp/input_pipe"$id
mkfifo $inputparam
exec 7<>$inputparam

#Create variables to use in ffmpeg command
mainparam="rtmp://127.0.0.1:1935/main/"$streamid
backupparam="rtmp://127.0.0.1:1935/backup/"$streamid
distributeparam="rtmp://127.0.0.1:1935/distribute/"$streamid
outputparam="-y"

#Create variables of input names
advideo=$id"video.mp4"
holdingvideo=$id"holding.mp4"
failovervideo=$id"failover.mp4"
lowerthird=$id"lowerthird.png"

#Names of screens within which processes will run
screenon="[S]CREEN.* "$id"on"
screenmain="[S]CREEN.* "$id"main"
screenback="[S]CREEN.* "$id"back"
screenholding="[S]CREEN.* "$id"holding"
screenvideo="[S]CREEN.* "$id"video"
screenplaylist="[S]CREEN.* "$id"playlist"
screenfailover="[S]CREEN.* "$id"failover"
#Array of all screens to delete easily later on
inputscreens=("$screenmain" "$screenback" "$screenholding" "$screenvideo" "$screenplaylist" "$screenfailover")
len=${#inputscreens[@]} #Length of above array

#Audio port is used to change volume on the fly
audioport=$(expr 5553 + 2 \* $id)

#Define bitrates for input resolutions, (input to distribute)
case $streamres in
1080p)
	inputres="1920x1080"
	inputbitrate="4M"
	;;

576p)
	inputres="720x576"
	inputbitrate="1M"
	;;

480p)
	inputres="854x480"
	inputbitrate="700K"
	;;

*) #Defaults to 720p
	inputres="1280x720"
	inputbitrate="1.5M"
	;;
esac

#Set up encoding profile for input encoding
case $encoding in
none) #Input codecs are copied to output. Minimal CPU usage
	inputencodeparam="-c copy -absf aac_adtstoasc -flags +global_header -f flv -strict 2"
	#inputencodeparam="-acodec aac -af aresample=44100:async=1 -vcodec copy -f flv -strict -2";
	;;

audio) #Volume control only. By default volume is doubled
	inputencodeparam="-af azmq=bind_address=tcp\\\://127.0.0.1\\\:"$audioport",volume=2,aresample=44100:async=1 -c:a aac -ar 44100 -vcodec copy -f flv -strict -2"
	;;

*) #lowerthirds via image2. Loop to poll for changes in lowerthird. Volume control
	inputencodeparam="-f image2 -loop 1 -i /usr/local/nginx/scripts/images/$lowerthird -af azmq=bind_address=tcp\\\://127.0.0.1\\\:"$audioport",volume=2,aresample=44100:async=1 -c:a aac -b:a 128k -filter_complex overlay=0:H-h -vcodec libx264 -pix_fmt yuv420p -preset veryfast -r 25 -g 50 -s $inputres -b:v $inputbitrate -maxrate $inputbitrate -minrate $inputbitrate -bufsize $inputbitrate -profile:v high -f flv -strict -2" ;;
esac

case $1 in
####### Volume Modification ########
volume)
	echo 'Parsed_volume_1 volume '$2 | /usr/local/bin/tools/zmqsend -b tcp://127.0.0.1:$audioport
	sleep 0.5
	;;

####### Lowerthird Modification ########
super)
	case $2 in
	off) #Turn off works by moving a blank png into lowerthird.png
		sudo cp /usr/local/nginx/scripts/images/lowerthird/$lowerthird /usr/local/nginx/scripts/images/$lowerthird
		echo $lowerthird " removed"
		sleep 0.2
		;;
	*) #Move appropriate png into lowerthird.png
		lowerthirdid=$id"lowerthird"$2".png"
		if test -f "/usr/local/nginx/scripts/images/lowerthird/"$lowerthirdid; then
			sudo cp /usr/local/nginx/scripts/images/lowerthird/$lowerthirdid /usr/local/nginx/scripts/images/$lowerthird
			echo $lowerthirdid " added"

		else #In case lowerthird does not exist
			echo $lowerthirdid " does not exist. Please upload it."
		fi

		sleep 0.2
		;;
	esac
	;;

###### INPUT CONFIGURATION #######
on) #This ffmpeg process runs between inputs pipe and distribute
	screenname=$id"on"

	#Lock file to prevent same screen being created in case user clicks twice
	LCK="/usr/local/nginx/scripts/tmp/${screenname}.LCK"
	exec 8>$LCK

	if flock -n -x 8; then  #If lock does not exist, continue with ffmpeg creation
		if [ -z "$STY" ]; then #If we are in main terminal, continue
			echo "Turning on $streamid"
			exec screen -dm -S $screenname /bin/bash "$0" on #Create screen and run same command inside screen
		fi

		while true; do #This infinite loop will run inside the screen
			$newffmpegparam $inputparam $inputencodeparam $distributeparam
			echo "Restarting ffmpeg..." #When above process fails for any reason, restart
			sleep .2                    #Needed so CPU doesn't get stuck
		done

	else #If lock exists, process is already running
		echo $screenname " is already running"
	fi
	;;

########## TURN ON ENDS. MAIN BEGINS ################

main)
	screenname=$id"main"
	LCK="/usr/local/nginx/scripts/tmp/${screenname}.LCK"

	exec 8>$LCK

	if flock -n -x 8; then
		for ((i = 0; i < $len; i++)); do #Before turning on, turn of all other inputs
			if [ $(ps aux | grep -E "${inputscreens[i]}" | grep -v "$screenmain" | awk '{print $2}' | wc -l) -gt 0 ]; then
				kill $(ps aux | grep -E "${inputscreens[i]}" | grep -v "$screenmain" | awk '{print $2}')
				echo "Turning off ${inputscreens[i]:11} input"
				i=$len #Set i to len to exit loop immediately after match is found.
			fi
		done

		if [ -z "$STY" ]; then
			echo "Turning on $streamid main input"
			exec screen -dm -S $screenname /bin/bash "$0" main
		fi

		while true; do #Send main input to pipe
			$newffmpegparam $mainparam -c copy -vbsf h264_mp4toannexb -f mpegts pipe:1 >$inputparam

			case $failmethod in   #Failover method
			mainback)             #Main to backup
				screenname=$id"back" #Set screen name to back and spawn backup. Main screen will be killed by backup
				screen -dm -S $screenname /bin/bash "$0" back
				;;

			mainbackfail) #Main to backup. Backup will fail to failover in its section
				screenname=$id"back"
				screen -dm -S $screenname /bin/bash "$0" back
				;;

			mainfail) #Main to failover
				screenname=$id"failover"
				screen -dm -S $screenname /bin/bash "$0" failover
				;;

			*) #No failover
				echo "Restarting ffmpeg..."
				sleep .2
				;;
			esac
		done

	else
		echo $screenname " is already running"
	fi
	;;
########## MAIN ENDS. BACKUP BEGINS ################

back)
	screenname=$id"back"
	LCK="/usr/local/nginx/scripts/tmp/${screenname}.LCK"

	exec 8>$LCK

	if flock -n -x 8; then
		for ((i = 0; i < $len; i++)); do
			if [ $(ps aux | grep -E "${inputscreens[i]}" | grep -v "$screenback" | awk '{print $2}' | wc -l) -gt 0 ]; then
				kill $(ps aux | grep -E "${inputscreens[i]}" | grep -v "$screenback" | awk '{print $2}')
				echo "Turning off ${inputscreens[i]:11} input"
				i=$len
			fi
		done

		if [ -z "$STY" ]; then
			echo "Turning on $streamid backup input"
			exec screen -dm -S $screenname /bin/bash "$0" back
		fi

		while true; do
			$newffmpegparam $backupparam -c copy -vbsf h264_mp4toannexb -f mpegts pipe:1 >$inputparam

			case $failmethod in
			mainback)
				screenname=$id"main"
				screen -dm -S $screenname /bin/bash "$0" main
				;;

			mainbackfail)
				screenname=$id"failover"
				screen -dm -S $screenname /bin/bash "$0" failover
				;;

			*)
				echo "Restarting ffmpeg..."
				sleep .2
				;;
			esac
		done

	else
		echo $screenname " is already running"
	fi
	;;
########## BACKUP ENDS. HOLDING BEGINS ################

holding)
	screenname=$id"holding"
	LCK="/usr/local/nginx/scripts/tmp/${screenname}.LCK"

	exec 8>$LCK

	if flock -n -x 8; then
		for ((i = 0; i < $len; i++)); do
			if [ $(ps aux | grep -E "${inputscreens[i]}" | grep -v "$screenholding" | awk '{print $2}' | wc -l) -gt 0 ]; then
				kill $(ps aux | grep -E "${inputscreens[i]}" | grep -v "$screenholding" | awk '{print $2}')
				echo "Turning off ${inputscreens[i]:11} input"
				i=$len
			fi
		done

		if [ -z "$STY" ]; then
			echo "Turning on $streamid holding screen at $2 seconds"
			exec screen -dm -S $screenname /bin/bash "$0" holding $2
		fi

		while true; do #Loop the same file using stream_loop -1. genpts needed to continue PTS for each iteration
			/usr/local/bin/ffmpeg -nostdin -re -fflags +genpts -stream_loop -1 -ss $2 -i /usr/local/nginx/scripts/images/$holdingvideo -c copy -vbsf h264_mp4toannexb -f mpegts pipe:1 >$inputparam
			echo "Restarting ffmpeg..."
			sleep .2
		done

	else
		echo $screenname " is already running"
	fi
	;;
########## HOLDING ENDS. AD VIDEO BEGINS ################

video)
	screenname=$id"video"
	LCK="/usr/local/nginx/scripts/tmp/${screenname}.LCK"

	exec 8>$LCK

	if flock -n -x 8; then
		for ((i = 0; i < $len; i++)); do
			if [ $(ps aux | grep -E "${inputscreens[i]}" | grep -v "$screenvideo" | awk '{print $2}' | wc -l) -gt 0 ]; then
				kill $(ps aux | grep -E "${inputscreens[i]}" | grep -v "$screenvideo" | awk '{print $2}')
				echo "Turning off ${inputscreens[i]:11} input"
				i=$len
			fi
		done

		if [ -z "$STY" ]; then
			echo "Turning on $streamid Ad video at $2 seconds"
			exec screen -dm -S $screenname /bin/bash "$0" video $2
		fi

		while true; do
			/usr/local/bin/ffmpeg -nostdin -re -fflags +genpts -stream_loop -1 -ss $2 -i /usr/local/nginx/scripts/images/$advideo -c copy -vbsf h264_mp4toannexb -f mpegts pipe:1 >$inputparam
			echo "Restarting ffmpeg..."
			sleep .2
		done

	else
		echo $screenname " is already running"
	fi
	;;

########## AD VIDEO ENDS. PLAYLIST BEGINS ################

playlist)
	screenname=$id"playlist"
	LCK="/usr/local/nginx/scripts/tmp/${screenname}.LCK"

	exec 8>$LCK

	if flock -n -x 8; then
		for ((i = 0; i < $len; i++)); do
			if [ $(ps aux | grep -E "${inputscreens[i]}" | grep -v "$screenplaylist" | awk '{print $2}' | wc -l) -gt 0 ]; then
				kill $(ps aux | grep -E "${inputscreens[i]}" | grep -v "$screenplaylist" | awk '{print $2}')
				echo "Turning off ${inputscreens[i]:11} input"
				i=$len
			fi
		done

		if [ -z "$STY" ]; then
			echo "Turning on $streamid playlist"
			exec screen -dm -S $screenname /bin/bash "$0" playlist
		fi

		while true; do #Playlist works by concating files from list.txt
			/usr/bin/ffmpeg -nostdin -thread_queue_size 512 -re -f concat -safe 0 -i /usr/local/nginx/scripts/images/set/list.txt -c copy -vbsf h264_mp4toannexb -f mpegts pipe:1 >$inputparam
			echo "Restarting ffmpeg..."
			sleep .2
		done

	else
		echo $screenname " is already running"
	fi
	;;
########## PLAYLIST ENDS. FAILOVER VIDEO BEGINS ################

failover)
	screenname=$id"failover"
	LCK="/usr/local/nginx/scripts/tmp/${screenname}.LCK"

	exec 8>$LCK

	if flock -n -x 8; then
		for ((i = 0; i < $len; i++)); do
			if [ $(ps aux | grep -E "${inputscreens[i]}" | grep -v "$screenfailover" | awk '{print $2}' | wc -l) -gt 0 ]; then
				kill $(ps aux | grep -E "${inputscreens[i]}" | grep -v "$screenfailover" | awk '{print $2}')
				echo "Turning off ${inputscreens[i]:11} input"
				i=$len
			fi
		done

		if [ -z "$STY" ]; then
			echo "Turning on $streamid failover"
			exec screen -dm -S $screenname /bin/bash "$0" failover
		fi

		while true; do
			/usr/local/bin/ffmpeg -nostdin -re -fflags +genpts -stream_loop -1 -i /usr/local/nginx/scripts/images/$failovervideo -c copy -vbsf h264_mp4toannexb -f mpegts pipe:1 >$inputparam
			echo "Restarting ffmpeg..."
			sleep .2
		done

	else
		echo $screenname " is already running"
	fi
	;;
########## FAILOVER VIDEO ENDS. TURN OFF BEGINS ################

off)
	ME=$id"off"
	echo $screenmain
	LCK="/usr/local/nginx/scripts/tmp/${ME}.LCK"

	exec 8>$LCK

	if flock -n -x 8; then

		if [ $(ps aux | grep "$screenon" | awk '{print $2}' | wc -l) -gt 0 ]; then
			kill $(ps aux | grep "$screenon" | awk '{print $2}')
			echo "Turning off $streamid"
		fi

		offstatus="$streamid is already off" #Initialize variable to use inside below loop
		for ((i = 0; i < $len; i++)); do
			if [ $(ps aux | grep -E "${inputscreens[i]}" | awk '{print $2}' | wc -l) -gt 0 ]; then
				kill $(ps aux | grep -E "${inputscreens[i]}" | awk '{print $2}')
				offstatus="Turning off ${inputscreens[i]:11} input" #If something exists to turn off, change variable
				i=$len
			fi
		done

		echo $offstatus #Echoes Already off in case user clicks twice

	else
		echo "You're already trying to turn off $streamid. Hold on!"
	fi

	sleep 0.5
	;;

####### OUTPUT CONFIGURATION ######

out99) #For instagram
	case $2 in
	off)
		ME="[S]CREEN.* "$id$1 #Turn off output
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

	*) #Instagram encoding at 480x854 at 1mbps. Flags global headers needed because tee muxer will not automatically generate headers needed for rtmp flv format
		encodeparam="-acodec aac -async 1 -ar 44100 -ac 1 -b:a 128k -vcodec libx264 -pix_fmt yuv420p -r 25 -g 50 -s 480x854 -b:v 1000k -preset veryfast -flags +global_header"
		screenname=$id$1
		LCK="/usr/local/nginx/scripts/tmp/${screenname}.LCK"

		#Create master-slave link to send output to nginx output app simultaneously for stats monitoring
		checkout="[f=flv]$dest|[f=flv]rtmp://127.0.0.1:1935/output/$streamid-$streamname"

		exec 8>$LCK
		if flock -n -x 8; then
			i="0"
			echo $streamid $1 " has started at "$resolution" resolution"
			if [ -z "$STY" ]; then
				exec screen -dm -S $screenname /bin/bash "$0" "$1" "$2"
			fi
			while [ $i -lt 9000 ]; do #Turn off if output is idle for 9000*0.2=1800 seconds
				#Use transpose filter to transpose 90 degrees.
				$newffmpegparam $distributeparam $encodeparam -vf "transpose=1" -f tee -map 0:v -map 0:a $checkout
				echo "Waiting for input... Feed me!!!"
				sleep 0.2
				i=$(($i + 1))
			done

		else
			echo $streamid $1 " is already running"
		fi
		;;
	esac
	;;

*) #Output resolution encode parameters
	case $resolution in

	source) #Copy all codecs
		encodeparam="-c copy -flags +global_header"
		;;

	vertical) # Rotate video 90 degrees and scale to 720p
		encodeparam="-vf 'transpose=1, scale=720:1280' -c:v libx264 -c:a aac -flags +global_header"
		;;

	720p) #1.3mbps video, audio copy
		encodeparam="-acodec copy -vcodec libx264 -pix_fmt yuv420p -r 25 -g 50 -s 1280x720 -b:v 1300k -preset veryfast -flags +global_header"
		;;

	540p) #1mbps video, audio resampled to 44.1khz 128kbps mono for Twitter
		encodeparam="-acodec aac -async 1 -ar 44100 -ac 1 -b:a 128k -vcodec libx264 -pix_fmt yuv420p -r 25 -g 50 -s 960x540 -b:v 1000k -preset veryfast -flags +global_header"
		;;

	576p) #800k video, audio copy
		encodeparam="-acodec copy -vcodec libx264 -pix_fmt yuv420p -r 25 -g 50 -s 720x576 -b:v 800k -preset veryfast -flags +global_header" ;;
	esac

	case $2 in

	off)
		ME="[S]CREEN.* $id$1 "
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
		;;
	esac

	screenname=$id$1
	checkout="[f=flv]$dest|[f=flv]rtmp://127.0.0.1:1935/output/$streamid-$streamname"
	LCK="/usr/local/nginx/scripts/tmp/${screenname}.LCK"
	exec 8>$LCK

	if flock -n -x 8; then
		i="0"
		echo $streamid $1 " has started at "$resolution" resolution"
		if [ -z "$STY" ]; then
			exec screen -dm -S $screenname /bin/bash "$0" "$1"
		fi

		ffmpegcommand="$newffmpegparam $distributeparam $encodeparam -strict -2 -f tee -map 0:v -map 0:a \"$checkout\""

		while [ $i -lt 9000 ]; do
			eval "$ffmpegcommand"
			echo "Waiting for English input... Feed me!!!"
			sleep 0.2
			i=$(($i + 1))
		done

	else
		echo $streamid $1 " is already running"
	fi
	;;
esac
########## OUTPUTS END. ALL END ################
