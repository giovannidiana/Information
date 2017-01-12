#!/bin/bash

DIR=/home/diana/workspace/Analysis/Information
LABEL=pdf3D_Hpi
PDFDIR=pdf3D
GTLIST=$1

if [ ! $GTLIST ]; then GTLIST="QL196 QL404 QL402 QL435";fi

for GT in $GTLIST
do
   echo $GT

   outfileNC=$GT"_NC.dat"
   outfileSC=$GT"_SC.dat"
   outfileShuffle=$GT"_Shuffle.dat"

   if [ -e $outfileNC ]; then rm $outfileNC;fi
   if [ -e $outfileSC ]; then rm $outfileSC;fi
   if [ -e $outfileShuffle ]; then rm $outfileShuffle;fi

   for group in 1 2 3 4 5
   do
      $DIR/CCap3D $GT $PDFDIR $LABEL 30 $group  > $DIR/inpdf_$GT".dat"
      $DIR/GetNC $GT $group $PDFDIR $LABEL 30 >> $outfileNC
      $DIR/GetSC $GT $group $PDFDIR $LABEL 30 >> $outfileSC
      $DIR/GetShuffle $GT $group $PDFDIR $LABEL 30 >> $outfileShuffle
   done

done


