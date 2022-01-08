# Windows 2016 - Disable Services
# https://docs.microsoft.com/en-us/windows-server/security/windows-services/security-guidelines-for-disabling-system-services-in-windows-server

$ErrorActionPreference = "Stop"

Write-Host "Disable ActiveX Installer (AxInstSV)"
Get-Service -Name AxInstSV | Set-Service -StartupType Disabled

Write-Host "Disable Bluetooth Support Service"
Get-Service -Name bthserv | Set-Service -StartupType Disabled

Write-Host "Disable CDPUserSvc"
Get-Service -Name CDPUserSvc | Set-Service -StartupType Disabled

Write-Host "Disable WAP Push Message Routing Service"
Get-Service -Name dmwappushservice | Set-Service -StartupType Disabled

Write-Host "Disable Downloaded Maps Manager"
Get-Service -Name MapsBroker | Set-Service -StartupType Disabled

Write-Host "Disable Geolocation Service"
Get-Service -Name lfsvc | Set-Service -StartupType Disabled

Write-Host "Disable Internet Connection Sharing (ICS)"
Get-Service -Name SharedAccess | Set-Service -StartupType Disabled

Write-Host "Disable Link-Layer Topology Discovery Mapper"
Get-Service -Name lltdsvc | Set-Service -StartupType Disabled

Write-Host "Disable Microsoft Account Sign-in Assistant"
Get-Service -Name wlidsvc | Set-Service -StartupType Disabled

Write-Host "Disable Network Connection Broker"
Get-Service -Name NcbService | Set-Service -StartupType Disabled

Write-Host "Disable Print Spooler"
Get-Service -Name Spooler | Set-Service -StartupType Disabled

Write-Host "Disable Printer Extensions and Notifications"
Get-Service -Name PrintNotify | Set-Service -StartupType Disabled

Write-Host "Disable Program Compatibility Assistant Service"
Get-Service -Name PcaSvc | Set-Service -StartupType Disabled

Write-Host "Disable Quality Windows Audio Video Experience"
Get-Service -Name QWAVE | Set-Service -StartupType Disabled

Write-Host "Disable Radio Management Service"
Get-Service -Name RmSvc | Set-Service -StartupType Disabled

Write-Host "Disable Sensor Data Service"
Get-Service -Name SensorDataService | Set-Service -StartupType Disabled

Write-Host "Disable Sensor Monitoring Service"
Get-Service -Name SensrSvc | Set-Service -StartupType Disabled

Write-Host "Disable Sensor Service"
Get-Service -Name SensorService | Set-Service -StartupType Disabled

Write-Host "Disable Shell Hardware Detection"
Get-Service -Name ShellHWDetection | Set-Service -StartupType Disabled

Write-Host "Disable Smart Card Device Enumeration Service"
Get-Service -Name ScDeviceEnum | Set-Service -StartupType Disabled

Write-Host "Disable SSDP Discovery"
Get-Service -Name SSDPSRV | Set-Service -StartupType Disabled

Write-Host "Disable Still Image Acquisition Events"
Get-Service -Name WiaRpc | Set-Service -StartupType Disabled

Write-Host "Disable Touch Keyboard and Handwriting Panel Service"
Get-Service -Name TabletInputService | Set-Service -StartupType Disabled

Write-Host "Disable UPnP Device Host"
Get-Service -Name upnphost | Set-Service -StartupType Disabled

Write-Host "Disable WalletService"
Get-Service -Name WalletService | Set-Service -StartupType Disabled

Write-Host "Disable Windows Audio"
Get-Service -Name Audiosrv | Set-Service -StartupType Disabled

Write-Host "Disable Windows Audio Endpoint Builder"
Get-Service -Name AudioEndpointBuilder | Set-Service -StartupType Disabled

Write-Host "Disable Windows Biometric Service"
Get-Service -Name WbioSrvc | Set-Service -StartupType Disabled

Write-Host "Disable Windows Camera Frame Server"
Get-Service -Name FrameServer | Set-Service -StartupType Disabled

Write-Host "Disable Windows Insider Service"
Get-Service -Name wisvc | Set-Service -StartupType Disabled

Write-Host "Disable Windows Push Notifications System Service"
Get-Service -Name WpnService | Set-Service -StartupType Disabled

Write-Host "Disable Xbox Live Auth Manager"
Get-Service -Name XblAuthManager | Set-Service -StartupType Disabled

Write-Host "Disable Xbox Live Game Save"
Get-Service -Name XblGameSave | Set-Service -StartupType Disabled

Write-Host "Disable Scheduled Task XblGameSaveTask"
Get-ScheduledTask -TaskName XblGameSaveTask | Disable-ScheduledTask

Write-Host "Disable Scheduled Task XblGameSaveTaskLogon"
Get-ScheduledTask -TaskName XblGameSaveTaskLogon | Disable-ScheduledTask