#!/bin/bash

DIR=/home/diana/workspace/Analysis/Information
FOL=kNN
lab=3NN
gr=0

for GT in  QL196 QL404 QL402 QL435 
do

      outfile=$GT"_"$lab".dat"
      $DIR/CCap3D $GT $FOL $lab 30 $gr > $DIR/"inpdf_"$GT".dat"
      cat $DIR/inpdf_$GT".dat" > $DIR/"inpdf.dat"
      $DIR/GetMI3D $GT $gr $FOL $lab 30  > $outfile
      $DIR/GetMI1D $GT 1 $FOL $lab 30 $gr >> $outfile
      $DIR/GetMI1D $GT 2 $FOL $lab 30 $gr >> $outfile
      $DIR/GetMI1D $GT 3 $FOL $lab 30 $gr >> $outfile

done
