#!/bin/bash

DIR=/home/diana/workspace/Analysis/Information

for GT in QL196 QL404 QL402 QL435 
do
   for neur in 1 2 3 
   do
     outfile=$GT"inpdf"$neur".dat"
     if [ -e $outfile ]; then rm $outfile;fi

     for group in 1 2 3 4 5
     do
      $DIR/CCap1D $GT $neur pdf1D 30 $group >>$outfile
     done

   done

done
