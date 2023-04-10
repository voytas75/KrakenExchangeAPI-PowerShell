function Get-KEOpenPositions {
    <#

    .LINK
    For more information, see the Kraken API documentation:
    https://docs.kraken.com/rest/#tag/User-Data/operation/getOpenPositions

    .NOTES
    The KrakenExchange PowerShell module is not affiliated with or endorsed by Kraken exchange.
    Author: wnapierala [@] hotmail.com, chatGPT
    Date: 04.2023
    #>    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string]$ApiKey = ([Environment]::GetEnvironmentVariable('KE_API_KEY', 'user')),

        [Parameter(Mandatory = $false)]
        [Alias("encodedAPISecret")]
        [string]$ApiSecret = ([Environment]::GetEnvironmentVariable('KE_API_SECRET', 'user')),

        [Parameter(Mandatory = $false)]
        [Alias("Transaction IDs", "Transaction ID")]
        [string]$txid,

        [bool]$docalcs = $false,

        [string]$consolidation = "market"
    )

    try {
        Write-Debug $MyInvocation.ScriptName
        Write-Debug "APIKey env.: $([Environment]::GetEnvironmentVariable('KE_API_KEY', "User"))"
        Write-Debug "APIKey arg.: ${ApiKey}"
        Write-Debug "APISecret env.: $([Environment]::GetEnvironmentVariable('KE_API_SECRET', "User"))"
        Write-Debug "APISecret arg.: ${ApiSecret}"
    
        # Check if ApiSecret is provided or needs to be retrieved
        if (-not $ApiSecret) {
            Disconnect-KExchange
            Connect-KExchange
            $ApiKey = ([Environment]::GetEnvironmentVariable('KE_API_KEY', "User"))
            $ApiSecretEncoded = $ApiSecret = ([Environment]::GetEnvironmentVariable('KE_API_SECRET', "User"))
        }
        else {
            $ApiSecretEncoded = $ApiSecret
        }
    
        # Define User-Agent header
        $UserAgent = "Powershell Module KrakenExchange/1.0"
    
        # Define API endpoint and version
        $endpoint = "https://api.kraken.com"
        $OpenPositionsMethod = "/0/private/OpenPositions"
        $OpenPositionsUrl = $endpoint + $OpenPositionsMethod
    
        # Generate nonce for API request
        $nonce = [Math]::Round((New-TimeSpan -Start "1/1/1970").TotalMilliseconds)
    
        # Define parameters for API request
        $OpenPositionsParam = [ordered]@{
            "nonce"         = $nonce
            "txid"          = $txid
            "docalcs"       = $docalcs
            "consolidation" = $consolidation
        }
    
        Write-Debug ($MyInvocation.ScriptName | Out-String)
        Write-Debug ($MyInvocation.mycommand | Out-String)
        Write-Debug ($MyInvocation.BoundParameters | Out-String)
        Write-Debug ($MyInvocation.InvocationName | Out-String)
        Write-Debug ($MyInvocation.PipelineLength | Out-String)
        Write-Debug ($MyInvocation.ScriptLineNumber | Out-String)
        Write-Debug "OpenPositionsParam: $($OpenPositionsParam | out-string)"
    
        # Generate signature for API request
        $signature = Set-KESignature -Payload $OpenPositionsParam -URI $OpenPositionsMethod -ApiSecret $ApiSecretEncoded
    
        # Define headers for API request
        $OpenPositionsHeaders = @{ 
            "API-Key"    = $apiKey; 
            "API-Sign"   = $signature; 
            "User-Agent" = $useragent
        }
    
        Write-Debug ($MyInvocation.ScriptName | Out-String)
        Write-Debug ($MyInvocation.mycommand | Out-String)
        Write-Debug ($MyInvocation.BoundParameters | Out-String)
        Write-Debug ($MyInvocation.InvocationName | Out-String)
        Write-Debug ($MyInvocation.PipelineLength | Out-String)
        Write-Debug ($MyInvocation.ScriptLineNumber | Out-String)
        Write-Debug "OpenPositionsHeaders: $($OpenPositionsHeaders | out-string)"

        # Send API request and retrieve response
        $OpenPositionsResponse = Invoke-RestMethod -Uri $OpenPositionsUrl -Method Post -body $OpenPositionsParam -Headers $OpenPositionsHeaders
    
        # Return the response
        return $OpenPositionsResponse
    }
    catch {

        return $_.exception.message
    
    }    
}
