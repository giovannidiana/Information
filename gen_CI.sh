#!/bin/bash

GS=$1

for GT in "QL196" "QL404" "QL402" "QL435"
do
  for coup in 12 13 23
  do
    ./CCap $GT $coup "pdf_WT-June" $GS > results.dat
    case $coup in
     "12")
     cp results.dat "gnuplot/ADF-ASI/results_"$GT"_GS"$GS".dat"
     ;;
     "13")
     cp results.dat "gnuplot/ADF-NSM/results_"$GT"_GS"$GS".dat"
     ;;
     "23")
     cp results.dat "gnuplot/ASI-NSM/results_"$GT"_GS"$GS".dat"
     ;;
    esac 
  done
done
     



