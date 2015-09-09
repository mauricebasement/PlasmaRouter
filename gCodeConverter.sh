#!/bin/bash
cp $1 "cv_"$1
sed -i 's/G31 Z-100 F500 (find metal)//g' "cv_"$1
sed -i 's/G00 Z0.000000//g' "cv_"$1
sed -i 's/G92 Z0 (zero z)//g' "cv_"$1
sed -i 's/G00 Z10 F500 (going up)//g' "cv_"$1
sed -i 's/M03 (turn on plasma)/M8/g' "cv_"$1
sed -i 's/G01 Z1 (going to cutting z)//g' "cv_"$1
sed -i 's/M05 (turn off plasma)/M9/g' "cv_"$1
sed -i 's/([^)]*)//g' "cv_"$1
sed -i 's/G00 Z5.000000//g' "cv_"$1
sed -i 's/G01 Z-1.000000 F100.0//g' "cv_"$1
sed -i 's/M3//g' "cv_"$1
sed -i 's/ Z-1.000000//g' "cv_"$1
sed -i '/^$/d' "cv_"$1



