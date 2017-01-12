#!/bin/bash

DIR=/home/diana/workspace/Analysis/Information
folder=pdf3DT25
label=pdf3DT25

for GT in QL196 QL404 QL402 QL435 
do

   outfile=$GT"_all.dat"

   $DIR/CCap3D $GT $folder $label 30 0 > $DIR/"inpdf.dat"
   $DIR/GetMI3D $GT 0 $folder $label 30 > $outfile
   $DIR/GetMI1D $GT 1 $folder $label 30 0 >> $outfile
   $DIR/GetMI1D $GT 2 $folder $label 30 0 >> $outfile
   $DIR/GetMI1D $GT 3 $folder $label 30 0 >> $outfile

   for group in 1 2 3 4 5
   do
      outfile=$GT"_all_group"$group".dat"
      $DIR/CCap3D $GT $folder $label 30 $group > $DIR/"inpdf.dat"
      $DIR/GetMI3D $GT $group $folder $label 30 > $outfile
      $DIR/GetMI1D $GT 1 $folder $label 30 $group >> $outfile
      $DIR/GetMI1D $GT 2 $folder $label 30 $group >> $outfile
      $DIR/GetMI1D $GT 3 $folder $label 30 $group >> $outfile
   done

done
