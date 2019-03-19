function Invoke-Application {
    param( [switch] $ls = $false,  [switch] $add = $false)
$url = Get-Application -ls $ls -add $add $args[0] $args[1]
if($null -ne $url){
    Invoke-Item $url
}
}