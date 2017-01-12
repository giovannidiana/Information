#!/bin/bash

if [ -z $1 ]; then 
   echo  unset input!
   exit 0
fi

if [ $1 = "PDF" ]; then
   cd /home/diana/workspace/Analysis/R_projects/
   
   for GS in `seq 10 10 60` 
   do
     for seed in `seq 100 110`
     do
       ./gen_pdf_randomized.sh $GS $seed 
     done
   done
fi

cd /home/diana/workspace/Analysis/Information/

if [ -e GSstudy12R.dat ];then rm GSstudy12R.dat;fi
if [ -e GSstudy13R.dat ];then rm GSstudy13R.dat;fi
if [ -e GSstudy23R.dat ];then rm GSstudy23R.dat;fi

for GS in `seq 10 10 60`
do
  for seed in `seq 100 110`
  do
     ./CCap "QL196" 12 "pdf_WT-June" $GS $seed > results.dat 
     cat results.dat >> GSstudy12R.dat
     ./CCap "QL196" 13 "pdf_WT-June" $GS $seed > results.dat 
     cat results.dat >> GSstudy13R.dat
     ./CCap "QL196" 23 "pdf_WT-June" $GS $seed > results.dat 
     cat results.dat >> GSstudy23R.dat
  done
done
