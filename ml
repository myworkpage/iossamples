$creds = Get-Content './android-firebase-uat.json' | ConvertFrom-Json

$header = @{ alg = 'RS256'; typ = 'JWT' } | ConvertTo-Json -Compress
$now = [int][double]::Parse((Get-Date -UFormat %s))
$exp = $now + 3600
$payload = @{
  iss = $creds.client_email
  scope = 'https://www.googleapis.com/auth/cloud-platform'
  aud = 'https://oauth2.googleapis.com/token'
  iat = $now
  exp = $exp
} | ConvertTo-Json -Compress

function Base64UrlEncode([string]$input) {
  [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($input)).TrimEnd('=').Replace('+','-').Replace('/','_')
}

$headerEncoded = Base64UrlEncode $header
$payloadEncoded = Base64UrlEncode $payload
$toSign = "$headerEncoded.$payloadEncoded"

# Key decode
$key = ($creds.private_key -join "`n") -replace '-----.*?-----', '' -replace '\s+', ''
$bytes = [Convert]::FromBase64String($key)

$rsa = [System.Security.Cryptography.RSA]::Create()
[int]$bytesRead = 0
$rsa.ImportPkcs8PrivateKey($bytes, [ref]$bytesRead)

# Sign
$signature = $rsa.SignData(
  [System.Text.Encoding]::UTF8.GetBytes($toSign),
  [System.Security.Cryptography.HashAlgorithmName]::SHA256,
  [System.Security.Cryptography.RSASignaturePadding]::Pkcs1
)

$signatureEncoded = [Convert]::ToBase64String($signature).TrimEnd('=').Replace('+','-').Replace('/','_')
$jwt = "$toSign.$signatureEncoded"

Write-Host "`n✅ JWT:"
Write-Host $jwt
