function New-KEDataFolder {
<#
.SYNOPSIS
    Function to create folders for module data, i.e. coins price history 
.NOTES
    The KrakenExchange PowerShell module is not affiliated with or endorsed by Kraken exchange.
    Author: wnapierala [@] hotmail.com, chatGPT
    Date: 04.2023
.LINK
    https://github.com/voytas75/KrakenExchangeAPI-PowerShell
.EXAMPLE
    n/a
#>
    [CmdletBinding()]
    param (
        
    )
    
    $localAppDataPath = ([Environment]::GetFolderPath([Environment+SpecialFolder]::LocalApplicationData))
    $RootFolderName = "KrakenExchange"
    $CryptocurrencyPricesName = "CryptocurrencyPrices"
    $LogsName = "Logs"
    $OtherName = "Other"
    New-Item -Path $localAppDataPath -Name $RootFolderName -ItemType Directory

    New-Item -Path "${localAppDataPath}\${RootFolderName}" -Name $CryptocurrencyPricesName -ItemType Directory
    
    New-Item -Path "${localAppDataPath}\${RootFolderName}" -Name $LogsName -ItemType Directory
    
    New-Item -Path "${localAppDataPath}\${RootFolderName}" -Name $OtherName -ItemType Directory

}