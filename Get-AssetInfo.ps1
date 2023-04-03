function Get-AssetInfo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Asset
    )
    
    $AssetInfoMethod = "/0/public/Assets"
    $endpoint = "https://api.kraken.com"
    $UserAgent = "PowershellScript/1.0"
    $AssetInfoUrl = $endpoint + $AssetInfoMethod

    $AssetInfoParams = [ordered]@{ 
        "asset"  = $Asset
        "aclass" = "currency" 
    }
    
    $AssetInfoHeaders = @{ 
        "User-Agent" = $UserAgent
    }

    $AssetInfoResponse = Invoke-RestMethod -Uri $AssetInfoUrl -Method Get -Headers $AssetInfoHeaders -Body $AssetInfoParams
        
    return $AssetInfoResponse
}    
        
 