function Get-KEAccountBalance {
    <#
    .SYNOPSIS
    Get the account balance from Kraken API.
    
    .DESCRIPTION
    This function retrieves the account balance from Kraken API using the provided API key and API secret. It generates a nonce for authentication, sets the necessary headers, and makes a POST request to the Kraken API to fetch the account balance.
    
    .PARAMETER ApiKey
    The API key for authentication with Kraken API. 
    
    .PARAMETER ApiSecret
    The API secret for authentication with Kraken API.
    
    .EXAMPLE
    Get-KEAccountBalance -ApiKey "YourApiKey"
    
    Retrieves the account balance from Kraken API using the provided API key and API secret.
    #>
    
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$ApiKey = ([Environment]::GetEnvironmentVariable('KE_API_KEY','user')),

        [Parameter()]
        [string]$ApiSecret = ([Environment]::GetEnvironmentVariable('KE_API_SECRET','user'))

    )
    
    if (-not $ApiSecret) {
        $ApiSecret = Read-Host "Enter API Secret" -AsSecureString
        $ApiSecretEncoded = $ApiSecret | ConvertFrom-SecureString
        [Environment]::SetEnvironmentVariable("KE_API_SECRET", $ApiSecretEncoded, "User")
    }
    else {
        [Environment]::SetEnvironmentVariable("KE_API_SECRET", $ApiSecret, "User")
        $ApiSecretEncoded = ([Environment]::GetEnvironmentVariable('KE_API_SECRET', 'user'))
    }
    
        # Convert SecureString to plain text string
        $ApiSecret = Convertto-SecureString -String $env:apisecret | ConvertFrom-SecureString -AsPlainText
        $ApiSecretPtr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($ApiSecret)
        $ApiSecret = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($ApiSecretPtr)

    #useragent
    $UserAgent = "Powershell Module KrakenExchange/1.0"
    # Set API endpoint and version
    $endpoint = "https://api.kraken.com"
    $AccountBalanceMethod = "/0/private/Balance"
    $AccountBalanceUrl = $endpoint + $AccountBalanceMethod

    # Generate nonce
    $nonce = [Math]::Round((New-TimeSpan -Start "1/1/1970").TotalMilliseconds)
    # what is nonce: https://support.kraken.com/hc/en-us/articles/360000906023-What-is-a-nonce-

    $AccountBalanceParam = [ordered]@{
        "nonce" = $nonce
    }

    $signature = Set-KESignature -Payload $AccountBalanceParam -URI $AccountBalanceMethod -api_secret $ApiSecretEncoded

    $AccountBalanceHeaders = @{ 
        "API-Key"    = $apiKey; 
        "API-Sign"   = $signature; 
        "User-Agent" = $useragent
    }
    $AccountBalanceResponse = Invoke-RestMethod -Uri $AccountBalanceUrl -Method Post -body $AccountBalanceParam -Headers $AccountBalanceHeaders
    return $AccountBalanceResponse
}    
        
 