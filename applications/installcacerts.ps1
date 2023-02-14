$appName = "CACerts"
$appURI = "https://saaibeastus2.blob.core.windows.net/applications/Certs.zip"
$apppkg = "Certs.zip"
$drive = "C:\temp"
$LocalPath = $drive + '\' + $appName
$outputPath = $LocalPath + '\' + $apppkg
write-host "$(Get-Date) AIB Customization: Download $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Download $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Download URI $appURI"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Download package name is $apppkg"
New-Item -Path $drive -Name $appName -ItemType Directory -ErrorAction SilentlyContinue

#Download command
Write-Host "$(Get-Date) AIB Customization: Starting Download of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Starting download of $appname"
#set auto_login environment variable
$env:AZCOPY_AUTO_LOGIN_TYPE="MSI"
C:\temp\apps\azcopy\azcopy_windows\azcopy.exe copy $appURI $outputPath
Write-Host "$(Get-Date) AIB Customization: Completed Download of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Completed Download of $appname"

# Unzip the Certs
Write-host "$(Get-Date) AIB Customization: Unzipping $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Unzipping $appname"
Expand-Archive $outputPath -DestinationPath $LocalPath
Write-host "$(Get-Date) AIB Customization: Finished Download of $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Finished download of $appname"

# Install the Certs
Write-host "$(Get-Date) AIB Customization: Installing $appname"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Installing $appname"


$Certificates = Get-ChildItem $LocalPath -Filter *.cer -Recurse

foreach ($Cert in $Certificates )
{

    $CertName = $Cert.Name
    $CertFilePath = $Cert.VersionInfo.FileName

    if ($CertName -like "*root*") {

    try {
        Import-Certificate -FilePath $CertFilePath -CertStoreLocation Cert:\LocalMachine\Root
        Write-host "$(Get-Date) AIB Customization: Installed $CertName from $appname"
        Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Finished install of $CertName from $appname"
        }
        catch {
        Write-host "$(Get-Date) AIB Customization: Failled Install of $CertName from $appname with error: $_"
        Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Failed install of $CertName from $appname with error: $_"
        }

} 
elseif ($CertName  -like "*intermediate*") {
 
    try {
        Import-Certificate -FilePath $CertFilePath -CertStoreLocation Cert:\LocalMachine\CA
        Write-host "$(Get-Date) AIB Customization: Installed $CertName from $appname"
        Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Finished install of $CertName from $appname"
        }
        catch {
        Write-host "$(Get-Date) AIB Customization: Failled Install of $CertName from $appname with error: $_"
        Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Failed install of $CertName from $appname with error: $_"
        }
    
}

}