#!/bin/bash
# Uncomment set command below for code debuging bash
# set -x

home="/home/f5/scripts"
dcdip="10.1.10.6"
accesslogonvip="10.1.10.222"
accessradiusvip="10.1.10.117"
httponlyvip="1.1.1.1"
bigip1fqdn="BOS-vBIGIP01.termmarc.com"

already=$(ps -ef | grep "$0" | grep bash | grep -v grep | wc -l)
if [  $already -gt 2 ]; then
    echo "The script is already running `expr $already - 2` time."
    exit 1
fi

echo "# generate_access_reports_data.sh"
cd $home/access
count=`shuf -i 1-2 -n 1`;
./generate_access_reports_data.sh accessmock $httponlyvip $bigip1fqdn $dcdip $count;
count=`shuf -i 1-2 -n 1`;
./generate_access_reports_data.sh access $accesslogonvip $bigip1fqdn $dcdip $count;
count=`shuf -i 1-2 -n 1`;
./generate_access_reports_data.sh accesssessions $accesslogonvip $bigip1fqdn $dcdip $count;
count=`shuf -i 1-1 -n 1`;
./generate_access_reports_data.sh access $accessradiusvip $bigip1fqdn $dcdip $count;

echo "# generate_access_reports_mock_data.sh"
cd $home/access
count=`shuf -i 1-2 -n 1`;
./generate_access_reports_mock_data.sh $dcdip $bigip1fqdn $count


