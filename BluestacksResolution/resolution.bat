@echo off
REGEDIT.EXE  /S  "%~dp0\500x900.reg"
taskkill /f /t /im "HD-Agent.exe" /im "HD-BlockDevice.exe" /im "HD-FrontEnd.exe" /im "HD-Network.exe" /im "HD-Service.exe" /im "HD-SharedFolder.exe" /im "HD-UpdaterService.exe" /im "HD-LogRotatorService.exe"