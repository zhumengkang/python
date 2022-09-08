@echo off
echo 正在检测管理员权限
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
set workpath=C:\Users\Administrator\Downloads\Handle
dir %workpath% >nul 2>nul
if /i "%errorlevel%" == "1" mkdir %workpath%
pushd %workpath%
dir handle.exe > nul 2>nul
if /i "%errorlevel%" == "1" echo 未检测到handle，正在下载handle工具 && powershell (new-object System.Net.WebClient).DownloadFile( 'http://localhost','%workpath%\handle.exe')
echo 如无报错，初始化完毕
pause
:main
cls
title 主界面
rem 主界面
echo=
echo=
echo=
echo			1、钉钉版
echo			2、钉钉RC版
echo=
echo=
echo		适配win10 1903，其他版本自行测试
echo		使用钉钉版会顺带关闭RC版的句柄，不优化了
echo=
echo=
set leixing=
set /p leixing=请选择类型:
if /i "%leixing%" == "1" goto DD
if /i "%leixing%" == "2" goto DDRC
goto main

:DD
::@echo on
set name1=DingTalk
set name2=DingDing
goto Double

:DDRC
::@echo on
set name1=DingTalkRC
set name2=DingDingRC
goto Double


:Double
handle.exe -a "BaseNamedObjects\{{239B7D43-86D5-4E5C-ADE6-CEC42155B475}}%name1%" > 1.txt
del 2.txt
del 3.txt
for /f "tokens=2,3 delims=:" %%i in (1.txt) do (
echo %%i %%j >> 2.txt
)
for /f "tokens=1,4 delims= " %%i in (2.txt) do (
echo %%i %%j >> 3.txt
handle.exe -p %%i -c %%j -y
)
echo 显示Handle closed.则成功
"C:\Program Files (x86)\%name2%\DingtalkLauncher.exe"
pause



