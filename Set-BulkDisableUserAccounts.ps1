#Set-BulkDisableUserAccounts
#Rob Panio
#March 21, 2018

#Synopsis

#This script takes a list of user logon names from either a txt file (default) or from 
#a parameter and disables the user account in Active Directory.

#Note if using a txt file name it DisableUsers.txt and save it in the location
# "C:\Users\Administrator\Desktop\DisableUsers.txt" and enter the user names,
# one per line.
 
#Example: Set-BulkDisableUserAccounts -disablelist rpanio,sholden,amccartan

#Variables/Parameters

param (

#Generates an AD list of enabled computers as default but can be overriden so
#your can specifiy you own list.

$disablelist = (Get-Content "C:\Users\Administrator\Desktop\DisableUsers.txt")

)

#Execution

#Confirms if the accounts to be disabled are correct
$disablelist | ForEach-Object {
  $samAccountName = $_
  Get-ADUser -Identity $samAccountName |
  Select-Object Name,SamAccountName,Enabled
} | Out-Host
 
$Prompt = Read-Host "Is this the list of accounts you want to disable (y/n)?"

#Asks for confirmation to disable
if ($Prompt -match "y" ) {

    #Takes a list of user logons and disables the accounts 
    $disablelist | ForEach-Object {
    $samAccountName = $_ 
    Get-ADUser -Identity $samAccountName | Disable-ADAccount 
    }

    #Confirms if the accounts are now disabled
    echo " "
    echo "These account are now disabled:"
    
    #Displays the status of the disabled accounts
    $disablelist | ForEach-Object {
    $samAccountName = $_ 
    Get-ADUser -Identity $samAccountName |
    Select-Object Name,SamAccountName,Enabled
    }
}

#Provides the user feedback if the accounts shown were not correct
else {
    echo " "
    echo 'Check your txt file list of names at location"C:\Users\Administrator\Desktop\DisableUsers.txt"'
    echo 'or check your parameter -disablelist to make sure it is accurate before trying again'
    echo " "
    echo 'Exiting Set-BulkDisableUserAccounts'
    } 