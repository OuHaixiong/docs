#!/bin/bash

# 安装包根目录
toolsPath='/data/tools';
nginxFileName='nginx-1.17.1';
redisFileName='redis-5.0.5';
phpFileName='php-7.2.22';
imageMagickFileName='ImageMagick-6.9.2-4';

yum -y install git make pcre pcre-devel gcc gcc-c++ autoconf libjpeg libjpeg-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5-devel libidn libidn-devel openssl openssl-devel openldap openldap-devel openldap-clients openldap-servers gd gd-devel vim-minimal zip unzip file libpng.x86_64 libpng-devel.x86_64 libpng-static.x86_64 vim-enhanced postgresql-devel

cd ${toolsPath};

echo 'Start install libevent、libiconv、libmcrypt、mhash、mcrypt......';

tar -zxvf libevent-2.0.21-stable.tar.gz
cd libevent-2.0.21-stable
./configure && make && make install

cd ${toolsPath};
tar -zxvf libiconv-1.14.tar.gz
cd libiconv-1.14
./configure && make 
# 上面会报错，所以就需要再执行一遍，不make又不会出这个文件
rm -rf './srclib/stdio.h'
cp ${toolsPath}'/stdio.h' './srclib/stdio.h'
make && make install

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

ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx
mkdir -p /usr/local/nginx/conf/vhost
cd ${toolsPath};
cp -r 'nginx.conf' '/usr/local/nginx/conf/nginx.conf'

echo 'nginx is complete!!!!';

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

echo 'redis is complete!!!!';

echo 'Start install PHP......';

cd ${toolsPath};
tar -zxf ${phpFileName}'.tar.gz';
cd ${phpFileName}
# 如果没有用到bcmath相关函数，就不需要开启
./configure --prefix=/usr/local/php --with-mysqli=mysqlnd --with-pdo_mysql=mysqlnd --with-pgsql --with-pdo_pgsql --with-openssl --enable-opcache --enable-fpm --enable-mbstring --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-bz2 --with-libxml-dir=/usr --enable-xml --with-iconv=/usr/local/lib --with-curl --with-gd --with-mhash --enable-pcntl --enable-sockets  --enable-zip --enable-soap --enable-bcmath
make && make install
#mkdir -p /tmp/php_session # 这个不用改了
cp ${toolsPath}'/php.ini' '/usr/local/php/lib/php.ini'
mv /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf
cp ${toolsPath}'/php-fpm.conf' '/usr/local/php/etc/php-fpm.d/php-fpm.conf'
cp ${toolsPath}'/phpinfo.php' '/usr/local/nginx/html/phpinfo.php'
ln -s /usr/local/php/bin/php /usr/bin/php

# 安装php相关扩展
echo 'Start install php extension : redis......';
cd ${toolsPath}
unzip phpredis-develop-php7.zip
cd phpredis-develop/
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config
make && make install
echo "extension=/usr/local/php/lib/php/extensions/no-debug-non-zts-20170718/redis.so" >> /usr/local/php/lib/php.ini

echo 'Install php extension : redis complete!!!!';
echo 'Start install php extension : imagick......';

cd ${toolsPath};
tar -zxf ${imageMagickFileName}'.tar.gz';
cd  ${imageMagickFileName}
./configure --prefix=/usr/local/imagemagick
make && make install
ldconfig

cd ${toolsPath};
tar -zxf imagick-3.4.4.tgz
cd imagick-3.4.4
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config --with-imagick=/usr/local/imagemagick
make && make install
echo "extension=/usr/local/php/lib/php/extensions/no-debug-non-zts-20170718/imagick.so" >> /usr/local/php/lib/php.ini

cd ${toolsPath};
tar -zxf ghostscript-9.27-linux-x86_64.tgz
cd ghostscript-9.27-linux-x86_64
cp gs-927-linux-x86_64 /usr/bin/gs

echo 'Install php extension : imagick complete!!!!';
echo 'Start install php extension : rdkafka......';

cd ${toolsPath};
git clone https://github.com/edenhill/librdkafka.git
cd librdkafka/
./configure
make && make install

cd ${toolsPath};
git clone https://github.com/arnaud-lb/php-rdkafka.git
cd php-rdkafka/
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config
make all -j 5
make install
echo "extension=/usr/local/php/lib/php/extensions/no-debug-non-zts-20170718/rdkafka.so" >> /usr/local/php/lib/php.ini

echo 'Install php extension : rdkafka complete!!!!';
echo 'Install php extension : mongodb......';

cd ${toolsPath};
tar -zxvf mongodb-1.5.3.tgz
cd mongodb-1.5.3
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config
make && make install
echo "extension=/usr/local/php/lib/php/extensions/no-debug-non-zts-20170718/mongodb.so" >> /usr/local/php/lib/php.ini

echo 'Install php extension : mongodb complete!!!!';


# 加入开机启动
chmod a+x /etc/rc.d/rc.local;
echo '/usr/local/redis/bin/redis-server /usr/local/redis/etc/redis.conf' >> /etc/rc.local;
echo '/usr/local/nginx/sbin/nginx' >> /etc/rc.local;
echo '/usr/local/php/sbin/php-fpm' >> /etc/rc.local;
echo 'Add /etc/rc.local is complete!!!!';



echo 'Start servers!!!!';

/usr/local/redis/bin/redis-server /usr/local/redis/etc/redis.conf
/usr/local/nginx/sbin/nginx
/usr/local/php/sbin/php-fpm

echo 'Start servers is complete!!!!';


