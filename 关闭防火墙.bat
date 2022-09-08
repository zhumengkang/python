



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

echo 请输入你要更改的主机名

set /p name=：
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\ComputerName\ActiveComputerName" /v ComputerName /t reg_sz /d %name% /f
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters" /v "NV Hostname" /t reg_sz /d %name% /f
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters" /v Hostname /t reg_sz /d %name% /f


pause
