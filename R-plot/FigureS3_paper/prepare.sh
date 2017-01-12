#!/bin/bash

DIR=/home/diana/workspace/Analysis/Information

for GT in QL196 QL404 QL402 QL435 
do

   for group in 1 2 3 4 5
   do
      outfile=$GT"_all_group"$group".dat"
      $DIR/CCap3D $GT  > $DIR/"inpdf.dat"
      $DIR/GetMI3D $GT $group pdf3D 30 > $outfile
      $DIR/GetMI1D $GT 1 pdf3D 30 $group >> $outfile
      $DIR/GetMI1D $GT 2 pdf3D 30 $group >> $outfile
      $DIR/GetMI1D $GT 3 pdf3D 30 $group >> $outfile
   done

done
