#!/bin/bash

DIR=/home/diana/workspace/Analysis/Information
folder=pdf3DT15
label=pdf3DT15

for GT in QL196 QL404 QL402 QL435 
do

   for group in 1 2 3 4 5
   do
      outfile=$GT"_all_group"$group".dat"
      $DIR/CCap3D $GT $folder $label 30 $group > $DIR/"inpdf.dat"
      $DIR/GetMI3D $GT $group $label 30 > $outfile
      $DIR/GetMI1D $GT 1 $label 30 $group >> $outfile
      $DIR/GetMI1D $GT 2 $label 30 $group >> $outfile
      $DIR/GetMI1D $GT 3 $label 30 $group >> $outfile
   done

done
