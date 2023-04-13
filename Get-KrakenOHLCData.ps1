Function Get-KrakenOHLCData {
    <#
    .SYNOPSIS
    Retrieves OHLC data for a specified pair from KrakenExchange, processes it and exports the results to a CSV file.
    
    .PARAMETER Pair
    The trading pair for which OHLC data is to be retrieved.
    
    .PARAMETER OHLCInterval
    The interval for the OHLC data, in seconds.
    
    .PARAMETER OHLCCount
    The number of OHLC data points to retrieve.
    
    .EXAMPLE
    PS C:\> Get-KrakenOHLCData -Pair "ETHUSD" -OHLCInterval 10080 -OHLCCount 100
    Retrieves OHLC data for the trading pair ETHUSD with an interval of 10080 seconds and 100 data points.
    
    .NOTES
    Author: ChatGPT
    Date: 2023-04-13
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Pair,
        
        [Parameter(Mandatory = $true)]
        [int]$OHLCInterval,
        
        [Parameter(Mandatory = $true)]
        [int]$OHLCCount
    )

    $ohlcs = Get-KEOHLCData -pair $Pair -OHLCInterval $OHLCInterval -OHLCCount $OHLCCount

    if ($ohlcs -eq $null) {
        Write-Host "No OHLC data retrieved"
    }
    else {
        $csvPath = "$($env:USERPROFILE)\Documents\kraken_ohlc_${Pair}_${OHLCInterval}_${OHLCCount}.csv"
        Write-Host "Exporting data to $csvPath"
        ($data = foreach ($pair in $ohlcs.result.psobject.Properties) {
            $pairName = $pair.Name
            Write-Host "Processing $pairName"
            $pairData = $pair.Value

            foreach ($datapoint in $pairData) {
                $time = $datapoint[0]
                $date = [DateTimeOffset]::FromUnixTimeSeconds($time).UtcDateTime.ToString("yyyy-MM-dd HH:mm:ss")
                $open = $datapoint[1]
                $high = $datapoint[2]
                $low = $datapoint[3]
                $close = $datapoint[4]

                [pscustomobject]@{
                    Pair  = $pairName
                    Date  = $date
                    Open  = $open
                    High  = $high
                    Low   = $low
                    Close = $close
                }
            }
        }) | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
        return $csvPath
    }
}
