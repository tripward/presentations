echo "ColdFusion 11 - Installing and Basic basic configuration "
echo "Change to shared dir"
cd c:\vagrant\provisioners\ColdFusion
echo "Install CF silently per property files"
ColdFusion_2016_WWEJ_win64.exe -f c:\vagrant\provisioners\ColdFusion\cf_silent.properties
echo "Finished Installing cf"
