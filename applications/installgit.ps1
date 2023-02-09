<# We have to query for and extract the current version number of GIT for Windows. The download URL changes for each version.
 This way, unless the api.github.com repor URL changes, we can leave this script alone as it will adapt
#>
$gitscrape=Invoke-RestMethod -Uri https://api.github.com/repos/git-for-windows/git/releases/latest | Select-Object -ExpandProperty name
$gitver = $gitscrape | Select-String -Pattern '\d+.\d+.\d+' | ForEach-Object Matches | Select-Object -expandproperty Value
write-host "$(Get-Date) AIB Customization: Getting current version of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Getting current version of $appname"
write-host "$(Get-Date) AIB Customization: The current version of $appname is $gitver"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: The current version of $appname is $gitver"

# Our default variables using the acquired version information. 
$appName = "git"
$appURI = "https://github.com/git-for-windows/git/releases/download/v$gitver.windows.1/Git-$gitver-64-bit.exe"
$apppkg = "Git-$gitver-64-bit.exe"
$drive = "C:\temp\apps"
$LocalPath = $drive + '\' + $appName
$outputPath = $LocalPath + '\' + $apppkg
write-host "$(Get-Date) AIB Customization: Install $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Install $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Install URI $appURI"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Install package name is $apppkg"
New-Item -Path $drive -Name $appName -ItemType Directory -ErrorAction SilentlyContinue

<# We are creating the setup parameter INF file used by the installer with our custom choices. https://github.com/git-for-windows/git/wiki/Silent-or-Unattended-Installation
The $infvalue variable is the content generated using the /saveinf switch.
#>
$infvalue="[Setup]
Lang=default
Dir=C:\Program Files\Git
Group=Git
NoIcons=0
SetupType=default
Components=ext,ext\shellhere,ext\guihere,gitlfs,assoc,assoc_sh,windowsterminal,scalar
Tasks=
EditorOption=VisualStudioCode
CustomEditorPath=
DefaultBranchOption=develop
PathOption=Cmd
SSHOption=OpenSSH
TortoiseOption=false
CURLOption=WinSSL
CRLFOption=CRLFAlways
BashTerminalOption=MinTTY
GitPullBehaviorOption=Merge
UseCredentialManager=Enabled
PerformanceTweaksFSCache=Enabled
EnableSymlinks=Disabled
EnablePseudoConsoleSupport=Enabled
EnableFSMonitor=Disabled"

Write-host "$(Get-Date) AIB Customization: Creating install parameter INF file for $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Creating install parameter INF file for $appname"
New-Item -Path $LocalPath -Name "gitparam.inf" -ItemType File -ErrorAction SilentlyContinue
Add-Content -LiteralPath C:\temp\apps\git\gitparam.inf $infvalue
Write-host "$(Get-Date) AIB Customization: Finished creating install parameter INF file for $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Finished creating install parameter INF file for $appname"

Write-host "$(Get-Date) AIB Customization: Starting download of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Starting download of $appname"
#Download command
(New-Object Net.WebClient).DownloadFile("$appURI", "$outputPath")
Write-Host "$(Get-Date) AIB Customization: Finished download of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Finished download of $appname"
Write-Host "$(Get-Date) AIB Customization: Starting Install of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Starting Install of $appname"
# Set your install switches and arguments
Start-Process $outputPath "/sp- /verysilent /LOADINF=C:\temp\apps\git\gitparam.inf /log=${localpath}\git.log" -Wait
Write-host "$(Get-Date) AIB Customization: Finished Install of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Finished Install of $appname"