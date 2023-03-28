
#Requires -Version 7.0

<#
    .SYNOPSIS
    This script provides a PowerShell wrapper around the Kraken API.
    
    .DESCRIPTION
    This script provides a PowerShell wrapper around the Kraken API. It can be used to retrieve various information from the API, such as system status, trade balance, account balance, server time, OHLC data, and trade volume.
    
    .PARAMETER SystemStatus
    Returns the current system status of the Kraken API.
    
    .PARAMETER TradeBalance
    Returns the trade balance for a specific asset.
    
    .PARAMETER AccountBalance
    Returns the account balance for all assets.
    
    .PARAMETER ServerTime
    Returns the server time for the Kraken API.
    
    .PARAMETER OHLC
    Returns OHLC data for a specific currency pair.
    
    .PARAMETER OHLCSince
    Specifies the time frame for the OHLC data, in minutes.
    
    .PARAMETER OHLCInterval
    Specifies the interval for the OHLC data, in minutes.
    
    .PARAMETER TradeVolume
    Returns the trade volume for a specific currency pair.
    
    .PARAMETER ApiKey
    Specifies the API key to use for authentication.
    
    .PARAMETER ApiSecret
    Specifies the API secret to use for authentication.
    
    .EXAMPLE
    .\kraken.ps1 -ApiKey $env:apikey -ApiSecret $env:ApiSecret -TradeVolume
    
    This command returns the trade volume for the currency pair ETH/USD.
    
    .EXAMPLE
    (.\kraken.ps1 -ApiKey $env:apikey -ApiSecret $env:ApiSecret -TradeVolume).result | select -ExpandProperty volume
    
    This command returns only the trade volume value for the currency pair ETH/USD.

    .NOTES
    https://docs.kraken.com/rest/#tag/Market-Data/operation/getTickerInformation
    https://algotrading101.com/learn/kraken-api-guide/
    
    Author: wnapierala [@] hotmail.com
    Date: 03.2023
    #>


param (
    [switch]$SystemStatus,
    [switch]$TradeBalance,
    [switch]$AccountBalance,
    [switch]$ServerTime,
    [switch]$OHLC,
    [int]$OHLCSince = 15,
    [int]$OHLCInterval = 15,
    [switch]$TradeVolume,
    [string]$ApiKey = $env:apiKey,
    [string]$ApiSecret = $env:ApiSecret,
    [switch]$Help
)

function Show-Help {
    Write-Host "Kraken PowerShell script"
    Write-Host "Usage: kraken.ps1 [-ApiKey <string>] [-ApiSecret <string>] [-SystemStatus] [-TradeBalance] [-AccountBalance] [-ServerTime] [-OHLC] [-OHLCSince <int>] [-OHLCInterval <int>] [-TradeVolume]"
    Write-Host "  -ApiKey        Kraken API key."
    Write-Host "  -ApiSecret     Kraken API secret."
    Write-Host "  -SystemStatus  Get Kraken system status."
    Write-Host "  -TradeBalance  Get the trade balance for the user's account."
    Write-Host "  -AccountBalance Get the account balance for the user's account."
    Write-Host "  -ServerTime    Get Kraken server time."
    Write-Host "  -OHLC          Get OHLC data for a currency pair."
    Write-Host "  -OHLCSince     The time period in minutes from which to retrieve OHLC data. Default is 15."
    Write-Host "  -OHLCInterval  The interval in minutes between OHLC data points. Default is 15."
    Write-Host "  -TradeVolume   Get the user's trade volume."
    Write-Host "  -Help          This help."
    exit 0
}

if ($help.IsPresent) {
    <# Action to perform if the condition is true #>
    Show-Help
}

. .\Set-APIKrakenSignature.ps1

#useragent
$useragent = "myuseragent/1.0"

# Set API endpoint and version
$endpoint = "https://api.kraken.com"

# Set API method and parameters
# Public:
$OHLCMethod = "/0/public/OHLC"
$ServerTimeMethod = "/0/public/Time"
$systemstatusMethod = "/0/public/SystemStatus"
# Private:
$AccountBalanceMethod = "/0/private/Balance"
$TradeBalanceMethod = "/0/private/TradeBalance"
$TradeVolumeMethod = "/0/private/TradeVolume"

# Generate nonce
$nonce = [Math]::Round((New-TimeSpan -Start "1/1/1970").TotalMilliseconds)
# what is nonce: https://support.kraken.com/hc/en-us/articles/360000906023-What-is-a-nonce-
#[int][double]::Parse((Get-Date (get-date).touniversaltime() -UFormat %s))
#[int32]([DateTime]::UtcNow - (New-Object DateTime 1970, 1, 1, 0, 0, 0, 0, ([DateTimeKind]::Utc))).TotalMilliseconds

