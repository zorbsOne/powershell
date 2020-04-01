#Get-DhcpServerStats

#Synopsis

#This creates a list of DHCP server scopes and lists the  
#scope id,starting and ending ips, number of ips used and free,
#pending offers, number reserved, and percentage in use.
 
#Example: Get-DhcpServerStats

#Variables/Parameters

#Execution

echo "`nRetrieving DHCP information"

#This uses two different commands to acquire all the information.
Get-DhcpServerv4ScopeStatistics |
Select-Object    ScopeId,
                @{l='Starting IP';e={(Get-DhcpServerv4Scope).StartRange }},
                @{l='Ending IP';e={(Get-DhcpServerv4Scope).EndRange }},
                AddressesFree,AddressesInUse,PendingOffers,ReservedAddress,
                PerncentageInUse | format-list
 
 echo "`nDHCP stats completed!"
