#!/bin/bash

IDIR=~/workspace/Analysis/Information/
CCAP=~/workspace/Analysis/Information/CCap3D
GETMI1D=~/workspace/Analysis/Information/GetMI1D
ALGO=Hpi
lab=pdf3D_Hpi
dir=pdf3D

for GT in QL196 QL404 QL402 QL435;do 
	if [ -e $GT"_"$ALGO"_inpdf.dat" ]; then rm $GT"_"$ALGO"_inpdf.dat";fi
	for group in 1 2 3 4 5; do
		$CCAP $GT $dir $lab 30 $group >> $GT"_"$ALGO"_inpdf.dat"
	done
done
		
		
		
