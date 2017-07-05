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
baseDir="/data/backup/file/$today"
remoteIP="192.168.81.249"
remoteUser="weihu"
remotePassword="Mvtech123!@"
remoteDB="blxx_mobile"
localIP="127.0.0.1"
localUser="weihu"
localPassword="Mvtech123!@"
localDB="blxx_mobile"
sql="INSERT INTO blxx_mobile.mydumper(name) VALUES ('blxx')"
echo "开始创建备份文件夹;时间为:`date +%Y%m%d-%H:%M:%S`"		> /data/backup/log/blxx-$today.log
mkdir -p $baseDir
echo "开始使用mydumper进行备份;时间为:`date +%Y%m%d-%H:%M:%S`" >> /data/backup/log/blxx-$today.log
/usr/local/bin/mydumper -h $remoteIP -u $remoteUser -p $remotePassword -t 8 -B $remoteDB -o $baseDir
echo "开始使用myloader进行装载;时间为:`date +%Y%m%d-%H:%M:%S`" >> /data/backup/log/blxx-$today.log
/usr/local/bin/myloader -u $localUser -p $localPassword -h $localIP -t 16 -q 10000 -o -B $localDB -d $baseDir
echo "数据装载完毕，时间为:`date +%Y%m%d-%H:%M:%S`"			>> /data/backup/log/blxx-$today.log
echo "sql记录装载时间，时间为:`date +%Y%m%d-%H:%M:%S`"			>> /data/backup/log/blxx-$today.log
/usr/bin/mysql -h$localIP -u$localUser -p$localPassword -e "${sql}"
echo "sql记录完毕，时间为:`date +%Y%m%d-%H:%M:%S`"			>> /data/backup/log/blxx-$today.log
echo "删除3天前的备份，时间为:`date +%Y%m%d-%H:%M:%S`"			>> /data/backup/log/blxx-$today.log
find /data/backup/file/ -name "*" -mtime +3 -exec rm -f {} \;
echo "删除3天前的备份，时间为:`date +%Y%m%d-%H:%M:%S`"			>> /data/backup/log/blxx-$today.log
echo "灾备数据库执行完毕，时间为:`date +%Y%m%d-%H:%M:%S`"