#!/bin/bash

IDIR=~/workspace/Analysis/Information/
CCAP=~/workspace/Analysis/Information/CCap3D
GETMI1D=~/workspace/Analysis/Information/GetMI1D
ALGO=kNN

for GT in QL196 QL404 QL402 QL435;do 
	if [ -e $GT"_"$ALGO".dat" ]; then rm $GT"_"$ALGO".dat";fi
	if [ -e $GT"_adf_"$ALGO".dat" ]; then rm $GT"_adf_"$ALGO".dat";fi
	if [ -e $GT"_asi_"$ALGO".dat" ]; then rm $GT"_asi_"$ALGO".dat";fi
	if [ -e $GT"_nsm_"$ALGO".dat" ]; then rm $GT"_nsm_"$ALGO".dat";fi
	for group in 1 2 3 4 5; do
		$CCAP $GT kNN 3NN 30 $group > $IDIR/inpdf.dat 
		cp $IDIR/inpdf.dat $IDIR/inpdf_$GT".dat"
		cat $IDIR/inpdf.dat >> $GT"_"$ALGO".dat"
		$GETMI1D $GT 1 kNN 3NN 30 $group >> $GT"_adf_"$ALGO".dat"
		$GETMI1D $GT 2 kNN 3NN 30 $group >> $GT"_asi_"$ALGO".dat"
		$GETMI1D $GT 3 kNN 3NN 30 $group >> $GT"_nsm_"$ALGO".dat"

	done
done
		
		
		
