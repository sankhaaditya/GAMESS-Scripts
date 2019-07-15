#!/bin/bash
ofile=$1
nfile=$2
readwrite() {
ofile=$1
nfile=$2
oline=$3
echoon=false
ready=false
while IFS='' read -r line || [[ -n "$line" ]]; do
	line="$(echo -e "${line}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
        if [[ $line == '$END'  ]]
        then
                echoon=false
        fi
	if $echoon
	then
		if $ready
		then
			oline="$(($oline + 1))"
	                curr=`sed -n "$oline"p"" $ofile`
			i=0
			new=""
			for word in $curr
			do
				if [ "$i" -eq 2  ] || [ "$i" -eq 3  ] || [ "$i" -eq 4 ]
				then
					fl=`awk "BEGIN {print 1+$word; exit}"`
					new="$new$fl     "
				else
					new="$new$word     "
				fi
				i=$(($i+1))
			done
			echo "NewNew: $new"
			echo "New: $curr"
			echo "Old: $line"
		#	sed -i "s/$line/$curr/g" $nfile
			ready=false
		fi
		if [[ $line == 'C1' || $line == '' ]]
		then
			ready=true
		fi
	fi
	if [[ $line == '$DATA'  ]]
    	then
		echoon=true
	fi
done < $nfile
}
#while true
#do
#        grepout=`grep -n 'EQUILIBRIUM GEOMETRY LOCATED' $ofile`
#        if [[ $grepout == *"EQUILIBRIUM GEOMETRY LOCATED"*  ]]
#        then
#                startline=(${grepout//:/ })
#                startline="$(echo -e "${startline}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
#                startline="$(($startline + 3))"
#                break
#        else
#                grepout=`grep -n 'FAILURE TO LOCATE STATIONARY POINT' $ofile`
#                if [[ $grepout == *"FAILURE TO LOCATE STATIONARY POINT"*  ]]
#                then
#                        startline=(${grepout//:/ })
#                        startline="$(echo -e "${startline}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
#                        startline="$(($startline + 14))"
#                        break
#		else
			grepout=`grep -n 'ATOM   CHARGE       X              Y              Z' $ofile | tail -1`
			if [[ $grepout == *"ATOM   CHARGE       X              Y              Z"*  ]]
	                then
        	                startline=(${grepout//:/ })
                	        startline="$(echo -e "${startline}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
                        	startline="$(($startline + 1))"
				readwrite $ofile $nfile $startline
#                        	break
			fi
#                fi

#        fi
#	sleep 60
#done
#readwrite $ofile $nfile $startline
