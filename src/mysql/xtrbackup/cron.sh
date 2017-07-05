0 1 * * 0 bash +x /mvtech/backup/script/fullBackup.sh >> /mvtech/backup/log/fullBackup.log 2>&1 
0 1 * * 1,2,3,4,5,6  bash +x /mvtech/backup/script/incremental.sh /mvtech/backup/log/incremental.log 2>&1
0 1 * * * bash +x /mvtech/backup/script/gz.sh >> /mvtech/backup/log/gz.log 2>&1
