#!/bin/bash

if [ -z $1 ]; then 
   echo  unset input!
   exit 1
fi

pdfdir="BWt"
GT=$2

if [ $1 = "PDF" ]; then
   cd /home/diana/workspace/Analysis/R_projects/
   
   for GS in 30 
   do
       ./gen_pdf3D.sh $GS $pdfdir
   done
fi

cd /home/diana/workspace/Analysis/Information/BW-test/

filename="GSstudy3D-all"$2".dat"

if [ -e $filename ];then rm $filename;fi


for GS in 30 
do
     for group in 0
     do
         ../CCap3D $GT $pdfdir $GS $group > results.dat 
         cat results.dat >> $filename
     done
done
