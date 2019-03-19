param(
[switch] $ls = $false,
[switch] $add = $false,
[switch] $build = $false)

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
elseif($null -ne $args[0] )
{
$a = $args[0];
$element = ($xml.applications.application | Where-Object { $_.name.ToLower() -eq $a.ToLower() })
$url = $element.url
$serviceName = $element.ServiceName
if($build)
{
    if($null -ne $url)
    {
    $ms = "& 'C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin\MSBuild.exe' /target:Build "
    Invoke-Expression "$ms $url /nologo /consoleloggerparameters:ErrorsOnly /verbosity:q"

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
$src = Get-Service -Name $serviceName
if($src.Status -eq "Running"){
    if($src.CanStop)
    {
        $src.Stop()        
    }
    else
    {
        Write-Host $src  'can not be stopped' -foregroundColor Red
    }
}
elseif ($src.Status -eq "Stopped")
{
 
 try{
 $src |  Start-Service 
 }
 catch{
 Write-Host An error has occurred
 }
}
$src = Get-Service -Name $serviceName
Write-Host $src.DisplayName is : $src.Status
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

