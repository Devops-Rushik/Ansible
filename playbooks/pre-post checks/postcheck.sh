# This script will compare with pre checks taken before any any activity and will show if any differences
# This script is used to take post checks after kernel upgrade, reboot or any maintanence window
# Should run precheck.sh before this script to provide correct output

#!/bin/bash
rm -f /tmp/post_check*
DATE=$(date '+%Y%m%d_%H%M%S')
clear
echo "-----------------------------">>/tmp/post_check_$DATE
date>>/tmp/post_check_$DATE
echo "-----------------------------">>/tmp/post_check_$DATE
echo "-----------------------------" >> /tmp/post_check_$DATE
echo "Kernel version after patching" >> /tmp/post_check_$DATE
echo "-----------------------------" >> /tmp/post_check_$DATE
uname -r >> /tmp/post_check_$DATE
echo "-----------------------------" >> /tmp/post_check_$DATE
echo "FileSystem usage">> /tmp/post_check_$DATE
echo "-----------------------------">> /tmp/post_check_$DATE
df -hT>> /tmp/post_check_$DATE
echo "-----------------------------">> /tmp/post_check_$DATE
echo "FSTAB entries">> /tmp/post_check_$DATE
echo "-----------------------------">> /tmp/post_check_$DATE
tail /etc/fstab>> /tmp/post_check_$DATE
echo "-----------------------------">> /tmp/post_check_$DATE
echo " IP Check ">> /tmp/post_check_$DATE
echo "-----------------------------">> /tmp/post_check_$DATE
ip r l >> /tmp/post_check_$DATE
echo "-----------------------------">> /tmp/post_check_$DATE
echo "NTP | LOG rotation | IPTABLES check">> /tmp/post_check_$DATE
echo "-----------------------------">> /tmp/post_check_$DATE
ntpq -p >> /tmp/post_check_$DATE
ntpq -c peers  -c associations >> /tmp/post_check_$DATE
echo "-----------------------------">> /tmp/post_check_$DATE
systemctl status rsyslog | grep Active  | awk '{print $1,$2}' >> /tmp/post_check_$DATE
systemctl status ntpd | grep Active  | awk '{print $1,$2}' >> /tmp/post_check_$DATE
systemctl status firewalld | grep Active  | awk '{print $1,$2}' >> /tmp/post_check_$DATE
fi
echo "-----------------------------">> /tmp/post_check_$DATE
echo "-----------netstat-----------">> /tmp/post_check_$DATE
echo "-----------------------------">> /tmp/post_check_$DATE
netstat -tunlp | grep LISTEN >> /tmp/post_check_$DATE
echo "-----------------------------">> /tmp/post_check_$DATE
echo "-----------selinux-----------">> /tmp/post_check_$DATE
echo "-----------------------------">> /tmp/post_check_$DATE
sestatus>> /tmp/post_check_$DATE
echo "-----------------------------">> /tmp/post_check_$DATE

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

diff -y /tmp/pre_check_* /tmp/post_check_$DATE -W 150 | sed -e "s/.*|.*/\x1b[44m&\x1b[0m/" -e "s/.*>.*/\x1b[44m&\x1b[0m/"
