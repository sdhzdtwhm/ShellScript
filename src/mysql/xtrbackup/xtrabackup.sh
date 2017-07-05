#innobackupex使用方法
#使用stream备份
#使用tar打包
innobackupex --stream=tar --host=192.168.2.203 --user=root --password=mvtech123  --parallel=4 --throttle=400  /mvtech/mysql/data > /mvtech/backup/file/bak.tar
#解压tar包
tar -xivf 20170620.tar -C /backup/bak
#使用gz打包
innobackupex --host=192.168.2.203 --user=root --password=mvtech123 --parallel=4 --throttle=400  --stream=tar /mvtech/mysql/data |gzip> /mvtech/backup/file/bak.tar.gz
#解压gz包
tar -xizvf 20170621.tar.gz -C bakz/
#sshpass远程拷贝
sshpass -p 'Mvtech@123!' scp -o StrictHostKeyChecking=no /mvtech/backup/gz/$today.tar root@192.168.2.136:/data/203/


#
#innobackupex全量备份
innobackupex --defaults-file=/etc/my.cnf --host=127.0.0.1 --user=root --password=mvtech123 --parallel=4 --throttle=400  /mvtech/backup/$base --no-timestamp
#基于增量备份
innobackupex --defaults-file=/etc/my.cnf --host=127.0.0.1 --user=root --password=mvtech123 --parallel=4 --throttle=400  --incremental /mvtech/backup --no-timestamp --incremental-basedir=/mvtech/backup/$base
#
innobackupex --host=127.0.0.1 --user=weihu --password=Mvtech123!@ --parallel=4 --throttle=400  --stream=tar /opt/diskarray/mysql3 |gzip> /opt/diskarray/backup/bak.tar.gz
/opt/diskarray/backup


12:25:46
12:32:55

12:37:30
12:44:25
