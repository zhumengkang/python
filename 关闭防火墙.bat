



echo "���ڹرշ���ǽ"
netsh advfirewall set allprofiles state off
echo "�Ѿ��رշ���ǽ"

echo ......
echo win10��ֹ��̨�Զ����£�����֮��win10���������ظ����ļ������ļ�ʱ ��ʹ�ù���ԱȨ�ޣ����򽫻�ִ��ʧ��
echo ......
echo ���ڽ���win10���£�WaaSMedicSvc��......
echo ......
REG add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d "4" /f
echo ......
echo ���ڽ���win10���£�wuauserv��......
echo ......
REG add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d "4" /f
echo ......
echo ִ����ɣ�
echo ......

echo win10��ֹ��̨�Զ����£�����֮��win10���������ظ����ļ������ļ�ʱ ��ʹ�ù���ԱȨ�ޣ����򽫻�ִ��ʧ��

echo ��������Ҫ���ĵ�������

set /p name=��
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\ComputerName\ActiveComputerName" /v ComputerName /t reg_sz /d %name% /f
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters" /v "NV Hostname" /t reg_sz /d %name% /f
reg add "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters" /v Hostname /t reg_sz /d %name% /f


pause
