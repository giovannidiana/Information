#!/bin/bash

if [ -z $1 ]; then 
   echo  unset input!
   echo  usage: abscript GS GT
   exit 0
fi

GS=$1


pdfdir="Gaus3D"
GT=$2
infilename="ab2"$GT"_Gaus.dat"
suff=ab2$GT"_Gaus.dat"

for pref in n1 n2 n3 Shuffle 
do 
   if [ -e $pref$suff ]; then rm $pref$suff; fi
done

line=0
while read inp 
do
	 let line=1+$line

     alpha=`echo $inp | awk '{print $1}'`
	 beta=`echo $inp | awk '{print $2}'`
     cd /home/diana/workspace/Analysis/R_projects/
	 for Food in "1" "2.00e+07" "6.30e+07" "6.30e+08" "2.00e+09" "1.10e+10"
	 do
	    Rscript code3D_Gaus.R $GT $Food $GS Gaus3D $alpha $beta
	 done
	 
	 cd /home/diana/workspace/Analysis/Information/
	 sed -n $line'p' $infilename > inpdf_$GT".dat"
	 ./GetMI1D $GT 1 Gaus3D Gaus3D $GS 0 >> n1$suff 
	 ./GetMI1D $GT 2 Gaus3D Gaus3D $GS 0 >> n2$suff 
	 ./GetMI1D $GT 3 Gaus3D Gaus3D $GS 0 >> n3$suff
	 ./GetShuffle $GT 0 Gaus3D Gaus3D $GS  >> Shuffle$suff

 done < ab2-infile.dat
