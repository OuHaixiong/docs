#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
if [ $(id -u) != "0" ]; then
    echo "Error: Please use root to install it"
    exit 1
fi
if [ ! -s /etc/redhat-release ];then
        echo "Error:Please user a redhat release version"
        exit 1
fi
sys_long_bit=$(getconf LONG_BIT)
if [ $sys_long_bit != 64 ]; then
       echo "Error:Only support 64 bit system"
       exit 1
fi
if [ ! -s ~/webserver ]; then
   mkdir ~/webserver
fi


# 换源
toolsPath='/data/tools';
if [ ! -s ~/.pip ]; then
    mkdir ~/.pip
fi
cp ${toolsPath}'/pip.conf' ~/.pip/pip.conf

#安装依赖包
yum -y groupinstall "Development tools"
yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel
yum install libffi-devel -y 
cd ~/webserver
python_version="3.7.3"
wget -c https://www.python.org/ftp/python/$python_version/Python-$python_version.tgz
tar -zxvf Python-$python_version.tgz
cd Python-$python_version
./configure --prefix=/usr/local/python3
make
make altinstall
#避免与python2冲突
ln -s /usr/local/python3/bin/python3.7 /usr/local/python3/bin/python3
ln -s /usr/local/python3/bin/python3 /usr/bin/python3
ln -s /usr/local/python3/bin/pip3.7 /usr/local/python3/bin/pip3
ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3
echo 'PATH=$PATH:$HOME/bin:/usr/local/python3/bin' >> /etc/profile
export PATH
source /etc/profile
#升级pip
python3 -m pip install --upgrade pip
#安装扩展
pip3 install pyocr pdfminer3k pdf2image tabula-py pdfplumber

#pdf文字识别
#pyocr
#pdf文字识别
#pdfminer3k
#pdf转图片
#pdf2image
#pdf转Excel，需要Java支持
#tabula-py