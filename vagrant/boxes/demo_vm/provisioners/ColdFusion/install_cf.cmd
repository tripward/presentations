echo "ColdFusion 11 - Installing and Basic basic configuration "
echo "Change to shared dir"
cd c:\vagrant\provisioners\ColdFusion
echo "Install CF silently per property files"
ColdFusion_11_WWEJ_win64_011315.exe -f c:\vagrant\provisioners\ColdFusion\cf11_silent.properties
echo "Finished Installing cf"
