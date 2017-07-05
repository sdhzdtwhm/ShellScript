#!/bin/bash
#定义jdk安装路径
base="/data/mysql/"
#这里的-d 参数判断$base是否存在
if [ ! -d "$base" ]
then
    mkdir -p "$base"
fi
tar -xvf jdk-7u80-linux-x64.gz -C /data/java
sed -i '$a export JAVA_HOME=/data/java/jdk1.7.0_80' /etc/profile
sed -i '$a export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar' /etc/profile
sed -i '$a export PATH=$JAVA_HOME/bin:$PATH' /etc/profile