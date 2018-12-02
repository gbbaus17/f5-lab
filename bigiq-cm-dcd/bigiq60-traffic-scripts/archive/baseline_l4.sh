#!/bin/bash
SECONDS=0
while true; do  
   for i in "" httprequest.php exercise_guide.txt; do
      curl -m 1 -s -o /dev/null -w "/$i\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" 10.1.20.14/$i
      curl -m 1 -s -o /dev/null -w "/$i\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" 10.1.20.14/$i
      curl -m 1 -s -o /dev/null -w "/$i\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" 10.1.20.14/$i
      curl -m 1 -s -o /dev/null -w "/$i\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" 10.1.20.14/$i
      curl -m 1 -s -o /dev/null -w "/$i\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" 10.1.20.14/$i
      curl -m 1 -s -o /dev/null -w "/$i\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" 10.1.20.14/$i
      curl -m 1 -s -o /dev/null -w "/$i\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" 10.1.20.14/$i
      curl -m 1 -s -o /dev/null -w "/$i\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" 10.1.20.15/$i
      curl -m 1 -s -o /dev/null -w "/$i\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" 10.1.20.15/$i
      curl -m 1 -s -o /dev/null -w "/$i\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" 10.1.20.15/$i
      curl -m 1 -s -o /dev/null -w "/$i\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" 10.1.20.15/$i
      curl -m 1 -s -o /dev/null -w "/$i\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" 10.1.20.15/$i
      curl -m 1 -s -o /dev/null -w "/$i\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" 10.1.20.15/$i
      curl -m 1 -s -o /dev/null -w "/$i\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" 10.1.20.15/$i
   done
   hping3 --quiet -1 -c 5 --fast 10.1.20.14
   hping3 --quiet -1 -c 5 --fast 10.1.20.15
sleep 1
clear
echo "Baselining. Use 'tmsh show security dos l4bdos-context-info' to see status."
echo
echo
done

