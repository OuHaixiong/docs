#!/bin/bash
username='XXX';
# 家目录的上级目录，后面必须带/
dir='/home/ftps/company/';
password='****';
homeDir=${dir}${username};

mkdir -p ${homeDir}
mkdir -p ${homeDir}/attachment/files;

useradd ${username} -g www -s /sbin/nologin -d ${homeDir}
chown -R ${username}.www ${homeDir}
chmod -R 0777 ${homeDir}

# 设置密码，--stdin 表示输入
echo ${password}|passwd --stdin ${username}

# 追加写入用户名
echo ${username} >> /etc/vsftpd/user_list

# 写入多行
cat>>/etc/vsftpd/userconfig/${username}<<EOF
local_root=${homeDir}
write_enable=YES
download_enable=YES
local_umask=002
EOF

echo 'FTP账号已开通！！！！';