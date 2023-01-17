$appName = "agents"
$appURI = "https://saaibeastus2files.blob.core.windows.net/applications/agents.zip"
$apppkg = "agents.zip"
$drive = "C:\temp"
$LocalPath = $drive + '\' + $appName
$outputPath = $LocalPath + '\' + $apppkg
write-host "$(Get-Date) AIB Customization: Download $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Download $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Download URI $appURI"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Download package name is $apppkg"
New-Item -Path $drive -Name $appName -ItemType Directory -ErrorAction SilentlyContinue
#login with azcopy using managed identity
C:\temp\apps\azcopy\azcopy_windows_amd64_10.16.2\azcopy.exe login --identity --identity-client-id "d8453f9c-e06b-4346-86ca-16b4a04b1f9f"
#Download command
C:\temp\apps\azcopy\azcopy_windows_amd64_10.16.2\azcopy.exe copy $appURI $outputPath
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) Download of $apppkg complete"
Write-Host "$(Get-Date) AIB Customization: Starting Download of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Starting download of $appname"
# Set your download switches and arguments
Expand-Archive $outputPath -DestinationPath $LocalPath
Write-host "$(Get-Date) AIB Customization: Finished install of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Finished download of $appname"