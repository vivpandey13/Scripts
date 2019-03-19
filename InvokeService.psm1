Import-Module .\GetApplication.psm1    

function Invoke-Service {    
    [Alias("toggleService")]
    param( 
        [switch] $ls = $false, 
        [switch] $add = $false
    )

    if ($ls) {
        Get-Application -ls
    }
    elseif ($add) {
        Get-Application -add $args[0] $args[1]
    }
    elseif ($null -ne $args[0]) { 
        $lst = $args[0].split(',')
        foreach ($app in $lst) {
            $element = Get-Application $app
            if ($null -ne $element -and $null -ne $element.ServiceName) {
                $src = Get-Service -Name $element.ServiceName
                if ($src.Status -eq "Running") {
                    if ($src.CanStop) {
                        $src.Stop()        
                    }
                    else {
                        Write-Output $src  'can not be stopped' -foregroundColor Red
                    }
                }
                elseif ($src.Status -eq "Stopped") {
     
                    try {
                        $src |  Start-Service 
                    }
                    catch {
                        Write-Error 'An error has occurred while starting the service'
                    }
                }
                $src.Refresh()
                Write-Host $src.DisplayName is : $src.Status
            }
        }
    }
}

# Remove-Module InvokeService
# Import-Module .\InvokeService.psm1
# Invoke-Service cp, pp
# toggleService  cp, pp
