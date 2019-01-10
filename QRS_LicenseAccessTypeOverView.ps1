####################################################################################
#v1.0 Author Yoichi H
#Example on how to fetch data using QRS License Overview API into a file. Pls change the code based on your environment. 
#This code is NOT supported by Qlik.
####################################################################################

$output = "C:\yheTemp\LicenseAccessTypeOverview.txt"
$hdrs = @{}
$hdrs.Add("X-Qlik-Xrfkey","examplexrfkey123")
$hdrs.Add("X-Qlik-User", "UserDirectory=Domain;UserId=Administrator")
#$hdrs
$xrfkey="examplexrfkey123"
#$xrfkey
$cert = Get-ChildItem -Path "Cert:\CurrentUser\My" | Where {$_.Subject -like '*QlikClient*'}
#$cert
$Data = Get-Content C:\ProgramData\Qlik\Sense\Host.cfg
$FQDN = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($($Data)))
#$FQDN
$StartTime = Get-Date
Write-Host "Start Time is:" $StartTime
$GetAppObjectFull = Invoke-RestMethod -Uri "https://$($FQDN):4242/qrs/license/accesstypeoverview?xrfkey=$($xrfkey)" -Method Get -Headers $hdrs -ContentType 'application/json' -Certificate $cert
#$GetAppObjectFull
$return = $GetAppObjectFull | Out-String | Out-File $output
$EndTime = Get-Date
Write-Host "Finishedt Time is:" $EndTime