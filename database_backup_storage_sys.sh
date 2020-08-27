#!/bin/bash
echo 'Dump sys tables for storage , start...';
nowTime=`date +%Y%m%d_%H%M%S`;
# 前缀
prefix='web_sys_';
# 备份目录
backupDirectory='/data/db/database_backup/';
filename="${prefix}${nowTime}.sql";
# 备份某个数据库下的多个表
/usr/local/mysql/bin/mysqldump --add-drop-table -h192.167.11.100 -uroot -pqrNiqzKB -R -E --triggers storage_erp  web_sys_menu web_sys_page web_sys_page_field web_sys_table web_sys_table_field web_sys_widget_value > ${backupDirectory}${filename}
echo 'Dump sys tables for storage , finished!!!!';

# 删除7天前的数据
echo 'Delete files from seven days ago! Start...';
for i in `seq 7 12`
do
    dayAgo=`date -d "${i} days ago" +%Y%m%d`;
    deleteFiles="${prefix}${dayAgo}*";
    rm -rf ${backupDirectory}${deleteFiles};
done
echo 'Delete files from seven days age! Finished!!!!';
