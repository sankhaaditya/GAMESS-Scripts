#!/bin/bash
#nohup ./ddikick.x rungms0 2_631 00 8 -ddi 1 8 fist2-ProLiant-ML350-G6:cpus=8 -scr /tmp >& 2_631.out &
#./watchrun.sh 2_631.out
#nohup ./ddikick.x rungms0 6 00 8 -ddi 1 8 fist2-ProLiant-ML350-G6:cpus=8 -scr /tmp >& 6.out &
#./runsingle.sh fe6 
#./watchrun.sh 3_9.out
#./runsingle.sh 5_3
#./cpcoord.sh 5_3.out 5_3_v.inp
#./runsingle.sh 5_3_v
#./runsingle.sh 2_5
#./cpcoord.sh 2_5.out 2_5_v.inp
#./runsingle.sh 2_5_v
#./runsingle.sh 4_4
#./cpcoord.sh 4_4.out 4_4_v.inp
#./runsingle.sh 4_4_v
#./runsingle.sh 3_11
#./cpcoord.sh 3_11.out 3_11_v.inp
#./runsingle.sh 3_11_v
./runsingle.sh 5_4
./cpcoord.sh 5_4.out 5_4_v.inp
./runsingle.sh 5_4_v
