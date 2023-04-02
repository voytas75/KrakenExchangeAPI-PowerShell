# KrakenExchangeAPI-PowerShell

This PowerShell scripts provides an easy way to interact with the Kraken Exchange API. It includes cmdlets for querying account information, getting ticker information for a specific currency pair, ...

## Installation

Download scripts.

## ApiKey and ApiSecret

To get a Kraken API Key and API Secret, you will need to follow these steps:

1. Create a Kraken account if you don't already have one. You can sign up at <https://www.kraken.com/signup>.

2. Log in to your Kraken account and click on the "Settings" tab in the top right corner.

3. Select the "API" option from the dropdown menu.

4. Click the "Generate New Key" button.

5. You will need to give your API key a name and select the permissions you want to grant to the key. Kraken provides a variety of permission options, such as trading, funding, and viewing account balances.

6. Once you have selected your permissions, click the "Generate Key" button.

7. After generating your key, you will see your API Key and API Secret displayed on the screen. Make sure to copy both the API Key and API Secret to a safe location, as the API Secret will only be displayed once.

Note that it is important to keep your API Secret secure and not share it with anyone. You will need both your API Key and API Secret to access your Kraken account via API.

## Usage

Here are some examples of how to use scripts. The most important is the REST API client for public and private environments:

```powershell
# Get trade volume using wrapper
$env:ApiKey = "<Api_Key>"
$env:ApiSecret = "<Api_Secret>"
$Result = (.\kraken.ps1 -ApiKey $env:apikey -ApiSecret $env:ApiSecret -TradeVolume).result 
$Result | Select-Object -ExpandProperty volume
```

Other examples:

```powershell
# Get ticker information for BTC/USD
.\Get-KrakenTicker.ps1 -Pair 'ETH/USD'

# Get signature
PS C:\> $payload = [System.Collections.Specialized.OrderedDictionary]::new()
PS C:\> $payload.Add("nonce", [Math]::Round((New-TimeSpan -Start "1/1/1970").TotalMilliseconds))
PS C:\> $payload.Add("ordertype", "limit")
PS C:\> $payload.Add("type", "buy")
PS C:\> $payload.Add("pair", "XXBTZUSD")
PS C:\> $payload.Add("price", "9000")
PS C:\> $payload.Add("volume", "0.01")
PS C:\> .\Set-APIKrakenSignature.ps1 -Payload $payload -URI "/0/private/AddOrder" -api_secret "KrakenAPIsecret"
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
