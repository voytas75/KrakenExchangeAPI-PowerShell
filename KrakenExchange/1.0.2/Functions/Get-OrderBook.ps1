function Get-OrderBook {
    <#
    .NOTES
    The KrakenExchange PowerShell module is not affiliated with or endorsed by Kraken exchange.
    Author: wnapierala [@] hotmail.com, chatGPT
    Date: 04.2023
    
    .LINK
    For more information, see the Kraken API documentation:
    https://docs.kraken.com/rest/#tag/Market-Data/operation/getOrderBook    #>
    
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$Pair = "XBTUSD",
    
        [Parameter()]
        [int]$Count
            
    )
        
    $OrderBookMethod = "/0/public/Depth"
    $endpoint = "https://api.kraken.com"
    $OrderBookurl = $endpoint + $OrderBookMethod
    $UserAgent = "Powershell Module KrakenExchange/1.0"
   
    $OrderBookParams = [ordered]@{ 
        "pair"  = $Pair 
        "count" = $Count
    }
    $OrderBookHeaders = @{ 
        "User-Agent" = $useragent
    }
    
    $OrderBookResponse = Invoke-RestMethod -Uri $OrderBookurl -Method Get -Body $OrderBookParams -Headers $OrderBookHeaders
    
    return $OrderBookResponse
}
    