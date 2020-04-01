#Get-ADUserTelephoneNumbers

#Synopsis

#This creates a list of active ADUser's telephone numbers.
 
#Example: Get-ADUserTelephoneNumbers

#Variables/Parameters

#Sets verbose preference (in case not previously set in the environment)
$VerbosePreference="Continue"

#Execution

#Message to user that command is working
echo ' '
Write-Verbose "Retrieving phone numbers"

#This queries active ADUser for all users that have an office phone number
Get-AdUser -Properties officephone -Filter {(officephone -like "*") -and (Enabled -eq $True) } |
Sort-Object Name | FT Name,OfficePhone
