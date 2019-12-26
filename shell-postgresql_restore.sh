#!/bin/bash
host='127.0.0.1';
port='9095';
username='postgres';
password='****';
databaseName='XXX';
backupPath='/home/ouhaixiong/XXX_20191110192226.tar';
pgRestorePath='/usr/local/pgsql/bin/pg_restore';

export PGPASSWORD=${password};
`${pgRestorePath} -h ${host} -p ${port} -U "${username}" -d ${databaseName} ${backupPath}`;
echo 'pg restore Sucess!!';
