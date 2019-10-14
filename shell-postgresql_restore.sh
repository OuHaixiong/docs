#!/bin/bash

export PGPASSWORD="***"
/usr/pgsql-9.6/bin/pg_restore -h XXX -p 5432 -U "username" -d database_name /mnt/data/database_back.pgdump