<?php
// 下面是通过php程序执行linux命令更新svn
header("Content-type: text/html; charset=utf-8");
$dir = isset($_GET['dir']) ? $_GET['dir'] : '';
putenv('LANG=zh_CN.UTF-8'); // 注意这里的编码格式
echo '<pre>';     
$cmd = '/usr/bin/svn up /data/www/mvc/' . $dir . ' --username Bear --password BearXXX 2>&1'; // 这里的 2>&1 能输出错误信息
// 还可以加入 --accept theirs-full 的参数，这是当冲突发生时，都以 SVN Server 的文件版本为主: up --accept theirs-full
$result = shell_exec($cmd);
// 函数exec,system都可以调用系统命令(shell命令) 
// 注意:要想使用以上函数php.ini中的安全模式必须关闭

if(isset($_GET['debug']))
{
    echo $cmd . '<br />';
}

echo nl2br($result);
echo '</pre>';
// 这个怎么使用