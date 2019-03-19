function Get-Application {
    param( [switch] $ls = $false,  [switch] $add = $false,
    [switch] $like = $false)

    $path = "c:\Webcetera\scripts\ApplicantionList.xml"
    $xml = [xml](Get-Content $path)
    if ($ls) {
        $xml.applications.application
    }
    elseif ($add) {
        New-Application -xml $xml -Name $args[0] -url $args[1] -path $path
    }    
    elseif ($like) {
    
        $a = "*"+$args[0]+"*"
        $xml.applications.application| Where-Object {$_.Url -like ($a)}
    }
    elseif ($null -ne $args[0]) {
        $a = $args[0];
        $element = ($xml.applications.application | Where-Object { $_.name.ToLower() -eq $a.ToLower() })
        if ($null -ne $element) {
            Return $element 
        }
        else {
            $response = Read-Host -Prompt "The application does not exist, do you want to add the new application" 
            if ($response.ToLower() -eq "y") {
                $name = Read-Host -Prompt "Enter the application name"
                $url = Read-Host -Prompt "Enter the application url"
                New-Application -xml $xml -Name $name -url $url -path $path
            }
            else {
                Write-Host "Use Get-Help .Open.ps1 command for more help!! Bye..."
            }
        }
    }
    else {
        Write-Error "The application name is required. Use -ls to see list of applications" 
    }
}

function New-Application 
{
    param ($xml,$Name,$url,$path)

    $newapp = $xml.CreateElement("application")
    $newapp.SetAttribute("Name", $Name)
    $newapp.SetAttribute("url", $url)
    $xml.applications.AppendChild($newapp)
    $xml.Save($path)
    $xml = [xml](Get-Content $path)
    Write-Host "The application '$name' was added"
    
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

# Remove-Module GetApplication
# Import-Module .\GetApplication.psm1

