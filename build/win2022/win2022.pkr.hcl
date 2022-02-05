packer {
    required_version = ">= 1.7.9"

    required_plugins {
        vsphere = {
            version = ">= v1.0.2"
            source = "github.com/hashicorp/vsphere"
        }
    }

    required_plugins{
        windows-update = {
            version =">= 0.14.0"
            source = "github.com/rgl/windows-update"
        }
    }
}

source "vsphere-iso" "win2022dccore" {

    # vCenter Credentials

    username = var.vcenter_username
    password = var.vcenter_password

    # vCenter Details

    vcenter_server = var.vcenter_server
    insecure_connection = var.vcenter_sslconnection
    datacenter = var.vcenter_datacenter
    cluster = var.vcenter_cluster
    datastore = var.vcenter_datastore
    folder= var.vcenter_folder

    # VM Hardware Configuration

    vm_name ="win2022dccore"
    notes = "Version: ${ local.build_version }\nBuild Time: ${ local.build_date }\nSource: ${ var.build_repo }\nOS: Windows Server 2022 Datacenter Core"
    guest_os_type = var.vm_os_type
    firmware = var.vm_firmware
    vm_version = var.vm_hardware_version
    CPUs = var.vm_cpu_sockets
    cpu_cores = var.vm_cpu_cores
    RAM = var.vm_ram
    network_adapters {
        network_card = var.vm_nic_type
        network = var.vm_network
    }
    disk_controller_type = var.vm_disk_controller
    storage {
        disk_size = var.vm_disk_size
        disk_thin_provisioned = var.vm_disk_thin
    }
    configuration_parameters = var.config_parameters

    # Removable Media Configuration

    iso_paths = [
        "[${ var.vcenter_iso_datastore }] ${ var.os_iso_path }/${ var.os_iso_file }",
        "[${ var.vcenter_iso_datastore }] ${ var.vmtools_iso_path }/${ var.vmtools_iso_file }"
    ]

    floppy_files = [
        "../../bootfiles/win2022/datacentercore/autounattend.xml",
        "../../scripts/common/install-vmtools64.cmd",
        "../../scripts/common/initial-setup.ps1"
    ]

    remove_cdrom = var.vm_cdrom_remove
    convert_to_template = var.vm_convert_template

    # Build Settings

    boot_command = [
        "<spacebar>"
    ]
    boot_wait = "3s"

    ip_wait_timeout = "20m"
    communicator = "winrm"
    winrm_timeout = "8h"
    winrm_username = var.winrm_username
    winrm_password = var.winrm_password
    shutdown_command = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Build Complete\""
    shutdown_timeout = "1h"
}

source "vsphere-iso" "win2022dc" {

    # vCenter Credentials

    username = var.vcenter_username
    password = var.vcenter_password

    # vCenter Details

    vcenter_server = var.vcenter_server
    insecure_connection = var.vcenter_sslconnection
    datacenter = var.vcenter_datacenter
    cluster = var.vcenter_cluster
    datastore = var.vcenter_datastore
    folder= var.vcenter_folder

    # VM Hardware Configuration

    vm_name ="win2022dc"
    notes = "Version: ${ local.build_version }\nBuild Time: ${ local.build_date }\nSource: ${ var.build_repo }\nOS: Windows Server 2022 Datacenter"
    guest_os_type = var.vm_os_type
    firmware = var.vm_firmware
    vm_version = var.vm_hardware_version
    CPUs = var.vm_cpu_sockets
    cpu_cores = var.vm_cpu_cores
    RAM = var.vm_ram
    network_adapters {
        network_card = var.vm_nic_type
        network = var.vm_network
    }
    disk_controller_type = var.vm_disk_controller
    storage {
        disk_size = var.vm_disk_size
        disk_thin_provisioned = var.vm_disk_thin
    }
    configuration_parameters = var.config_parameters

    # Removable Media Configuration

    iso_paths = [
        "[${ var.vcenter_iso_datastore }] ${ var.os_iso_path }/${ var.os_iso_file }",
        "[${ var.vcenter_iso_datastore }] ${ var.vmtools_iso_path }/${ var.vmtools_iso_file }"
    ]

    floppy_files = [
        "../../bootfiles/win2022/datacenter/autounattend.xml",
        "../../scripts/common/install-vmtools64.cmd",
        "../../scripts/common/initial-setup.ps1"
    ]

    remove_cdrom = var.vm_cdrom_remove
    convert_to_template = var.vm_convert_template

    # Build Settings

    boot_command = [
        "<spacebar>"
    ]
    boot_wait = "3s"

    ip_wait_timeout = "20m"
    communicator = "winrm"
    winrm_timeout = "8h"
    winrm_username = var.winrm_username
    winrm_password = var.winrm_password
    shutdown_command = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Build Complete\""
    shutdown_timeout = "1h"
}

