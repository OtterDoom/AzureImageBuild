$appName = "vdot"
$appURI = "https://saaibeastus2.blob.core.windows.net/applications/vdot.zip"
$apppkg = "vdot.zip"
$drive = "C:\temp"
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
#set auto_login environment variable so azcopy will use the Managed Service Identity assigned to the Azure Image Builder VM and will be able to connect to our Azure Storage account
$env:AZCOPY_AUTO_LOGIN_TYPE="MSI"
C:\temp\apps\azcopy\azcopy_windows\azcopy.exe copy $appURI $outputPath
Write-Host "$(Get-Date) AIB Customization: Finished Download of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Finished Download of $appname"
# Unzip the package
Write-host "$(Get-Date) AIB Customization: Unzipping $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Unzipping $appname"
Expand-Archive $outputPath -DestinationPath $LocalPath
Write-host "$(Get-Date) AIB Customization: Finished unzipping of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Finished unzipping of $appname"
