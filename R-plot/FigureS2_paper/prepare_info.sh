#!/bin/bash

IDIR=~/workspace/Analysis/Information/
CCAP=~/workspace/Analysis/Information/CCap3D
GETMI1D=~/workspace/Analysis/Information/GetMI1D
ALGO=Hlscv
folder=pdf3D_bs

#for GT in QL196 QL404 QL402 QL435;do 
for GT in QL404 ;do 
	if [ -e $GT"_"$ALGO".dat" ]; then rm $GT"_"$ALGO".dat";fi
	if [ -e $GT"_adf_"$ALGO".dat" ]; then rm $GT"_adf_"$ALGO".dat";fi
	if [ -e $GT"_asi_"$ALGO".dat" ]; then rm $GT"_asi_"$ALGO".dat";fi
	if [ -e $GT"_nsm_"$ALGO".dat" ]; then rm $GT"_nsm_"$ALGO".dat";fi
	for group in `seq 1 40`; do
		echo $group
		$CCAP $GT $folder pdf3D_$ALGO$group 30 $group > $IDIR/inpdf.dat 
		cp $IDIR/inpdf.dat $IDIR/inpdf_$GT".dat"
		cat $IDIR/inpdf.dat >> $GT"_"$ALGO".dat"
		$GETMI1D $GT 1 $folder pdf3D_$ALGO$group 30 $group >> $GT"_adf_"$ALGO".dat"
		$GETMI1D $GT 2 $folder pdf3D_$ALGO$group 30 $group >> $GT"_asi_"$ALGO".dat"
		$GETMI1D $GT 3 $folder pdf3D_$ALGO$group 30 $group >> $GT"_nsm_"$ALGO".dat"

	done
done
		
		
		
