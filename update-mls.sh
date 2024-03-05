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

for ((i = 2; i <= ${STREAM_NUM}; i++)); do
	sudo cp 1.sh ${i}.sh
done

sudo ./nginxrestart.sh
