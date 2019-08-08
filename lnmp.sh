#!/bin/bash

# 安装包根目录
toolsPath='/data/tools';
nginxFileName='nginx-1.17.1';
redisFileName='redis-5.0.5';

yum -y install make pcre pcre-devel gcc gcc-c++ autoconf libjpeg libjpeg-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5-devel libidn libidn-devel openssl openssl-devel openldap openldap-devel openldap-clients openldap-servers gd gd-devel vim-minimal zip unzip file libpng.x86_64 libpng-devel.x86_64 libpng-static.x86_64 vim-enhanced

cd ${toolsPath};

echo 'Start install libevent、libiconv、libmcrypt、mhash、mcrypt......';

tar -zxvf libevent-2.0.21-stable.tar.gz
cd libevent-2.0.21-stable
./configure && make && make install

cd ${toolsPath};
tar -zxvf libiconv-1.14.tar.gz
cd libiconv-1.14
./configure && make && make install

cd ${toolsPath};
tar -zxvf libmcrypt-2.5.8.tar.gz
cd libmcrypt-2.5.8
./configure && make && make install

cd ${toolsPath};
tar -zxvf mhash-0.9.9.9.tar.gz;
cd mhash-0.9.9.9;
./configure && make && make install

cd ${toolsPath};
tar -zxvf mcrypt-2.6.8.tar.gz;
cd mcrypt-2.6.8;
`LD_LIBRARY_PATH=/usr/local/lib ./configure`
make && make install

echo 'libevent、libiconv、libmcrypt、mhash、mcrypt installation is complete!!!!';

echo 'Start install nginx......';

cd ${toolsPath};
groupadd www
useradd -g www -s /bin/falsh -M www
tar -zxvf ${nginxFileName}'.tar.gz'
cd ${nginxFileName}
./configure --user=www --group=www --prefix=/usr/local/nginx --sbin-path=/usr/local/nginx/sbin/nginx  --conf-path=/usr/local/nginx/conf/nginx.conf  --with-http_stub_status_module  --with-http_ssl_module --with-pcre --with-http_gzip_static_module --lock-path=/var/run/nginx.lock --pid-path=/var/run/nginx.pid
make && make install

echo 'nginx is complete!!!!';

ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx
mkdir -p /usr/local/nginx/conf/vhost
cd ${toolsPath};
cp -r ${nginxFileName}'.conf' '/usr/local/nginx/conf/nginx.conf'

echo 'Start install redis......';

cd ${toolsPath};
tar -zxvf ${redisFileName}'.tar.gz'; 
cd ${redisFileName}
make && make install
mkdir -p /usr/local/redis/{bin,etc,var}
ln -s /usr/local/bin/redis-* /usr/local/redis/bin/
mkdir -p /data/db/redis
mkdir -p /data/logs/redis
cd ${toolsPath};
cp -r ${redisFileName}'.conf' '/usr/local/redis/etc/redis.conf'
/usr/local/redis/bin/redis-server /usr/local/redis/etc/redis.conf

echo 'redis is complete!!!!';

# 加入开机启动
