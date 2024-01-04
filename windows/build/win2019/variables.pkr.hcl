# vCenter Credentials

variable "vcenter_username" {
    description = "The username Packer will use to login to vCenter"
    type = string
    sensitive = true
}

variable "vcenter_password" {
    description  = "The password Packer will use to login to vCenter"
    type = string
    sensitive = true
}

# vCenter Details

variable "vcenter_server" {
    description = "The FQDN of the vCenter Packer will connect to"
    type = string
}

variable "vcenter_sslconnection" {
    description = "Is the connection to vCenter secure or not"
    type = bool
}

variable "vcenter_datacenter" {
    description = "The name of the Datacenter in vCenter Packer will build in"
    type = string
}

variable "vcenter_cluster" {
    description = "The name of the Cluster in vCenter Packer will build in"
    type = string
}

variable "vcenter_datastore" {
    description = "The name of the Datastore in vCenter Packer will build in"
    type = string
}

variable "vcenter_folder" {
    description = "The name of the Folder in vCenter Packer will build in"
    type = string
}

# VM Hardware Configuration

variable "vm_os_type" {
    description = "The Guest OS identifier for the VM"
    type = string
}

variable "vm_firmware" {
    description = "The firmware type for the VM - BIOS/EFI"
    type = string
    default = "efi"
}

variable "vm_hardware_version" {
    description = "The VM hardware version"
    type = number
}

variable "vm_cpu_sockets" {
    description = "The number of CPU sockets for the VM"
    type = number
    default = 2
}

variable "vm_cpu_cores" {
    description = "The number of CPU cores for the VM"
    type = number
    default = 1
}

variable "vm_ram" {
    description = "The amount of RAM in Mb for the VM"
    type = number
    default = 2048
}

variable "vm_nic_type" {
    description = "The NIC Type (vmxnet3, e1000, etc.) for the VM"
    type = string
    default = "vmxnet3"
}

variable "vm_network" {
    description = "The name of the network that the VM will connect to"
    type = string
}

variable "vm_disk_controller" {
    description = "The disk controller type for the VM"
    type = list(string)
    default = ["pvscsi"]
}

variable "vm_disk_size" {
    description = "The size of the disk (C:) for the VM"
    type = number
    default = 20480
}

variable "vm_disk_thin" {
    description = "Should the disk be thin provision on the VM"
    type =bool
    default = true
}

variable "config_parameters" {
    description = "The list of extra configuration parameters to add to the vmx file"
    type = map(string)
}

# Removable Media Configuration

variable "vcenter_iso_datastore" {
    description = "The name of the Datastore in vCenter the ISOs are located on"
    type = string
}

variable "os_iso_path" {
    description = "The path to the ISO file to be used for OS installation"
    type = string
}

variable "os_iso_file" {
    description = "The name to the ISO file to be used for OS installation"
    type = string
}

variable "vmtools_iso_path" {
    description = "The path to the ISO file to be used for VMware Tools installation"
    type = string
}

variable "vmtools_iso_file" {
    description = "The name to the ISO file to be used for VMware Tools installation"
    type = string
}

variable "vm_cdrom_remove" {
    description = "Should the CDROMs be removed from the VM once build is complete"
    type = bool
    default = true
}

# Build Settings

variable "build_repo" {
    description = "The URL of the repo the VM was built from"
    type = string
}

variable "vm_convert_template" {
    description = "Convert the VM to a template"
    type = bool
    default = true
}

variable "winrm_username" {
    description = "The winrm username that is used to connect to the VM. This should match the Autounattend.xml"
    type = string
    default = "Administrator"
    sensitive = true
}

variable "winrm_password" {
    description = "The winrm password that is used to connect to the VM. This should match the Autounattend.xml"
    type = string
    sensitive = true
}

# Local Variables

locals {
    build_version = formatdate("YY.MM", timestamp())
    build_date = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
}

# Provisioner Settings

variable "powershell_scripts" {
    description = "The list of PowerShell scripts to run when the OS is ready"
    type = list(string)
}