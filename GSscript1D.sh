#!/bin/bash

if [ -z $1 ]; then 
   echo  unset input!
   exit 0
fi

if [ $1 = "PDF" ]; then
   cd /home/diana/workspace/Analysis/R_projects/
   
   for GS in `seq 10 4 30` 
   do
     ./gen_pdf1D.sh $GS 
   done
fi

cd /home/diana/workspace/Analysis/Information/

GT=$2
pdfdir="pdf1D"
ADFfile=GSstudyADF$GT".dat"
ASIfile=GSstudyASI$GT".dat"
NSMfile=GSstudyNSM$GT".dat"

if [ -e $ADFfile ];then rm $ADFfile;fi
if [ -e $ASIfile ];then rm $ASIfile;fi
if [ -e $NSMfile ];then rm $NSMfile;fi

for GS in `seq 10 4 30`
do
     for group in 0 1 2 3 4 5
     do
        ./CCap1D $GT 1 $pdfdir $GS $group > results.dat 
	cat results.dat >> $ADFfile
	./CCap1D $GT 2 $pdfdir $GS $group > results.dat 
	cat results.dat >> $ASIfile
	./CCap1D $GT 3 $pdfdir $GS $group > results.dat 
	cat results.dat >> $NSMfile
     done
done
