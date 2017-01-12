#!/bin/bash

if [ -z $1 ]; then 
   echo  unset input!
   exit 0
fi

if [ $1 = "PDF" ]; then
   cd /home/diana/workspace/Analysis/R_projects/
   
   for GS in `seq 10 4 30` 
   do
     for seed in `seq 100 100`
     do
       ./gen_Gaus3D.sh $GS  
     done
   done
fi

cd /home/diana/workspace/Analysis/Information/

pdfdir="Gaus3D"
GT=$2
filename="GSstudy3D-all"$2"_Gaus.dat"

if [ -e $filename ];then rm $filename;fi


for GS in `seq 10 4 30` 
do
     for seed in `seq 100 100`
     do
         ./CCap3D $GT $pdfdir $GS > results.dat 
         cat results.dat >> $filename
     done
done
