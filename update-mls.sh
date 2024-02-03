#!/bin/bash

source scripts/set-env.sh

#Shift files to right locations
sudo chgrp -R www-data ~/MLS
sudo chmod g+rw -R ~/MLS
sudo cp -R ~/MLS/html /usr/local/nginx
sudo cp scripts/nginx.conf /usr/local/nginx/conf/
sudo cp -R ~/MLS/scripts /usr/local/nginx
sudo chmod +x -R /usr/local/nginx/scripts

cd /usr/local/nginx/scripts/
for i in {2..${STREAM_NUM}}; do
	sudo cp 1.sh ${i}.sh
	sudo cp ./images/1lowerthird.png ./images/${i}lowerthird.png
	sudo cp ./images/1video.mp4 ./images/${i}video.mp4
	sudo cp ./images/1holding.mp4 ./images/${i}holding.mp4
	sudo cp ./images/1failover.mp4 ./images/${1}failover.mp5
done

sudo ./nginxrestart.sh
