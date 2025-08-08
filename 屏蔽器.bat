@echo off
title 极域电子教室屏蔽工具 (Win7 纯批处理)
color 0a

:menu
cls
echo ================================
echo    极域电子教室屏蔽工具
echo    作者：Mbilse 学习版
echo ================================
echo 1. 屏蔽极域控制
echo 2. 恢复正常使用
echo 0. 退出
echo ================================
set /p choice=请选择操作: 

if "%choice%"=="1" goto block
if "%choice%"=="2" goto unblock
if "%choice%"=="0" exit
goto menu

:block
echo 正在结束极域进程...
taskkill /f /im StudentMain.exe >nul 2>nul
taskkill /f /im Student.exe >nul 2>nul
taskkill /f /im GStudent.exe >nul 2>nul
taskkill /f /im studentmain.exe >nul 2>nul

echo 添加防火墙规则屏蔽端口...
netsh advfirewall firewall add rule name="Block Jiyu TCP" dir=out protocol=TCP localport=4705 action=block >nul
netsh advfirewall firewall add rule name="Block Jiyu UDP" dir=out protocol=UDP localport=4706 action=block >nul
netsh advfirewall firewall add rule name="Block Jiyu TCP in" dir=in protocol=TCP localport=4705 action=block >nul
netsh advfirewall firewall add rule name="Block Jiyu UDP in" dir=in protocol=UDP localport=4706 action=block >nul

echo 屏蔽已完成！
pause
goto menu

:unblock
echo 正在移除防火墙规则...
netsh advfirewall firewall delete rule name="Block Jiyu TCP" >nul
netsh advfirewall firewall delete rule name="Block Jiyu UDP" >nul
netsh advfirewall firewall delete rule name="Block Jiyu TCP in" >nul
netsh advfirewall firewall delete rule name="Block Jiyu UDP in" >nul

echo 恢复完成！（如果被控制，请重启客户端）
pause
goto menu
