#!/bin/bash

echo '欧阳海雄开始学习shell脚本了ing...'
# 下面是表达式求值。注意:加号的两边需要有空格;如果用乘号[*]需要加转义符
echo `expr 1 + 3`
echo `expr 2 \* 4`

age=37 # 注意给变量赋值时，等号[=]两边是不能有空格的
echo ${age}
if [ $age -eq 0 ] # 特别注意判断的前后是有空格的
then
    echo '你忽悠我呀，还没有出生的小孩'
elif [ $age -ge 80 ] # -gt 大于；-ge 大于等于
then
    echo '晚年人了，看淡人生'
elif [ $age -ge 60 -a $age -le 79 ] # -lt 小于；le 小于等于
then
    echo '老年人了，多注意休息，偶尔出去跑跑步'
elif [ $age -ge 18 ] && [ $age -le 59 ] # -a 逻辑与和&&是一个意思
then
    echo '人生最辉煌的时期，正是学习和干事业的机会'
else
    echo '未成年人，你不要胡来'
fi

# 下面是case分支的写法
case "$#" in
    0) echo '输入了0个参数' ;; # 每个分支必须以两个分号结尾
    1) echo '输入了1个参数' ;;
    *) echo '输入了多个参数' ;;
esac

# 下面是for循环的写法
for i in `seq 1 9` # seq 会产生1-9的数字序列，比如：seq 1 4 取值如：1，2，3，4 。 也可以写成 for (i in xxx) do 
do
    #echo `expr $i \* 10` # 输出100内10的倍数. 也可以用break和continue语句中断循环
    echo $(expr $i \* 10) # 上面两种写法是一样的
done

# 下面是read的用法
#echo '请输入多个值：'
#read variable1 variable2 variable3 # read可以从键盘上读取多个变量值
#echo "你输入的第一个值是：${variable1}"
#echo "你输入的第二个值是：${variable2}"
#echo "你输入的第三个值是：${variable3}"
# 当用户输入数据时，以空格或Tab键作为分割。如果输入的数据个数不够，则从左到右对应赋值，没有输入的变量为空；如果输入的数据个数超过了，则从左到右对应赋值，最后一个变量被赋予剩余的所有数据

# 下面是while的写法：
i=1
sum=0
while [ $i -le 100 ]
do
    sum=$[$sum+$i] # 特别注意这里，[]是直接求值命令，如果需要再赋值是需要在前面加$
    i=$[$i+1] # 只能这样写，不能用圆括号
done
echo "1到100的总和：$sum"

cat<<HELP  # 打印多行文本
   ren -- renames a number of files using sed regular expressions
   USAGE: ren 'regexp' 'replacement' files
   EXAMPLE: rename all *.HTM files in *.html:
   ren 'HTM$' 'html' *.HTM
HELP







