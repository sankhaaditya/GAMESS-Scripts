#!/bin/bash
from="series_${1}_${2}.out"
to="series_${3}_${4}.inp"
echo "Copying from $from to $to"
if (( $(echo "$1 != $3" | bc -l) )); then
	d=`echo "scale=5;($3-$1)/1.4142" | bc`
	./cpcoord_rp.sh $from $to $d
fi
if (( $(echo "$2 != $4" | bc -l) )); then
	d=`echo "scale=5;($4-$2)/2.8284" | bc`
	./cpcoord_ro.sh $from $to $d
fi
