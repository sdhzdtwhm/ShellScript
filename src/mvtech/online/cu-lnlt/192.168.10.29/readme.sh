#!/bin/bash
#192.168.10.29服务器上的脚本介绍如下：
#1.使用mysqldump 定时导出isms库、cdh1、cdh2、cdh3四个数据库
#脚本路径：/mvtech/mysql-backup/script
#定时任务如下：
00 1 * * * bash +x /mvtech/mysql-backup/script/isms.sh
10 1 * * * bash +x /mvtech/mysql-backup/script/cdh1.sh
20 1 * * * bash +x /mvtech/mysql-backup/script/cdh2.sh
30 1 * * * bash +x /mvtech/mysql-backup/script/cdh3.sh
#2.每天会接收到从192.168.10.12上传输过来的xtrabackup的备份库，并定期删除规定期限之前的备份文件
#定时任务如下：
40 1 * * * bash +x /mvtech/mysql-backup/script/del.sh