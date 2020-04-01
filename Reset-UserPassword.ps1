#Reset-UserPassword.ps1
#April 4, 2018
#Rob Panio

#Synopsis
#This is a script lets you reset an AD user or multiple users' passwords 
#forcing to change their password at next logon.


#Variables
$VerbosePreference = "Continue"

#Execution
Do {
$User=Read-Host "`nEnter the user name you want to reset the password for"
$Password=Read-Host "`nEnter the new password for $User"
 
#Execution
Set-ADAccountPassword -Identity $User `
-NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force) -reset 
Write-Verbose "Password for $User has been reset!"
$Continue=Read-Host "`nDo you want to reset another user's password y or n"
}
While ($Continue -ne "n")