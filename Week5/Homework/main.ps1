. (Join-Path $PSScriptRoot ScrapingChamplainClasses.ps1)
clear

$table = gatherClasses
$translatedTable = daysTranslator $table

#Deliverable i
#$translatedTable | Where-Object { $_.Instructor -ilike "Furkan Paligu" } | `
#                   Format-Table "Class Code", Instructor, Location, Days, "Time Start", "Time End"

#Deliverable ii
#$translatedTable | Where-Object {($_.Location -ilike "JOYC 302") -and ($_.Days -contains "Monday") } | `
#                   Sort-Object "Time Start" | Format-Table "Time Start", "Time End", "Class Code"

#Deliverable iii
$ITSInstructors = $translatedTable | Where-Object { ($_."Class Code" -ilike "SYS*") -or `
                                                    ($_."Class Code" -ilike "NET*") -or `
                                                    ($_."Class Code" -ilike "SEC*") -or `
                                                    ($_."Class Code" -ilike "FOR*") -or `
                                                    ($_."Class Code" -ilike "CSI*") -or `
                                                    ($_."Class Code" -ilike "DAT*") `
                                                  } | Sort-Object Instructor -Unique | `
                                                  Format-Table