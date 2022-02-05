# Windows 2022 - Remove Features

$ErrorActionPreference = "Stop"

# Determine if Core or Desktop Experience
$osVersion = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name InstallationType

# Common Features

# Remove PowerShell v2
Write-Host "Remove PowerShell v2"
Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2 -NoRestart | Out-Null

# If Desktop Experience is installed disable these services, otherwise Exit cleanly

if ( $osVersion -eq "Server" )
{
    # Remove XPS Viewer
    Write-Host "Remove XPS Viewer"
    Uninstall-WindowsFeature -Name XPS-Viewer | Out-Null

    # Remove Microsoft XPS Document Writer
    Write-Host "Remove Microsoft XPS Document Writer"
    Disable-WindowsOptionalFeature -Online -FeatureName Printing-XPSServices-Features -NoRestart | Out-Null

    # Remove Windows Media Player
    Write-Host "Remove Windows Media Player"
    Disable-WindowsOptionalFeature -Online -FeatureName WindowsMediaPlayer -NoRestart | Out-Null

    # Remove Windows Media Playback
    Write-Host "Remove Windows Media Playback"
    Disable-WindowsOptionalFeature -Online -FeatureName MediaPlayback -NoRestart | Out-Null

    # Remove Internet Explorer 11
    Write-Host "Remove Internet Explorer 11"
    Disable-WindowsOptionalFeature -Online -FeatureName Internet-Explorer-Optional-amd64 -NoRestart | Out-Null

    # Remove Microsoft Print to PDF
    Write-Host "Remove Microsoft Print to PDF"
    Disable-WindowsOptionalFeature -Online -FeatureName Printing-PrintToPDFServices-Features -NoRestart | Out-Null
}
else
{
    exit 0
}