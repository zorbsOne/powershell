#Get-ADComputerIPAdresses
#Rob Panio
#March 21, 2018

#Synopsis

#This creates a list of the IP addresses of AD computers.
 
#Example: Get-ADComputerIPAdresses -computername SERV2

#Variables/Parameters

param (

#Generates an AD list of enabled computers as default but can be overriden so
#you can specifiy you own list

$computername = (Get-ADComputer -filter "Enabled -eq 'True'" |
 Select-Object -ExpandProperty name)

)

#Execution

#Displays message to user that the command is working
echo ' '
Write-Verbose "Getting the IP adress/addresses of enabled AD Computers"

#Retrieves the IP address/addresses of AD computers filtering omly ipv4 private addresses
Invoke-Command -ScriptBlock { Get-NetIPAddress |
 Where-Object{ $_.AddressFamily -eq “IPv4” -and !($_.IPAddress -match “169”) -and !($_.IPaddress -match “127”) } |
 select-object -Property IPAddress } -ComputerName $computername |
 Format-Table PSComputerName,IPAddress -AutoSize