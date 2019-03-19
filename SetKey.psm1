<#
.Synopsis
  Change value of a key in an XML file.
.DESCRIPTION
   Change value of a key in an XML file.
.EXAMPLE
   Set-Key -FilePath $filepath -ElementPath "//log4net/root/level/@value" -ChangedValue "WARN"
#>
function Set-Key 
{
    param($FilePath,$ElementPath,$ChangedValue)
  
        $webfile = $FilePath
        [xml]$webconfig = Get-Content $webfile
        $node =  $webconfig.SelectSingleNode($ElementPath)
        $node.Value = $ChangedValue 
        $webconfig.Save($webfile)
        Get-Key -FilePath $FilePath -ElementPath $ElementPath
        
  
}
function Get-Key 
{
    param($FilePath,$ElementPath)
  
        $webfile = $FilePath
        [xml]$webconfig = Get-Content $webfile
        $node =  $webconfig.SelectSingleNode($ElementPath)
        if($null -ne $node){

           Write-Host $node.Name ':'$node.Value
        }
        
  
}

# Remove-Module SetKey
# Import-Module .\SetKey.psm1