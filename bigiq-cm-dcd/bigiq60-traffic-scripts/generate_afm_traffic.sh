#!/bin/bash
# Uncomment set command below for code debuging bash
# set -x

home="/home/f5/scripts"

already=$(ps -ef | grep "$0" | grep bash | grep -v grep | wc -l)
if [  $already -gt 2 ]; then
    echo "The script is already running `expr $already - 2` time."
    exit 1
fi

sitefqdn[1]="site10.example.com"
sitefqdn[2]="site12.example.com"
sitefqdn[3]="site14.example.com"
sitefqdn[4]="site15.example.com"
sitefqdn[5]="site16.example.com"
sitefqdn[6]="site18.example.com"
sitefqdn[7]="site20.example.com"
sitefqdn[8]="site22.example.com"
sitefqdn[9]="site26.example.com"
sitefqdn[10]="site28.example.com"
sitefqdn[11]="site28.example.com"
sitefqdn[12]="site30.example.com"
sitefqdn[13]="site32.example.com"
sitefqdn[14]="site36.example.com"
sitefqdn[15]="site38.example.com"
sitefqdn[16]="site40.example.com"
sitefqdn[17]="site42.example.com"

# get length of the array
arraylength=${#sitefqdn[@]}


for (( i=1; i<${arraylength}+1; i++ ));
do
    if [ ! -z "${sitefqdn[$i]}" ]; then
        # Only generat traffic on alive VIP
        ip=$(ping -c 1 -w 1 ${sitefqdn[$i]} | grep PING | awk '{ print $3 }')
        timeout 1 bash -c "cat < /dev/null > /dev/tcp/${ip:1:-1}/443"
        if [  $? == 0 ]; then
		# Port 443 open
		port=443
        else
                # If 443 not anwser, trying port 80
                timeout 1 bash -c "cat < /dev/null > /dev/tcp/${ip:1:-1}/80"
                if [  $? == 0 ]; then
                        # Port 80 open
                        port=80
                else
                      port=0
                fi
        fi

        if [[  $port == 443 || $port == 80 ]]; then
                echo -e "\n# site $i ${sitefqdn[$i]} nmap"

                nmap -sS ${sitefqdn[$i]} -D 10.1.10.7,10.1.10.8,10.1.10.9,5.188.11.1,5.188.11.2

        else
                echo "SKIP ${sitefqdn[$i]} - $ip not answering on port 443 or 80"
        fi
   fi
done