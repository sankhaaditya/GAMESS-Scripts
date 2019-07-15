#!/bin/bash
num=$1
./runsingle.sh "$1"_631""
grepout=`grep -n 'CORRUPTION OF THE HESSIAN' "$1"_631.out""`
if [[ $grepout == *"CORRUPTION OF THE HESSIAN"*  ]]
then
	exit
fi
cp "$1"_631.inp"" "$1"_321.inp""
sed -i 's/N31 6/N21 3/g' "$1"_321.inp""
sed -i 's/NSTEP=100/NSTEP=200/g' "$1"_321.inp""
./cpcoord.sh "$1"_631.out"" "$1"_321.inp""
./runsingle.sh "$1"_321""
