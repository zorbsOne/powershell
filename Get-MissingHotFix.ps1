#Get-MissingHotFix.ps1
 
#Synopsis
#This script pulls a report of AD computers that are missing a 
#specified HotFix ID creates text file listing them.

#Note you want to make sure the computers are running and
# you can connect to them or you will get an error:
# "No such interface supported" for those you can't reach.

#Example: Get-MissingHotFixID -hotfixid KB4089511 -path C:\Missing.txt -computername SERV2

#Variables/Parameters
[cmdletBinding()]
param (
[Parameter(Mandatory=$True)]
[string]$hotfixid,
[string]$path = "C:\Users\Administrator\Desktop\Missing-$hotfixid.txt",
$computername = (Get-ADComputer -filter "Enabled -eq 'True'" | 
Select-Object -ExpandProperty name)
)

#Execution

Write-host "`nChecking computers for missing $hotfixid."
Write-Host "`nThis may take a while......"

#Goes through each computer in list and enters their name in the txt file is ID 
#is missing.
$computername | ForEach { if (!(Get-HotFix -Id $hotfixid -ComputerName $_ -erroraction 'silentlycontinue' )) { 
                    Add-Content $_ -Path $path }}

Write-Host "`nChecking is complete and file $path is ready for viewing"
