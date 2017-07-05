HISTFILESIZE=2000000
HISTSIZE=200000000
HISTTIMEFORMAT="%Y%m%d-%H%M%S: "
export HISTTIMEFORMAT
iphost=`/sbin/ifconfig|awk -F'[ :]+' 'NR==2 {print $4}'`
export PROMPT_COMMAND='{ command=$(history 1 | { read x y; echo $y; }); logger -p local5.notice -t bash -i "ip=$iphost,user=$USER,ppid=$PPID,from=$SSH_CLIENT,pwd=$PWD,command:$command"; }'


#批量追加
ansible 144 -m shell -a "echo "HISTFILESIZE=2000000" >> /etc/profile"
ansible 144 -m shell -a "echo "HISTSIZE=200000000" >> /etc/profile"
ansible 144 -m shell -a "echo "HISTTIMEFORMAT="%Y%m%d-%H%M%S: "" >> /etc/profile"
ansible 144 -m shell -a "echo "export HISTTIMEFORMAT" >> /etc/profile"
ansible 144 -m shell -a "echo "iphost=`/sbin/ifconfig|awk -F'[ :]+' 'NR==2 {print $4}'`" >> /etc/profile"
ansible 144 -m shell -a "echo "export PROMPT_COMMAND='{ command=$(history 1 | { read x y; echo $y; }); logger -p local5.notice -t bash -i "ip=$iphost,user=$USER,ppid=$PPID,from=$SSH_CLIENT,pwd=$PWD,command:$command"; }'" >> /etc/profile"

#iphost=`ip r l |cut -d' ' -f12`


ansible rsyslog -m shell -a 'wget -P /root/ http://10.0.242.66/syslog.txt'
ansible rsyslog -m shell -a "cat /root/syslog.txt >> /etc/profile" -f 100
ansible rsyslog -m shell -a "source /etc/profile"
ansible rsyslog -m shell -a 'echo "local5.*  @192.168.84.45" >> /etc/rsyslog.conf' -f 100
ansible rsyslog -m shell -a 'service rsyslog restart'

服务器端：
local5.* /var/log/history.log


10.0.240.158 | FAILED => FAILED: timed out


59 23 * * * /usr/sbin/logrotate -f /etc/logrotate.conf


59 23 * * * /usr/sbin/logrotate -f /etc/logrotate.conf
59 23 * * * bash +x /data/syslog/script/last.sh
00 01 * * * bash +x /data/syslog/script/upload.sh

#!/bin/sh
/usr/bin/ansible rsyslog -m shell -a "last -F" -f 100 > /data/syslog/last.log
