#!/bin/bash
waitfunc() {
ofile=$1
min=0
while :
do
	sleep 60 
	gout=`grep 'gracefully' $ofile`
	gout="$(echo -e "${gout}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
	if [[ ! $gout == '' ]]
	then
		break	
	fi
	min=$((min + 1))
	# Run for at most one day
	if [ $min -eq 1440  ]
	then
		break
	fi
done
}
run() {
cpus=8
./kill_gamess.sh
./kill_ipcs.sh
nohup ./ddikick.x rungms0 "$1"_631"" 00 $cpus -ddi 1 $cpus fist2-ProLiant-ML350-G6:cpus=$cpus -scr /tmp >& "$1"_631.out"" &
waitfunc "$1"_631.out""
mv ""/tmp/"$1"_631.dat"" .

cp "$1"_631.inp"" "$1"_321.inp""
sed -i 's/N31 6/N21 3/g' "$1"_321.inp""
sed -i 's/NSTEP=100/NSTEP=200/g' "$1"_321.inp""
./cpcoord.sh "$1"_631.out"" "$1"_321.inp""

./kill_gamess.sh
./kill_ipcs.sh
nohup ./ddikick.x rungms0 "$1"_321"" 00 $cpus -ddi 1 $cpus fist2-ProLiant-ML350-G6:cpus=$cpus -scr /tmp >& "$1"_321.out"" &
waitfunc "$1"_321.out""
mv ""/tmp/"$1"_321.dat"" .
}
input="./controlinp.txt"
for i in {1..20}
do
	torun=`sed -n "$i"p"" $input`
	if [ -f "$torun"*.inp"" ]; then  		
		run $torun
	fi
done
#while IFS= read -r line
#do
#  torun="$line"
#  run $torun
#done < "$input"
