#!/bin/bash

pdfdir=$1
label=$2
GS=$3

if [ -z $1 ]; then 
   echo  unset input!
   exit 1
fi

cd /home/diana/workspace/Analysis/Information/

for GT in QL196 QL404 QL402 QL435
do
	filename=$label"_"$GT".dat"
	if [ -e $filename ];then rm $filename;fi

	for group in 0 1 2 3 4 5
   	do
        	./CCap3D $GT $pdfdir $label $GS $group > results.dat 
		cat results.dat >> $filename
	done
done

