#!/bin/bash
rp0=1.90
drp=0.02
ro0=3.00
dro=0.05
rp=$rp0
ro=$ro0
for i in {0..10}
do
	rp=`echo "$rp0+($i*$drp)" | bc`
	t=0
	d=1
	while [ $t -le 10 ]
	do
		if [ ! -z "$E" ]; then
			./forminput.sh $rp_from $ro_from $rp $ro
		fi
		./runsingle.sh "series_${rp}_${ro}"
		E=`grep "TOTAL ENERGY      =" "series_${rp}_${ro}.out"`
		E=${E//=/ }
		E=${E[2]}
		if [ $t -eq 0 ]; then
			E0=$E
		fi
		if [ $t -eq 1 ]; then
			if (( $(echo "$E < $E0" | bc -l) )); then
				E_pre=$E
			else
				d=`echo "$d*(-1)" | bc`
				ro=`echo "$ro+$d*$dro" | bc`
				E_pre=$E0
			fi
		fi
		if [ $t -ge 2 ]; then
			if (( $(echo "$E < $E_pre" | bc -l) )); then
				E_pre=$E
			else
				ro=`echo "$ro-($d*$dro)" | bc`
				rp_from=$rp
				ro_from=$ro
				break							
			fi
		fi
		rp_from=$rp
		ro_from=$ro
		ro=`echo "$ro+($d*$dro)" | bc`
		t=$(($t+1))
	done
done
