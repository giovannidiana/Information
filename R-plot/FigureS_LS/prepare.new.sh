#!/bin/bash

DIR=/home/diana/workspace/Analysis/Information
label="Hpi-10"

for GT in QL196 QL404 QL402 QL435 
do

   outfile=$GT"_all.dat"

   sed -n 1p $DIR/$label"_"$GT".dat" > $DIR/"inpdf.dat"
   $DIR/GetMI3D $GT 0 pdf3D $label 30 > $outfile
   $DIR/GetMI1D $GT 1 pdf3D $label 30 0 >> $outfile
   $DIR/GetMI1D $GT 2 pdf3D $label 30 0 >> $outfile
   $DIR/GetMI1D $GT 3 pdf3D $label 30 0 >> $outfile

   for group in 1 2 3 4 5
   do
      outfile=$GT"_all_group"$group".dat"
      let line=1+$group
      sed -n $line'p' $DIR/$label"_"$GT".dat" > $DIR/"inpdf.dat"
      $DIR/GetMI3D $GT $group pdf3D $label 30 > $outfile
      $DIR/GetMI1D $GT 1 pdf3D $label 30 $group >> $outfile
      $DIR/GetMI1D $GT 2 pdf3D $label 30 $group >> $outfile
      $DIR/GetMI1D $GT 3 pdf3D $label 30 $group >> $outfile
   done

done
