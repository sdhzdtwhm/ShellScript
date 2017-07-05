#!/bin/sh

##################################################################
#  此脚本适用于微智信业CU系统Mysql数据库isms的备份
#  Mysql定时备份 crontab    root 用户,创建执行脚本
##################################################################

#备份根路径
dbBackupPath="/mvtech/mysql-backup/backup/"
#备份日志路径
dbBackupLogsPath="/mvtech/mysql-backup/logs/"
#获取当前月份
MONTH=`date +%Y%m`
#完整备份路径dbBackupPath
dbBackupFullPath=$dbBackupPath$MONTH

#这里的-d 参数判断$dbBackupFullPath是否存在
if [ ! -d "$dbBackupFullPath" ]
then
    mkdir -p "$dbBackupFullPath"
fi
#数据库服务器IP
DB_IP="192.168.10.13"
#数据库名称
DB_NAME="isms"
#用户名
DB_USER="root"
#密码
DB_PASS="mvtech123"
#Mysql执行目录
#BIN_DIR="/usr/bin"
#获取当前时间
DATE=`date +%Y%m%d_%H%M%S`

echo "----------------------Mysql backup start! $DATE  ----------------------------">>$dbBackupLogsPath/isms.log

#删除30天以前的备份

echo "----------------------删除30天以前的备份，时间为:`date +%Y%m%d_%H%M%S`-------">>$dbBackupLogsPath/isms.log

find $dbBackupPath -name "*.gz" -mtime +30 -exec rm -f {} \;

#开启 gzip 压缩,一般来说可以实现10倍压缩比例

#备份指定库

echo "----------------------备份isms开始，时间为:`date +%Y%m%d_%H%M%S`  -----------">>$dbBackupLogsPath/isms.log

mysqldump --opt -h$DB_IP -u$DB_USER -p$DB_PASS $DB_NAME | gzip > $dbBackupFullPath/isms_$DATE.sql.gz

echo "----------------------备份isms结束，时间为:`date +%Y%m%d_%H%M%S`-------------">>$dbBackupLogsPath/isms.log

END_DATE=`date +%Y%m%d_%H%M%S`

echo "----------------------Mysql backup done! $END_DATE --------------------------">>$dbBackupLogsPath/isms.log

