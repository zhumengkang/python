# -*- coding: utf-8 -*-
# @Time    : 2021/9/19 21:37
# @Author  : plan (pzh1024@126.com)
# @File    : Linux服务监控.py
# @Desc    :
# @Version :
#----------------------------------------------------------
import paramiko

ip_adress = "171.35.125.222,171.35.123.167"
userName = "root"
password = "qky2021BZZ+++"

def ssh_login(ip,userName,password):
    """
    提供远程登录服务，并返回ssh连接对象
    """
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(ip, username=userName, password=password,timeout=5)
    return ssh

def command(ip,ssh,shell):
    """
    ssh提供shell指令输入
    """
    result = ssh.exec_command(shell)[1]
    print("-------------------------")
    print("当前IP: {}".format(ip))
    for i in result.readlines():
        print(i,end="")
    print("-------------------------")


def mainFunc():
    shell = input("请输入需要执行的指令:\n")
    if "," in ip_adress:
        ip_list = ip_adress.split(",")
        for ip in ip_list:
            ssh = ssh_login(ip,userName,password)
            command(ip,ssh,shell)
    else:
        ssh = ssh_login(ip_adress, userName, password)
        command(ip_adress,ssh, shell)

mainFunc()
