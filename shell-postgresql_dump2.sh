#!/bin/sh
db_user="***"
db_passwd="XXX"
db_host="127.0.0.1"
db_port="9095"
datetime="$(date +"%Y%m%d")"
backup_dir="/data/xxx/$datetime"
time="$(date +%Y%m%d%H%M)"
pgDumpPath="/usr/local/pgsql/bin/pg_dump"
export PGPASSWORD=$db_passwd
mkdir -p -m 755 $backup_dir
test ! -w $backup_dir && echo "Error: $backup_dir is un-writeable." && exit 0
for db in XXX XX xxxx
do
    $pgDumpPath -h$db_host -p $db_port -U $db_user --clean --format c --verbose --file $backup_dir/$time.$db.tar $db
done
echo 'database dump sucess!!';

# 对应的恢复语句
/usr/local/pgsql/bin/pg_restore -h XXX.xx.XXXX.xx -p 5432 -U user -c -d databaseName -v "/xx/xxx/x.tar" --jobs=4 -O --disable-triggers -W
