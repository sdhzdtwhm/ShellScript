#!/bin/bash
#The Script is use install zabbix-agentd

#获取本机ip地址定义成变量
ip=`/sbin/ifconfig eth0 | grep "inet addr" | awk -F'[ :]+' '{print $4}'`
echo $ip
#安装zabbix-agent
rpm -ivh /root/zabbix/zabbix-agent-2.4.8-1.el6.x86_64.rpm --nodeps
#备份之前的配置文件
mv /etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf.bak
#拷贝新的配置文件
cp /root/zabbix/zabbix_agentd.conf /etc/zabbix/
#替换hostname ip
sed -i "s/Hostname=192.168.10.40/Hostname=$ip/g" /etc/zabbix/zabbix_agentd.conf
#创建日志文件夹
mkdir -p /mvtech/nm/logs/Zabbix/logs/
#修改文件夹所属组
groupadd zabbix
useradd -g zabbix zabbix
chown -R zabbix:zabbix /mvtech/nm/logs/Zabbix/
#启动服务
service zabbix-agent start
#将服务设成开机启动
chkconfig zabbix-agent on
