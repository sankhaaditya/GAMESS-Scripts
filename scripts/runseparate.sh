#!/bin/bash
input="./controlinp.txt"
for i in {1..20}
do
        torun=`sed -n "$i"p"" $input`
       # if [ -f "$torun"*.inp"" ]; then
        ./runmultipart.sh $torun
       # fi
done
