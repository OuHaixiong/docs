#!/bin/bash
echo 'Dump all database start...';
nowTime=`date +%Y%m%d_%H%M%S`;
# 前缀
prefix='all_';
# 备份目录
backupDirectory='/data/database_backup/';
filename="${prefix}${nowTime}.sql";
# 备份某个数据库，如果想备份多个数据库的话：
# /usr/local/mysql/bin/mysqldump --databases --add-drop-table -h192.167.11.100 -uroot -pqrNiqzKB -R -E --triggers  database1 database2 > ${backupDirectory}${filename}
#/usr/local/mysql/bin/mysqldump --add-drop-table -h192.167.11.100 -uroot -p*** -R -E --triggers erp > /data/db/database_backup/erp_${filename}
/usr/local/mysql/bin/mysqldump --all-databases  --add-drop-table -h127.0.0.1 -uroot -pXXXX -R -E --triggers > ${backupDirectory}${filename} # 备份所有的数据库
# -R:备份存储过程和函数；-E：备份事件；--triggers：备份触发器
echo 'Dump all database finished!!!!';

# 删除7天前的数据
echo 'Delete files from seven days ago! Start...';
for i in `seq 7 12`
do
    dayAgo=`date -d "${i} days ago" +%Y%m%d`;
    deleteFiles="${prefix}${dayAgo}*";
    rm -rf ${backupDirectory}${deleteFiles};
done
echo 'Delete files from seven days age! Finished!!!!';

 

