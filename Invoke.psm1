Import-Module .\GetApplication.psm1    

function Invoke-Application {    
    [Alias("launch")]
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
            if ($null -ne $element -and $null -ne $element.url) {
                Invoke-Item $element.url
            }
        }
    }
}

# Remove-Module InvokeApplication
# Import-Module .\InvokeApplication.psm1
# Invoke-Application vs, api
# launch  vs
