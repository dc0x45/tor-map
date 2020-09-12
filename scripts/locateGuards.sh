#!/bin/bash

#This script outputs to CSV format, use the command "bash locateGuards.sh | tee guardData.csv" to both see the output in stdout and write to the CSV file

rawList=$(curl -s "https://onionoo.torproject.org/details?search=flag:Guard%20running:true&fields=or_addresses")

formList=$(grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' <<< $rawList)

echo "Lat,Long,ISP,Hosting,IP"

for ip in $formList
do
	data=$(curl -s "http://ip-api.com/csv/$ip?fields=16786112")
	echo "$data"
	sleep 1.4s
done
