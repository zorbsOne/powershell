#Get-ServicesStatus.ps1

#Synopsis
#This is a script pulls a list of services on a local computer(default) or 
#a remote computer(s) and sorts them by status and name.

#Example: Get-ServicesStatus -computername SERV2,LOCALHOST -service win*

#Variables/Parameters
param (
$computername = 'localhost',
$service = '*'
)

#Execution
Get-Service -ComputerName $computername -Name $service | 
Sort-Object MachineName,Status,Name | 
Select-Object MachineName,Name,Status
