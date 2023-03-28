# KrakenExchangeAPI-PowerShell

This PowerShell scripts provides an easy way to interact with the Kraken Exchange API. It includes cmdlets for querying account information, getting ticker information for a specific currency pair, ...

## Installation

Download scripts.

## Usage

Here are some examples of how to use scripts:

```powershell
# Get ticker information for BTC/USD
.\Get-KrakenTicker.ps1 -Pair 'ETH/USD'

# Get signature
PS C:\> $payload = [System.Collections.Specialized.OrderedDictionary]::new()
PS C:\> $payload.Add("nonce", [int64]([DateTime]::UtcNow - (New-Object DateTime 1970, 1, 1, 0, 0, 0, 0, ([DateTimeKind]::Utc))).TotalMilliseconds
PS C:\> $payload.Add("ordertype", "limit")
PS C:\> $payload.Add("type", "buy")
PS C:\> $payload.Add("pair", "XXBTZUSD")
PS C:\> $payload.Add("price", "9000")
PS C:\> $payload.Add("volume", "0.01")
PS C:\> .\Set-APIKrakenSignature.ps1 -Payload $payload -URI "/0/private/AddOrder" -api_secret "KrakenAPIsecret"

# Get trade volume using wrapper
(.\kraken.ps1 -ApiKey $env:apikey -ApiSecret $env:ApiSecret -TradeVolume).result | select -ExpandProperty volume
```

## Contributing

Contributions to this project are welcome and encouraged! If you notice a bug, have an idea for a new feature, or would like to contribute code, please open a GitHub issue or pull request.

Before contributing, please review our [contribution guidelines](CONTRIBUTING.md) for instructions on how to get started.

## License

This project is licensed under the terms of the [GNU General Public License (GPL) version 3](LICENSE).

The GPL is a copyleft license, which means that any derivative works must be distributed under the same terms. This ensures that the code remains free and open source.

For more information about the GPL, please see the [official GNU website](https://www.gnu.org/licenses/gpl-3.0.en.html).

## Contact

If you have any questions or comments about this project, please feel free to [contact us](mailto:wnapierala@hotmail.com). We would be happy to hear from you!
