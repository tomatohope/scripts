#!/usr/bin/env bash

# cpu
ps aux | head -1; ps aux | sort -nrk 3 | head -5

# mem
ps aux | head -1; ps aux | sort -nrk 4 | head -5

cat /proc/meminfo | grep MemTotal
free -k
free -m

#CPU 型号
cat /proc/cpuinfo  |grep name | cut -d: -f2 | uniq -c
#物理CPU 数
cat /proc/cpuinfo | grep "physical id" | wc -l
#查看单个物理CPU core数
cat /proc/cpuinfo  | grep cores | uniq
#查看逻辑CPU数
cat /proc/cpuinfo  | grep processor | wc -l

#IO 磁盘 IO 和 网络IO

# CPU MEM IO 磁盘瓶颈
sar -d -p 1 2

top
1
c

# 网络
 ethtool ethN
 ethtool -s eth0 autoneg off duplex full
 ifconfig eth1
 route -n
 nslookup baidu.com
 /etc/resolv.conf nameserver 10.21.1.205
 traceroute www.baidu.com
 telnet 220.181.111.188 80
 nmap -p 22 220.181.111.188
 netstat -lnp | grep PORT

# 按第二列排序  
sort -k2 -rn

# 常见排查命令
 cat  /var/log/messages  | grep PID
 ps aux|head -1;ps aux|grep -v PID|sort -rn -k +3|head
 uptime
 W
 dmesg | more
 dmesg | tail
 vmstat 1 5 #5次/sort
    r : 等待CPU PID 数；应小于 CPU core 数
	free: free memory 单位 K
	si,so 交换分区 写入 和 读取 的量，当值不等于0，物理内存已不足
	us,sy,id,wa,st: CPU 消耗时间 wa,st: IO 等待时间和被偷走时间
 mpstat -P ALL 1 CPU 个数和占用
 pidstat 1 #PID CPU 占用
 iostat -zx 1 #磁盘
 sar -n DEV 1 #网络
 sar -n TCP,ETCP 1

 # 普通 用户 提权
useradd $add_new_username
echo $add_new_user_password |passwd --stdin $add_new_username
chmod  0640 /etc/sudoers
{{ add_new_username }} ALL=(ALL) NOPASSWD: ALL
chmod  0440 /etc/sudoers

# 查看 进程 端口
netstat -antlp | grep `ps aux | grep http | grep -v "\--color"| awk '{print $2}'`

# 域名
/etc/resolv.conf文件
nameserver 8.8.8.8

# selinux firewalld
/etc/selinux/config
systemctl disable firewalld

# 免密登录
ssh-keygen -t rsa
ssh-copy-id -i ~/.ssh/id_rsa.pub root@host

# 替换 换行 空格
echo char | tr '\n' ' ' | sed 's/ //g'"

# yum执行报错No module named yummain处理
wget  http://yum.baseurl.org/download/3.4/yum-3.4.0.tar.gz
tar -xf yum-3.4.0.tar.gz
cd yum-3.4.0
./yummain.py  install yum
yum update

# rpm 包下载
http://rpm.pbone.net/

# ssh 修复
rpm -qa openssh*
yum remove openssh

yum install openssh openssh-server openssh-clients

chmod -R 777 /etc/polkit-1/rules.d
yum search polkit
yum -y install polkit.x86_64

systemctl restart  polkit.service
service sshd start
echo root:12345678  | chpasswd

# 大文件处理
https://www.cnblogs.com/cherishui/p/4136847.html

wget http://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2
 tar -xf parallel-latest.tar.bz2
 cd parallel-20191022/
./configure
  make
make install

cat 11 | parallel   --pipe sed 's?\`??g' >> 22

# securecrt SFTP
alt+p
put:
cd [dit]
lcd [dir]
put filename

get
...
get filename

#
$* 参数
$$
Shell本身的PID（ProcessID）
$!
Shell最后运行的后台Process的PID
$?
最后运行的命令的结束代码（返回值）
$*
所有参数列表。如"$*"用「"」括起来的情况、以"$1 $2 … $n"的形式输出所有参数。
$@
所有参数列表。如"$@"用「"」括起来的情况、以"$1" "$2" … "$n" 的形式输出所有参数。
$#
添加到Shell的参数个数
$0
Shell本身的文件名
$1～$n
添加到Shell的各参数值。$1是第1参数、$2是第2参数…

#字符串分割
awk -F "符号" ‘{print $1"想追加的字符"}’
#打印第N列后的所有列（不包括第N列）
awk '{for(i=N+1;i<=NF;i++)printf $i "  ";printf"\n"}' file

查看文件内容
cat -s file
#将多个空行转换为一行
cat file | tr -s '\n'
不显示空白行

#复制子文件及其属性
cp -rp

#if 匹配
[[ $port =~ ^[0-9]{1,5}$ ]]
$i =~ ^[0-9]+$

[[ ]] 是if判断使用正则表达式的固定格式
=~表示匹配
^ 是以什么开头
+ 表示1到多个
$ 是以什么结尾

#if 判断
BB=
[[ -n $BB ]]   #“-n”为空
[root]# echo $?

#a=2
if [ $a ];then
echo ok
fi
如果a有值,输出OK

#jq 对JSON进行操作

ln -s 【目标目录】 【软链接地址】
!!!创建符号链接的时候一定要使用绝对路径 ，否则会出现“符号连接的层数过多”，是由于不同路径访问都采用了相对路径

rm -rf 【软链接地址】
上述指令中，软链接地址最后不能含有“/”，当含有“/”时，删除的是软链接目标目录下的资源，而不是软链接本身。

ln -snf 【新目标目录】 【软链接地址】
这里修改是指修改软链接的目标目录

#readlink  追溯源文件

#########
#basename 去除绝对路径

变量和字符一起组合
echo ${a}s

