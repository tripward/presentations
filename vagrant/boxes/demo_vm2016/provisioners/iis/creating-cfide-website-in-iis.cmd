@echo off

echo Creating app pool...
C:\Windows\System32\inetsrv\appcmd.exe add apppool /name:CFIDE /managedRuntimeVersion:v4.0 /managedPipelineMode:Integrated

echo Creating cfide website...
C:\Windows\System32\inetsrv\appcmd.exe add site /name:CFIDE /physicalPath:C:\ColdFusion\cfusion\wwwroot\CFIDE\administrator /bindings:http/*:89:
C:\Windows\System32\inetsrv\appcmd.exe set app "CFIDE/" /applicationPool:"CFIDE"

echo Website is created. You can acces it by url http://127.0.0.1:89/
