$appName = "chrome"
$appURI = "https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi"
$apppkg = "googlechromestandaloneenterprise64.msi"
$drive = "C:\temp\apps"
$LocalPath = $drive + '\' + $appName
$outputPath = $LocalPath + '\' + $apppkg
write-host "$(Get-Date) AIB Customization: Install $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Install $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Install URI $appURI"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Install package name is $apppkg"
New-Item -Path $drive -Name $appName -ItemType Directory -ErrorAction SilentlyContinue
#Download command
(New-Object Net.WebClient).DownloadFile("$appURI", "$outputPath")
write-host "$(Get-Date) AIB Customization: Download of $apppkg complete"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Download of $apppkg complete"
Write-Host "$(Get-Date) AIB Customization: Starting Install of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Starting Install of $appname"
#Install Command
Start-Process -FilePath msiexec.exe -Args "/I $outputPath /q /log C:\temp\chrome.log" -Wait
Write-host "$(Get-Date) AIB Customization: Finished Install of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Finished Install of $appname"