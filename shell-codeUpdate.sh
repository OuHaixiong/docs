#!/bin/sh

cdsLbPath='/mnt/data/www/cds_lb';

# 连接从机，先更新从机代码
ssh -tt slave_admin@10.0.0.5 <<EOF   # 连接上远程的服务器后需要执行的命令
if who | grep -q 'slave_admin'; then
    echo 'is logged on fedex-slave, next svn up...';
else
    echo 'is not logged on fedex-slave! svn up fail!!!!'
    exit 1
fi
cd ${cdsLbPath}
svn up
logout
EOF

# 本机（主机），更新代码
echo 'now at master_web, next svn up...';
cd  ${cdsLbPath}
svn up
