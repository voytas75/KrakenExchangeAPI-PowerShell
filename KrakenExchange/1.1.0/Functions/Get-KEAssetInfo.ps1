function Get-KEAssetInfo {
    <#
    .SYNOPSIS
    Retrieves information about a specific asset from the Kraken API.
    
    .DESCRIPTION
    This function retrieves information about a specific asset (e.g. currency) from the Kraken API. It requires the asset symbol as input, and returns detailed information about the asset including its name, ticker, trading volume, etc.
    
    .PARAMETER Asset
    The symbol of the asset for which information is to be retrieved.
    
    .EXAMPLE
    Get-AssetInfo -Asset "XBT"
    Retrieves information about the "XBT" asset (Bitcoin) from the Kraken API.
    
    .LINK
    For more information, see the Kraken API documentation:
    https://docs.kraken.com/rest/#tag/Market-Data/operation/getAssetInfo

    .NOTES
    The KrakenExchange PowerShell module is not affiliated with or endorsed by Kraken exchange.
    Author: wnapierala [@] hotmail.com, chatGPT
    Date: 04.2023
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$Asset = "BTC,ETH"
    )
    
    $AssetInfoMethod = "/0/public/Assets"
    $endpoint = "https://api.kraken.com"
    $UserAgent = "Powershell Module KrakenExchange/1.0"
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
        
 