# Build API request URL
$AccountBalanceUrl = $endpoint + $AccountBalanceMethod
$ServerTimeUrl = $endpoint + $ServerTimeMethod
$TradeBalanceurl = $endpoint + $TradeBalanceMethod
$TradeVolumeUrl = $endpoint + $TradeVolumeMethod

#TradeVolume
if ($TradeVolume.IsPresent) {
    <# Action to perform if the condition is true #>
    $TradeVolumeParams = [ordered]@{ 
        "nonce" = $nonce
        "pair"  = "ETHUSD" 
    }
    
    $signature = Set-APIKrakenSignature -Payload $TradeVolumeParams -URI $TradeVolumeMethod -api_secret $apiSecret
    
    # Build API request headers
    $TradeVolumeheaders = @{ 
        "API-Key"      = $apiKey
        "API-Sign"     = $signature
        "Content-Type" = "application/x-www-form-urlencoded; charset=utf-8"
        "User-Agent"   = $useragent
    }

    $TradeVolumeResponse = Invoke-RestMethod -Uri $TradeVolumeUrl -Method Post -Headers $TradeVolumeheaders -Body $TradeVolumeParams
    $TradeVolumeResponse

}

#systemstatus
if ($systemstatus.IsPresent) {
    $systemstatusheaders = @{ 
        "User-Agent" = $useragent
    }
    $systemstatusUrl = $endpoint + $systemstatusMethod
    $systemstatusResponse = Invoke-RestMethod -Uri $systemstatusUrl -Method Get -Headers $systemstatusheaders
    $systemstatusResponse | ConvertTo-Json
}

#server time
if ($ServerTime.IsPresent) {
    <# Action to perform if the condition is true #>
    $ServerTimeResponse = Invoke-RestMethod -Uri $ServerTimeUrl -Method Post
    $ServerTimeResponse
}

#tradebalance
if ($TradeBalance.IsPresent) {
    $TradeBalanceParams = [ordered]@{ 
        "nonce" = $nonce
        "asset" = "USD" 
    }
    $signature = Set-APIKrakenSignature -Payload $TradeBalanceParams -URI $TradeBalanceMethod -api_secret $apiSecret
    
    # Build API request headers
    $TradeBalanceheaders = @{ 
        "API-Key"    = $apiKey
        "API-Sign"   = $signature 
        "User-Agent" = $useragent
    }
    $TradeBalanceResponse = Invoke-RestMethod -Uri $TradeBalanceurl -Method Post -Headers $TradeBalanceheaders -Body $TradeBalanceParams
    # -Body $TradeBalanceParams
    $TradeBalanceResponse
}

#accountbalance
if ($AccountBalance.IsPresent) {

    $AccountBalanceParam = [ordered]@{
        "nonce" = $nonce
    }

    $signature = Set-APIKrakenSignature -Payload $AccountBalanceParam -URI $AccountBalanceMethod -api_secret $apiSecret

    $AccountBalanceHeaders = @{ 
        "API-Key"    = $apiKey; 
        "API-Sign"   = $signature; 
        "User-Agent" = $useragent
    }
    $AccountBalanceResponse = Invoke-RestMethod -Uri $AccountBalanceUrl -Method Post -body $AccountBalanceParam -Headers $AccountBalanceHeaders
    $AccountBalanceResponse
}

#OHLC
if ($OHLC.IsPresent) {
    $since = [int][double]::Parse((Get-Date ((get-date).addminutes(-$OHLCSince)).touniversaltime() -UFormat %s))
    $OHLCurl = $endpoint + $OHLCMethod
    $OHLCparams = [ordered]@{ 
        "pair"     = "ETHUSD" 
        "interval" = $OHLCInterval
        "since"    = $since 
    }
    $OHLCHeaders = @{ 
        "User-Agent" = $useragent
    }

    <# Action to perform if the condition is true #>
    $OHLCresponse = Invoke-RestMethod -Uri $OHLCurl -Method Post -Body $OHLCparams -Headers $OHLCHeaders
    $OHLCresponse.Result

    <# 
1678642200: This is the timestamp for the first OHLC data in Unix time format.
1521.68: This is the open price for the first OHLC period.
1528.04: This is the high price for the first OHLC period.
1517.12: This is the low price for the first OHLC period.
1523.04: This is the close price for the first OHLC period.
1521.37: This is the volume-weighted average price for the first OHLC period.
542.99456062: This is the volume traded for the first OHLC period.
604: This is the number of trades that occurred during the first OHLC period.
#>
}
