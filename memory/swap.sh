#!/bin/sh

VERBOSE=true

list_swap() 
{
	ps -eo pid,comm |  while read pid comm; do 
		if [ -f /proc/$pid/smaps ]; then
			swap=`awk '/Swap:/ {swap += $2} END {print swap}' /proc/$pid/smaps`
			size=`awk '/Size:/ {size += $2} END {print size}' /proc/$pid/smaps`
			rss=`awk '/Rss:/ {rss += $2} END {print rss }' /proc/$pid/smaps`
			if [ x$swap != x ]; then
				if [ $VERBOSE == true -o $swap -ne 0 ]; then
					#echo -e "$swap \t $rss \t $size \t $pid \t $comm"
					printf "%-10d %-10d %-10d %-10d %s\n" $swap $rss $size $pid $comm
				fi
			fi
		fi
	done
}


echo =================================================
echo "MEM USAGE:"
free -m
echo
echo -------------------------------------------------
echo
echo "SWAP USAGE PER PROCESS"
echo 
printf "%-10s %-10s %-10s %-10s %s\n" "SWAP(K)" "RSS" "SIZE" "PID" "COMM"

list_swap | sort -n
echo =================================================
