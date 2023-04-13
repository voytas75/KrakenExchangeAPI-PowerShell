Function Get-KrakenOHLCData2 {
    <#
    .SYNOPSIS
    Retrieves OHLC data for a specified pair from KrakenExchange.
    
    .PARAMETER Pair
    The trading pair for which OHLC data is to be retrieved.
    
    .PARAMETER OHLCInterval
    The interval for the OHLC data, in seconds.
    
    .PARAMETER OHLCCount
    The number of OHLC data points to retrieve.
    
    .EXAMPLE
    PS C:\> Get-KrakenOHLCData2 -Pair "ETHUSD" -OHLCInterval 10080 -OHLCCount 100
    Retrieves OHLC data for the trading pair ETHUSD with an interval of 10080 seconds and 100 data points.
    
    .NOTES
    Author: wnapierala [@] hotmail.com, @voytas75, ChatGPT
    Date: 2023-04-13
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Pair,
    
        [Parameter()]
        [ValidateSet(1, 5, 15, 30, 60, 240, 1440, 10080)]
        [int]$OHLCInterval = 60,
    
        [Parameter()]
        [int]$OHLCCount = 24
    )
    
    $ohlcs = Get-KEOHLCData -pair $Pair -OHLCInterval $OHLCInterval -OHLCCount $OHLCCount
    
    if ($null -eq $ohlcs) {
        Write-Host "No OHLC data retrieved"
    }
    else {
        $data = foreach ($pair in $ohlcs.result.psobject.Properties) {
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
        }
    
        return $data
    }
}
    