# Windows 2016 - Customise OS

$ErrorActionPreference = "Stop"

# Enable RDP Connections
Write-Host "Enable RDP Connections"
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name fDenyTSConnections -Type DWord -Value 0 | Out-Null
Enable-NetFirewallRule -DisplayGroup "Remote Desktop" | Out-Null

# Add Logoff icon to Desktop
Write-Host "Add Logoff icon to Public Desktop"
$shortcutPath = "C:\Users\Public\Desktop\Loggoff.lnk"
$iconLocation = "C:\Windows\system32\shell32.dll"
$iconArrayIndex = 44
$shell = New-Object -ComObject ("WScript.Shell")
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = "C:\Windows\System32\logoff.exe"
$shortcut.IconLocation = "$iconLocation, $iconArrayIndex"
$shortcut.Save()

# Create C:\Temp
Write-Host "Create C:\Temp"
New-Item -Path C:\Temp -ItemType Directory | Out-Null

# Disable VMware Tools System Tray Icon
Write-Host "Disable VMware Tools icon in System Tray"
Set-ItemProperty -Path 'HKLM:\SOFTWARE\VMware, Inc.\VMware Tools' -Name 'ShowTray' -Value 0 | Out-Null

# Enable Firewall
Write-Host "Enable Windows Firewall"
netsh Advfirewall set allprofiles state on

# Clear Event Logs
Write-Host "Clear Event Logs"
Get-EventLog -LogName * | ForEach-Object { Clear-EventLog -LogName $_.Log } -Verbose | Out-Null