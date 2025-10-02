# This script will take necessary outputs that need to be cross checked after the activity so that there won't be any changes in the server configuration
# Should run postcheck.sh script after the activity

#!/bin/bash
rm -f /tmp/pre_check*
DATE=$(date '+%Y%m%d_%H%M%S')
clear
echo "-----------------------------">>/tmp/pre_check_$DATE
date>>/tmp/pre_check_$DATE
echo "-----------------------------">>/tmp/pre_check_$DATE
echo "-----------------------------" >> /tmp/pre_check_$DATE
echo "Kernel version before patching">> /tmp/pre_check_$DATE
echo "-----------------------------">> /tmp/pre_check_$DATE
uname -r>> /tmp/pre_check_$DATE
echo "-----------------------------">> /tmp/pre_check_$DATE
echo "FileSystem usage">> /tmp/pre_check_$DATE
echo "-----------------------------">> /tmp/pre_check_$DATE
df -hT>> /tmp/pre_check_$DATE
echo "-----------------------------">> /tmp/pre_check_$DATE
echo "FSTAB entries">> /tmp/pre_check_$DATE
echo "-----------------------------">> /tmp/pre_check_$DATE
tail /etc/fstab>> /tmp/pre_check_$DATE
echo "-----------------------------">> /tmp/pre_check_$DATE
echo " IP Check ">> /tmp/pre_check_$DATE
echo "-----------------------------">> /tmp/pre_check_$DATE
iptables -L >> /tmp/pre_check_$DATE
echo "-----------------------------">> /tmp/pre_check_$DATE
echo "NTP | LOG rotation | IPTABLES check">> /tmp/pre_check_$DATE
echo "-----------------------------">> /tmp/pre_check_$DATE
ntpq -p >> /tmp/pre_check_$DATE
echo "-----------------------------">> /tmp/pre_check_$DATE

systemctl status rsyslog | grep Active  | awk '{print $1,$2}' >> /tmp/pre_check_$DATE
systemctl status ntpd | grep Active  | awk '{print $1,$2}' >> /tmp/pre_check_$DATE
systemctl status firewalld | grep Active  | awk '{print $1,$2}' >> /tmp/pre_check_$DATE
fi
echo "-----------------------------">> /tmp/pre_check_$DATE
echo "-----------netstat-----------">> /tmp/pre_check_$DATE
echo "-----------------------------">> /tmp/pre_check_$DATE
netstat -tunlp | grep LISTEN >> /tmp/pre_check_$DATE
echo "-----------------------------">> /tmp/pre_check_$DATE
echo "-----------selinux-----------">> /tmp/pre_check_$DATE
echo "-----------------------------">> /tmp/pre_check_$DATE
sestatus>> /tmp/pre_check_$DATE
echo "-----------------------------">> /tmp/pre_check_$DATE

ps -ef | grep [p]mon 1>/dev/null 
db=$?
if [ $db == 0 ];then
echo "DB running on the server"
else
echo "No DB running "
fi
ps -ef | grep [m]ysql 1>/dev/null
my=$?
if [ $my == 0 ];then
echo "MYSQL running on the server"
else
echo "No MYSQL running "
fi
