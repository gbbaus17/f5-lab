#!/bin/bash
SECONDS=0
while true; do  
   for i in sell register help index user_login; do
      curl -s -m 1 -o /dev/null -w "$i.php\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" 10.1.20.101/$i.php
      curl -s -m 1 -o /dev/null -w "$i.php\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" 10.1.20.101/$i.php
      curl -s -m 1 -o /dev/null -w "$i.php\tstatus: %{http_code}\tbytes: %{size_download}\ttime: %{time_total}\n" 10.1.20.101/$i.php
   done

sleep 1
clear
echo
echo "Baselining for L7 BDOS. Watch 'admd -s vs./Common/Auction.info -s vs./Common/Auction.sig.health' for status."
echo
done

