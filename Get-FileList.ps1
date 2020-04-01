#Get-FileList.ps1

#Synopsis
#This script will list all the files of a certain type,
#in a certain directory specified by the user.

#Variables
$FileType = Read-Host "What type of file extension? (.txt etc.)"
$Path = Read-host "Where do you want PowerShell to look? Path"

#Execution
get-childitem -file -Path $Path -include "*$FileType" -Recurse |
Format-Table -Property Name,Directory,CreationTime,LastAccessTime,LastWriteTime -AutoSize




