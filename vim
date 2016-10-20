
安装：yum -y install vim-enhanced

vim快捷键 

跳转：
0（数字）                 :跳到行首
$                               :跳到行尾
gg                             :跳到页首
G                              :跳到页尾
行数（123) -> shift+g :跳到指定行

光标在一个单词前面，按shift+#,可以往上搜索该单词

大小写转变：
g~iw     切换当前字的大小写
gUiw     将当前字变成大写
guiw     将当前字变成小写

缩进：
>>     将当前行右移一个单位
<<     将当前行左移一个单位(一个tab符)
==     自动缩进当前行
gg=G 全文自动缩进

删除复制粘贴：
dd     删除光标所在行
dw     删除一个字(word)
d回车      删除2行
n（数字）dd    删除以当前行开始的n行
x     删除当前字符
X     删除前一个字符
D     删除到行末
yy     复制一行，此命令前可跟数字，标识复制多行，如6yy，表示从当前行开始复制6行
yw     复制一个字
y$     复制到行末
p(小写)     粘贴粘贴板的内容到当前行的下面
P(大写)     粘贴粘贴板的内容到当前行的上面
]p     有缩进的粘贴，vim会自动调节代码的缩进
:9,15 copy 16  或 :9,15 co 16 将第9行至第15行的数据，复制到第16行

u 倒退一步，撤销刚才的操作

如果不小心按了Ctrl+S，就要按Ctrl+Q解锁（原来Ctrl+S在Linux里，是锁定屏幕的快捷键。如果要解锁，按下Ctrl+Q就可以了）。