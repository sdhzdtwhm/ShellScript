#!/bin/bash
#The Script is use mydumper backup mysql
#The Author is yanghang by 2017

#格式化日期
today=$(date +%Y%m%d)
echo "--------------------------------------------------------"
echo "-------------------Today is $today----------------------"
echo "--------------------Start backup------------------------"
echo "--------------------------------------------------------"
#定义变量
baseDir1="/mvtech/backup/mydumper/192.168.10.38/net_manager/$today"
baseDir2="/mvtech/backup/mydumper/192.168.10.38/zabbix/$today"
remoteIP="192.168.10.38"
remoteUser="root"
remotePassword="mvtech123"
remoteDB1="net_manager"
remoteDB2="zabbix"
echo "开始创建备份文件夹;时间为:`date +%Y%m%d-%H:%M:%S`"		> /mvtech/backup/log/38.log
mkdir -p $baseDir1
mkdir -p $baseDir2
echo "开始使用mydumper进行备份;时间为:`date +%Y%m%d-%H:%M:%S`" >> /mvtech/backup/log/38.log
/usr/local/mydumper/bin/mydumper -h $remoteIP -u $remoteUser -p $remotePassword -t 8 -B $remoteDB1 -o $baseDir1
/usr/local/mydumper/bin/mydumper -h $remoteIP -u $remoteUser -p $remotePassword -t 8 -B $remoteDB2 -o $baseDir2
echo "mydumper备份结束;时间为:`date +%Y%m%d-%H:%M:%S`" >> /mvtech/backup/log/38.log
echo "删除15天前的备份，时间为:`date +%Y%m%d-%H:%M:%S`"			>> /mvtech/backup/log/38=.log
find /mvtech/backup/mydumper/192.168.10.38/net_manager/ -name "*" -mtime +3 -exec rm -f {} \;
find /mvtech/backup/mydumper/192.168.10.38/zabbix/ -name "*" -mtime +3 -exec rm -f {} \;
echo "删除15天前的备份，时间为:`date +%Y%m%d-%H:%M:%S`"			>> /mvtech/backup/log/38.log