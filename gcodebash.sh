#!/bin/bash

sed -i 's/G31 Z-100 F500 (find metal)//g' $1
sed -i 's/G00 Z0.000000//g' $1
sed -i 's/G92 Z0 (zero z)//g' $1
sed -i 's/G00 Z10 F500 (going up)//g' $1
sed -i 's/M03 (turn on plasma)/M8/g' $1
sed -i 's/G01 Z1 (going to cutting z)//g' $1
sed -i 's/M05 (turn off plasma)/M9/g' $1

