echo "ColdFusion - Installing web configuration tool"

Start-Process "cmd.exe" -ArgumentList "/c C:\ColdFusion\cfusion\runtime\bin\wsconfig.exe -ws iis -site 0 -v"

echo "ColdFusion 11 - finished Installing web configuration tool"

Restart-Service "ColdFusion 2016 Application Serve"

exit
