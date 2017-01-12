#!/bin/bash

DIR=/home/diana/workspace/Analysis/Information
LABEL=pdf3DT15
PDFDIR=pdf3DT15

for GT in QL196 QL404 QL402 QL435 
do

   outfileNC=$GT"_NC.dat"
   outfileSC=$GT"_SC.dat"
   if [ -e $outfileNC ]; then rm $outfileNC;fi
   if [ -e $outfileSC ]; then rm $outfileSC;fi

   for group in 1 2 3 4 5
   do
	  echo $GT $group
      $DIR/CCap3D $GT $PDFDIR $LABEL 30 $group  > $DIR/inpdf_$GT".dat"
      $DIR/GetNC $GT $group $PDFDIR $LABEL 30 >> $outfileNC
      $DIR/GetSC $GT $group $PDFDIR $LABEL 30 >> $outfileSC
   done

done

