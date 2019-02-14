$path = "c:\Webcetera\scripts\ApplicantionList.xml"
$xml = [xml](Get-Content $path)
$result = $xml.applications.application | Out-GridView -PassThru -Title 'Make a  selection'

foreach($item in $result)
{
    Invoke-Item $item.url
}

