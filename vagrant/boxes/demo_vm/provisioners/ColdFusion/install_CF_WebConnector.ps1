echo "ColdFusion 11 - Installing web configuration tool"

Start-Process "cmd.exe" -ArgumentList "/c C:\ColdFusion11\cfusion\runtime\bin\wsconfig.exe -ws iis -site 0 -v"

echo "ColdFusion 11 - finished Installing web configuration tool"
exit
