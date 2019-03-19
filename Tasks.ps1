#region Change Location
Set-Location C:\Webcetera\scripts
Set-Location C:\Users\Vivek.Pandey\Downloads
Set-Location C:\Webcetera\source\EzLynx\CommonResources
Set-Location C:\Webcetera\source\EzLynx\EzLynx\Apps\ApplicantPortal\src\EzLynx.ApplicantPortal.App
Set-Location C:\Users\ra-vpandey\source\repos
Set-Location C:\Users\ra-vpandey\Documents\WindowsPowerShell\Modules

#endregion

#region Search

Get-ChildItem -Filter "CacheCleanService.csproj" -r | Select-Object FullName
Get-ChildItem -recurse |  Select-String -pattern "FileTypeDetector_Tests.Detect_Unknown" | Group-Object path | Select-Object name
#endregion

#region Utility
.filecopier.ps1 # Copy the files to CIM
.\taskautomation.bat # Install gulp and grunt in various places
.\ClientCenterLocalSetup.ps1 
.\PolicyProcessorSetup.ps1
#endregion

#region Service
Get-Service | Where-Object {$_.Name -like "EZLynx*"} | Stop-Service
Get-Service | Where-Object {$_.Name -like "EZLynx*"} | Start-Service
Get-Service | where-object {$_.Name -like 'Ezlynx*'} | Format-Table Name, DisplayName, Status

Get-Service "EZLynx Policy Processor" | Stop-Service
Get-Service "EZLynx Policy Processor" | Start-Service
#endregion

#region Open
.\Open.ps1 epolicy
.\Open.ps1 ds
.\Open.ps1 epolicy
.\Open.ps1 cca
.\Open.ps1 cc
.\Open.ps1 cp
.\Open.ps1 cm
.\Open.ps1 soss
.\Open.ps1 ezweb
.\Open.ps1 ap
.\Open.ps1 vs
.\Open.ps1 cc
code .\Service.ps1
code .\ApplicantionList.xml

#endregion

#region VS code
code test.sql
code .\Tasks.ps1
#endregion

#region Toggle Claims Processor service
net stop EZLynxClaimsSvc
net start EZLynxClaimsSvc

#endregion

#region Disable http/2
Set-ItemProperty -Path HKLM:\System\CurrentControlSet\Services\HTTP\Parameters -Name EnableHttp2Tls -Value 0 -Type DWord
Set-ItemProperty -Path HKLM:\System\CurrentControlSet\Services\HTTP\Parameters -Name EnableHttp2Cleartext -Value 0 -Type DWord
#endregion

#region Windows
optionalfeatures
regedit
Clear-Host
ssms
cleanmgr
appwiz
Get-Content C:\Users\Vivek.Pandey\.ssh\id_rsa.pub | clip
Get-Content -Path $(Join-Path $env:USERPROFILE "\.ssh\id_rsa.pub")  | clip
sysdm.cpl #Computer properties
Get-ChildItem *.txt | Rename-Item -NewName { $_.name -Replace 'Existing', 'New' } #Rename files in a folder

#endregion


