# Install IIS and related Windows features.
Import-Module ServerManager
$features = @(
   "Web-WebServer",
   "Web-Static-Content",
   "Web-Http-Errors",
   "Web-Http-Redirect",
   "Web-Stat-Compression",
   "Web-Filtering",
   "Web-Asp-Net45",
   "Web-Net-Ext45",
   "Web-ISAPI-Ext",
   "Web-ISAPI-Filter",
   "Web-CGI"
   "Web-Mgmt-Console",
   "Web-Mgmt-Tools",
   "NET-Framework-45-ASPNET"
)
Add-WindowsFeature $features -Verbose

Foreach ($feature in $iisFeatures)
{
	$featureInstalled = Get-WindowsFeature $feature
	If (!$featureInstalled.Installed)
	{
		Add-WindowsFeature $feature
	}
}
