@echo off

echo Creating app pool...
C:\Windows\System32\inetsrv\appcmd.exe add apppool /name:website /managedRuntimeVersion:v4.0 /managedPipelineMode:Integrated

echo Creating website...
C:\Windows\System32\inetsrv\appcmd.exe add site /name:website /physicalPath:\\localhost\website_share /bindings:http/*:80:
C:\Windows\System32\inetsrv\appcmd.exe set app "website/" /applicationPool:"website"

echo Website is created. You can acces it by url http://127.0.0.1:80/
