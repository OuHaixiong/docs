#!/bin/bash
echo 'Dump database start...';
#nowTime=`date +%Y%m%d_%H%M%S`;
sqlName="edu_wordpress.sql";
/usr/local/mysql/bin/mysqldump --add-drop-table -uroot -proot -R -E --triggers edu_wordpress > /mnt/resource/backup/${sqlName}
echo 'Dump database finished!!!!';
echo 'Send email start...';
/usr/bin/php /mnt/resource/backup/sendEmail.php
echo 'Send email end!!!!';