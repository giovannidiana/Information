#!/bin/bash

DIR=/home/diana/workspace/Analysis/Information
LABEL=pdf3D_Hpi
PDFDIR=pdf3D
GTLIST=$1

if [ ! $GTLIST ]; then GTLIST="QL196 QL404 QL402 QL435";fi

for GT in $GTLIST
do
   echo $GT

   outfileI=$GT"_I.dat"
   outfileI1=$GT"_I1.dat"
   outfileI2=$GT"_I2.dat"
   outfileI3=$GT"_I3.dat"
   outfileShuffle=$GT"_Shuffle.dat"

   if [ -e $outfileI ]; then rm $outfileI;fi
   if [ -e $outfileI1 ]; then rm $outfileI1;fi
   if [ -e $outfileI2 ]; then rm $outfileI2;fi
   if [ -e $outfileI3 ]; then rm $outfileI3;fi
   if [ -e $outfileShuffle ]; then rm $outfileShuffle;fi

   for group in 1 2 3 4 5
   do
      $DIR/CCap3D $GT $PDFDIR $LABEL 30 $group  > $DIR/inpdf_$GT".dat"
      $DIR/GetMI3D $GT $group $PDFDIR $LABEL 30 >> $outfileI
      $DIR/GetMI1D $GT 1 $PDFDIR $LABEL 30 $group >> $outfileI1
      $DIR/GetMI1D $GT 2 $PDFDIR $LABEL 30 $group >> $outfileI2
      $DIR/GetMI1D $GT 3 $PDFDIR $LABEL 30 $group >> $outfileI3
      $DIR/GetShuffle $GT $group $PDFDIR $LABEL 30 >> $outfileShuffle
   done

done


