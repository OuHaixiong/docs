#!/bin/bash

#if [ -f /bin/date ]
#then
#    echo '/bin/date is exist'
#else
#    echo '/bin/date is not exist'
#fi

# 也可以这样写
#filepath=/bin/date
filepath='/bin/date'
#if ( test -f ${filepath} ) then
if (test -f "$filepath") then   # 上面的这几种表现方式都可以
    echo 'is exist'
else
    echo 'not exist'
fi


hour=`date +%H`
echo ${hour}
if [ ${hour} -ge 0 ] && [ ${hour} -le 12 ]  # &&可以用-a代替
then
    echo 'Good morning!'
elif [ ${hour} -gt 12 ] && [ ${hour} -lt 17 ];then
    echo 'Good afternoon!'
else
    echo 'Good evening!'
fi

if test $# -eq 1  # 这里不能直接接then
then
	#if [ $1 == ${LOGNAME} ] ; then # ${LOGNAME}等于${USER}等于$(whoami)；${UID}等于$(id -u)
	if who | grep -q $1; then # 判断用户是否已经在系统中登录. -q：表示禁止显示搜索到的信息
	# 这样也行：if `who -q |grep $1`; then  （其实有些系统shell命令不需要用``都可以）
	    #echo "is logined;login name is ${LOGNAME} and UID is ${UID}";
	    echo "is logined;login name is $(whoami) and UID is $(id -u)";
	    #exit 0
	else
	    echo 'is not logged on!'
	    #exit 1 # 加入退出的话，后面的代码将不会执行
	fi
fi


echo ' ---------------------------------
|  请输入对应的菜单数字选择操作： |
| 1，执行1菜单操作                |
| 2，菜单2                        |
| 3，菜单3                        |
| 4，执行4的操作                  |
 ---------------------------------'
#echo "Please select:"
#read num
#case ${num} in
#    1) echo '执行1的操作';;
# 也可以写成 pattern 1 ）
#     ... ;;
#    2) echo '执行2的操作';;
#    3) echo '执行3的操作';;
#    4) echo '执行4的操作';;
#    *) echo '你输入有误，无法执行操作';;
#esac


# 下面是对某个文件夹下的所有同类型的文件进行修改后缀名。 linux 不支持mv *.txt *.doc这样的命令 
#for file in ./test_mv/*.txt
#currentFolder=`pwd` # 后面不带 /
#files=${currentFolder}'/test_mv/*.doc' 
#echo ${files} # 这里返回如：/Users/bear/Downloads/www/docs/test_mv/b.doc /Users/bear/Downloads/www/docs/test_mv/d.doc /Users/bear/Downloads/www/docs/test_mv/e.doc
#for file in ${files}
#do
    #leftname=`basename ${file} .txt` # 如果是shell执行脚本获取返回值最好用``把shell引起来
#    leftname=`basename ${file} .doc` # basename从随后的文件名中剥去指定的后缀
    #mv ${file} ./test_mv/${leftname}.doc
#    mv ${file} "${currentFolder}/test_mv/${leftname}.txt" # 注意多种不同的写法
#done


# 下面是每隔5分钟检查下指定的用户是否已经登录系统
#if test $# -ne 1 # -ne：不等于
#then
#    echo 'Usage:./shell-iffile.sh username'
#else 
#    user="$1"
#    until who | grep "${user}" > /dev/null # 无限循环。如果没有找到指定的用户名，返回码为非0即为假；找到后返回码为0即为真
                              # 采用重定向到/dev/null空文件的目的是不显示查找到的用户其他信息
#    do
#        sleep 300 # sleep 暂停多少秒
#    done
#    echo "${user} has logged on!"
#fi




