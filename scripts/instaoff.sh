#!/bin/bash
screen -S $1instagram -X stuff "stop
"

sleep 5
if [ $(ps aux | grep "[S]CREEN.* $1instagram" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "[S]CREEN.* $1instagram" | awk '{print $2}')
echo "Turning off $1instagram"
fi

if [ $(ps aux | grep "[S]CREEN.* $1insta" | awk '{print $2}' | wc -l) -gt 0 ]; then
kill $(ps aux | grep "[S]CREEN.* $1insta" | awk '{print $2}')
echo "Turning off $1insta"
fi


