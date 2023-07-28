#!/bin/bash

sudo chgrp -R www-data ~/MLS
sudo chmod g+rw -R ~/MLS
sudo cp -R ~/MLS/html /usr/local/nginx
sudo cp scripts/nginx.conf /usr/local/nginx/conf/
sudo cp -R ~/MLS/scripts /usr/local/nginx
sudo chmod +x -R /usr/local/nginx/scripts

sudo ./scripts/nginxrestart.sh
