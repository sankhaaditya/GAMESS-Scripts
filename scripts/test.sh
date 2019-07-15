#!/bin/bash
ps -C gamess.00.x | awk -F ' ' '{print $1}' | \
while read i
do
	if [[ ! $i == 'PID'  ]]
	then
		kill -9 $i
	fi
done

