# vCenter credentials
# Use environment variables or pass with build command
vcenter_username = "administrator@vsphere.local"
vcenter_password = "VMware1!"

# vCenter details
vcenter_server = "vcsa.contoso.com"
vcenter_sslconnection = true
vcenter_datacenter = "Datacenter"
vcenter_cluster = "Cluster"
vcenter_datastore = "datastore"
vcenter_folder = "Templates"

# VM Hardware Configuration
vm_os_type = "windows9Server64Guest"
vm_firmware = "efi"
vm_hardware_version = 17
vm_cpu_sockets = 2
vm_cpu_cores = 1
vm_ram = 4096
vm_nic_type = "vmxnet3"
vm_network = "VM Network"
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
vcenter_iso_datastore = "datastore"
os_iso_path = "ISO/Microsoft"
os_iso_file = "20348.169.210806-2348.fe_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso"
vmtools_iso_path = "ISO/VMware"
vmtools_iso_file = "VMware-tools-windows-11.3.5-18557794.iso"
vm_cdrom_remove = true

# Build Settings
build_repo = "https://github.com/cwestwater/packer-vsphere-iso"
vm_convert_template = false
winrm_username = "Administrator"
# Use environment variables or pass with build command
winrm_password = "VMware1!"

# Provisioner Settings
powershell_scripts = [
    "../../scripts/win2022/disable-tls.ps1",
    "../../scripts/win2022/disable-services.ps1",
    "../../scripts/win2022/remove-features.ps1",
    "../../scripts/win2022/config-os.ps1",
]