#!/bin/bash
readwrite() {
        fromfile=$1
        tofile=$2
        line=$3
        curr="blank"
        while [ ! -z "$curr" ]
        do
                line="$(($line + 1))"
                curr=`sed -n "$line"p"" $fromfile`
                if [ ! -z "$curr" ]
                then
                        echo "$curr" >> $tofile
			if [[ $curr == *"FE"*  ]]
			then
				echo "N31 6" >> $tofile
				echo "f 1 ; 1 0.8 1.0" >> $tofile
				echo "" >> $tofile
			else
				echo "N31 6" >> $tofile
                                echo "d 1 ; 1 0.8 1.0" >> $tofile
                                echo "" >> $tofile
			fi
                fi
        done
	echo " \$END" >> $tofile
        return $line
}
fromfile="1.out"
tofile="2.inp"
while true
do
	sleep 60
	grepout=`grep -n 'EQUILIBRIUM GEOMETRY LOCATED' $fromfile`
	if [[ $grepout == *"EQUILIBRIUM GEOMETRY LOCATED"*  ]]
	then
		startline=(${grepout//:/ })
	        startline="$(echo -e "${startline}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
		startline="$(($startline + 3))"
		break
	else
		grepout=`grep -n 'FAILURE TO LOCATE STATIONARY POINT' $fromfile`
	        if [[ $grepout == *"FAILURE TO LOCATE STATIONARY POINT"*  ]]
		then
	                startline=(${grepout//:/ })
        	        startline="$(echo -e "${startline}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
        	        startline="$(($startline + 14))"
			break
		fi

	fi
done
readwrite $fromfile $tofile $startline
./kill_ipcs
nohup ./ddikick.x rungms0 2 00 12 -ddi 1 12 fist2-ProLiant-ML350-G6:cpus=12 -scr /tmp >& 2.out &
