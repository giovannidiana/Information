#!/bin/bash

DIR=/home/diana/workspace/Analysis/Information

for GT in QL196 QL402 
do
   for group in 1 2 3 4 5
   do
      outfile=$GT"_all_group"$group".dat"
      if [ -e $outfile ]; then rm $outfile; fi 
      $DIR/CCap2D $GT pdf2D adfnsm 30 $group > $DIR/inpdf_$GT".dat" 
      cat $DIR/inpdf_$GT".dat" >> $outfile
      $DIR/GetMI1D_f2D $GT 1 pdf2D adfnsm 30 $group >> $outfile
      $DIR/GetMI1D_f2D $GT 3 pdf2D adfnsm 30 $group >> $outfile
   done

done
