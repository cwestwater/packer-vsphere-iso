# Windows 2022 - Remove Features

$ErrorActionPreference = "Stop"

# Remove XPS Viewer
Write-Host "Remove XPS Viewer"
Uninstall-WindowsFeature -Name XPS-Viewer

# Remove Microsoft XPS Document Writer
Write-Host "Remove Microsoft XPS Document Writer"
Disable-WindowsOptionalFeature -Online -FeatureName Printing-XPSServices-Features -NoRestart

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
Disable-WindowsOptionalFeature -Online -FeatureName Printing-PrintToPDFServices-Features -NoRestart