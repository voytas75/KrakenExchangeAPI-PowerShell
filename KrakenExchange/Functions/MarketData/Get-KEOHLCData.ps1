function Get-KEOHLCData {
<#
.SYNOPSIS
Gets OHLC data for a given trading pair from the Kraken exchange.

.DESCRIPTION
The Get-OHLCData function retrieves the Open, High, Low, Close (OHLC) data for a given trading pair from the Kraken exchange.

.PARAMETER Pair
The trading pair for which to retrieve OHLC data. The default is XBTUSD.

.PARAMETER OHLCInterval
The time interval, in minutes, for each OHLC datapoint. Must be a value between 1 and 1440. The default is 15.

.PARAMETER OHLCCount
The number of OHLC datapoints to retrieve. The default is 5.

.NOTES
The KrakenExchange PowerShell module is not affiliated with or endorsed by Kraken exchange.
Author: wnapierala [@] hotmail.com, chatGPT
Date: 04.2023

.LINK
For more information, see the Kraken API documentation:
https://docs.kraken.com/rest/#tag/Market-Data/operation/getOHLCData    
#>

    [CmdletBinding()]
    param (
        [Parameter()]
        [ValidatePattern("[A-Z]")]
        [string]$Pair = "XBTUSD",

        [Parameter()]
        [ValidateSet(1,5,15,30,60,240,1440,10080)]
        [int]$OHLCInterval = 15,

        [Parameter()]
        [int]$OHLCCount = 5
        
    )
    
    $OHLCMethod = "/0/public/OHLC"
    $endpoint = "https://api.kraken.com"
    $OHLCurl = $endpoint + $OHLCMethod
    $UserAgent = "Powershell Module KrakenExchange/1.0"

    $OHLCSince = $OHLCInterval * $OHLCCount
    $since = [int][double]::Parse((Get-Date ((get-date).addminutes(-$OHLCSince)).touniversaltime() -UFormat %s))

    $OHLCparams = [ordered]@{ 
        "pair"     = $Pair 
        "interval" = $OHLCInterval
        "since"    = $since 
    }
    $OHLCHeaders = @{ 
        "User-Agent" = $useragent
    }

    $OHLCresponse = Invoke-RestMethod -Uri $OHLCurl -Method Post -Body $OHLCparams -Headers $OHLCHeaders

    return $OHLCresponse
}
