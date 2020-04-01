#Add-NewADUsersBulk.ps1
 
#Synopsis
#This script uses a csv file to create new AD users.
#Note: A csv file has to be created and is by default
#located on the Administrator/Desktop
#The csv file only use 3 headings: Given, Surname, and Logon

#Paramters/Variables
param (

#Allows user to specify path to CSV file and domain name.
$CSVpath = 'C:\Users\Administrator\Desktop\NewUsers.csv',
$domain = '@PANIO.Local'
)

$password = "P@ssw0rd" | ConvertTo-SecureString -AsPlainText -Force 

#Execution

Import-Csv $CSVpath | foreach-object {
$FullName = $_.Given + ' ' + $_.Surname
$UserPrinicpalName = $_.Logon + $domain
$VerbosePreference = "Continue" 

Write-Verbose "Creating user $FullName"

New-ADUser -Name $FullName `
-GivenName $_.Given `
-Surname $_.Surname `
-SamAccountName $_.Logon `
-AccountPassword $password `
-ChangePasswordAtLogon $True `
-UserPrincipalName $UserPrinicpalName `
-enable $true `
-PassThru}

Write-Verbose "Users have been created."
