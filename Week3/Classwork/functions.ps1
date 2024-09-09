function GetLoginOutLogs($numDays)
{
    $loginouts = Get-EventLog System -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays("-" + $numDays)

    $loginoutsTable = @()
    for($i = 0; $i -lt $loginouts.Count; $i++)
    {
        $event = ""
        if($loginouts[$i].CategoryNumber -eq 1101) {$event="Logon"}
        if($loginouts[$i].CategoryNumber -eq 1102) {$event="Logoff"}

        $user = New-Object System.Security.Principal.SecurityIdentifier($loginouts[$i].ReplacementStrings[1])
        $user = $user.Translate([System.Security.Principal.NTAccount])

        $loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated;
                                               "Id" = $loginouts[$i].EventID;
                                            "Event" = $event;
                                             "User" = $user;
                                            }
    }
    return $loginoutsTable
}

function GetPowerLogs($numDays)
{
    $powerOnOff = Get-EventLog System -source EventLog -After (Get-Date).AddDays("-" + $numDays)
    $powerOnOffTable = @()

    for($i = 0; $i -lt $powerOnOff.Count; $i++)
    {
        $event = ""
        if($powerOnOff[$i].EventID -eq 6005) {$event = "Startup"}
        elseif($powerOnOff[$i].EventID -eq 6006) {$event = "Shutdown"}
        else {continue}

        $user = "System"

        $powerOnOffTable += [pscustomobject]@{"Time" = $powerOnOff[$i].TimeGenerated;
                                                "Id" = $powerOnOff[$i].EventID;
                                             "Event" = $event;
                                              "User" = $user;
                                             }


    }
    return $powerOnOffTable
}
