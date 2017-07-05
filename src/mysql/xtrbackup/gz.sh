#!/bin/bash
#This script is xtrabackup full backup mysql
# tar.gz and scp 192.168.2.136:/data/203

#格式化日期
today=$(date +%Y%m%d)
#全量备份
/usr/bin/innobackupex --host=192.168.2.203 --user=root --password=mvtech123 --parallel=4 --throttle=400 --stream=tar /mvtech/mysql/data |gzip> /mvtech/backup/gz/$today.tar.gz
#拷贝今天的全量备份
sshpass -p 'Mvtech@123!' scp -o StrictHostKeyChecking=no /mvtech/backup/gz/$today.tar.gz root@192.168.2.136:/data/203/
#删除今天的备份
rm -rf /mvtech/backup/gz/$today.tar.gz
