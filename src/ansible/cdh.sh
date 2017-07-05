#!/bin/bash
#The Script is use mydumper backup mysql
#The Author is yanghang by 2017

1.关闭防火墙
ansible cdh2 -m shell -a "service iptables stop" -f 100
ansible cdh2 -m shell -a "chkconfig iptables off" -f 100
2.关闭selinux
ansible cdh2 -m shell -a "sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config" -f 100
3.配置hosts
ansible cdh2 -m shell -a "mv /etc/hosts /etc/hosts.bak" -f 100
ansible cdh2 -m copy -a "src=/var/www/html/file/hosts dest=/etc/ owner=root group=root mode=0644" -f 100

--之前的主机
ansible cdh -m copy -a "src=/var/www/html/file/hosts1 dest=/root/ owner=root group=root mode=0644" -f 100
ansible cdh -m shell -a "cat /root/hosts1 >> /etc/hosts" -f 100

-- 4.配置yum 可以连接外网  未操作
ansible cdh2 -m shell -a "rm -rf /etc/yum.repos.d/*" -f 100
ansible cdh2 -m copy -a "src=/var/www/html/http.repo dest=/etc/yum.repos.d/ owner=root group=root mode=0644" -f 100

5.优化参数
# /etc/security/limits.conf
ansible cdh2 -m shell -a 'echo "* soft nproc 2047" >> /etc/security/limits.conf' -f 100
ansible cdh2 -m shell -a 'echo "* hard nproc 16384" >> /etc/security/limits.conf' -f 100
ansible cdh2 -m shell -a 'echo "* soft nofile 65500" >> /etc/security/limits.conf' -f 100
ansible cdh2 -m shell -a 'echo "* hard nofile 65500" >> /etc/security/limits.conf' -f 100

# /etc/sysctl.conf
ansible cdh2 -m shell -a 'echo "net.ipv4.ip_local_port_range = 9000 65500" >> /etc/sysctl.conf' -f 100
ansible cdh2 -m shell -a "echo 'vm.swappiness = 10' >> /etc/sysctl.conf"
ansible cdh2 -m shell -a '/sbin/sysctl -p' -f 100

ansible cdh2 -m shell -a 'uptime' -f 100
6.时钟同步
ansible cdh2 -m shell -a 'mv /etc/ntp.conf /etc/ntp.conf.bak' -f 100
ansible cdh2 -m copy -a "src=/var/www/html/file/ntp.conf dest=/etc/ owner=root group=root mode=0644" -f 100
ansible cdh2 -m shell -a 'ntpdate 192.168.1.145' -f 100
ansible cdh2 -m shell -a 'service ntpd start' -f 100
ansible cdh2 -m shell -a 'chkconfig ntpd on' -f 100
7.配置主机互信
-- 各服务器执行ssh-keygen
ansible cdh2 -m shell -a "ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa" -f 100
-- 生成authorized_keys文件
ansible cdh2 -m shell -a "cat /root/.ssh/id_rsa.pub" -f 100 > /tmp/authorized_keys
-- 去除多余的行
sed -i '/SUCCESS/d' /tmp/authorized_keys
-- 分发authorized_keys至每台服务器
ansible cdh2 -m copy -a "src=/var/www/html/file/authorized_keys dest=/root/.ssh/ owner=root group=root mode=0644" -f 100
-- 给其他服务器追加
ansible cdh -m copy -a "src=/tmp/authorized_keys dest=/tmp/ owner=root group=root mode=0644" -f 100
ansible cdh -m shell -a "cat /tmp/authorized_keys >> /root/.ssh/authorized_keys" -f 100

8.配置jdk
ansible cdh2 -m copy -a "src=/root/jdk dest=/root/ owner=root group=root mode=0777" -f 100
ansible cdh2 -m shell -a "/root/jdk/install.sh" -f 100
9.
拷贝agent：
ansible cdh2 -m copy -a "src=/opt/cm-5.6.1.tar dest=/root/ owner=root group=root mode=0700" -f 100
ansible cdh2 -m shell -a "tar -xvf /root/cm-5.6.1.tar -C /opt" -f 100
ansible cdh2 -m shell -a 'useradd --system --home=/opt/cm-5.6.1/run/cloudera-scm-server/ --no-create-home --shell=/bin/false --comment "Cloudera SCM User" cloudera-scm' -f 100

#启动agent节点
/opt/cm-5.6.1/etc/init.d/cloudera-scm-agent start
/opt/cm-5.6.1/etc/init.d/cloudera-scm-agent stop
#查看启动日志
tail -f /opt/cm-5.6.1/log/cloudera-scm-agent/cloudera-scm-agent.log