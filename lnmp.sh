#!/bin/bash

yum -y install make pcre pcre-devel gcc gcc-c++ autoconf libjpeg libjpeg-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5-devel libidn libidn-devel openssl openssl-devel openldap openldap-devel openldap-clients openldap-servers gd gd-devel vim-minimal zip unzip file libpng.x86_64 libpng-devel.x86_64 libpng-static.x86_64 vim-enhanced

toolPath='/data/tool';
cd ${toolPath};

echo 'Start install libevent、libiconv、libmcrypt、mhash、mcrypt......';
tar -zxvf libevent-2.0.21-stable.tar.gz
cd libevent-2.0.21-stable
./configure && make && make install

cd ${toolPath};
tar -zxvf libiconv-1.14.tar.gz
cd libiconv-1.14
./configure && make && make install

cd ${toolPath};
tar -zxvf libmcrypt-2.5.8.tar.gz
cd libmcrypt-2.5.8
./configure && make && make install

cd ${toolPath};
tar -zxvf mhash-0.9.9.9.tar.gz;
cd mhash-0.9.9.9;
./configure && make && make install

cd ${toolPath};
tar -zxvf mcrypt-2.6.8.tar.gz;
cd mcrypt-2.6.8;
`LD_LIBRARY_PATH=/usr/local/lib ./configure`
make && make install
echo 'libevent、libiconv、libmcrypt、mhash、mcrypt installation is complete!!!!';

echo 'Start install nginx......';
cd ${toolPath};
groupadd www
useradd -g www -s /bin/falsh -M www
tar -zxvf nginx-1.10.1.tar.gz
cd nginx-1.10.1
./configure --user=www --group=www --prefix=/usr/local/webserver/nginx --sbin-path=/usr/local/webserver/nginx/sbin/nginx  --conf-path=/usr/local/webserver/nginx/conf/nginx.conf  --with-http_stub_status_module  --with-http_ssl_module --with-pcre --with-http_gzip_static_module --lock-path=/var/run/nginx.lock --pid-path=/var/run/nginx.pid
make && make install
echo 'nginx is complete!!!!';


