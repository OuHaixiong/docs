username='XXX';
dir='/home/ftps/company/';
password='****';
homeDir=${dir}${username};

useradd ${username} -g www -s /sbin/nologin -d ${homeDir}
echo ${password}|passwd --stdin ${username}

echo ${username} >> /etc/vsftpd/user_list

cat>>/etc/vsftpd/userconfig/${username}<<EOF
local_root=${homeDir}
write_enable=YES
download_enable=YES
local_umask=002
EOF
