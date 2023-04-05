#
# Module manifest for module 'KrakenExchange'
#
# Generated by: voytas
#
# Generated on: 04.04.2023
#

@{

    # Script module or binary module file associated with this manifest.
    RootModule        = 'KrakenExchange'

    # Version number of this module.
    ModuleVersion     = '1.0.1'

    # Supported PSEditions
    # CompatiblePSEditions = @()

    # ID used to uniquely identify this module
    GUID              = 'c30f4b2b-b5b6-4c4d-9257-b535b4a963ea'

    # Author of this module
    Author            = 'Wojciech Napierała (voytas75)'

    # Company or vendor of this module
    #CompanyName = 'NoCompany'

    # Copyright statement for this module
    Copyright         = '(c) 2023 voytas75. All rights reserved.'

    # Description of the functionality provided by this module
    Description       = 'A PowerShell module for working with Kraken Exchange'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion = '7.0'

    # Name of the Windows PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the Windows PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # DotNetFrameworkVersion = ''

    # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # CLRVersion = ''

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module
    # RequiredModules = @()

    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @()

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    # NestedModules = @()

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @(
        'Get-KEAccountBalance'
        'Set-KESignature'
        'Find-KEProfit'
        'Find-KEZeroProfitPrice'
        'Get-KEAssetInfo'
        'Get-KEProfitTable'
        'Get-KETicker'
        'Get-KETickerInformation'
        'Get-KETradableAssetPair'
        )

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport   = @()

    # Variables to export from this module
    VariablesToExport = '*'

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport   = @()

    # DSC resources to export from this module
    # DscResourcesToExport = @()

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    # FileList = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData       = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags       = @(
                "KrakenAPI", 
                "RESTAPI",
                "Cryptocurrency", 
                "PowerShell" , 
                "Trading", 
                "Exchange",
                "Automation",
                "Trading", 
                "Bots",
                "Trading", 
                "Strategies",
                "Investment",
                "FinancialData",
                "MarketAnalysis",
                "TradingSignals",
                "TechnicalAnalysis"
            )

            # A URL to the license for this module.
            # LicenseUri = ''

            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/voytas75/KrakenExchangeAPI-PowerShell'

            # A URL to an icon representing this module.
            IconUri = 'https://github.com/voytas75/KrakenExchangeAPI-PowerShell/blob/main/img/favicon_io/favicon-32x32.png'

            # ReleaseNotes of this module
            # ReleaseNotes = ''

        } # End of PSData hashtable

    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''

}

