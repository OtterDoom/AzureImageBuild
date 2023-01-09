# Installation of Teams on Windows Multisession host requires the following. There is a prerequisite of installing the Visual C++ Redistributable before this script runs.
# set regKey
write-host 'AIB Customization: Set required regKey'
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Going to set registry key for Teams Multisession"
New-Item -Path HKLM:\SOFTWARE\Microsoft -Name "Teams" 
New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Teams -Name "IsWVDEnvironment" -Type "Dword" -Value "1"
write-host 'AIB Customization: Finished Set required regKey'
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Finished set registry key for Teams Multisession"

# install webSoc svc
$appName = "webSocketSvc"
$appURI = "https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4AQBt"
$apppkg = "webSocketSvc.msi"
$drive = 'C:\temp\apps'
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
Start-Process -FilePath msiexec.exe -Args "/I $outputPath /quiet /norestart /log C:\temp\webSocket.log" -Wait
Write-host "AIB Customization: Finished Install of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Finished Install of $appname"

# install Teams
$appName = "teams"
$appURI = "https://teams.microsoft.com/downloads/desktopurl?env=production&plat=windows&arch=x64&managedInstaller=true&download=true"
$apppkg = "teams.msi"
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
Start-Process -FilePath msiexec.exe -Args "/I $outputPath /quiet /norestart /log C:\temp\teams.log ALLUSER=1 ALLUSERS=1" -Wait
Write-host "AIB Customization: Finished Install of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Finished Install of $appname"