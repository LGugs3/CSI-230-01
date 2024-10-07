function chooseRunTime($time, $taskName)
{
    $scheduledTask = Get-ScheduledTask | Where-Object { $_.TaskName -ilike $taskName }
    if($scheduledTask -ne $null)
    {
        Write-Host "Task already exists" | Out-String
        DisableAutoRun $taskName
    }

    Write-Host "Creating New Task" | Out-String

    $action = New-ScheduledTaskAction -Execute "powershell.exe" `
              -Argument "-File `"C:\Users\champuser\Desktop\CSI-230-01\Week7\Classwork\main.ps1`""
    $trigger = New-ScheduledTaskTrigger -Daily -At $time
    $principal = New-ScheduledTaskPrincipal -UserId 'champuser' -RunLevel Highest
    $settings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable -WakeToRun
    $task = New-ScheduledTask -Action $action -Trigger $trigger -Principal $principal -Settings $settings

    Register-ScheduledTask $taskName -InputObject $task
    Get-ScheduledTask | Where-Object { $_.TaskName -ilike "myTask" }
}

function DisableAutoRun($taskName)
{
    $scheduledTask = Get-ScheduledTask | Where-Object { $_.TaskName -ilike $taskName }
    if($scheduledTask -ne $null)
    {
        Write-Host "Unregistering Task" | Out-String
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
    }
    else
    {
        Write-Host "Given task is not registered" | Out-String
    }
}
