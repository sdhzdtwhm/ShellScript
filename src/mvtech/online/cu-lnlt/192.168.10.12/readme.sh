#!/bin/bash
#192.168.10.12服务器上的脚本介绍如下：
#1.使用xtrabackup工具热备mysql库
#备份策略周日全量备份，周一到周六增量备份
#备份脚本地址：/mvtech/backup/script
0 1 * * 0 bash +x /mvtech/backup/script/fullBackup.sh >> /mvtech/backup/log/fullBackup.log 2>&1 
0 1 * * 1,2,3,4,5,6  bash +x /mvtech/backup/script/incremental.sh /mvtech/backup/log/incremental.log 2>&1
#2.使用xtrabackup每天全量备份并传输至192.168.10.29服务器
#定时任务：
0 1 * * * bash +x /mvtech/backup/script/gz.sh >> /mvtech/backup/log/gz.log 2>&1
