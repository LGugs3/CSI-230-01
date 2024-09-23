function gatherClasses()
{
    $page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.15/Courses-1.html

    $trs = $page.parsedHtml.body.getElementsByTagName("tr")



    $fullTable = @()
    for($i = 1; $i -lt $trs.length; $i++)
    {
        $tds = $trs[$i].getElementsByTagName("td")

        $times = $tds[5].innerText.Split("-")

        $fullTable += [pscustomobject] @{"Class Code" = $tds[0].innerText;
                                         "Title" = $tds[1].innerText;
                                         "Days" = $tds[4].innerText;
                                         "Time Start" = $times[0];
                                         "Time End" = $times[1];
                                         "Instructor" = $tds[6].innerText;
                                         "Location" = $tds[9].innerText;
                                        }
    }#end for
    return $fullTable
}

function daysTranslator($fullTable)
{
    for($i = 0; $i -lt $fullTable.Length; $i++)
    {
        if ($fullTable[$i] -ilike "TBA") {continue}
        $days = @()

        if($fullTable[$i].Days -match "^M{1}") {$days += "Monday"}
        if($fullTable[$i].Days -match "^T[^HB]*") {$days += "Tuesday"}
        if($fullTable[$i].Days -match "W{1}") {$days += "Wednesday"}
        if($fullTable[$i].Days -match "TH{1}$") {$days += "Thursday"}
        if($fullTable[$i].Days -match "F{1}$") {$days += "Friday"}

        if ($days.Length -ne 0) { $fullTable[$i].Days = $days }
    }#end for
    return $fullTable
}