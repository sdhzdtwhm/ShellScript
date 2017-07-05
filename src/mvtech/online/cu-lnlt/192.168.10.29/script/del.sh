#!/bin/bash
#This Script is del 192.168.10.12 xtrabackup 

find /mvtech/backup/ -name "*.gz" -mtime +7 -exec rm -f {} \;
