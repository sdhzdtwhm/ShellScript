#!/bin/bash
#This Script is for mvtech cu init linux
#The Author is yanghang by 2017
#关闭防火墙
echo '关闭防火墙'
service iptables stop
echo '关闭防火墙开机启动'
chkconfig iptables off
#关闭selinux
echo '关闭selinux'
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
#添加优化参数 cdh 需要配置
sed -i '$a vm.swappiness = 10' /etc/sysctl.conf
#修改limit.conf
sed -i '$a * soft nofile 65500 ' /etc/security/limits.conf
sed -i '$a * hard nofile 65500 ' /etc/security/limits.conf
sed -i '$a * soft nproc 65500 ' /etc/security/limits.conf
sed -i '$a * hard nproc 65500 ' /etc/security/limits.conf
#修改/etc/pam.d/login
sed -i '$a session	required	/lib/security/pam_limits.so' /etc/pam.d/login