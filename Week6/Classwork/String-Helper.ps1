<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
}


function checkPassword($password)
{
    $specialCharacters = [regex] "[^0-9A-Za-z]+"
    $numbers = [regex] "[0123456789]+"
    $letters = [regex] "[A-Z]+|[a-z]+"

    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)


    if ([System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr) -notmatch $specialCharacters)
    {
        Write-Host "Password Does not contain at least one special character"
        return $false
    }

    if ([System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr) -notmatch $numbers)
    {
        Write-Host "Password does not contain at least one number"
        return $false
    }

    if ([System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr) -notmatch $letters)
    {
        Write-Host "Password does not contain at least one letter"
        return $false
    }

    if (([System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)).Length -lt 6)
    {
        Write-Host "Password is less than six characters"
        return $false
    }

    return $true
}