# HashiCorp Packer with VMware vSphere to build Windows Server Images on vCenter

This repo hosts a set of files to build Windows Server 2016, 2019 and 2022 Operating Systems in a VMware vSphere environment using [HashiCorp Packer](https://www.packer.io/).

## OS Versions

All ISO's used are obtained from the [Microsoft Evaluation Center](https://www.microsoft.com/en-gb/evalcenter/evaluate-windows-server), specifically:

- [Windows Server 2016](https://www.microsoft.com/en-gb/evalcenter/evaluate-windows-server-2016)
- [Windows Server 2019](https://www.microsoft.com/en-gb/evalcenter/evaluate-windows-server-2019)
- [Windows Server 2022](https://www.microsoft.com/en-gb/evalcenter/evaluate-windows-server-2022)

## VMware Tools

The latest version of VMware Tools can always be obtained at [this link](https://packages.vmware.com/tools/releases/latest/windows)

## Packer and Modules Versions

The version of Packer, the [vsphere-iso](https://www.packer.io/plugins/builders/vsphere/vsphere-iso) plugin and the [Windows Update](https://github.com/rgl/packer-plugin-windows-update) plugin  to be used is defined in the first section of the `win*.pkr.hcl` file:

```terraform
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
```

Packer should be downloaded from the [Packer Downloads](https://www.packer.io/downloads) page and installed appropriately. See the [Install Packer](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli) tutorial.

## autounattend.xml Boot Files

The `autounattend.xml` files are located in the `bootfiles` folder.

These files are used to perform initial boot of the OS and perform such tasks as partition the disk, set regional options, select the OS version, etc. These are best edited using the [Windows System Image Manager](https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/wsim/windows-system-image-manager-technical-reference) which is part of [Windows ADK](https://docs.microsoft.com/en-us/windows-hardware/get-started/adk-install).

The autounattend files specifically perform these steps:

- Set Regional options to `en-GB` - Lines 6-12
- Partition the disk to suite a EFI layout - Line 16-66
- Choose the OS to install - Line 79
- Sets Name and Organisation - Lines 90-91, 106-107
- Loads the PVSCSI driver - Line 97
- Sets the computer name - Line 104
- Sets the Time Zone - Line 105
- Sets the PowerShell Execution Policy - Lines 135-146
- Disable network discovery prompt for all users - Lines 147-151
- Turn on network discovery for all network profiles - Lines 152-156
- Calls the script `install-vmtools64.cmd` to install VMware Tools - Line 157-161
- Calls the script `initial-setup.ps1` which sets up PowerShell and WinRM - Line 162-166
- Sets the local Administrator Account password - Lines 175-178

> You will see the local Administrator account shown in clear text. You should use WSIM to set your own password and use WISM to encrypt it. See [Hide Sensitive Data in an Answer File](https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/wsim/hide-sensitive-data-in-an-answer-file)

These are pretty standard. The parts added to work with Packer/vSphere are the addition of the PVSCSI driver and the call to the script `install-vmtools64.cmd`.

## Packer HCL Files

The Packer specific files are located in the `build` folder.

These files are written using [HashiCorp HCL2](https://www.packer.io/guides/hcl) which is the preferred way to write Packer builds. Each OS has three files:

- variables.pkr.hcl - defines all the variables used in the build
- win*.pkrvar.hcl - the values for all the variables defined above
- win*.pkr.hcl - the build definition for the OS

To be able to run the builds in your environment you need to fill in the missing values in the `win*.pkrvar.hcl` files:

```terraform
vcenter_username = ""
vcenter_password = ""
vcenter_server = ""
vcenter_datacenter = ""
vcenter_cluster = ""
vcenter_datastore = ""
vcenter_folder = ""
vm_network = ""
vcenter_iso_datastore = ""
os_iso_path = ""
vmtools_iso_path = ""
```

Look in the `variables.pkr.hcl` file for details on each variable.

I have placed an example variables value file called [example.pkrvar.hcl](,,/build/example.pkrvar.hcl) the the top level of the `build` folder with the values filled out for a fictitious vCenter environment so you can see how they can be completed.

The build of the VM is defined in the `win*.pkr.hcl` files. The file is split into the 'sections':

- vCenter credentials
- vCenter details - which vCenter, datastore, network,, etc. to build on
- VM Hardware Configuration - the hardware settings for the VM
- Removable Media Configuration - the details of the OS and VMware Tools ISO
- Build Settings - items such as the boot command, winrm connection, shutdown command, etc.
- Provisioner Settings - the scripts used to setup the OS and Windows Update plugin

Each of the Operating System `win*.pkr.hcl` files has four options:

- Datacenter
- Datacenter Core
- Standard
- Standard Core

## How to Run

Once all variables have a value in the `win*.pkrvar.hcl` file browse to the OS `build` folder you want to run. Run the following command:

Windows Server 2022:

```dosbatch
packer build -force -var-file win2022.pkrvar.hcl .
```

Windows Server 2019:

```dosbatch
packer build -force -var-file win2019.pkrvar.hcl .
```

Windows Server 2016:

```dosbatch
packer build -force -var-file win2016.pkrvar.hcl .
```

Note the `.` at the end of the command. This makes Packer process all the files in the folder.

Each of these commands will build all four OS versions. If you want to target a particular OS version you can use the following command (Windows Server 2022 Standard as an example):

```dosbatch
packer build -force -var-file win2022.pkrvar.hcl -only "Windows Server 2022.vsphere-iso.win2022dc" .
```

## A Note on Credentials

The credentials needed to successfully build are as follows:

- vCenter username and password - the variables `var.vcenter_username` and `var.vcenter_password`
- WinRM username and password - the variables `var.winrm_username` and `var.winrm_password`
- Local Administrator account username and password - found in the `autounattend.xml` files

Important - the WinRM username and password should match the Local Administrator account username and password as this is what Packer uses to connect to the VM for customisation. In the files in this repo I have added the local Administrator account password in clear text. Please use WSIM to hide the password.

It is important not to store any credentials in any of the files so they cannot be leaked. Please use environment variables or pass them at the command line. For example to pass vCenter creds and the WinRM password at the command line for Windows Server 2022 you could run:

```dosbatch
packer build -force -var-file win2022.pkrvar.hcl -var "vcenter_username=administrator@vsphere.local" -var "vcenter_password=VMware1!" -var "winrm_password=VMware1!" .
```

Please see [Template User Variables](https://www.packer.io/docs/templates/legacy_json_templates/user-variables) in the Packer documentation for more details.

## Maintenance

Once you have filled out the variable values in the relevant `win*.pkrvar.hcl` files and placed the ISOs in the datastore and folder as defined in that file, the only real maintenance you need to do is update VMware tools. This is accomplished by downloading the latest ISO as detailed the [VMware Tools](#VMware-Tools) section. You then update the variable value `var.vmtools_iso_file` with the downloaded ISO filename.
