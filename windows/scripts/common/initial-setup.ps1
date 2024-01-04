$ErrorActionPreference = "Stop"

# Switch network connection to private mode
# Required for WinRM firewall rules
$networkProfile = Get-NetConnectionProfile
While ($networkProfile.Name -eq "Identifying..."){
    Start-Sleep -Seconds 10
    $networkProfile = Get-NetConnectionProfile
}
Set-NetConnectionProfile -Name $networkProfile.Name -NetworkCategory Private

# Drop the firewall while building and re-enable as a standalone provisioner in the Packer file if needs be
netsh Advfirewall set allprofiles state off

# Enable WinRM service
winrm quickconfig -quiet
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

# Reset auto logon count
# https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-shell-setup-autologon-logoncount#logoncount-known-issue
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name AutoLogonCount -Value 0