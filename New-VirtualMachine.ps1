#New-VirtualMachine

#Synopsis
#This script uses default parameters set by the user to quickly create a differencing virtual hard drive and virtual machine.

#parameters

[CmdletBinding()]
param (
$parentPath = 'C:\SCRATCH\Parents\Windows 10 Enterprise Parent.vhdx',
$vhdpath = "C:\SCRATCH\Disks\",
$VMpath = "C:\SCRATCH\Vms",
$memory = 1024MB,
$gen = 2,
$switch = "External - Virtual Switch",
[Parameter(Mandatory=$True)]
[string]$name
)

#Execution

#Creates a differencing vhdx disk from a parent disk

echo ""
echo "Creating a VHD..."
echo ""
echo "A VHD has been created with the following parameters:"

New-VHD -ParentPath $parentPath -Path $vhdpath$name.vhdx -Differencing |
Select-Object Path,VhdType,ParentPath | format-list

#creates a new VM using the vhdx disk created above

echo "Creating a VM..."
echo ""
echo "A VM has been created with the following parameters:"

New-VM -Name $name -MemoryStartupBytes $memory -Generation $gen -path $VMpath -VHDPath $vhdpath$name.vhdx -SwitchName $switch |
Select-Object name,Path,@{name='MemoryStartup(MB)';expression={$_.MemoryStartup / 1MB}},
Generation,@{name='SwitchName';expression={$switch}} | Format-List
