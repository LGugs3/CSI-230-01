function GetApachePageRequests($pageVisited, $httpCode, $webBrowser)
{
    $httpCode = " " + $httpCode + " "
    $notFounds = Get-Content C:\xampp\apache\logs\access.log | Select-String $httpCode, $webBrowser, $pageVisited

    $regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

    $ipsUnorganized = $regex.Matches($notFounds)

    $ips = @()
    for($i = 0; $i -lt $ipsUnorganized.Count; $i++)
    {
        $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value;
                                   "Page" = $pageVisited;
                                   "Browser" = $webBrowser;
                                 }
    }

    $counts = $ips | Where-Object { $_.IP -ilike "10.*" } | Group-Object IP

    return $counts | select Count, Name, @{Name = "Page";Expression={($_.Group.Page -ilike $pageVisited)[0]}}, `
                            @{Name = "Browser";Expression={($_.Group.Browser -ilike $webBrowser)[0]}}
}