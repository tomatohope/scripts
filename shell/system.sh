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

