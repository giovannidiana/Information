#!/bin/bash

GT=$2
pdfdir=$3
label=$4

if [ -z $1 ]; then 
   echo  unset input!
   exit 1
fi

if [ $1 = "PDF" ]; then
   cd /home/diana/workspace/Analysis/R_projects/
   
   for GS in `seq 10 4 30` 
   do
       ./gen_pdf3D.sh $GS $folder $label
   done
fi

cd /home/diana/workspace/Analysis/Information/

filename=$label$GT".dat"

if [ -e $filename ];then rm $filename;fi


for GS in `seq 10 4 30` 
do
     for group in 0 1 2 3 4 5
     do
         ./CCap3D $GT $pdfdir $label $GS $group > results.dat 
         cat results.dat >> $filename
     done
done
