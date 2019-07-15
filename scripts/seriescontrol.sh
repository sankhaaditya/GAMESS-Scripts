#!/bin/bash
# a single: series + roo + rp
# loop through various rp
# in each rp, find minimum energy roo

RP0=2.60
dRP=0.01
dRO=0.05
for i in {0..20}
do
	rp=`echo "$RP0-$i*$dRP" | bc`
	t=0
	dir=1
	flip=0
	while [ $t -lt 10 ]
	do	
		./run
		E=getenergy
		if [ $t -ne 0 ]; then
			if (( $(echo "$E > $E_prev" |bc -l) )); then
				flip=$(($flip+1))
				dir=`echo "(-1)*$dir" | bc`
				ro=`echo "$ro+dir*$dRO" | bc`
			fi
		fi
		if [ $flip -eq 2 ]; then
			break
		fi
		if [ $t -ge 2 ] && [ $dir -eq -1 ] && [ $flip -eq 1 ]; then
			break
		fi
		E_prev=$E
		ro=`echo "$ro+dir*$dRO" | bc`
		t=$(($t+1))
	done
	
done
