# Read service account JSON
$jsonPath = "./android-firebase-uat.json"
Write-Host "🔍 Reading service account from: $jsonPath"
$creds = Get-Content $jsonPath | ConvertFrom-Json

# JWT Header and Claims
$jwtHeaderRaw = (@{ alg = "RS256"; typ = "JWT" } | ConvertTo-Json -Compress)
Write-Host "`n📦 JWT Header JSON:"
Write-Host $jwtHeaderRaw

Write-Host "`n JWT Header FUll Name" 
Write-Host $jwtHeaderRaw.GetType().FullName

$now = [int][double]::Parse((Get-Date -UFormat %s))
$exp = $now + 3600
$scope = "https://www.googleapis.com/auth/cloud-platform https://www.googleapis.com/auth/firebase"
$audience = "https://oauth2.googleapis.com/token"

$jwtClaimSetRaw = (@{
  iss   = $creds.client_email
  scope = $scope
  aud   = $audience
  exp   = $exp
  iat   = $now
} | ConvertTo-Json -Compress)

Write-Host "`n📦 JWT Claims JSON:"
Write-Host $jwtClaimSetRaw

Write-Host "`n JWT Claims FUll Name" 
Write-Host $jwtClaimSetRaw.GetType().FullName

$jwtHeader = [string]$jwtHeaderRaw
$jwtClaimSet = [string]$jwtClaimSetRaw

Write-Host "`Forced JWT Header JSON:"
Write-Host $jwtHeader.GetType().FullName

Write-Host "`Forced JWT Claims JSON:"
Write-Host $jwtClaimSet.GetType().FullName

# Base64 URL Encode function
function Base64UrlEncode {
    param([string]$inputParam)
    Write-Host "`n🔎 Entered Base64UrlEncode()"
    Write-Host "🔎 Input value: $inputParam"
    Write-Host "🔎 Input type: $($inputParam.GetType().FullName)" 

    $utf8Bytes = [System.Text.Encoding]::UTF8.GetBytes($inputParam)
    return [Convert]::ToBase64String($utf8Bytes).TrimEnd('=').Replace('+', '-').Replace('/', '_')
}

# Encode header and claims
$headerEncoded = Base64UrlEncode -inputParam $jwtHeader
$claimsEncoded = Base64UrlEncode -inputParam $jwtClaimSet
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


Jwt:

eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3NDk2NzAwOTcsImV4cCI6MTc0OTY3MzY5NywiaXNzIjoiZmlyZWJhc2UtZGlzdHJpYnV0b3JAYW5kcm9pZC1maXJlYmFzZS11YXQtZTBmYWEuaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLCJhdWQiOiJodHRwczovL29hdXRoMi5nb29nbGVhcGlzLmNvbS90b2tlbiIsInNjb3BlIjoiaHR0cHM6Ly93d3cuZ29vZ2xlYXBpcy5jb20vYXV0aC9jbG91ZC1wbGF0Zm9ybSBodHRwczovL3d3dy5nb29nbGVhcGlzLmNvbS9hdXRoL2ZpcmViYXNlIn0.J9oIQtnbGz6XfhnDQQ2K6b1Cv4uNil9oQqBqjX6OdKXfZLbx8KwKaaqSo8Imz4qPRaow2wbjP54Ws5kBYw-N9J2JFH-Pt7SXCai6jzWFeFFqDv3-QKWyEbVwrjYouBSt0hbPYjunNLgLS2yPk9yJswBpRU5EH_39pEU150v0dalAxCBbyOXXXAt7geMnGhOObC25j-j4jbpXSuhX8rRYAG7Io6IdcyrDwUExfXwLOI9PNKGQtCggyvFjPv0-DRtNd_30K1Vz5aK9_xlv__lXiHBkonZDIuyjaaiJ3FSJq81q9TYUg4SXnGx3Q3bSbFIwPSeK2y0JZdGMUFiAHBiMQg
