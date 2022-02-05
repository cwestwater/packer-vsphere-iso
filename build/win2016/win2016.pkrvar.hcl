# vCenter credentials
# Use environment variables or pass with build command
# vcenter_username = ""
# vcenter_password = ""

# vCenter details
vcenter_server = ""
vcenter_sslconnection = true
vcenter_datacenter = ""
vcenter_cluster = ""
vcenter_datastore = ""
vcenter_folder = ""

# VM Hardware Configuration
vm_os_type = "windows9Server64Guest"
vm_firmware = "efi"
vm_hardware_version = 17
vm_cpu_sockets = 2
vm_cpu_cores = 1
vm_ram = 4096
vm_nic_type = "vmxnet3"
vm_network = ""
vm_disk_controller = ["pvscsi"]
vm_disk_size = 20480
vm_disk_thin = true
config_parameters = {
        "devices.hotplug" = "FALSE",
        "guestInfo.svga.wddm.modeset" = "FALSE",
        "guestInfo.svga.wddm.modesetCCD" = "FALSE",
        "guestInfo.svga.wddm.modesetLegacySingle" = "FALSE",
        "guestInfo.svga.wddm.modesetLegacyMulti" = "FALSE"
}

# Removable Media Configuration
vcenter_iso_datastore = ""
os_iso_path = ""
os_iso_file = "Windows_Server_2016_Datacenter_EVAL_en-us_14393_refresh.ISO"
vmtools_iso_path = ""
vmtools_iso_file = "VMware-tools-windows-11.3.5-18557794.iso"
vm_cdrom_remove = true

# Build Settings
build_repo = "https://github.com/cwestwater/packer-vsphere-iso"
vm_convert_template = false
winrm_username = "Administrator"
# Use environment variables or pass with build command
# winrm_password = ""

# Provisioner Settings
powershell_scripts = [
    "../../scripts/win2016/disable-tls.ps1",
    "../../scripts/win2016/disable-services.ps1",
    "../../scripts/win2016/remove-features.ps1",
    "../../scripts/win2016/config-os.ps1",
]