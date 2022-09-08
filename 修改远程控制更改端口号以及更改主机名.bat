@echo off
REG ADD HKLM\SYSTEM\CurrentControlSet\Control\Terminal" "Server /v fDenyTSConnections /t REG_DWORD /d 00000000 /f

echo "正在关闭防火墙"
netsh advfirewall set allprofiles state off
echo "已经关闭防火墙"

echo ......
echo win10禁止后台自动更新，禁用之后，win10将不会下载更新文件。打开文件时 请使用管理员权限，否则将会执行失败
echo ......
echo 正在禁用win10更新（WaaSMedicSvc）......
echo ......
REG add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d "4" /f
echo ......
echo 正在禁用win10更新（wuauserv）......
echo ......
REG add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d "4" /f
echo ......
echo 执行完成！
echo ......

echo win10禁止后台自动更新，禁用之后，win10将不会下载更新文件。打开文件时 请使用管理员权限，否则将会执行失败

color f0
echo 修改远程桌面3389端口(支持Windows 2003 2008 2008R2 2012 2012R2 7 8 10 )
echo 自动添加防火墙规则
echo %date%   %time%
echo    祝孟康要求你以下输入你要更改的端口号 
set /p c= 请输入新的端口:
if "%c%"=="" goto end
goto edit
:edit
netsh advfirewall firewall add rule name="Remote PortNumber" dir=in action=allow protocol=TCP localport="%c%"
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\Wds\rdpwd\Tds\tcp" /v "PortNumber" /t REG_DWORD /d "%c%" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v "PortNumber" /t REG_DWORD /d "%c%" /f
echo 修改成功
net stop TermService /y
net start TermService
pause
exit
:end
echo 修改失败





echo 请输入你要更改的主机名

set /p name=：
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\ComputerName\ActiveComputerName" /v ComputerName /t reg_sz /d %name% /f
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters" /v "NV Hostname" /t reg_sz /d %name% /f
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters" /v Hostname /t reg_sz /d %name% /f


pause

