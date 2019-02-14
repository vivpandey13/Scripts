$claim = Get-Service -Name EZLynxClaimsSvc
if($claim.Status -eq "Running"){
    if($claim.CanStop)
    {
        $claim.Stop()        
    }
    else
    {
        Write-Host $claim  'can not be stopped' -foregroundColor Red
    }
}
elseif ($claim.Status -eq "Stopped")
{
 
 try{
 $claim |  Start-Service 
 }
 catch{
 Write-Host An error has occurred
 }
}
$claim = Get-Service -Name EZLynxClaimsSvc
Write-Host $claim.DisplayName is : $claim.Status
