#!/bin/bash

XY=3
X=2
Y=3

DIR=/home/diana/workspace/Analysis/Information

for GT in QL196 QL404 QL402 QL435 
do
   for group in 1 2 3 4 5
   do
   
      outfile=$GT"_"$XY"_group"$group".dat"
      let line=31+$group
      sed -n $line'p' $DIR"/GSstudy3D-all"$GT".dat" > $DIR/"inpdf.dat"
      $DIR/GetMI2D $GT $XY pdf3D 30 $group > $outfile
      $DIR/GetMI1D $GT $X pdf3D 30 $group >> $outfile
      $DIR/GetMI1D $GT $Y pdf3D 30 $group >> $outfile
   done

done
