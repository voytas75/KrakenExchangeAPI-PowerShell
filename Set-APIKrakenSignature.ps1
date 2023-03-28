function Set-APIKrakenSignature {

    param (
        [Parameter(Mandatory = $true)]
        [System.Collections.Specialized.OrderedDictionary]$Payload,

        [Parameter(Mandatory = $true)]
        [string]$URI,

        [Parameter(Mandatory = $true)]
        [string]$api_secret
    )

    #    write-verbose ($payload | out-string) -verbose

    $url_encoded_payload = ($payload.GetEnumerator() | ForEach-Object { $_.Name + "=" + $_.Value }) -join "&"

    #    write-verbose ($url_encoded_payload | out-string) -verbose

    <# 
Both [System.Security.Cryptography.HashAlgorithm]::Create('SHA256') and [System.Security.Cryptography.SHA256]::Create() create an instance of the SHA256 hashing algorithm provided by the .NET Framework's System.Security.Cryptography namespace. The difference between them is that the former creates an instance of the HashAlgorithm class and the latter creates an instance of the SHA256 class, which inherits from HashAlgorithm.
The HashAlgorithm class is an abstract base class that provides the basic functionality common to all hash algorithms. It defines the ComputeHash method, which computes the hash value for a given input, as well as other methods and properties that are common to all hash algorithms. When you create an instance of the SHA256 algorithm using [System.Security.Cryptography.HashAlgorithm]::Create('SHA256'), you are creating an instance of the SHA256Managed class, which is a concrete implementation of the SHA256 algorithm that inherits from HashAlgorithm.
On the other hand, when you create an instance of the SHA256 algorithm using [System.Security.Cryptography.SHA256]::Create(), you are creating an instance of the SHA256Cng class, which is a concrete implementation of the SHA256 algorithm that inherits directly from SHA256.
In general, it is recommended to use the specific algorithm class, such as SHA256, rather than the HashAlgorithm base class, as it provides a more strongly-typed interface and may have additional functionality specific to that algorithm. However, both methods should work fine for creating an instance of the SHA256 algorithm.
[System.Security.Cryptography.HMAC]::Create("HMACSHA512") - it works too
#>
    $sha = [System.Security.Cryptography.SHA256]::Create()

    $shahash = $sha.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($Payload["nonce"].ToString() + $url_encoded_payload))

    $shasum = $shahash

    $api_secret_bytes = [System.Convert]::FromBase64String($api_secret)

    $mac = New-Object System.Security.Cryptography.HMACSHA512
    $mac.Key = $api_secret_bytes
    $machash = $mac.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($URI) + $shasum)

    $macsum = $machash

    $signature = [System.Convert]::ToBase64String($macsum)

    return $signature
}
