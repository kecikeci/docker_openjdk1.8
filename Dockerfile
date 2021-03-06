# centos6.8+阿里云yum源+常用软件
# 个人博客：https://4xx.me
FROM hub.c.163.com/library/centos:6.8
MAINTAINER https://4xx.me

RUN cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN yum install wget -y

# 更换阿里源
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo

# 安装常用软件
RUN yum clean all
RUN yum install -y yum-plugin-ovl || true
RUN yum install -y vim tar wget curl rsync bzip2 iptables tcpdump less telnet net-tools lsof sysstat cronie passwd openssl openssh-server kde-l10n-Chinese glibc-common

# 安装openjdk1.8
RUN yum remove java* -y
RUN yum install java-1.8.0-openjdk* -y

# 清除yum缓存
RUN yum clean all
RUN rm -rf /var/cache/yum/*

# 中文设置
ENV LANG="zh_CN.UTF-8" 
RUN echo "export LC_ALL=zh_CN.UTF-8"  >>  /etc/profile