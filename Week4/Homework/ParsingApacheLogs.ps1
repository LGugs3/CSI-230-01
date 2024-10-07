function ApacheLogs1()
{
    $unformattedLogs = Get-Content C:\xampp\apache\logs\access.log
    $tableRecords = @()

    for($i = 0; $i -lt $unformattedLogs.Count; $i++)
    {
        $words = $unformattedLogs[$i].Split(" ");
        
        $tableRecords += [pscustomobject]@{ "IP" = $words[0];
                                            "Time" = $words[3].Trim('[');
                                            "Method" = $words[5].Trim('"');
                                            "Page" = $words[6];
                                            "Protocol" = $words[7];
                                            "Response" = $words[8];
                                            "Referrer" = $words[10];
                                            "Client" = $words[11..($words.Count - 1)];
                                           }
                                           
    }
    return $tableRecords | Where-Object {$_.IP -like "10.*" }
}
#clear

#$tableLogs = ApacheLogs1
#$tableLogs | Format-Table -AutoSize -Wrap