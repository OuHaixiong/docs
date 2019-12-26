#!/bin/bash
host='xx.xxx.x.xxxx';
port='5432';
username='root';
password='123456';
databaseName='test_database';
savePath='/data/databaseBack';
datetime=`date +%Y%m%d%H%M%S`;
pgDumpPath='/usr/bin/pg_dump';

export PGPASSWORD=${password};
`${pgDumpPath} -h ${host} -p ${port} -U ${username} -Ft ${databaseName} > ${savePath}/${databaseName}_${datetime}.tar`;
echo 'pg dump Success!!';

cd ${savePath}
/usr/bin/tar -zcf ./${databaseName}_${datetime}.tar.gz ./${databaseName}_${datetime}.tar
echo 'tar Success!!';