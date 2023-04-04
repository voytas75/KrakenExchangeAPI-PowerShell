function Write-KEModuleLog {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$ModuleName,
        [Parameter(Mandatory = $true)]
        [string]$Message
    )

    # Get the path to the user's Documents folder
    $documentsFolder = [Environment]::GetFolderPath("MyDocuments")

    # Create a subfolder for the logs
    $logFolder = Join-Path -Path $documentsFolder -ChildPath "PowerShellLogs"

    if (-not (Test-Path -Path $logFolder -PathType Container)) {
        # Create the log folder if it doesn't exist
        New-Item -Path $logFolder -ItemType Directory | Out-Null
    }

    # Create a subfolder for the module logs
    $moduleLogFolder = Join-Path -Path $logFolder -ChildPath $ModuleName

    if (-not (Test-Path -Path $moduleLogFolder -PathType Container)) {
        # Create the module log folder if it doesn't exist
        New-Item -Path $moduleLogFolder -ItemType Directory | Out-Null
    }

    # Create the log file path
    $logFile = Join-Path -Path $moduleLogFolder -ChildPath "$ModuleName.log"

    # Write a message to the log file
    "$(Get-Date) - $Message" | Out-File -FilePath $logFile -Append
}
