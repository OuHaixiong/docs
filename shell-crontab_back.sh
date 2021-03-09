#!/bin/bash
# crontab 里面的内容备份到某个目录下，并按-年-月-日进行存储
/usr/bin/crontab -l>/mnt/backup/cron/cron-`date +%Y-%m-%d`
# 找到某个目录下，符合条件的文件，并且修改时间是15天前的文件，进行删除处理（即保留16个文件，16天的）
find /mnt/backup/cron -name "*" -mtime +15 |xargs rm -rf