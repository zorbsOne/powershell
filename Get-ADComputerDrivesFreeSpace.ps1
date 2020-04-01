#Get-ADComputerDrivesFreeSpace

#Synopsis

#This creates a list of AD computer drives that have less than a specified percentage 
#of free space available.
 
#Example: Get-DiskMinPercentFree -computername SERV2 -percentfree 10

#Variables/Parameters

param (
#Generates an AD list of enabled computers as default but can be overriden so
#you can specifi=y you own list
$computername = (Get-ADComputer -filter "Enabled -eq 'True'" | Select-Object -ExpandProperty name),

#allows user to specify the percentage free space they want reported on. Default is 10%
$percentfree = 10

)
#Gets hard drive info from computers
Get-CimInstance -className Win32_LogicalDisk -computername $computername -filter "drivetype=3" |

#Filters the information based on minimum free space
Where-Object { ($_.FreeSpace / $_.Size) -lt ($percentfree / 100) } |

#Formats specific information to be displayed
Select -Property  PSComputerName,DeviceID,
@{l="FreeSpace(MB)";e={$_.FreeSpace / 1MB -as [Int32] }},
@{l="Size(MB)";e={$_.Size / 1MB -as [Int32] }},
@{l="PercentFree";e={($_.FreeSpace / $_.Size) *100 -as [int]}} |
Format-Table -AutoSize 