source "vsphere-iso" "win2022stdcore" {

    # vCenter Credentials

    username = var.vcenter_username
    password = var.vcenter_password

    # vCenter Details

    vcenter_server = var.vcenter_server
    insecure_connection = var.vcenter_sslconnection
    datacenter = var.vcenter_datacenter
    cluster = var.vcenter_cluster
    datastore = var.vcenter_datastore
    folder= var.vcenter_folder

    # VM Hardware Configuration

    vm_name ="win2022stdcore"
    notes = "Version: ${ local.build_version }\nBuild Time: ${ local.build_date }\nSource: ${ var.build_repo }\nOS: Windows Server 2022 Standard Core"
    guest_os_type = var.vm_os_type
    firmware = var.vm_firmware
    vm_version = var.vm_hardware_version
    CPUs = var.vm_cpu_sockets
    cpu_cores = var.vm_cpu_cores
    RAM = var.vm_ram
    network_adapters {
        network_card = var.vm_nic_type
        network = var.vm_network
    }
    disk_controller_type = var.vm_disk_controller
    storage {
        disk_size = var.vm_disk_size
        disk_thin_provisioned = var.vm_disk_thin
    }
    configuration_parameters = var.config_parameters

    # Removable Media Configuration

    iso_paths = [
        "[${ var.vcenter_iso_datastore }] ${ var.os_iso_path }/${ var.os_iso_file }",
        "[${ var.vcenter_iso_datastore }] ${ var.vmtools_iso_path }/${ var.vmtools_iso_file }"
    ]

    floppy_files = [
        "../../bootfiles/win2022/standardcore/autounattend.xml",
        "../../scripts/common/install-vmtools64.cmd",
        "../../scripts/common/initial-setup.ps1"
    ]

    remove_cdrom = var.vm_cdrom_remove
    convert_to_template = var.vm_convert_template

    # Build Settings

    boot_command = [
        "<spacebar>"
    ]
    boot_wait = "3s"

    ip_wait_timeout = "30m"
    communicator = "winrm"
    winrm_timeout = "8h"
    winrm_username = var.winrm_username
    winrm_password = var.winrm_password
    shutdown_command = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Build Complete\""
    shutdown_timeout = "1h"
}

source "vsphere-iso" "win2022std" {

    # vCenter Credentials

    username = var.vcenter_username
    password = var.vcenter_password

    # vCenter Details

    vcenter_server = var.vcenter_server
    insecure_connection = var.vcenter_sslconnection
    datacenter = var.vcenter_datacenter
    cluster = var.vcenter_cluster
    datastore = var.vcenter_datastore
    folder= var.vcenter_folder

    # VM Hardware Configuration

    vm_name ="win2022std"
    notes = "Version: ${ local.build_version }\nBuild Time: ${ local.build_date }\nSource: ${ var.build_repo }\nOS: Windows Server 2022 Standard"
    guest_os_type = var.vm_os_type
    firmware = var.vm_firmware
    vm_version = var.vm_hardware_version
    CPUs = var.vm_cpu_sockets
    cpu_cores = var.vm_cpu_cores
    RAM = var.vm_ram
    network_adapters {
        network_card = var.vm_nic_type
        network = var.vm_network
    }
    disk_controller_type = var.vm_disk_controller
    storage {
        disk_size = var.vm_disk_size
        disk_thin_provisioned = var.vm_disk_thin
    }
    configuration_parameters = var.config_parameters

    # Removable Media Configuration

    iso_paths = [
        "[${ var.vcenter_iso_datastore }] ${ var.os_iso_path }/${ var.os_iso_file }",
        "[${ var.vcenter_iso_datastore }] ${ var.vmtools_iso_path }/${ var.vmtools_iso_file }"
    ]

    floppy_files = [
        "../../bootfiles/win2022/standard/autounattend.xml",
        "../../scripts/common/install-vmtools64.cmd",
        "../../scripts/common/initial-setup.ps1"
    ]

    remove_cdrom = var.vm_cdrom_remove
    convert_to_template = var.vm_convert_template

    # Build Settings

    boot_command = [
        "<spacebar>"
    ]
    boot_wait = "3s"

    ip_wait_timeout = "30m"
    communicator = "winrm"
    winrm_timeout = "8h"
    winrm_username = var.winrm_username
    winrm_password = var.winrm_password
    shutdown_command = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Build Complete\""
    shutdown_timeout = "1h"
}

build {
    name = "Windows Server 2022"
    sources = [
        "source.vsphere-iso.win2022dccore",
        "source.vsphere-iso.win2022dc",
        "source.vsphere-iso.win2022stdcore",
        "source.vsphere-iso.win2022std"
    ]

    provisioner "windows-restart" {}

    provisioner "powershell" {
        elevated_user = var.winrm_username
        elevated_password  = var.winrm_password
        scripts = var.powershell_scripts
    }

    provisioner "windows-update" {
        pause_before = "30s"
        search_criteria = "IsInstalled=0"
        filters = [ "exclude:$_.Title -like '*VMware*'",
                        "exclude:$_.Title -like '*Preview*'",
                        "exclude:$_.Title -like '*Defender*'",
                        "exclude:$_.InstallationBehavior.CanRequestUserInput",
                        "include:$true" ]
        restart_timeout = "120m"
    }

}