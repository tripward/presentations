Import-Module ServerManager

# Create a symlink and make a network share for the shared Vagrant folder to bypass a known issue with IIS sites and VirtualBox shared drives.
$appDirExists = Test-Path C:\website
$networkShareExists = Get-WmiObject Win32_Share -Filter "path='C:\\website'"

If (!$appDirExists)
{
	Start-Process "cmd.exe" -ArgumentList "/c mklink /d C:\website C:\website_sym" -Wait | Out-Null
}

if ($networkShareExists -eq $null)
{
	(Get-WMIObject Win32_Share -List).Create("C:\website", "website_share", 0)
}
