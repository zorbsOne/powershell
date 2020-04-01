#Get-ADCompProcessMemUsage
#Rob Panio
#March 21, 2018

#Synopsis

#This creates a list of AD computer processes top 5 memory usage generated remotely.
 
#Example: Get-ADCompProcessMemUsage -computername SERV2

#Variables/Parameters

param (

#Generates an AD list of enabled computers as default but can be overriden so
#you can specifiy you own list

$computername = (Get-ADComputer -filter "Enabled -eq 'True'" |
 Select-Object -ExpandProperty name),

#Sets verbose preference (in case not previously set in the environment)
$VerbosePreference="Continue"

 )

#Execution

#Message to user that command is working
echo ' '
Write-Verbose "Retrieving process information remotely from computers"

#Runs scipt on each computer remotely returning top 5 nonpagedmemory usage processes
Invoke-Command -ScriptBlock { Get-Process | Sort-Object NPM -Descending | 
Select-Object -Property NPM,PM,ProcessName -First 5 } `
-ComputerName $computername |

#Formats the returned information into a friendly readable presentaion
Format-Table    @{n='ADComputerName';e={$_.PSComputerName}},
                @{n='ProcessName';e={$_.ProcessName}},
                @{n='NonPagedMemory(MB)';e={$_.NPM/8000 -as [int]}},
                @{n='PagedMemory(MB)';e={$_.PM/8000 -as [int]}} -AutoSize

