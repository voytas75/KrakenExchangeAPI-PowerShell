function Get-KETickerInformation {
    <#
    .SYNOPSIS
    Retrieves ticker information for a specified trading pair from the Kraken exchange.
    
    .DESCRIPTION
    The Get-KETickerInformation function retrieves ticker information for a specified trading pair from the Kraken exchange using the Kraken API.
    
    .PARAMETER Pair
    The trading pair to retrieve ticker information for. Default value is XBTUSD.
    
    .EXAMPLE
    PS C:\> Get-KETickerInformation -Pair "ETHUSD"
    Returns the ticker information for the ETHUSD trading pair.
    
    .OUTPUTS
    Returns a PowerShell object with the following properties:
    - a: Array of ask prices
    - b: Array of bid prices
    - c: Array of last trade closed prices
    - v: Array of volume information
    - p: Array of volume weighted average prices
    - t: Array of number of trades
    - l: Array of low prices
    - h: Array of high prices
    - o: Opening price
    
    .NOTES
    The KrakenExchange PowerShell module is not affiliated with or endorsed by Kraken exchange.
    Author: wnapierala [@] hotmail.com, chatGPT
    Date: 04.2023
    
    .LINK
    For more information, see the Kraken API documentation:
    https://www.kraken.com/features/api
    
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$Pair = "XBTUSD"
    )
    
    $TickerInformationMethod = "/0/public/Ticker"
    $Endpoint = "https://api.kraken.com"
    $UserAgent = "Powershell Module KrakenExchange/1.0"
    $TickerInformationUrl = $Endpoint + $TickerInformationMethod

    $TickerInformationParams = @{
        "pair" = $Pair
    }
    
    $TickerInformationHeaders = @{ 
        "User-Agent" = $UserAgent
    }

    $TickerInformationResponse = Invoke-RestMethod -Uri $TickerInformationUrl -Method Get -Headers $TickerInformationHeaders -Body $TickerInformationParams
    
    return $TickerInformationResponse
}
