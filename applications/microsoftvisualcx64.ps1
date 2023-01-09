$appName = "visualC"
$appURI = "https://aka.ms/vs/17/release/vc_redist.x64.exe"
$apppkg = "vc_redist.x64.exe"
$drive = "C:\temp\apps"
$LocalPath = $drive + '\' + $appName
$outputPath = $LocalPath + '\' + $apppkg
write-host "AIB Customization: Install $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Install $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Install URI $appURI"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Install package name is $apppkg"
New-Item -Path $drive -Name $appName -ItemType Directory -ErrorAction SilentlyContinue
(New-Object Net.WebClient).DownloadFile("$appURI", "$outputPath")
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) Download of $apppkg complete"
Write-Host "AIB Customization: Starting Install of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Starting Install of $appname"
# Set your install switches and arguments
Start-Process -FilePath $outputPath -Args "/install /quiet /norestart /log C:\temp\vcdist.log" -Wait
Write-host "AIB Customization: Finished Install of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Finished Install of $appname"