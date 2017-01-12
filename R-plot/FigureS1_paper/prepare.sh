#!/bin/bash

DIR=/home/diana/workspace/Analysis/Information
label=$1
pdfdir=JKpdf

for GT in QL196 QL404 QL402 QL435 
do

   outfile=$GT"_"$label".dat"

   echo "Calculating CC for" $GT
   $DIR/CCap3D $GT JKpdf $label 30 0 > $DIR/"inpdf.dat"
   cp $DIR/inpdf.dat $DIR/inpdf_$GT".dat"
   $DIR/GetMI3D $GT 0 JKpdf $label 30 > $outfile
   $DIR/GetMI1D $GT 1 JKpdf $label 30 0 >> $outfile
   $DIR/GetMI1D $GT 2 JKpdf $label 30 0 >> $outfile
   $DIR/GetMI1D $GT 3 JKpdf $label 30 0 >> $outfile

done
