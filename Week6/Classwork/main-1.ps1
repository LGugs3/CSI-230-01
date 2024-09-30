. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot pwsh7RemoteConnect.ps1)

clear

#$process = Start-Process PWSH -ArgumentList @("-NoExit") -PassThru -WindowStyle Hidden

#$Runspace = New-OutOfProcRunspace -PID $process.Id
#$Host.PushRunspace($Runspace)

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 - Get At Risk Users`n"
$Prompt += "10 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        $password = Read-Host -AsSecureString -Prompt "Please enter the password for the new user"

        $userExists = checkUser($name)
        if ($userExists)
        {
            Write-Host "Username Already Exists"
            continue
        }
        $goodPass = checkPassword($password)
        if (-not $goodPass)
        {
            Write-Host "Cannot create user b/c password does not meet requirements"
            continue
        }

        createAUser $name $password

        Write-Host "User: $name is created." | Out-String
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        $userExists = checkUser($name)
        if (-not $userExists)
        {
            Write-Host "User does not exist"
            continue
        }

        removeAUser $name

        Write-Host "User: $name Removed." | Out-String
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        $userExists = checkUser($name)
        if (-not $userExists)
        {
            Write-Host "User does not exist"
            continue
        }

        enableAUser $name

        Write-Host "User: $name Enabled." | Out-String
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        $userExists = checkUser($name)
        if (-not $userExists)
        {
            Write-Host "User does not exist"
            continue
        }

        disableAUser $name

        Write-Host "User: $name Disabled." | Out-String
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"

        $userExists = checkUser($name)
        if (-not $userExists)
        {
            Write-Host "User does not exist"
            continue
        }

        $daysBack = Read-Host -Prompt "Enter number of days back to get"
        $userLogins = getLogInAndOffs $daysBack

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"

        $userExists = checkUser($name)
        if (-not $userExists)
        {
            Write-Host "User does not exist"
            continue
        }

        $daysBack = Read-Host -Prompt "Enter number of days back to get"
        $userLogins = getFailedLogins $daysBack

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    }

    elseif($choice -eq 9)
    {
        $daysBack = Read-Host -Prompt "Enter number of days back to get"
        $userLogins = getFailedLogins $daysBack

        $failedLogins = $userLogins | Group-Object Event | Where-Object { $_.Count -ge 10 } |Sort-Object Count -Descending
        $failedLogins | Format-Table Count, @{Name = "User"; Expression={$_.Group.User[0]}} | Out-String
    }
    # TODO: Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option numbers
    
    else
    {
        Write-Host "Invalid Input"
        continue
    }
}


