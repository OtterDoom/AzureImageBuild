$appName = "agents"
$appURI = "https://saazureimagebuilder.blob.core.windows.net/applications/agents.zip"
$apppkg = "agents.zip"
$drive = "C:\temp"
$LocalPath = $drive + '\' + $appName
$outputPath = $LocalPath + '\' + $apppkg
write-host "$(Get-Date) AIB Customization: Download $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Download $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Download URI $appURI"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Download package name is $apppkg"
New-Item -Path $drive -Name $appName -ItemType Directory -ErrorAction SilentlyContinue

#login as AZCopy using managed identity
$env:AZCOPY_AUTO_LOGIN_TYPE="MSI"
# $env:AZCOPY_MSI_OBJECT_ID="2959ba51-134a-469d-8966-de1f513963e2"
# $env:AZCOPY_TENANT_ID="eff244d8-2c89-49e9-bb2a-c98646dc7330"
# C:\temp\apps\azcopy\azcopy_windows\azcopy.exe login --identity
# C:\temp\apps\azcopy\azcopy_windows\azcopy.exe login --identity --identity-object-id "2959ba51-134a-469d-8966-de1f513963e2"

#Download command
Write-Host "$(Get-Date) AIB Customization: Starting Download of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Starting download of $appname"
C:\temp\apps\azcopy\azcopy_windows\azcopy.exe copy $appURI $outputPath
Write-Host "$(Get-Date) AIB Customization: Completed Download of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Completed Download of $appname"

# Set your download switches and arguments
Write-host "$(Get-Date) AIB Customization: Unzipping $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Unzipping $appname"
Expand-Archive $outputPath -DestinationPath $LocalPath
Write-host "$(Get-Date) AIB Customization: Finished install of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Finished download of $appname"