$appName = "azcopy"
$appURI = "https://aka.ms/downloadazcopy-v10-windows"
$apppkg = "azcopy_windows_amd64_10.16.2.zip"
$drive = "C:\temp\apps"
$LocalPath = $drive + '\' + $appName
$outputPath = $LocalPath + '\' + $apppkg
write-host "$(Get-Date) AIB Customization: Download $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Download $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Download URI $appURI"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Download package name is $apppkg"
New-Item -Path $drive -Name $appName -ItemType Directory -ErrorAction SilentlyContinue
#Download command
(New-Object Net.WebClient).DownloadFile("$appURI", "$outputPath")
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) Download of $apppkg complete"
Write-Host "$(Get-Date) AIB Customization: Starting Download of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Starting download of $appname"
# Set your download switches and arguments
Expand-Archive $outputPath -DestinationPath $LocalPath
Write-host "$(Get-Date) AIB Customization: Finished download of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Finished download of $appname"