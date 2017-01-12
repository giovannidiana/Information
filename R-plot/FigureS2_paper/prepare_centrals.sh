#!/bin/bash

DIR=/home/diana/workspace/Analysis/Information

for GT in  QL196 QL404 QL402 QL435 
do

      outfile=$GT"_kNN_group0.dat"
      $DIR/CCap3D $GT kNN 3NN 30 0 > $DIR/"inpdf_"$GT".dat"
      cat $DIR/inpdf_$GT".dat" > $DIR/"inpdf.dat"
      $DIR/GetMI3D $GT 0 kNN 3NN 30  > $outfile
      $DIR/GetMI1D $GT 1 kNN 3NN 30 0 >> $outfile
      $DIR/GetMI1D $GT 2 kNN 3NN 30 0 >> $outfile
      $DIR/GetMI1D $GT 3 kNN 3NN 30 0 >> $outfile

done
