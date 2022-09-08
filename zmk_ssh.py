#!/usr/local/bin/python3
from paramiko.ssh_exception import NoValidConnectionsError,AuthenticationException
print ('=='*50)
qwe = "hostname && ip a | grep 10.0.0. |awk '{print $2}'&&"
shell = input("请输入你需要执行的命令：\n")
zmk = qwe+shell 
def connect(cmd,hostname,user,password):
    import paramiko
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    try:
        client.connect(
            hostname=hostname,
            username=user,
            password=password
        )
        stdin, stdout, stderr = client.exec_command(zmk)
        a = stdout.read().decode('utf-8')
        print(stdout.read().decode('utf-8'))
        return a
    except NoValidConnectionsError as e:
        return '主机%s连接失败' %(hostname)
    except AuthenticationException as e:
        return '主机%s密码错误' %(hostname)
    except Exception as e:
        return '未知错误:',e
    finally:
        client.close()
with open('/home/python/hosts') as f:
    for line in f:
        hostname,username,password = line.strip().split(':')
        res = connect('hostname',hostname,username,password)
        # print(hostname.center(50,'*'))
        print('主机名:', res)
print ('=='*50)
print ('脚本已执行完成，如有问题请联系祝孟康 zhumk@biyouxinli.com')
