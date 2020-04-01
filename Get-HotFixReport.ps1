#Get-HotFixReport.ps1
#April 4, 2018
#Rob Panio

#Synopsis
#This script pulls HotFixes from computer(s) and exports them in a html report.

#Example: Get-HotFixReport -computername SERV2,LOCALHOST -description update

#Variables/Parameters
param (
$description = "*",
$computername = 'localhost',
$reportpath = 'c:\Users\Administrator\Desktop\hotfixreport.htm'
)

#Execution

Write-Host "`nGetting HotFixes. This may take a while....."

#Gets hoitfixes
Get-HotFix -Description $description -ComputerName $computername |

#Sorts 
Sort-Object -Property PSComputerName,Description,HotFixID -Descending |

#selects objects and creates a file 
Select-Object -Property PSComputerName,Description,HotFixID,InstalledOn | 
ConvertTo-html -Title “Hot Fix Report” | Out-File $reportpath

Write-Host "`nFile has been created and sent to $reportpath."