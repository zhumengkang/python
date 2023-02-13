#!/bin/bash
lnx_ver=`uname -a|grep 'Ubuntu'`
if [ -n "$lnx_ver" ];then
    echo "this is a Ubuntu"
    echo $lnx_ver
    #卸载系统里存在的docker
    apt-get remove -y  docker docker-engine docker.io containerd runc
    apt-get update
    #安装docker
    apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io
    apt-cache madison docker-ce
    apt-get install -y docker-ce=5:18.09.1~3-0~ubuntu-xenial
    #安装docker-compose
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
else
    echo "this is a centos"
    #echo $lnx_ver
    #卸载系统里存在的docker
    yum remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
    #安装docker
    yum install -y yum-utils \
    device-mapper-persistent-data \
    lvm2
    yum-config-manager \
       --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo
    yum install -y docker-ce docker-ce-cli containerd.io
    #启动docker
    systemctl start docker
    #安装docker-compose
    curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi
