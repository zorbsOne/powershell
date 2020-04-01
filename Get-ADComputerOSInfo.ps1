#Get-ADComputerOSInfo

#Synopsis

#This creates a list of AD computer OS information.
 
#Example: Get-ADComputerOSInfo -computername SERV2

#Variables/Parameters

param (

#Generates an AD list of enabled computers as default but can be overriden so
#you can specifiy you own list

$computername = (Get-ADComputer -filter "Enabled -eq 'True'" |
 Select-Object -ExpandProperty name)
)

#Execution

#Gets the software version of each computer remotely
Invoke-Command –scriptblock {get-itemproperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\' |

#Filters which information to send back from each computer
Select-Object PSComputerName,ProductName,EditionID,CurrentVersion} -computername $computername |

#Formats the information in a readable form
Format-Table    @{n='ADComputerName';e={$_.PSComputerName}},
                @{n='ProductName';e={$_.ProductName}},
                @{n='Edition';e={$_.EditionID}},
                @{n='Version';e={$_.CurrentVersion}} -AutoSize
