@echo off
setlocal enabledelayedexpansion

:menu
cls
echo IP Ping Script
echo ================
echo 1. Add IP address
echo 2. Remove IP address
echo 3. View IP addresses
echo 4. Run continuous ping
echo 5. Exit
echo.

set /p choice=Enter your choice (1-5): 

if "%choice%"=="1" goto addIP
if "%choice%"=="2" goto removeIP
if "%choice%"=="3" goto viewIPs
if "%choice%"=="4" goto runPing
if "%choice%"=="5" goto end

echo Invalid choice. Please try again.
pause
goto menu

:addIP
set /p newIP=Enter the IP address to add: 
echo !newIP!>> ip_list.txt
echo IP address added successfully.
pause
goto menu

:removeIP
set /p removeIP=Enter the IP address to remove: 
type nul > temp.txt
for /f "tokens=*" %%a in (ip_list.txt) do (
    if not "%%a"=="!removeIP!" echo %%a>> temp.txt
)
move /y temp.txt ip_list.txt > nul
echo IP address removed successfully.
pause
goto menu

:viewIPs
echo Current IP addresses:
type ip_list.txt
pause
goto menu

:runPing
cls
echo Running continuous ping for all IP addresses.
echo Press Ctrl+C to stop pinging a specific IP.
echo Close the window to stop all pings and exit the script.
echo.

for /f "tokens=*" %%a in (ip_list.txt) do (
    start cmd /k "echo Pinging %%a && ping -t %%a"
)

echo All pings started. Close this window to stop all pings and exit.
pause
goto menu

:end
echo Exiting script. Goodbye!
exit
