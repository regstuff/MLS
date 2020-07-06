#!/bin/bash
sudo rm /usr/local/nginx/logs/*.log
sudo cp /usr/local/nginx/scripts/images/lowerthird/*lowerthird.png /usr/local/nginx/scripts/images
sudo /usr/local/nginx/sbin/nginx -s stop; sudo /usr/local/nginx/sbin/nginx
