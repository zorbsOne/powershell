#Set-ServiceStatus.ps1

#Synopsis
#This Script asks the user for a service, check the status of the service and reports it to the screen.
#Then it asks them if they would like to change the state to running or stopped depending on its state.

#Parameters

#Asks the user for the name of a service and stores the response in $svc

$svc = Read-Host "`nEnter the service you would like to modify"


#Execution

#Checks the current state of the service stored in $svc

$status = get-service $svc | Select-Object -ExpandProperty status

#If the current status is running
if ($status -match "Running") 
{
    #Reports the current status of the service and asks if the user wants to stop it and stores the 
    #answer in the variable $ansr
    
    $ansr = Read-Host "The current status of $svc is $status. Would you like to stop it? (y/n)"

    #If $ansr matches the answer y, the service is stopped, the status rechecked, then reported to
    #the screen 
    
    if ($ansr -match "y") 
    {    
        Stop-Service $svc
        $status = get-service $svc | Select-Object -ExpandProperty status
        Write-Host "`nThe status of $svc is now $status"
    }
    
    else 
    {   
        #Otherwise the status is checked and reported to the screen
        
        $status = get-service $svc | Select-Object -ExpandProperty status
        Write-Host "`nThe status of $svc is still $status"
    }
}

#If the status is Stopped

else 
{
    #Reports the current status of the service and asks if the user wants to start it and stores the 
    #answer in the variable $ansr
    
    $ansr = Read-Host "The current status of $svc is $status. Would you like to start it? (y/n)"

    #If $ansr matches the answer y, the service is started, the status rechecked, then reported to
    #the screen 
    
    if ($ansr -match "y") 
    {    
        Start-Service $svc
        $status = get-service $svc | Select-Object -ExpandProperty status
        Write-Host "`nThe status of $svc is now $status"
    }
    else 
    {
        #Otherwise the status is checked and reported to the screen
        
        $status = get-service $svc | Select-Object -ExpandProperty status
        Write-Host "`nThe status of $svc is still $status"
    }
}
