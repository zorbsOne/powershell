#Set-DailyErrorsReport.ps1

#Synopsis
#This is a script creates a background job that will get the latest n errors
#from the system event log on your computer and export them to a CliXML file.
#Note to remove, use Unregister-ScheduledJob -Id # 

#Example: Set-DailyErrorsReport -path C:\ -timeOfDay 5am -numErrors 10

#Parameters/Variables
param (
$VerbosePreference = "Continue",
$path = 'c:\Users\Administrator\Desktop\DailyErrors.xml',
$timeOfDay = '6:00AM',
$numErrors = 25
)

#Execution

#Sets Trigger for running report.
$Trigger=New-JobTrigger -At $timeOfDay -DaysOfWeek "Monday", 
"Tuesday","Wednesday","Thursday","Friday" –Weekly 

#Script block to run at trigger.
$command={ Get-EventLog -LogName System -Newest $numErrors -EntryType Error |
Export-Clixml $path} 

#Registers a scheduled job
Register-ScheduledJob -Name "Get System Errors" -ScriptBlock $Command -Trigger $Trigger 
