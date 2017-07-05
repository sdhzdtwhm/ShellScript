#!/bin/bash
#The Script is use mydumper backup mysql examples
#The Author is yanghang by 2017

#mydumper使用：远程备份主机上的blxx_mobile库到本机/data目录下
mydumper -h 192.168.81.249 -u weihu -p 'Mvtech123!@' -t 8 -B blxx_mobile -o /data/blxx_mobile
#删除之前备份库
/usr/bin/mysql -h127.0.0.1 -uweihu -p'Mvtech123!@' -e 'drop database test1'
#创建数据库
/usr/bin/mysql -h127.0.0.1 -uweihu -p'Mvtech123!@' -e 'CREATE DATABASE `blxx_mobile` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci'
#myloader使用：将备份的数据库装载到本机
myloader -u weihu -p 'Mvtech123!@' -h 127.0.0.1 -t 16 -q 3000 -o -B blxx_mobile -d /data/backup/file/blxx_mobile
