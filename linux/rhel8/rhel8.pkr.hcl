packer {

  required_version = ">= 1.10.0"

  required_plugins {
    vmware = {
      version = ">= 1.2.3"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}

source "vmware-iso" "rhel89" {

  # vCenter Credentials
  username = "administrator@vsphere.local"
  password = "VMware1!"

  # vCenter Details
  vcenter_server      = "vcsa-01.localdomain"
  insecure_connection = true
  datacenter          = "contoso"
  cluster             = "prod"
  datastore           = "localssdesxi-01"
  folder              = "templates"

  # VM Hardware Configuration
  vm_name       = "rhel89tmplt"
  guest_os_type = "rhel8_64Guest"
  firmware      = "bios"
  vm_version    = "19"
  CPUs          = 2
  cpu_cores     = 1
  RAM           = 4096
  network_adapters {
    network_card = "vmxnet3"
    network      = "VM Network"
  }
  disk_controller_type = ["pvscsi"]
  storage {
    disk_size             = 40960
    disk_thin_provisioned = true
  }

  # Removable Media Configuration
  iso_paths = [
    "[localssdesxi-01] ISO/RHEL/RHEL8.9/rhel-8.9-x86_64-dvd.iso"
  ]

  # Build Settings
  boot_command = [
    "<tab><bs><bs><bs><bs><bs>inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait15s><esc>"
  ]
  boot_wait           = "30s"
  ip_wait_timeout     = "20m"
  http_directory      = "http"
  communicator        = "ssh"
  ssh_port            = 22
  ssh_username        = "root"
  ssh_password        = "VMware1!"
  ssh_timeout         = "30m"
  shutdown_command    = "echo 'packer'|sudo systemctl poweroff"
  shutdown_timeout    = "10m"
  remove_cdrom        = true
  convert_to_template = true
}

build {
  name = "Red Hat Enterprise Linux 8.9"
  sources = [
    "source.vmware-iso.rhel89"
  ]

  provisioner "shell" {
  execute_command = "echo 'packer'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
  scripts         = ["scripts/register.sh"]
  }

  provisioner "shell" {
  execute_command = "echo 'packer'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
  inline          = ["dnf -y update"]
  }

  provisioner "shell" {
  execute_command = "echo 'packer'|{{ .Vars }} sudo -S -E bash '{{ .Path }}'"
  scripts         = ["scripts/cleanup.sh"]
  }
}