#Get-ADComputersPing.ps1

#Synopsis
#This script pings all the enabled AD computers 
#from the local host. The parametes allow the user to select computers,
#source, packet size, and number of pings if so desired. 

param (
#Generates an AD list of enabled computers as default but can be overriden so
#you can specifiy you own list
$pingTo = (Get-ADComputer -filter "Enabled -eq 'True'" |
 Select-Object -ExpandProperty name),
$pingFrom = "localhost",
$pktSize = 32,
$times = 4
)

#Execution

#initates the ping test using parameters specified or defaults
Test-Connection -Source $pingFrom -ComputerName $pingTo `
-BufferSize $pktSize -Count $times

Write-Verbose "Ping test complete."
