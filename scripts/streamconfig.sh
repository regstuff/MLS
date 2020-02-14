#!/bin/bash

#echo $2
sudo sed -i "s|stream$1__.*|stream$1__ $2 $3|" /usr/local/nginx/scripts/streamconfig.txt;
