
安装java 1.8.0_221
下载java二进制包：jdk-8u221-linux-x64.tar.gz

1，创建目录并解压文件
mkdir -p /usr/local/java
tar -zxvf jdk-8u221-linux-x64.tar.gz

2，移动文件到/usr/local/java
mv ./jdk1.8.0_221/* /usr/local/java

3，设置环境变量，在/etc/profile最后添加相关环境变量，执行如下命令
echo 'export JAVA_HOME=/usr/local/java' >> /etc/profile
echo 'export JRE_HOME=${JAVA_HOME}/jre' >> /etc/profile
echo 'export CLASSPATH=.:${JAVA_HOME}/lib/dt.jar:${JAVA_HOME}/lib/tools.jar:${JRE_HOME}/lib' >> /etc/profile
echo 'export PATH=${JAVA_HOME}/bin:${JRE_HOME}/bin:$PATH' >> /etc/profile

使环境变量生效：
source /etc/profile

4，创建软连接并验证是否安装好了
ln -s /usr/local/java/bin/java /usr/bin/java
java -version

