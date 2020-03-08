#!/bin/sh
# usage sh test_driver.sh 
#
# This script was made for the stresstesting of CPU and memory 
# 
# using utility for stresstesting - "stress-ng"

test_time=1800 # time in seconds
info_reading_time=$(expr $test_time + 60)

echo "summary time of stress test =" $((info_reading_time + 60))
echo "processor cooldown";
echo "before tests:" > test_temps;
sensors | sed 1,5d | sed 5,8d >> test_temps;
sleep 60
echo "60 seconds later" >> test_temps; #for processor cooldown 
sensors | sed 1,5d | sed 5,8d  >> test_temps;

echo "stress test is starting";
echo "after tests:" >> test_temps;
stress-ng --cpu 4 --io 2 --vm 2 --vm-bytes 8G --timeout $test_time --metrics-brief &
for i in $(seq 1 info_reading_time); 
do
	sensors | sed 1,5d | sed 5,8d >> test_temps;
	sleep 1;
done;
