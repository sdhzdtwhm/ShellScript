#!/bin/bash
#This script is xtrabackup full backup mysql
#The Author is mvtech by 2017

#格式化日期
today=$(date +%Y%m%d)
echo "--------------------------------------------------------"
echo "-------------------Today is $today----------------------"
echo "--------------------Start backup------------------------"
echo "--------------------------------------------------------"
#定义变量
lastDay=`date -d "-1 days" +%Y-%m-%d`
baseDir="/mvtech/backup/file/$today"
#创建备份文件夹
mkdir -p $baseDir
#全量备份
/usr/bin/innobackupex --defaults-file=/etc/my.cnf --host=127.0.0.1 --user=root --password=mvtech123 $baseDir --no-timestamp --parallel=8 --throttle=800 
#删除30天以前的备份
echo "---------删除30天以前的备份，时间为:`date +%Y%m%d`-------"
find /mvtech/backup/file/ -name "*" -mtime +30 -exec rm -f {} \;
