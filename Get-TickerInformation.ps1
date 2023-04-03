function Get-TickerInformation {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Pair
    )
    
    $TickerInformationMethod = "/0/public/Ticker"
    $endpoint = "https://api.kraken.com"
    $UserAgent = "PowershellScript/1.0"
    $TickerInformationUrl = $endpoint + $TickerInformationMethod

    $TickerInformationParams = [ordered]@{ 
        "pair" = $Pair
    }
    
    $TickerInformationHeaders = @{ 
        "User-Agent" = $UserAgent
    }

    $TickerInformationResponse = Invoke-RestMethod -Uri $TickerInformationUrl -Method Get -Headers $TickerInformationHeaders -Body $TickerInformationParams
    
    return $TickerInformationResponse
}
