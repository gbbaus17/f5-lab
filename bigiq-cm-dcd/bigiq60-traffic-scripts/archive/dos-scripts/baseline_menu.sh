#!/bin/bash

clear
echo "Traffic Baselining"
echo

IP="10.1.10.20"

BASELINE='Please enter your type of baselining: '
options=("increasing" "alternate" "Quit")
select opt in "${options[@]}"
do
        case $opt in
		"increasing")
			while true; do
				clear
				echo "Hourly increasing traffic: $IP"
				echo
				for i in $(eval echo "{0..`date +%M`}")
				do
					curl -0 --interface 10.1.10.52 -s -o /dev/null -A "`shuf -n 1 ./source/useragents_with_bots.txt`" -w "status: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" http://$IP`shuf -n 1 ./source/urls.txt`
					curl -0 --interface 10.1.10.52 -s -o /dev/null -A "`shuf -n 1 ./source/useragents_with_bots.txt`"  http://$IP`shuf -n 1 ./source/urls.txt`
					curl -0 --interface 10.1.10.52 -s -o /dev/null -A "`shuf -n 1 ./source/useragents_with_bots.txt`"  http://$IP`shuf -n 1 ./source/urls.txt`
					#curl -0 -s -o /dev/null -A "`sort -R ./source/useragents_with_bots.txt | head -1`" -w "status: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" http://$IP`sort -R ./source/urls.txt | head -1`
				done
			#sleep 0.1
		done
	;;
	"alternate")
		while true; do
			clear
			echo "Hourly alternate traffic: $IP"
			echo
			#if (( {`date +%k` % 2} )); then
			if (( `date +%k` % 2 )); then
				for i in {1..100};
					do
						curl -0 --interface 10.1.10.52 -s -o /dev/null -A "`shuf -n 1 ./source/useragents_with_bots.txt`" -w "High:\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" http://$IP`shuf -n 1 ./source/urls.txt`
						curl -0 --interface 10.1.10.52 -s -o /dev/null -A "`shuf -n 1 ./source/useragents_with_bots.txt`"  http://$IP`shuf -n 1 ./source/urls.txt`
						curl -0 --interface 10.1.10.52 -s -o /dev/null -A "`shuf -n 1 ./source/useragents_with_bots.txt`"  http://$IP`shuf -n 1 ./source/urls.txt`
						#curl -0 -s -o /dev/null -A "`sort -R ./source/useragents_with_bots.txt | head -1`" -w "status: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" http://$IP`sort -R ./source/urls.txt | head -1`
					done
			else
				for i in {1..50};
					do
						curl --interface 10.1.10.52 -s -o /dev/null -A "`shuf -n 1 ./source/useragents_with_bots.txt`" -w "High:\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" http://$IP`shuf -n 1 ./source/urls.txt`
						curl --interface 10.1.10.52 -s -o /dev/null -A "`shuf -n 1 ./source/useragents_with_bots.txt`"  http://$IP`shuf -n 1 ./source/urls.txt`
						curl --interface 10.1.10.52 -s -o /dev/null -A "`shuf -n 1 ./source/useragents_with_bots.txt`"  http://$IP`shuf -n 1 ./source/urls.txt`
					#curl -0 -s -o /dev/null -A "`sort -R ./source/useragents_with_bots.txt | head -1`" -w "status: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" http://$IP`sort -R ./source/urls.txt | head -1`
					done
			fi
			#sleep 0.1
			clear
		done
	;;
	"Quit")
		break
	;;
	*) echo invalid option;;
esac
done

