#!/bin/bash
sleeptime=300
ofile=$1
out2='fakeoutstringhopefullynothingwillmatchthis'
while true
do
	out1=`tail $ofile`
	if [ "$out1" == "$out2"  ]
	then
		break
	else
		out2=$out1
		sleep $sleeptime
	fi
done
