#!/bin/bash
username='XXX';
dir='/home/ftps/company/';
password='****';
homeDir=${dir}${username};

mkdir -p ${homeDir}

useradd ${username} -g www -s /sbin/nologin -d ${homeDir}
chown -R ${username}.www ${homeDir}
chmod -R 0777 ${homeDir}

echo ${password}|passwd --stdin ${username}

echo ${username} >> /etc/vsftpd/user_list

cat>>/etc/vsftpd/userconfig/${username}<<EOF
local_root=${homeDir}
write_enable=YES
download_enable=YES
local_umask=002
EOF

echo 'FTP账号已开通！！！！';