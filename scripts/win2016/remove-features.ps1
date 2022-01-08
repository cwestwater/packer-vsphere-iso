# Windows 2016 - Remove Features

$ErrorActionPreference = "Stop"

# Remove XPS Viewer
Write-Host "Remove SMB 1.0/CIFS File Sharing Support"
Uninstall-WindowsFeature -Name FS-SMB1

# Remove PowerShell v2
Write-Host "Remove PowerShell v2"
Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2 -NoRestart

# Remove Windows Media Player
Write-Host "Remove Windows Media Player"
Disable-WindowsOptionalFeature -Online -FeatureName WindowsMediaPlayer -NoRestart

# Remove Windows Media Playback
Write-Host "Remove Windows Media Playback"
Disable-WindowsOptionalFeature -Online -FeatureName MediaPlayback -NoRestart

# Remove Internet Explorer 11
Write-Host "Remove Internet Explorer 11"
Disable-WindowsOptionalFeature -Online -FeatureName Internet-Explorer-Optional-amd64 -NoRestart

# Remove Microsoft Print to PDF
Write-Host "Remove Microsoft Print to PDF"
Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Printing-PrintToPDFServices-Package -NoRestart
Disable-WindowsOptionalFeature -Online -FeatureName Printing-PrintToPDFServices-Features -NoRestart

# Remove Microsoft XPS Document Writer
Write-Host "Remove Microsoft XPS Document Writer"
Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Printing-XPSServices-Package -NoRestart
Disable-WindowsOptionalFeature -Online -FeatureName Printing-XPSServices-Features -NoRestart