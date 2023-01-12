write-host "$(Get-Date) AIB Customization: Copying Zip file"
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Copying Zip file"
Copy-Item -Path \\gsazfilescorp.file.core.windows.net\azureimagebuilderfiles\applications\lookatme.zip -Destination c:\temp
Add-Content -LiteralPath C:\New-SessionHostImage.log "$(Get-Date) AIB Customization: Copying Zip file Complete"