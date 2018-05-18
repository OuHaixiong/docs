#!/bin/bash
DATETIME=`date +%Y%m%d%H%M%S`
DATEY=`date +%Y`

echo -e "git pull start...\n\n";
## 切换分支
cd Makeblock.com
git checkout -t origin/develop
git pull
if [ $? -eq 0 ];then
    echo -e "git pull develop ok!\n\n";
    cd ..
    \cp -rf Makeblock.com Makeblock.com.tmp
    if [ $? -eq 0 ];then
        echo -e "cp Makeblock.com.tmp ok!\n\n";
        ## copy image
        cd Makeblock.com.tmp
        \cp -rf ../www.makeblock.com/image/* image/
        if [ $? -eq 0 ];then
            echo -e "cp image ok!\n\n";
            ## copy 配置
            cp ../www.makeblock.com/config.php config.php
            if [ $? -eq 0 ];then
                echo -e "cp config.php ok!\n\n";
                ## copy admin配置
                cp ../www.makeblock.com/admin/config.php admin/config.php
                if [ $? -eq 0 ];then
                    echo -e "cp admin/config.php ok!\n\n";
                    ## 设置权限
                    chmod -R a+rw system/cache/
                    chmod -R a+rw package/
                    if [ $? -eq 0 ];then
                        echo -e "chmod ok!\n\n";
                        cd ..
                        rm -rf www.makeblock.com.${DATEY}*
                        mv www.makeblock.com www.makeblock.com.${DATETIME}
                        if [ $? -eq 0 ];then
                            ## 替换新版本
                            mv Makeblock.com.tmp www.makeblock.com
                            if [ $? -eq 0 ];then
                                ln -s /var/www/html/mbot101 /var/www/html/www.makeblock.com/mbot101
                                echo -e "mv to www.makeblock.com ok!\n\n";
                            else
                                echo -e "mv to www.makeblock.com fail!!!\n\n";
                                exit;
                            fi
                        else
                            echo -e "rm www.makeblock.com fail!!!\n\n";
                            exit;
                        fi
                    else
                        echo -e "chmod fail!!!\n\n";
                        exit;
                    fi
                else
                    echo -e "cp admin/config.php fail!!!\n\n";
                    exit;
                fi
            else
                echo -e "cp config fail!!!\n\n";
                exit;
            fi
        else
            echo -e "cp image fail!!!\n\n";
            exit;
        fi
    else
        echo -e "cp Makeblock.com.tmp fail!!!\n\n";
    fi
else
    echo -e "git pull master fail!!!";
    exit;
fi




#!/bin/bash
MY_URL="http://openlab.makeblock.com"
RESULT=`curl -I $MY_URL | grep "HTTP/1.1 500"`
if [ -n "$RESULT" ]; then
cd /var/www/openlab.makeblock.com&&sh ./restart.sh
fi

OPENLAB=`curl -I $MY_URL | grep "HTTP/1.1 502"`
if [ -n "$OPENLAB" ]; then
cd /var/www/openlab.makeblock.com&&sh ./restart.sh
fi

PASSPORTURL="http://passport.makeblock.com"
PASSPORT=`curl -I $PASSPORTURL | grep "HTTP/1.1 502"`
if [ -n "$PASSPORT" ]; then
cd /var/www/passport.makeblock.com/server&&sh ./restart.sh
fi


restart.sh
#!/usr/bin/env bash
if forever stop -e err.log app.js;
    then echo -e NodeJS Service Stop Success!
fi
if export NODE_ENV=production;
    then echo -e NODE_ENV Set Success!
fi
if forever start -e err.log app.js;
    then echo -e NodeJS Server Start Success!
fi

*/1 * * * * sh /var/www/autorestart.sh >/dev/null 2>&1