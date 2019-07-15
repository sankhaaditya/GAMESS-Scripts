#!/bin/bash
waitfunc() {
ofile=$1
while :
do
	sleep 60 
	gout=`grep 'gracefully' $ofile`
	gout="$(echo -e "${gout}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
	if [[ ! $gout == '' ]]
	then
		break	
	fi
done
}
gv() {
cpus=8
./kill_gamess.sh
./kill_ipcs.sh
nohup ./ddikick.x rungms0 "$1" 00 $cpus -ddi 1 $cpus fist2-ProLiant-ML350-G6:cpus=$cpus -scr /tmp >& "$1".out"" &
waitfunc "$1".out""
./proc1.sh "$1".out"" "$1"v.inp""
./kill_gamess.sh
./kill_ipcs.sh
nohup ./ddikick.x rungms0 "$1"v"" 00 $cpus -ddi 1 $cpus fist2-ProLiant-ML350-G6:cpus=$cpus -scr /tmp >& "$1"v.out"" &
waitfunc "$1"v.out""
}
gv "q3-3q1"
