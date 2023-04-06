function Get-KETradableAssetPair {
    <#
    .SYNOPSIS
    Retrieves information about a specific Kraken asset pair.

    .DESCRIPTION
    The Get-KETradableAssetPair function retrieves information about a specific Kraken asset pair, such as trading fees, leverage, and margin.

    .PARAMETER Pair
    The trading pair to retrieve information for. Default value is "XBTUSD".

    .PARAMETER Info
    The type of information to retrieve for the asset pair. Possible values are "info" (default), "leverage", "fees", and "margin".

    .EXAMPLE
    PS C:\> Get-KETradableAssetPair -Pair "XXBTZUSD" -Info "fees"
    Retrieves trading fee information for the "XXBTZUSD" asset pair.

    .EXAMPLE
    PS C:\> Get-KETradableAssetPair
    Retrieves general information about the "XBTUSD" asset pair.

    .NOTES
    The KrakenExchange PowerShell module is not affiliated with or endorsed by Kraken exchange.
    Author: wnapierala [@] hotmail.com, chatGPT
    Date: 04.2023

    .LINK
    For more information, see the Kraken API documentation:
    https://docs.kraken.com/rest/#tag/Market-Data/operation/getTradableAssetPairs
    #>

    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$Pair = "XBTUSD",

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
