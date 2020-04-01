#Get-LastLogons.ps1

#Source https://social.technet.microsoft.com/Forums/lync/en-US/4f6815f1-2998-484c-a423-fe6507f1548c/powershell-script-to-fetch-logonlogoff-user-on-particular-server-getwinevent-geteventlog?forum=winserverpowershell

#Synopsis
#This script will retrieve the date and time of logons for a specific computer for last n days.

#Example: Get-LastLogons -computer SERV2 -Days 30

#Parameters/Variables
Param (
 [string]$Computer = (Read-Host Computer name),
 [int]$Days = 20
 )
 #Sets to an empty hash table
 $Result = @()
 
 Write-Host "Gathering Event Logs, this can take awhile..."
 
 #Execution

 #Assigns a variable to the PS object within a date parameter
 $ELogs = Get-EventLog -logname System -Source Microsoft-Windows-WinLogon -After (Get-Date).AddDays(-$Days) -ComputerName $Computer
 
 #Condition if there are logs then logon and logoff events will be labelled.
 #If ($ELogs)
 If ($ELogs -and ($Elogs.machinename -match $Computer))
  { Write-Host "Processing..."
    ForEach ($Log in $ELogs)
        { If ($Log.InstanceId -eq 7001)
            { $ET = "Logon"
            }
        ElseIf ($Log.InstanceId -eq 7002)
            { $ET = "Logoff"
            }
        Else
            #returns to top of loop
            { Continue
            }

    #Creates a PS object using a hash of Time, Event, and User
    $Result += New-Object PSObject -Property @{
        Computer =$log.MachineName 
        Time = $Log.TimeWritten
        'Event Type' = $ET
        User = (New-Object System.Security.Principal.SecurityIdentifier $Log.ReplacementStrings[1]).Translate([System.Security.Principal.NTAccount])
        }
    }
 #Takes the results PS object and sorts and formats
 $Result | Select Computer, Time,"Event Type",User | Sort Time -Descending | Format-Table -AutoSize
 Write-Host "Done."
 }
 
 #This is what is displayed if no logs are generated.
 Else
 { Write-Host "Problem with $Computer."
 Write-Host "If you see a 'Network Path not found' error, try starting the Remote Registry service on that computer."
 Write-Host "Or there are no logon/logoff events (Some OS's require auditing be turned on)"
 }
