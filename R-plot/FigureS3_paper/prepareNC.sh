#!/bin/bash

DIR=/home/diana/workspace/Analysis/Information


for GT in QL196 QL404 QL402 QL435 
do
outfileNC=nc_$GT".dat"
outfileSC=sc_$GT".dat"
if [ -e $outfileSC ]; then rm $outfileSC;fi
if [ -e $outfileNC ]; then rm $outfileNC;fi
   for group in 1 2 3 4 5
   do
      let line=31+$group
      sed -n $line'p' $DIR"/GSstudy3D-all"$GT".dat" > $DIR/"inpdf.dat"
      $DIR/GetNC $GT $group pdf3D 30
      cat nc.dat >> $outfileNC
      $DIR/GetSC $GT $group pdf3D 30
      cat sc.dat >> $outfileSC
   done

done
