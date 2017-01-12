#!/bin/bash

if [ -z $1 ]; then 
   echo  unset input!
   exit 0
fi

GS=$1


pdfdir="Gaus3D"
GT=$2
filename="ab2"$2"_Gaus.dat"

if [ -e $filename ];then rm $filename;fi

while read inp 
do

         alpha=`echo $inp | awk '{print $1}'`
	 beta=`echo $inp | awk '{print $2}'`
         cd /home/diana/workspace/Analysis/R_projects/
	 for Food in "1" "2.00e+07" "6.30e+07" "6.30e+08" "2.00e+09" "1.10e+10"
	 do
	    Rscript code3D_Gaus.R $GT $Food $GS Gaus3D $alpha $beta
	 done
	 
	 cd /home/diana/workspace/Analysis/Information/

         ./CCap3D $GT $pdfdir Gaus3D $GS 0 > results$GT".dat"
         cat results$GT".dat" >> $filename

 done < ab2-$GT-infile.dat
