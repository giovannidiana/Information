#!/bin/bash

gridsize=$1
GT="QL196"

for coup in 12 13 23
do
   if [ -e results.dat ]; then rm results.dat; fi
   #for list in superset1 superset2 superset3 superset4 superset5 superset6 superset7 superset8 superset9 
   for list in list1 list2 list3 list4
   do
     ./CCap $list $coup $gridsize >> results.dat
   done
   
   case $coup in 
   
   "12")
     cp results.dat "gnuplot/ADF-ASI/results_"$GT"_GS"$gridsize".dat"
     ;;
   "13")
     cp results.dat "gnuplot/ADF-NSM/results_"$GT"_GS"$gridsize".dat"
     ;;
   "23")
     cp results.dat "gnuplot/ASI-NSM/results_"$GT"_GS"$gridsize".dat"
     ;;
   esac
done

