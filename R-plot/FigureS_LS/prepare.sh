#!/bin/bash

DIR=/home/diana/workspace/Analysis/Information

for GT in N2 QL101 QL282 QL300 
do

   outfile=info$GT".dat"
   if [ -e $outfile ]; then rm $outfile; fi
   for group in 1 2 3 4 5
   do
      $DIR/CCapLS $GT pdf_LS 30 $group >> $outfile
   done

done
