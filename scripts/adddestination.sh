#!/bin/bash

#echo $2
sudo sed -i "s|stream$2__out$3_.*|stream$2__out$3__ $(echo $1 | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g') $4|" /usr/local/nginx/scripts/1data.txt;
