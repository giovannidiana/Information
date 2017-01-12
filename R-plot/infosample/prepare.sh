#!/bin/bash

DIR=/home/diana/workspace/Analysis/Information
PDFGEN=/home/diana/workspace/Analysis/R_projects/code3D_infosampler.R
LABEL=fake
PDFDIR=pdf3D_infosample
GT=QL196
group=0


   outfileI=I.dat
   outfileI1=I1.dat
   outfileI2=I2.dat
   outfileI3=I3.dat
   outfileShuffle=Shuffle.dat

   if [ -e $outfileI ]; then rm $outfileI;fi
   if [ -e $outfileI1 ]; then rm $outfileI1;fi
   if [ -e $outfileI2 ]; then rm $outfileI2;fi
   if [ -e $outfileI3 ]; then rm $outfileI3;fi
   if [ -e $outfileShuffle ]; then rm $outfileShuffle;fi


   seed=0
   while true
	   do
		   let seed=$seed+1
		   Rscript $PDFGEN $seed
		   echo $seed
		   $DIR/CCap3D $GT $PDFDIR $LABEL 30 $group  > $DIR/inpdf_$GT".dat"
		   $DIR/GetMI3D $GT $group $PDFDIR $LABEL 30 >> $outfileI
		   $DIR/GetMI1D $GT 1 $PDFDIR $LABEL 30 $group >> $outfileI1
		   $DIR/GetMI1D $GT 2 $PDFDIR $LABEL 30 $group >> $outfileI2
		   $DIR/GetMI1D $GT 3 $PDFDIR $LABEL 30 $group >> $outfileI3
		   $DIR/GetShuffle $GT $group $PDFDIR $LABEL 30 >> $outfileShuffle
   done





