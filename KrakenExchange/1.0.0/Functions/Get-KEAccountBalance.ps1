function Get-KEAccountBalance {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ApiKey,

        [Parameter(Mandatory = $true)]
        [string]$ApiSecret

    )
    
    #useragent
    $useragent = "myuseragent/1.0"
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

    $signature = Set-KESignature -Payload $AccountBalanceParam -URI $AccountBalanceMethod -api_secret $apiSecret

    $AccountBalanceHeaders = @{ 
        "API-Key"    = $apiKey; 
        "API-Sign"   = $signature; 
        "User-Agent" = $useragent
    }
    $AccountBalanceResponse = Invoke-RestMethod -Uri $AccountBalanceUrl -Method Post -body $AccountBalanceParam -Headers $AccountBalanceHeaders
    return $AccountBalanceResponse
}    
        
 