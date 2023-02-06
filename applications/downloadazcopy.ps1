$appName = "azcopy"
$appURI = "https://aka.ms/downloadazcopy-v10-windows"
$apppkg = "azcopy_windows.zip"
$drive = "C:\temp\apps"
$LocalPath = $drive + '\' + $appName
$outputPath = $LocalPath + '\' + $apppkg
write-host "$(Get-Date) AIB Customization: Download $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Download $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Download URI $appURI"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Download package name is $apppkg"
New-Item -Path $drive -Name $appName -ItemType Directory -ErrorAction SilentlyContinue
Write-Host "$(Get-Date) AIB Customization: Starting Download of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Starting download of $appname"
#Download command
(New-Object Net.WebClient).DownloadFile("$appURI", "$outputPath")
Write-Host "$(Get-Date) AIB Customization: Completed Download of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Completed Download of $appname"
# Set your download switches and arguments
Expand-Archive $outputPath -DestinationPath $LocalPath
Get-ChildItem $LocalPath -Attributes D | Rename-Item -NewName "azcopy_windows"
Write-host "$(Get-Date) AIB Customization: Finished unzip of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Finished unzip of $appname" 
