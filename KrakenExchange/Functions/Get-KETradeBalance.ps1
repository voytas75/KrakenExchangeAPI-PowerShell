function Get-KETradeBalance {
    <#
    .SYNOPSIS
    Retrieves the trade balance for the specified Kraken exchange account.
    
    .DESCRIPTION
    The Get-KETradeBalance function retrieves the trade balance for the specified Kraken exchange account.
    
    .PARAMETER ApiKey
    The API key for the Kraken exchange account.
    
    .PARAMETER ApiSecret
    The encoded API secret for the Kraken exchange account.
    
    .NOTES
    The KrakenExchange PowerShell module is not affiliated with or endorsed by Kraken exchange.
    Author: wnapierala [@] hotmail.com, chatGPT
    Date: 04.2023
    
    .EXAMPLE
    PS C:\> Get-KETradeBalance -ApiKey "MY_API_KEY" -ApiSecret "encoded_MY_API_SECRET"
    Retrieves the trade balance for the Kraken exchange account associated with the specified API key and encoded secret.
    #>    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [string]$ApiKey = ([Environment]::GetEnvironmentVariable('KE_API_KEY', 'user')),

        [Parameter(Mandatory=$false)]
        [string]$ApiSecret = ([Environment]::GetEnvironmentVariable('KE_API_SECRET', 'user'))

    )

    # Check if ApiSecret is provided or needs to be retrieved
    if (-not $ApiSecret) {
        Connect-KExchange
    }
    else {
        $ApiSecretEncoded = $ApiSecret
    }

    # Define User-Agent header
    $UserAgent = "Powershell Module KrakenExchange/1.0"

    # Define API endpoint and version
    $endpoint = "https://api.kraken.com"
    $TradeBalanceMethod = "/0/private/TradeBalance"
    $TradeBalanceUrl = $endpoint + $TradeBalanceMethod

    # Generate nonce for API request
    $nonce = [Math]::Round((New-TimeSpan -Start "1/1/1970").TotalMilliseconds)

    # Define parameters for API request
    $TradeBalanceParam = [ordered]@{
        "nonce" = $nonce
    }

    # Generate signature for API request
    $signature = Set-KESignature -Payload $TradeBalanceParam -URI $TradeBalanceMethod -ApiSecret $ApiSecretEncoded

    # Define headers for API request
    $TradeBalanceHeaders = @{ 
        "API-Key"    = $apiKey; 
        "API-Sign"   = $signature; 
        "User-Agent" = $useragent
    }

    # Send API request and retrieve response
    $TradeBalanceResponse = Invoke-RestMethod -Uri $TradeBalanceUrl -Method Post -body $TradeBalanceParam -Headers $TradeBalanceHeaders
    
    # Return the response
    return $TradeBalanceResponse
}