a=`echo 'ls /homewew"m'`
echo $a  | sed 's/"/\\\\"/g'`
#将字符串   ls /homewew"m'  中的“ 替换为\\"

# 指定行替换整行：
sed '行号c 新的内容' 要处理的文件
sed -e "/url/c${url}" file
sed -e "/allow/c \            allow 111;" /usr/local/nginx/conf/nginx.conf

# 指定替换某个字符：
sed -i "s/account/${app}/g" file

a=aaaaa
echo ${a//bbb-/}

删除指定行后的文件：
cat a | sed -e '/auto/,$d'

在指定行后添加多行文本：
      将多行文本存到指定文件
      sed -e '/指定行字符/r 指定的多行文本文件' 需要修改的文件

#替换时附加引号
sed -e "s/${aa}/\"${aa1}\"/g" aa

#将/ 替换成 \/
GitUrl="$( echo "${GitUrl}" | sed 's/\//\\\//g' )"

#屏蔽输入输出，多用于密码字段
stty -echo

#date 格式
输出30天前的日期：
date -d '30 days ago' +%F
date=`date -d "$one_month_ago" +%s`
#将“年-月-日”日期格式转换为秒格式
date "+%Y-%m-%d %H:%M:%S"
ts=`date +%Y%m%d%H%M%S` ###20190304235406

#匹配以字符#开头
if [[ "$a" =~ ^#  ]];then
   echo 1
fi
#########################
#匹配以字符fd结尾
if [[ "$a" =~ fd$  ]];then
   echo 1
fi

文本统计：wc (word count)
      -l：多少行
      -w：多少单词
      -c：多少字符
      -L：最长的一行包含了多少个字符

######## 断电
ERROR:/dev/sda2: Inodes that were part of a corrupted orphan linked list found.
fsck.ext4 /dev/sda2
fsck.ext4 -y /dev/sda2

############ /var/log 系统日志 系统信息
Linux /var/log下的各种日志文件详解

系统的引导日志:/var/log/boot.log
系统日志一般都存在/var/log下
核心启动日志:/var/log/dmesg
系统报错日志:/var/log/messages
邮件系统日志:/var/log/maillog
FTP系统日志:/var/log/xferlog
安全信息和系统登录与网络连接的信息:/var/log/secure
登录记录:/var/log/wtmp      记录登录者讯录，二进制文件，须用last来读取内容    who -u /var/log/wtmp 查看信息
News日志:/var/log/spooler
RPM软件包:/var/log/rpmpkgs
XFree86日志:/var/log/XFree86.0.log
引导日志:/var/log/boot.log   记录开机启动信息，dmesg | more
cron(定制任务日志)日志:/var/log/cron
安全信息和系统登录与网络连接的信息:/var/log/secure

文件 /var/run/utmp 现在登录用户
文件 /var/log/wtmp 所有登录登出
文件 /var/log/lastlog 用户最后登录信息
文件 /var/log/btmp 错误登录尝试
#相关查询登录信息命令： w who last
#相关开机信息命令：dmesg
#相关系统信息命令：uptime top free df fdisk cat /etc/redhat-release

############ 快速度量磁盘信息
http://soft.vpser.net/manage/ncdu/ncdu-1.6.tar.gz
./configure
make && make install
启动路径：/usr/local/bin/ncdu

提示：
configure: error: no acceptable C compiler found in $PATH
请安装gcc编译器：
#yum -y install gcc gcc-c++
configure: error: required header file not found
请安装:
yum -y install ncurses ncurses-devel

#########################

上下箭头切换目录
左右箭头切换父级目录
s 按 文件大小排序
n 按 文件名排序
q 退出


n - 按名称排序（再次按降序排列）
s - 按文件大小排序（再次按降序排列）
d - 删除所选文件或目录
g - 显示百分比和/或图表
t - 排序时在文件之前切换dirs
c - 切换子项目计数的显示
b - 当前目录中的Spawn shell
i - 显示有关所选项目的信息
r - 刷新/重新计算当前目录
q - 退出ncdu

#### clean /var/log/journal 
#journalctl --disk-usage
5 2 * * * journalctl --vacuum-time=1w

权限管理 只读账户
##########################

username="lingang"
useradd "${username}"
echo "9FpvaUa#ISCMAWfo" | passwd "${username}" --stdin
#setfacl -m u:"${username}":r -R /data
#setfacl -x user:"${username}" -R /data/
#getfacl /data/

mkdir /home/"${username}"/.bin
chown root. /home/"${username}"/.bash_profile 
chmod 755 /home/"${username}"/.bash_profile
chattr -i /home/"${username}"/.bash_profile
sed -i 's/PATH=/#PATH=/g' /home/"${username}"/.bash_profile 
sed -i '/#PATH/a PATH=$HOME/.bin' /home/"${username}"/.bash_profile 

ln -s /usr/bin/wc  /home/"${username}"/.bin/wc
ln -s /usr/bin/tail  /home/"${username}"/.bin/tail
ln -s /bin/more  /home/"${username}"/.bin/more
ln -s /bin/cat  /home/"${username}"/.bin/cat
ln -s /bin/grep  /home/"${username}"/.bin/grep
ln -s /bin/find  /home/"${username}"/.bin/find
ln -s /bin/pwd  /home/"${username}"/.bin/pwd
ln -s /bin/ls  /home/"${username}"/.bin/ls
ln -s /usr/bin/less /home/"${username}"/.bin/less
ln -s /bin/tar  /home/"${username}"/.bin/tar
ln -s /bin/cd  /home/"${username}"/.bin/cd

su "${username}"
source ~/.bash_profile 


##
#修改账户密码保留时间
# -M max -m min -W waning; 注意更新后请及时更改root密码，可能行号符合机制
chage -M 60 -m 0 -W 7 root
# m M W
cat /etc/shadow | grep root | awk -F ":" '{print $4" "$5" "$6}'

##
# 使用shc 加密为可执行文件
yum -y install shc 
##  当 shell 开头是 bin/bash 时才可加密成功, 加密后就不需要 加 bash 执行
#!/bin/bash
shc -r -f t.sh

## redis log
redis-cli -h xxx -p 6379 -a pass monitor

##
date -d "31 days ago " "+%Y-%m-%d"

##
inodes much more
df -i
for i in /data/*; do echo $i; find $i |wc -l ;done

/data
/proc

2539083
1368419


for i in /proc/*; do echo $i; find $i |wc -l ;done


## httpd

# install in order
expat --> apr --> apr-util
yum install expat-devel -y

apche apr

http://apr.apache.org/download.cgi
把RM='$RM'改为RM='$RM  -f'
./configure --prefix=/tmp/hope/apr/apr
make && make install

apche apr-util


http://apr.apache.org/download.cgi
./configure --prefix=/tmp/hope/apr-util/apr-util --with-apr=/tmp/hope/apr/apr/bin/apr-1-config
make && make install


apache http
https://httpd.apache.org/docs/2.4/install.html
#./configure --prefix=PREFIX
./configure --prefix=/tmp/hope/httpd --with-apr=/tmp/hope/apr/apr/bin/apr-1-config  --with-apr-util=/tmp/hope/apr-util/apr-util
make
make install
#vi PREFIX/conf/httpd.conf
PREFIX/bin/apachectl -k start


##########################
脚本 +x 执行权限
cron 里执行的脚本使用绝对路径,包括命令
cron 里的时间格式 分 时 日 月 周 03 02 * * * ：表示每天 2点3分
tail -f /var/log/cron # 待 cron reload 后生效
service crond restart
crontab -l

# date -s 02:00:00 \\更改时间
# date -d "+%Y-%m-%d %H:%M:%S" \\转换格式



########################## mv error : 将会把 /tmp/out/wp-customer整个目录放到  /data/log-backup/sfa/wp-customer/ 下，导致再次 mv 会有同样的文件
mv /tmp/out/wp-customer/`ls | grep $(date -d "3 days ago " "+%Y-%m-%d")` /data/log-backup/sfa/wp-customer/
### 但是这样拼接的可以
mv /data/MS/want-ceo-taskserver-1.0.0/wso2/default/logs/carbon-`date -d "1 days ago " "+%m-%d-%Y".log` /data/extend/applogs/ms-taskserver/
### 推荐使用
find /tmp/out/wp-customer/ -type f -mtime +10 -exec  mv  {} /data/log-backup/sfa/wp-customer/  \; 

##########################修改文件时间
touch -c -t {YYYY}MMDDhhmm filename
ll
stat filename 



#########################

#!/usr/bin/env bash

# N colomns  N 列 多列 按
echo $releaseinfo | awk  '{for(i=2;i<=NF;i=i+2) print $(i-1),$i}' >> /tmp/release

# 指定行 替换  sed 去除换行符
sed -i "/js.version=/c js.version=$time" xxx/${app}-prod.properties
echo -e ${A} | sed  -e "s/auto/${auto}/g" | sed  -e "s/num/${num}/g"
sed -e 's/\\r//g'

# get file detail info 查看 文件 详细信息 文件类型
ls -lt --time-style='full-iso' $file
file $file

# tar 文件打包
tar -jcvPf  $backdir/$sqlfilename$time.tar.bz2 $sqlfile

# 字符截取
echo 1234 | cut -b1,2,3
echo 1:234 | cut -d':' -f 2

# 字符转义
SOA="\`id\`, \`zone\`, \`host\`, \`type\`, \`data\`, \`ttl\`, \`mx_priority\`"

# 自增
((auto++))

# 引入 外部脚本
#source
script_path=$(cd $(dirname $0); pwd)
. $script_path/../../common/common.sh

# 脚本名
basename $0

# 参数 数量
if [ $# -eq 0 ]; then
   echo "${USAGE}" >&2
   exit 1
fi

# 将 结果 输出到 标准错误
>&2

# 判断 变量 数量 合法性
while true; do
    case "$1" in
        -h | --help )
            echo "${USAGE}" >&2
            exit 0
            ;;

        -e | --env )
           env=$2
           log_info "[ env: $env ]"
           shift 2
           ;;

        -u | --dbuser )
           dbuser=$2
           log_info "[ dbuser: $dbuser ]"
           shift 2
           ;;

        -p | --dbpasswd )
           dbpasswd=$2
           log_info "[ dbpasswd: $dbpasswd ]"
           shift 2
           ;;

         '' )
            shift
            break
            ;;

         * )
            echo "${USAGE}" >&2
            exit 1
            ;;

     esac
done

# 去除 特殊 字符

function remove_special_char_line_file () {

charfile=$1
sed -i '/*/d'  $charfile
sed -i '/\\/d' $charfile
sed -i '/\//d' $charfile
sed -i '/]/d'  $charfile
sed -i '/\$/d' $charfile
sed -i '/\^/d' $charfile
sed -i '/\./d' $charfile
sed -i '/\[/d' $charfile
sed -i '/\?/d' $charfile

special_char="\` ~ ! @ #  %  & ( ) + = | { } ' : ; ' , <  > ? ~ ！ @ # ￥ % … … & （ ） — — + | { } 【 】 ‘  ； ： ” “ ’ 。 ， 、 ？ -"

for char in `echo $special_char`
do
   sed -i "/$char/d" $charfile
done

}


function remove_special_char_line_param () {

code="$1"
code=$(echo -e "$code" | sed -e '/*/d' | sed -e '/\?/d' | sed -e '/\[/d' | sed -e '/\./d' | sed -e '/\^/d' | sed -e '/\$/d' | sed -e '/]/d' | sed -e '/\//d' | sed -e '/\\/d')

special_char="\` ~ ! @ #  %  & ( ) + = | { } ' : ; ' , <  > ? ~ ！ @ # ￥ % … … & （ ） — — + | { } 【 】 ‘  ； ： ” “ ’ 。 ， 、 ？ -"

for char in `echo $special_char`
do
   code=$(echo -e "$code" | sed -e "/${char}/d")
done
echo -e "$code"

}

# 文件 是否存在
if [ -f $file ];then
        echo "exist" >> info
fi


# 文件名 带 空格 的 文件
# 遍历
for i in `ls ./ | tr " " "\?"`
do
   cd /var/lib/jenkins/jobs/dev-auto-deploy/jobs/
   echo "cd ${i}/builds"

  # 带双引号
   cd "${i}/builds"

# 文件压缩
0 3 * * * cd /var/log/`date +\%m-\%d` && gzip *

gzip
高压缩比，压缩后会清掉源文件，解压后也会清掉源文件，不支持目录

eg:
   cd dir
   gzip *
   或 gzip filename1 filename2

# wget 只下载 html ,  双引号 ： 403
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "https://download.oracle.com/otn-pub/java/jdk/14.0.1+7/664493ef4a6946b186ff29eb326336a2/jdk-14.0.1_linux-x64_bin.tar.gz"


# 示例while 循环 不会使得一行变为多行
while read -r line
do
  echo $line
done < app

#
tar -zcvf apache.tar.gz --exclude=logs/* /data/ceoServer/apache-tomcat-7.0.107/



######################### crontab 任务未执行 和 编写注意事项

1、crontab 服务未开启
2、crontab 里没有使用绝对路径(对应相对用户相关命令 和脚本文件 使用 绝对路径)
3、脚本的执行权限: 阔以 不加， 但后面一定要用 bash 执行
4、crontab 本身的环境变量问题：(非 root 用户 运行 的 cron)

    示例格式： 
    时间  source /etc/profile && nohup bash /home/wzwp_sfa/task.sh > /dev/null 2>&1 &

5、调试DEDUG输出
   时间 CND  >>/tmp/xxxlog &   结束后 恢复 为 >/dev/null 2>&1 & 
6、新创建的cron job，不会马上执行，至少要过2分钟才执行。如果重启cron则马上执行： service crond restart
7、cron 执行的命令追加，避免撑满邮件系统文件 >/dev/null 2>&1 &； tail -f /var/log/cron
8、cron 格式： 编写注意事项： 在细分时间粒度上，少用 * ； 比如 * */12 * * * ; 表示 每12个小时 的 整点时，会 00 01 。。。 58 59 地执行； 一定要设置为 01 */12 * * *


yum -y install sysstat
iostat -x 1 10  
# %util


yum install iotop -y
iotop

## lsof 恢复 还有进程在读的文件 误删除的文件
lsof | grep filename
cat /proc/[PID]/fd/1 > filename


##磁盘 IO 
磁盘IO wait > 20ms ： 磁盘故障阀值
iotop
iostat -x 1
lsof -p PID 
lsof | grep filename
#####

top 看到 wa 值高，CPU us 低，说明 IO wait 导致 CPU 使用率高（CPU 使用率: idle CPU 空闲率；）
iostat -x 2 5 # util 值可以再次看磁盘负载是否较高
iotop # 查看 io 使用较高 的 PID 排行
lsof -p [PID] # 查看 pid 访问的对应文件

##### 开机自动挂载  
echo '/dev/vdb1 /data/extend/ ext4 defaults 0 0' >> /etc/fstab
mount -a


##############  tomcat 新建目录权限  待验证  
umask 0000 权限 == 7777 - 0000 ==> 7777

修改Tomcat的bin/catalina.sh文件
将“0027”改为“0000”

############## 关于权限问题
故事背景：在nginx 反向代理调用后端服务（后端服务是以普通用户运行，其新建的目录给的权限是 645 导致，新目录文件下下没有写 上传文件 的权限）
解决：该普通用户新建目录权限最低改为 700 ; 以root 用户运行该服务获取超级权限; 修改程序新建目录时指定基础 700 权限;
备注：
    这里出现的权限问题不是nginx程序用户来创建的，而是运行该服务的用户；x 权限是打开目录的权限
    umask 新文件或目录默认权限：目录来说最大的权限是 777，实际新目录默认权限777-xxx; 对于文件来说最大的权限一般为 666; /etc/profile 或 ~/.bashrc 里配
    s 与 t 权限： s 权限 chmod u +s  或 chmod g + s 让普通用户具有该属主 或 属组 的 权限； t 权限是让用户只能更改自己创建的文件  
    facl 文件访问控制权限：授予特定用户或组权限 
        setfacl  --help
        setfacl -d -m u:username:rwx /data/upload_file/ #让用户创建的子目录都具有rwx的权限； 权限继承  
        getfacl /data/upload_file/
        setfacl -b  /data/upload_file/                  #remove all acl
#####################################################################################################################################################################
用户 目录 权限 软件安装 

########################
redis set pass
mysql 升级至 MySQL5.6.49
nginx 升级至 Nginx1.15.7: 无需升级，已是 1.16.0 版本，检查可能有误
OpenSSH升级到7.9
HTTP/2 升级到新版 \\ curl -I domain \\ nginx server need to add ca ssl
apache-tomcat7 升级到 7.0.104 host255

redis set pass
########################
#host244 /usr/local/redis redis set pass

""" redis install
https://redis.io/download
$ wget https://download.redis.io/releases/redis-4.0.8.tar.gz
$ tar -xzvf redis-4.0.8.tar.gz -C /opt/redis
$ cd redis-4.0.8
$ make
$ make install

vim redis.conf
    bind 114.86.189.141 10.105.0.0/16
    port 16079
    requirepass yourpasswd
useradd normal_user
chmod -R 700 /opt/redis
chown -R normal_user:normal_user /opt/redis
su normal_user
$ src/redis-server redis.conf
$ src/redis-cli
   auth <apth>
# usermod -s /sbin/nologin normal_user
# usermod -s /bin/bash normal_user
"""
$ redis-cli
> config get requirepass
> config set requirepass <pass>
> config get requirepass

> auth <pass>
> config get requirepass


mysql 升级至 MySQL5.6.49
########################
#host243 host244 mysql 5.6.28 升级至 MySQL5.6.49
https://dev.mysql.com/doc/refman/5.6/en/installing-source-distribution.html
https://dev.mysql.com/doc/refman/5.6/en/upgrading.html

#### install
#
yum install -y autoconf automake imake libxml2-devel expat-devel cmake gcc gcc-c++ libaio libaio-devel bzr bison ncurses-devel
#
wget http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.28.tar.gz
# install
tar -xf mysql-5.6.28.tar.gz

cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
-DMYSQL_DATADIR=/usr/local/mysql/data \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DWITH_EXTRA_CHARSETS=all \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_FEDERATED_STORAGE_ENGINE=1 \
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
-DWITHOUT_EXAMPLE_STORAGE_ENGINE=1 \
-DWITH_ZLIB=bundled \
-DWITH_SSL=bundled \ # -DWITH_SSL=system
-DENABLED_LOCAL_INFILE=1 \
-DWITH_EMBEDDED_SERVER=1 \
-DENABLE_DOWNLOADS=1 \
-DWITH_DEBUG=0

#make clean
#rm CMakeCache.txt
# https://blog.csdn.net/qinglingls/article/details/95347952
# https://www.boost.org/users/history/

make && make install

mv /etc/my.cnf /etc/my.cnf_default
cp /usr/local/mysql/support-files/my-default.cnf /etc/my.cnf
vi /etc/my.cnf
[client]
port = 3307
socket = /var/mysql/mysql.sock
[mysql]
no-auto-rehash
[mysqld]
user = mysql
port = 3307
basedir = /usr/local/mysql
datadir =  /var/mysql/data
pid-file =  /var/mysql/mysql.pid
relay-log =  /var/mysql/relay-bin
relay-log-info-file =  /var/mysql/relay-log.info
#log-bin = /var/mysql/mysql-bin
server-id = 3306
socket = /var/mysql/mysql.sock
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES
[mysqld_safe]
## start failure
log-error =  /var/mysql/mysql.err
pid-file =  /var/mysql/mysql.pid

useradd mysql
mkdir -p /var/mysql/data
chown -R mysql:mysql /var/mysql/data
cd /usr/local/mysql/scripts
./mysql_install_db --basedir=/usr/local/mysql  --datadir=/var/mysql/data --user=mysql

    To start mysqld at boot time you have to copy
    support-files/mysql.server to the right place for your system

    PLEASE REMEMBER TO SET A PASSWORD FOR THE MySQL root USER !
    To do so, start the server, then issue the following commands:

      /usr/local/mysql/bin/mysqladmin -u root password 'new-password'
      /usr/local/mysql/bin/mysqladmin -u root -h aliyun-test password 'new-password'

    Alternatively you can run:

      /usr/local/mysql/bin/mysql_secure_installation

    which will also give you the option of removing the test
    databases and anonymous user created by default.  This is
    strongly recommended for production servers.

    See the manual for more instructions.

    You can start the MySQL daemon with:

      cd . ; /usr/local/mysql/bin/mysqld_safe &

    You can test the MySQL daemon with mysql-test-run.pl

      cd mysql-test ; perl mysql-test-run.pl

    Please report any problems at http://bugs.mysql.com/

    The latest information about MySQL is available on the web at

      http://www.mysql.com

    Support MySQL by buying support/licenses at http://shop.mysql.com

vi /etc/profile
  	export PATH=$PATH:/usr/local/mysql/bin
source  /etc/profile

cp  /usr/local/mysql/support-files/mysql.server /etc/init.d/mysql
chkconfig --add /etc/init.d/mysql
chkconfig mysql on
chkconfig --list mysql
   mysql           0:off   1:off   2:on    3:on    4:on    5:on    6:off
touch /var/mysql/mysql.err
chown -R mysql:mysql /var/mysql/
chown -R mysql:mysql /usr/local/mysql
chmod -R 700 /var/mysql/
chmod -R 700 /usr/local/mysql
su mysql
service mysql start

mysqladmin -u root password "123456"
# ln -s /var/lib/mysql/mysql.sock /tmp/mysql.sock
mysql -uroot -p

mysql> SET PASSWORD FOR 'root'@'localhost' = PASSWORD('new_pass');
mysql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;
mysql> flush privileges;
exit # su root
usermod -s /sbin/nologin mysql
#usermod -s /bin/bash mysql
#### upgrade

make sure your previous and destination version:
  eg: 5.6.a --> 5.6.z In-Place Upgrade
  eg: 5.6   --> 5.7 Logical Upgrade
  error: 5.5 --> 5.7
learn about updated
update one by one version: 5.6 --> 5.7; or 5.6.a --> 5.6.z
backup your data
upgrade by your method of installation
#### official update In-Place Upgrade
shutting down the old MySQL server
replacing the old MySQL binaries or packages with the new ones
restarting MySQL on the existing data directory
and upgrading any remaining parts of the existing installation that require upgrading.

# commit or rollback transcation
# get transcation status
XA RECOVER;
## COMMIT or ROLLBACK
XA COMMIT xid ;
XA ROLLBACK xid;
XA RECOVER;

# If you use InnoDB, configure MySQL to perform a slow shutdown by setting innodb_fast_shutdown to 0. For example:
show variables like '%storage_engine%';
show engines;
mysql -u root -p --execute="SET GLOBAL innodb_fast_shutdown=0"

# shutdown old server
mysqladmin -u root -p shutdown
service mysql status
ps -ef | grep mysql

# install latest version
    unpack source file
    wget http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.49.tar.gz

    mv /usr/local/mysql/ /usr/local/mysql_5.6.28
    cd mysql-5.6.49
    cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
    -DMYSQL_DATADIR=/usr/local/mysql/data \
    -DDEFAULT_CHARSET=utf8 \
    -DDEFAULT_COLLATION=utf8_general_ci \
    -DWITH_EXTRA_CHARSETS=all \
    -DWITH_INNOBASE_STORAGE_ENGINE=1 \
    -DWITH_FEDERATED_STORAGE_ENGINE=1 \
    -DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
    -DWITHOUT_EXAMPLE_STORAGE_ENGINE=1 \
    -DWITH_ZLIB=bundled \
    -DWITH_SSL=bundled \
    -DENABLED_LOCAL_INFILE=1 \
    -DWITH_EMBEDDED_SERVER=1 \
    -DENABLE_DOWNLOADS=1 \
    -DWITH_DEBUG=0
    # if error: mysql Wrong option or path for WITH_SSL=bundled
    yum -y install openssl-devel
    mysql Wrong option or path for WITH_SSL=system

    make && make install

cp -rf /var/mysql/data /var/mysql/data_bak
cp /usr/local/mysql_5.6.28/my.cnf /usr/local/mysql/
chown -R mysql:mysql /var/mysql
chown -R mysql:mysql /usr/local/mysql
#mysqld_safe --user=mysql --datadir=/path/to/existing-datadir &
mysqld_safe --user=mysql --datadir=/var/mysql/data mysqld_safe &

mysql_upgrade -u root -p

mysqladmin -u root -p shutdown
mysqld_safe --user=mysql --datadir=/var/mysql/data &
rm -f /etc/init.d/mysql
cp  /usr/local/mysql/support-files/mysql.server /etc/init.d/mysql
chown -R mysql:mysql /etc/init.d/mysql


>flush privileges;
>show variables like '%time_zone%';


OpenSSH升级到7.9
########################
#host243 host244 host245 OpenSSH_7.4p1 OpenSSH升级到7.9
#https://www.openssh.com/releasenotes.html
https://developer.aliyun.com/article/719068
# 升级依赖: openssl
# 升级注意：临时安装辅助 telnet 软件

# update openssl

    yum -y install vim git gcc wget make perl-Test-Harness zlib-devel
    # openssl update
    https://www.openssl.org/source/
    git clone https://github.com/openssl/openssl.git
    git checkout OpenSSL_1_1_1-stable

    ./config shared zlib  --prefix=/usr/local/openssl && make && make install

    mv /usr/bin/openssl /usr/bin/openssl.old
    mv /usr/include/openssl /usr/include/openssl.old
    ln -s /usr/local/openssl/bin/openssl /usr/bin/openssl
    ln -s /usr/local/openssl/include/openssl /usr/include/openssl
    ln -sf /usr/local/openssl/lib/libcrypto.so /lib/libcrypto.so

    echo "/usr/local/openssl/lib" >>/etc/ld.so.conf
    ldconfig -v

    openssl version

# update openssh

    # tmp install telnet
        yum install -y telnet-server
        yum install -y xinetd
        systemctl start telnet.socket
        systemctl start  xinetd

        echo 'pts/0' >>/etc/securetty
        echo 'pts/1' >>/etc/securetty
        systemctl restart telnet.socket

        systemctl enable xinetd.service
        systemctl enable telnet.socket

        systemctl stop telnet.socket
        systemctl stop  xinetd

        systemctl start telnet.socket
        systemctl start  xinetd

        # connect test
        telnet ip port

    # install openssh

        cp -r /etc/ssh /etc/ssh.old
        ls /etc | grep  ssh

        rpm -qa|grep openssh
        rpm -e --nodeps openssh-clients-7.4p1-16.el7.x86_64
        rpm -e --nodeps openssh-7.4p1-16.el7.x86_64
        rpm -e --nodeps openssh-server-7.4p1-16.el7.x86_64
        rpm -qa|grep openssh

        install openssh
        https://www.openssh.com/releasenotes.html
        wget https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-7.9p1.tar.gz

        install -v -m700 -d /var/lib/sshd
        chown -v root:sys /var/lib/sshd
        groupadd -g 50 sshd
        useradd -c 'sshd PrivSep' -d /var/lib/sshd -g sshd -s /bin/false -u 50 sshd
        cd openssh-7.9p1
        ./configure --prefix=/usr --sysconfdir=/etc/ssh --with-md5-passwords --with-privsep-path=/var/lib/sshd
            OpenSSH has been configured with the following options:
                                 User binaries: /usr/bin
                               System binaries: /usr/sbin
                           Configuration files: /etc/ssh
                               Askpass program: /usr/libexec/ssh-askpass
                                  Manual pages: /usr/share/man/manX
                                      PID file: /var/run
              Privilege separation chroot path: /var/lib/sshd
                        sshd default user PATH: /usr/bin:/bin:/usr/sbin:/sbin
                                Manpage format: doc
                                   PAM support: no
                               OSF SIA support: no
                             KerberosV support: no
                               SELinux support: no
                          MD5 password support: yes
                               libedit support: no
                               libldns support: no
              Solaris process contract support: no
                       Solaris project support: no
                     Solaris privilege support: no
                   IP address in $DISPLAY hack: no
                       Translate v4 in v6 hack: yes
                              BSD Auth support: no
                          Random number source: OpenSSL internal ONLY
                         Privsep sandbox style: seccomp_filter
                          Host: x86_64-pc-linux-gnu
                      Compiler: gcc
                Compiler flags: -g -O2 -pipe -Wall -Wpointer-arith -Wuninitialized -Wsign-compare -Wformat-security -Wsizeof-pointer-memaccess -Wno-pointer-sign -Wno-unused-result -fno-strict-aliasing -D_FORTIFY_SOURCE=2 -ftrapv -fno-builtin-memset -fstack-protector-strong -fPIE
            Preprocessor flags:  -D_XOPEN_SOURCE=600 -D_BSD_SOURCE -D_DEFAULT_SOURCE
                  Linker flags:  -Wl,-z,relro -Wl,-z,now -Wl,-z,noexecstack -fstack-protector-strong -pie
                     Libraries: -lcrypto -ldl -lutil -lz  -lcrypt -lresolv

        chmod 600 /etc/ssh/ssh_host_rsa_key
        chmod 600 /etc/ssh/ssh_host_ecdsa_key
        chmod 600 /etc/ssh/ssh_host_ed25519_key
        make install
        install -v -m755 contrib/ssh-copy-id /usr/bin
        install -v -m644 contrib/ssh-copy-id.1 /usr/share/man/man1
        install -v -m755 -d /usr/share/doc/openssh-7.9p1
        install -v -m644 INSTALL LICENCE OVERVIEW README* /usr/share/doc/openssh-7.9p1

        cp -p contrib/redhat/sshd.init /etc/init.d/sshd
        chmod +x /etc/init.d/sshd
        chkconfig --add sshd
        chkconfig sshd on
        chkconfig --list sshd

        mv /etc/ssh.old/sshd_config /etc/ssh.old/sshd_config_default
        cp /etc/ssh.old/sshd_config_default /etc/ssh/
        diff /etc/ssh/sshd_config /etc/ssh/sshd_config_default
        vim  /etc/ssh/sshd_config
        systemctl restart sshd

        ssh -V
        rpm -qa|grep openssl \\don't remove these ; avoid yum -y install wget ..etc  \\ no file libssl.so.10
        #rpm -e --nodeps openssl-1.0.2k-16.el7_6.1.x86_64
        #rpm -e --nodeps openssl-libs-1.0.2k-16.el7_6.1.x86_64

        systemctl disable xinetd.service
        systemctl disable telnet.socket

        systemctl stop telnet.socket
        systemctl stop  xinetd


HTTP/2 升级到新版 \\ curl -I domain \\ nginx server need to add ca ssl
########################
#host244 host245
# if ssl cert on nginx sever \\ nginx conf: listen 443 ssl http2;
# https://httpwg.org/specs/rfc7540.html#starting
# 升级 nginx 可以升级到 http/2
# nginx version 1.16.0

# quickly

    # backup nginx and config file
    # ./configure ... && make  && make install
    # nginx -t
    # nginx  -s reload

    # nginx install

        1 #### package prepare
        wget http://nginx.org/download/nginx-1.16.0.tar.gz

        2 #### install
        yum install  -y make gcc gcc-c++ pcre-devel \\ openssl-devel: don't install it if has update ssh
        tar -zxvf nginx-1.16.0.tar.gz
        cd nginx-1.16.0
        #./configure --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_realip_module
        ./configure --prefix=/usr/local/nginx \\ monitor old version

            Info:
            Configuration summary
              + using system PCRE library
              + using system OpenSSL library
              + using system zlib library

              nginx path prefix: "/usr/local/nginx"
              nginx binary file: "/usr/local/nginx/sbin/nginx"
              nginx modules path: "/usr/local/nginx/modules"
              nginx configuration prefix: "/usr/local/nginx/conf"
              nginx configuration file: "/usr/local/nginx/conf/nginx.conf"
              nginx pid file: "/usr/local/nginx/logs/nginx.pid"
              nginx error log file: "/usr/local/nginx/logs/error.log"
              nginx http access log file: "/usr/local/nginx/logs/access.log"
              nginx http client request body temporary files: "client_body_temp"
              nginx http proxy temporary files: "proxy_temp"
              nginx http fastcgi temporary files: "fastcgi_temp"
              nginx http uwsgi temporary files: "uwsgi_temp"
              nginx http scgi temporary files: "scgi_temp"

        make && make install

        3 #### start
        vim /etc/init.d/nginx
        chmod 777 /etc/init.d/nginx
        service nginx start | stop | restart | reload | stop
        chkconfig --add /etc/init.d/nginx
        chkconfig nginx on
        chkconfig --list nginx
            nginx           0:off   1:off   2:on    3:on    4:on    5:on    6:off

        4 #### port and firewall
        netstat -nltp|grep nginx
            tcp        0      0 0.0.0.0:80      0.0.0.0:*      LISTEN      8078/nginx: master

        # you can open if allow
        systemctl  status | start firewalld
        firewall-cmd --zone=public --add-port=80/tcp --permanent
        firewall-cmd --reload

        # 4-1 普通用户启动 nginx
            useradd nginx
            vim nginx.conf
                user nginx;
                listen 8081; #当 su nginx 启动时；普通用户不能监听 1024 以下的端口
            chown -R nginx:nginx /usr/local/nginx ## 如果 nginx 运行还涉及比如额外的日志路径，也要给对应权限
            chmod -R 700 /usr/local/nginx
            su nginx
            /usr/local/nginx/sbin/nginx
            exit
            将80 端口转发至 8081 # 这种方法会耗费服务器性能
                  systemctl start firewalld
                  firewall-cmd --zone=public --list-ports
                  firewall-cmd --zone=public --add-port=ALL/tcp --permanent
                  firewall-cmd --zone=public --add-port=0-65535/tcp --permanent ##开发所有端口,这里因为外部还有一层防火墙
                  firewall-cmd --add-forward-port=port=80:proto=tcp:toaddr=127.0.0.1:toport=8081 --permanent ## 配置端口转发，本地需要有对应的两个端口
                  firewall-cmd --reload


            setcap cap_net_bind_service=+eip /usr/local/nginx/sbin/nginx #获取到 root的权限， 1024 以下端口默认普通用户不能使用; 推荐方式
            usermod -s /sbin/nologin nginx
        5 ####访问测试，看是否可以看到 nginx 首页

    # nginx upgrade
        #backup
            cp -r /usr/local/nginx /usr/local/nginx_bak
            ll /usr/local/nginx_bak
        # update
            wget http://nginx.org/download/nginx-1.16.0.tar.gz
            yum install  -y make gcc gcc-c++ pcre-devel \\ openssl-devel: don't install it if has update ssh
            tar -zxvf nginx-1.16.0.tar.gz
            cd /root/nginx-1.16.0
            #./configure --help \\ old nginx -V get configure info
            #./configure --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_realip_module --with-http_v2_module \\ update \\ with-http_stub_status_module nginx status
            ./configure --prefix=/usr/local/nginx --with-http_ssl_module --with-http_v2_module  --with-openssl=/usr/local/openssl
            make
                vim /root/nginx-1.16.0/auto/lib/openssl/conf
                    line 39-45 remove .openssl
                        CORE_INCS="$CORE_INCS $OPENSSL/include
                ./configure && make again
            make install

    #  test
         nginx conf:
             # http to https
             #server {
             #       listen       80;
             #       server_name  stg-op.xxx.com;
             #       return 301 https://$server_name$request_uri;
             #
             #   }

             # http2 \\ firefox browser test result: X-Firefox-Spdy: "h2"
              server {
                    listen       443 ssl http2;
                    server_name  stg-op.xxx.com;

                    ssl_certificate      /root/cert/Nginx/stg-op.xxx.com.crt;
                    ssl_certificate_key  /root/cert/Nginx/stg-op.xxx.com.key;

                    # ssl_session_cache    shared:SSL:1m;
                    # ssl_session_timeout  5m;

                    #ssl_ciphers  HIGH:!aNULL:!MD5;
                    # adapt to more browser
                    # ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:DHE-RSA-AES128-GCM-SHA256:AES256+EDH:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES128-SHA256:DHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES256-GCM-SHA384:AES128-GCM-SHA256:AES256-SHA256:AES128-SHA256:AES256-SHA:AES128-SHA:DES-CBC3-SHA:HIGH:!aNULL:!eNULL:!EXPORT:!DES:!MD5:!PSK:!RC4;
                    }


apache-tomcat7 升级到 7.0.107
########################
host255





##########################################################################

http{
    server_tokens off; \\ 隐藏 nginx 版本信息
    autoindex off; \\ 不递归目录 禁止网站目录浏览

        # nginx conf ssl
            server {
            listen       443 ssl;
            server_name  localhost;

            ssl_certificate      cert.crt;
            ssl_certificate_key  cert.key;

            ssl_session_cache    shared:SSL:1m;
            ssl_session_timeout  5m;

            ssl_ciphers  HIGH:!aNULL:!MD5;
        #    ssl_prefer_server_ciphers  on;

            location / {
                root   html;
                index  index.html index.htm;
                }
            }
        # nginx -t
        # nginx -s stop && ps -ef | grep nginx
        # nginx

            去阿里云申请一个证书, 申请之后将 nginx 的证书文件下载下来, 有两个文件, 后缀分别是 pem 和 key 或者是 crt 和 key
            # ssl写在443端口后面。这样http和https的链接都可以用
            listen 443 ssl http2 default_server;
            server_name chat.chengxinsong.cn;

            # HSTS的合理使用，max-age表明HSTS在浏览器中的缓存时间，includeSubdomainscam参数指定应该在所有子域上启用HSTS，preload参数表示预加载，通过Strict-Transport-Security: max-age=0将缓存设置为0可以撤销HSTS
            add_header Strict-Transport-Security "max-age=63072000; includeSubdomains; preload";

            ssl_certificate   /usr/local/nginx/cert/2540136_chat.chengxinsong.cn.pem;
              ssl_certificate_key /usr/local/nginx/cert/2540136_chat.chengxinsong.cn.key;

            # 分配20MB的共享内存缓存，不同工作进程共享TLS会话信息
            # ssl_session_cache shared:SSL:20m;

            # 设置会话缓存过期时间1h
            ssl_session_timeout 60m;

            # TLS协议的合理配置
            # 指定TLS协议的版本，不安全的SSL2和SSL3要废弃掉
            ssl_protocols TLSv1 TLSv1.1 TLSv1.2;

            # 启用ssl_prefer_server_ciphers，用来告诉Nginx在TLS握手时启用服务器算法优先，由服务器选择适配算法而不是客户端
            ssl_prefer_server_ciphers on;

            # 优先选择支持前向加密的算法，且按照性能的优先顺序排列
            ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4;

            # 会话恢复的合理使用
            # 配置会话票证，减少了TLS握手的开销
            ssl_session_tickets on;

            # nginx conf
                user  nginx nginx;
                worker_processes  1;

                error_log  /var/log/nginx/error.log;

                pid        /var/run/nginx/nginx.pid;

                events {
                    use epoll;
                    worker_connections  1024;
                }

                http {
                    include       mime.types;
                    default_type  application/octet-stream;
                    charset UTF-8;

                    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                                      '$status $body_bytes_sent "$http_referer" '
                                      '"$http_user_agent" "$http_x_forwarded_for"';

                    access_log  /var/log/nginx/access.log  main;

                    sendfile        on;

                    keepalive_timeout  65;

                    #隐藏Nginx版本信息，禁止网站目录浏览
                    server_tokens off;
                    autoindex off;
                    #当FastCGI后端服务器处理请求给出http响应码为4xx和5xx时，就转发给nginx
                    fastcgi_intercept_errors on;

                    #关于fastcgi的配置
                    fastcgi_connect_timeout 300;
                    fastcgi_send_timeout 300;
                    fastcgi_read_timeout 300;
                    fastcgi_buffer_size 64k;
                    fastcgi_buffers 4 64k;
                    fastcgi_busy_buffers_size 128k;
                    fastcgi_temp_file_write_size 128k;

                    #支持gzip压缩
                    gzip on;
                    gzip_min_length 1k;
                    gzip_buffers 16 64k;
                    gzip_http_version 1.1;
                    gzip_comp_level 6;
                    gzip_types text/plain application/x-javascript text/css application/javascript text/javascript image/jpeg image/gif image/png application/xml application/json;
                    gzip_vary on;
                    gzip_disable "MSIE [1-6].(?!.*SV1)";

                    server {
                        listen 80;
                        server_name www.lcgod.com lcgod.com;
                        charset utf-8;
                        access_log  /var/log/nginx/access.log main;
                        rewrite ^/(.*)$ https://www.lcgod.com/$1 permanent;
                    }

                    server {
                        listen               443 ssl http2;
                        server_name          www.lcgod.com lcgod.com;

                        #301重定向
                        if ($host = 'lcgod.com') {
                            rewrite  ^/(.*)$    https://www.lcgod.com$1 permanent;
                        }

                        # 不产生日志
                        access_log off;
                        ssl_certificate /etc/nginx/server.crt;
                        ssl_certificate_key /etc/nginx/server.key;
                        ssl_stapling on;
                        ssl_stapling_verify on;
                        ssl_trusted_certificate /etc/nginx/server.crt;
                        resolver 8.8.8.8 114.114.114.114 valid=300s;
                        resolver_timeout 5s;
                        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
                        ssl_ciphers EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+AES128:RSA+AES128:EECDH+AES256:RSA+AES256:EECDH+3DES:RSA+3DES:!aNULL:!MD5:!RC4:!DHE:!kEDH;
                        add_header Strict-Transport-Security "max-age=15768001; preload";
                        add_header X-Content-Type-Options nosniff;

                        #设置网站根目录
                        root   /home/www/blog;
                        index  index.php index.html;

                        #设置css/javascript/图片等静态资源的缓存时间
                        location ~ .*\.(css|js|ico|png|gif|jpg|json|mp3|mp4|flv|swf)(.*) {
                            expires 60d;
                        }

                        # URLRwrite
                        location / {
                            try_files $uri $uri/ /index.php?$query_string;
                        }

                        ## 设置Nginx和php通信机制为tcp的socket模式，而不是直接监听9000端口
                        location ~ \.php(.*)$ {
                            fastcgi_pass unix:/var/run/php-fpm/php-fpm.sock;
                            fastcgi_index index.php;
                            fastcgi_split_path_info ^((?U).+\.php)(/?.+)$;
                            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                            include fastcgi_params;
                        }
                    }
                }
		
