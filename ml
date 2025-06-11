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


Hope you're doing well. I was working on generating a JWT using a service account and got a bit stuck — the token I'm generating doesn't seem valid (it's coming out looking like binary or garbage output, e.g., starting with ..FngK...).

I've double-checked the signing and encoding steps, but still no luck. Just wanted to check if you're aware of any common issues around this, or if you've encountered something similar before?

Would really appreciate your input if you have a few minutes to spare.








# Read service account JSON
$jsonPath = "./android-firebase-uat.json"
Write-Host "🔍 Reading service account from: $jsonPath"
$creds = Get-Content $jsonPath | ConvertFrom-Json

# JWT Header and Claims
$jwtHeader = @{ alg = "RS256"; typ = "JWT" } | ConvertTo-Json -Compress
Write-Host "`n📦 JWT Header JSON:"
Write-Host $jwtHeader

$now = [int][double]::Parse((Get-Date -UFormat %s))
$exp = $now + 3600
$scope = "https://www.googleapis.com/auth/cloud-platform https://www.googleapis.com/auth/firebase"
$audience = "https://oauth2.googleapis.com/token"

$jwtClaimSet = @{
  iss   = $creds.client_email
  scope = $scope
  aud   = $audience
  exp   = $exp
  iat   = $now
} | ConvertTo-Json -Compress

Write-Host "`n📦 JWT Claims JSON:"
Write-Host $jwtClaimSet

# Base64 URL Encode function
function Base64UrlEncode([string]$input) {
  return [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($input)).TrimEnd('=').Replace('+', '-').Replace('/', '_')
}

# Encode header and claims
$headerEncoded = Base64UrlEncode $jwtHeader
$claimsEncoded = Base64UrlEncode $jwtClaimSet
$toSign = "$headerEncoded.$claimsEncoded"

Write-Host "`n🔐 Encoded Header:"
Write-Host $headerEncoded
Write-Host "`n🔐 Encoded Claims:"
Write-Host $claimsEncoded
Write-Host "`n🧩 Data to Sign (Header.Claims):"
Write-Host $toSign

# Decode the private key
$privateKeyPem = $creds.private_key -replace '-----.*?-----', '' -replace '\s+', ''
$privateKeyBytes = [Convert]::FromBase64String($privateKeyPem)

Write-Host "`n🔑 Decoded Private Key Bytes Length:"
Write-Host $privateKeyBytes.Length

# Sign the JWT
try {
  $rsa = [System.Security.Cryptography.RSA]::Create()
  [int]$bytesRead = 0
  $rsa.ImportPkcs8PrivateKey($privateKeyBytes, [ref]$bytesRead)
  Write-Host "`n✅ RSA Key Imported Successfully (Bytes Read: $bytesRead)"

  $dataToSign = [System.Text.Encoding]::UTF8.GetBytes($toSign)
  Write-Host "`n📏 Data to Sign (Byte Length): $($dataToSign.Length)"

  $signature = $rsa.SignData(
    $dataToSign,
    [System.Security.Cryptography.HashAlgorithmName]::SHA256,
    [System.Security.Cryptography.RSASignaturePadding]::Pkcs1
  )

  Write-Host "`n🖊️ Raw Signature Bytes Length: $($signature.Length)"

  $signatureEncoded = [Convert]::ToBase64String($signature).TrimEnd('=').Replace('+','-').Replace('/','_')
  Write-Host "`n🧾 Encoded Signature:"
  Write-Host $signatureEncoded

  $jwt = "$toSign.$signatureEncoded"
  Write-Host "`n✅ Final JWT (first 200 chars):"
  Write-Host $jwt.Substring(0, [Math]::Min(200, $jwt.Length)) "... (truncated)"

  # Optionally write to file
  $jwt | Set-Content -Path "./jwt.txt" -Encoding ascii
  Write-Host "`n📄 Full JWT written to jwt.txt"
} catch {
  Write-Error "❌ Failed to sign JWT: $_"
}



