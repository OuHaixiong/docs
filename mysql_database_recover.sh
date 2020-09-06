#!/bin/bash
# 恢复数据库
echo 'Recover all database start...';
/usr/local/mysql/bin/mysql -h127.0.0.1 -uXXXX -p****** [erp] < /data/db/database_backup/erp_all_20200812_104620.sql
echo 'Recover all database finished!!!!';