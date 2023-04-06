
function Get-KERecentSpreads {
    <#

.NOTES
The KrakenExchange PowerShell module is not affiliated with or endorsed by Kraken exchange.
For more information, see the Kraken API documentation: 
https://docs.kraken.com/rest/#tag/Market-Data/operation/getRecentSpreads
Author: wnapierala [@] hotmail.com, chatGPT
Date: 04.2023
#>
    [CmdletBinding()]
    param ( 
        [Parameter()]
        [string]$Pair = "XBTUSD"
    )
        
    $RecentSpreadsMethod = "/0/public/Spread"
    $endpoint = "https://api.kraken.com"
    $UserAgent = "Powershell Module KrakenExchange/1.0"
    $RecentSpreadsUrl = $endpoint + $RecentSpreadsMethod
    
    $RecentSpreadsParams = [ordered]@{ 
        "pair" = $Pair 
    }
    
    $RecentSpreadsHeaders = @{ 
        "User-Agent" = $UserAgent
    }
    
    $RecentSpreadsResponse = Invoke-RestMethod -Uri $RecentSpreadsUrl -Method Get -Headers $RecentSpreadsHeaders -Body $RecentSpreadsParams
    
    return $RecentSpreadsResponse
}    
