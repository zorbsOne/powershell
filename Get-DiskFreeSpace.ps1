#Get-DiskFreeSpace
#March 9, 2018
#Rob Panio

#Synopsis
#This script checks the free space of logical disks.


#Variables
[CmdletBinding()]
param (
[Parameter(Mandatory=$True)]
[String[]]$ComputerName,
[Parameter(Mandatory=$True)]
[String[]]$Drive
)

#Execution

$var=foreach ($Drive in $Drive) { 
Get-WmiObject -class Win32_LogicalDisk -computername $computername | 
where-object DeviceID -eq $Drive |
Select-Object DeviceID,FreeSpace,Size,__server
}
$var | Sort-Object __server,DeviceID |
Format-Table @{name='ComputerName';expression={$_.__server}},DeviceID,
@{name='FreeSpace(GB)';expression={$_.FreeSpace / 1GB -as [int]}},
@{name='Size(GB)';expression={$_.Size / 1GB -as [int]}},
@{name='PercentFree';expression={$_.FreeSpace / $_.Size * 100 -as [int]}}
