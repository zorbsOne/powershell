#Get-ADAccounts.ps1

#Synopsis
#This script displays all the active or disabled user accounts in your active directory

#Variable/Parameters
[String]$Enabled = Read-Host "`nWhat users do you want listed? `
Enable(enter true) or Disabled(enter false)?"

#Execution
#Filters the AD Users by enabled or disabled and displays only certain fields
Get-ADUser -Filter {Enabled -eq $Enabled}  | 
Select-Object Name,SamAccountName,Enabled
