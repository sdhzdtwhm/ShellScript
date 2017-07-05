#!/bin/bash

function main()
{
    for var in vc/*
        do
            echo $var
			time=`stat $var | grep -i Modify | awk -F. '{print $1}' | awk '{print $2$3}'| awk -F- '{print $1$2$3}' | awk -F: '{print $1$2$3}'`
			time1=${time:0:8}
			echo $time1
			if [ -d $time1/vc ]; then
                cp -p $var $time1/vc/
            else
                mkdir -p $time1/vc/
                cp -p $var $time1/vc/
            fi
        done
	for var in vd/*
        do
            echo $var
			time=`stat $var | grep -i Modify | awk -F. '{print $1}' | awk '{print $2$3}'| awk -F- '{print $1$2$3}' | awk -F: '{print $1$2$3}'`
			time1=${time:0:8}
			echo $time1
			if [ -d $time1/vd ]; then
                cp -p $var $time1/vd/
            else
                mkdir -p $time1/vd/
                cp -p $var $time1/vd/
            fi
        done
	for var in sv/*
        do
            echo $var
			time=`stat $var | grep -i Modify | awk -F. '{print $1}' | awk '{print $2$3}'| awk -F- '{print $1$2$3}' | awk -F: '{print $1$2$3}'`
			time1=${time:0:8}
			echo $time1
			if [ -d $time1/sv ]; then
                cp -p $var $time1/sv/
            else
                mkdir -p $time1/sv/
                cp -p $var $time1/sv/
            fi
        done

	rm -rf vc
	rm -rf vd
	rm -rf sv
	
	today=`date +%Y%m%d`
	echo $today
	rm -rf $today
}

main
