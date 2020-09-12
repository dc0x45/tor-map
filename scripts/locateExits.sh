#!/bin/bash

#This script outputs to CSV format, use the command "bash locateExits.sh | tee exitData.csv" to both see the output in stdout and write to the CSV file

rawDate=$(date -u +%Y-%m-%d)
currHour=$(date -u +%H)
preHour=$(expr $currHour - 1)
if [ "$preHour" -le 9 ]; then
        preHour="0$preHour"
fi
formDate="$rawDate-$preHour-02-00"

rawList=$(curl -s https://collector.torproject.org/recent/exit-lists/$formDate)

formList=$(grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' <<< $rawList)

echo "Lat,Long,ISP,Hosting,IP"

for ip in $formList
do
        data=$(curl -s "http://ip-api.com/csv/$ip?fields=16786112")
        echo "$data"
        sleep 1.4s
done
