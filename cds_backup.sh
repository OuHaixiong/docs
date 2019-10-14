#!/bin/sh
db_user="postgres"
db_passwd="4Oi@hypxVCs0"
db_host="127.0.0.1"
db_port="9094"
datetime="$(date +"%Y%m%d")"
backup_dir="/home/databak/pgsql/$datetime"
time="$(date +%Y%m%d%H%M)"
PGSQLDUMP="/usr/local/pgsql/bin/pg_dump"
export PGPASSWORD=$db_passwd
mkdir -p -m 755 $backup_dir
test ! -w $backup_dir && echo "Error: $backup_dir is un-writeable." && exit 0
for db in cds_sf ccs cds datav exam logistics sys_360 sys_cas sys_cost sys_crm sys_edi sys_sysoms test_ccs test_cds test_zz zz upscdas
do
        $PGSQLDUMP -h$db_host -p $db_port -U $db_user --clean --format t --verbose --file $backup_dir/$time.$db.tar $db 
done


#删除7天以前的备份
find /home/databak/pgsql/ -name "*.tar" -mtime +7 |xargs rm -rf
find /home/databak/pgsql/ -type d -empty |xargs rm -rf
exit 0;
