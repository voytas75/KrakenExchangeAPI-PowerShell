function Disconnect-KrakenExchange {
    <#
    .NOTES
        Author: chatGPT
        Date: 04.2023
    #>
    [CmdletBinding()]
    param (    )

    try {
        [Environment]::SetEnvironmentVariable("KE_API_KEY", "", "User")
        [Environment]::SetEnvironmentVariable("KE_API_SECRET", "", "User")
        [Environment]::SetEnvironmentVariable("KE_WEBSOCKET_TOKEN", "", "User")
    }
    catch {
        write-error $_.Exception.Message<#Do this if a terminating exception happens#>
    }    
}
