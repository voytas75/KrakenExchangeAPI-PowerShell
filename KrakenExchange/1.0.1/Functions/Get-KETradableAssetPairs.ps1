function Get-KETradableAssetPairs {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Pair,

        [Parameter()]
        [validateSet("info", "leverage", "fees", "margin")]
        [string]$Info = "info"
    )
    
    $TradableAssetPairsMethod = "/0/public/AssetPairs"
    $endpoint = "https://api.kraken.com"
    $UserAgent = "Powershell Module KrakenExchange/1.0"
    $TradableAssetPairsUrl = $endpoint + $TradableAssetPairsMethod

    $TradableAssetPairsParams = [ordered]@{ 
        "pair" = $Pair
        "info" = $info
    }
    
    $TradableAssetPairsHeaders = @{ 
        "User-Agent" = $UserAgent
    }

    $TradableAssetPairsResponse = Invoke-RestMethod -Uri $TradableAssetPairsUrl -Method Get -Headers $TradableAssetPairsHeaders -Body $TradableAssetPairsParams
    
    return $TradableAssetPairsResponse
}
