param(
[switch] $ls = $false,
[switch] $add = $false)

$path = "c:\Webcetera\scripts\ApplicantionList.xml"
$xml = [xml](Get-Content $path)
if($ls)
{
$xml.applications.application | Format-Table -AutoSize 
}
elseif($add)
{
$newapp = $xml.CreateElement("application")
$newapp.SetAttribute("Name", $args[0])
$newapp.SetAttribute("url", $args[1])
$xml.applications.AppendChild($newapp)
$xml.Save($path)
$xml = [xml](Get-Content $path)
}
elseif($null -ne $args[0])
{
$a = $args[0];
$url = ($xml.applications.application | Where-Object { $_.name.ToLower() -eq $a.ToLower() }).url
if($null -ne $url)
{
Invoke-Item $url
}
else
{
$response = Read-Host -Prompt "The application does not exist, do you want to add the new application" 
if($response.ToLower() -eq "y")
{
$name = Read-Host -Prompt "Enter the application name"
$url = Read-Host -Prompt "Enter the application url"
$newapp = $xml.CreateElement("application")
$newapp.SetAttribute("Name", $name)
$newapp.SetAttribute("url", $url)
$xml.applications.AppendChild($newapp)
$xml.Save($path)
$xml = [xml](Get-Content $path)
Write-Host "The application '$name' was added"
}
else
{
Write-Host "Use Get-Help .Open.ps1 command for more help!! Bye..."
}
}
}
else{
 Write-Host "The application name is required. Use -ls to see list of applications" -foregroundColor Red
}
<#

.SYNOPSIS
This is a script to launch application

.DESCRIPTION
Use this script to open any applicattion as administrator.

.EXAMPLE

1.To see the list of available application and alias : ./Open.ps1 -ls
2. To add a new application : .Open.ps1 -add <alias> "<application/file path>" 
3. To launch an application :.open.ps1 <alias>


.NOTES
Your feedback is always appreciated.

.LINK
http://www.vivekkumarpandey.com

#>

