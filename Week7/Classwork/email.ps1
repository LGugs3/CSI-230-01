function sendAlertEmail($body)
{
    $sender = "liam.gugliotta@mymail.champlain.edu"
    $reciever = "liam.gugliotta@mymail.champlain.edu"
    $subject = "Suspicous Activity"

    $password = "bwyg jcjt aask wyat" | ConvertTo-SecureString -AsPlainText -Force
    $creds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $sender, $password

    Send-MailMessage -From $sender -To $reciever -Subject $subject -Body $body -SmtpServer "smtp.gmail.com" `
    -port 587 -UseSsl -Credential $creds
}