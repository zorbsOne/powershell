#Set-UnlockADUsers.ps1

#Synopsis
#This is a script pulls all the AD users that are locked out and un locks them.

#Example: Set-UnlockADUsers 

#Variables

$Locked = Get-ADUser -filter * -Properties lockedout | 
Where-Object -Property lockedout -EQ $True |
Select-Object -Property SamAccountName,lockedOut

#Execution
if ($Locked) {
    Write-Host "`nThese are the accounts currently locked out"
    $Locked

    #Takes the list and unlocks them
    $Locked | Select-Object -ExpandProperty SamAccountName |Unlock-ADAccount
    echo ""
    echo "Unlocking complete!"
}
else {
    Write-Host "`nThere are no accounts that are locked. Goodbye!"
}
