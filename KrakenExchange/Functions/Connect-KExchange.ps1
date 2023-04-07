function Connect-KExchange {
    <#
    .SYNOPSIS
        Connects to the Kraken cryptocurrency exchange API and returns an API object that can be used to make public and private API requests.
    
    .DESCRIPTION
        Connects to the Kraken cryptocurrency exchange API and returns an API object that can be used to make public and private API requests.
    
    .PARAMETER ApiKey
        The API key for the Kraken account, as a string.
    
    .PARAMETER ApiSecret
        The API secret for the Kraken account, as a string.
    
    .PARAMETER GenerateWebsocketToken
        Whether to generate a websocket token using the Get-KEWebsocketsToken function and save it to the $env:KE_WEBSOCKET_TOKEN environment variable.
    
    .EXAMPLE
        PS C:\> $api = Connect-KrakenExchange -ApiKey "your_api_key" -ApiSecret "your_api_secret"
    
    .NOTES
        The KrakenExchange PowerShell module is not affiliated with or endorsed by Kraken exchange.
        Author: wnapierala [@] hotmail.com, chatGPT
        Date: 04.2023
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, HelpMessage = "The API key for the Kraken account, as a string.")]
        [string]$ApiKey,

        [Parameter(Mandatory = $false, HelpMessage = "Encoded API secret for the Kraken account, as a string.")]
        [string]$ApiSecret,

        [Parameter(Mandatory = $false, HelpMessage = "Whether to generate a websocket token using the Get-KEWebsocketsToken function and save it to the `$env:KE_WEBSOCKET_TOKEN environment variable.")]
        [bool]$GenerateWebsocketToken = $true
    )

    if (-not $ApiKey -or -not $ApiSecret) {
        $ApiKey = Read-Host "API Key"
        [securestring]$ApiSecret = Read-Host "API Secret" -AsSecureString 
        [string]$ApiSecretEncoded = $ApiSecret | ConvertFrom-SecureString
        [Environment]::SetEnvironmentVariable("KE_API_SECRET", $ApiSecretEncoded, "User")
    }
    else {
        $ApiSecretEncoded = $ApiSecret
        [Environment]::SetEnvironmentVariable("KE_API_SECRET", $ApiSecretEncoded, "User")
    }

    <#     $headers = @{
        'API-Key' = ([Environment]::GetEnvironmentVariable('KE_API_KEY', 'user'))
    }
 #>
    if ($GenerateWebsocketToken) {
        $token = Get-KEWebsocketsToken -ApiKey ([Environment]::GetEnvironmentVariable('KE_API_KEY', 'user')) -ApiSecret $ApiSecretEncoded
        [Environment]::SetEnvironmentVariable("KE_WEBSOCKET_TOKEN", $token.result.token, "User")
        #Write-Host "Websocket token generated and saved to environment variable KE_WEBSOCKET_TOKEN."
    }

    $API = @{
        #        BaseUri   = 'https://api.kraken.com/0/'
        ApiKey          = ([Environment]::GetEnvironmentVariable('KE_API_KEY', 'user'))
        ApiSecret       = ([Environment]::GetEnvironmentVariable('KE_API_SECRET', 'user'))
        #        Headers   = $headers
        WebsocketsToken = [Environment]::GetEnvironmentVariable("KE_WEBSOCKET_TOKEN", "User")
    }

    return $API
}
