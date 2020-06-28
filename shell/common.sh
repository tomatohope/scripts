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
