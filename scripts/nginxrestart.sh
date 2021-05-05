#!/bin/bash
sudo rm /usr/local/nginx/logs/*.log
sudo cp /usr/local/nginx/scripts/images/lowerthird/*lowerthird.png /usr/local/nginx/scripts/images
sudo /usr/local/nginx/sbin/nginx -s stop; sudo /usr/local/nginx/sbin/nginx
sudo sed -i "s|<title>.*</title>|<title>$(hostname)</title>|" /usr/local/nginx/html/control.html
sudo sed -i "s|<p align="\""center"\"" id="\""server-name"\""><b>.*</b></p>|<p
 align="\""center"\"" id="\""server-name"\""><b>$(hostname)</b></p>|" /usr/local/nginx/html/control.html
sudo sed -i "s|<title>.*</title>|<title>$(hostname) Settings</title>|" /usr/local/nginx/html/settings.html
sudo sed -i "s|<title>.*</title>|<title>$(hostname) Stats</title>|" /usr/local/nginx/html/stat.xsl