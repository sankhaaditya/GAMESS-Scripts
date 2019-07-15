#!/bin/bash
ifile="$1".inp""
ofile="$1".out""
./kill_gamess.sh
./kill_ipcs.sh
nohup ./ddikick.x rungms0 $ifile 00 8 -ddi 1 8 fist2-ProLiant-ML350-G6:cpus=8 -scr /tmp >& $ofile &
./watchrun.sh $ofile
