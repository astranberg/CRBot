@echo off
echo Install 425x765.reg
REGEDIT.EXE  /S  "%~dp0\425x765.reg"
@echo off
echo Closing all Bluestacks Process
taskkill /f /t /im "HD-Agent.exe" /im "HD-BlockDevice.exe" /im "HD-FrontEnd.exe" /im "HD-Network.exe" /im "HD-Service.exe" /im "HD-SharedFolder.exe" /im "HD-UpdaterService.exe" /im "HD-LogRotatorService.exe"
@echo off
echo All Bluestacks Process Closed
pause