#!/bin/bash

DIR=/home/diana/workspace/Analysis/Information

for GT in QL196 QL404 QL402 QL435 
do

   outfile=$GT"_all.dat"
   if [ -e $outfile ]; then rm $outfile;fi

   for group in 1 2 3 4 5
   do
      let line=31+$group
      sed -n $line'p' $DIR"/GSstudy3D-all"$GT".dat" > $DIR/"inpdf.dat"
      $DIR/GetSC $GT $group pdf3D 30 >> $outfile
   done

done
