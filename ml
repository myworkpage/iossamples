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



🔍 Reading service account from: ./android-firebase-uat.json

📦 JWT Header JSON:
{"typ":"JWT","alg":"RS256"}

📦 JWT Claims JSON:
{"iss":"firebase-distributor@android-firebase-uat-e0faa.iam.gserviceaccount.com","aud":"https://oauth2.googleapis.com/token","exp":1749667582,"iat":1749663982,"scope":"https://www.googleapis.com/auth/cloud-platform https://www.googleapis.com/auth/firebase"}

🔐 Encoded Header:


🔐 Encoded Claims:


🧩 Data to Sign (Header.Claims):
.

🔑 Decoded Private Key Bytes Length:
1216

✅ RSA Key Imported Successfully (Bytes Read: 1216)

📏 Data to Sign (Byte Length): 1

🖊️ Raw Signature Bytes Length: 256

🧾 Encoded Signature:
NpPtgBpwJjY8_3we5lXMeDoEeezU_477Vd44WPP6sS3fW9GayGDWdwv-2vDrffXqQ0MHgZ3oGdNJ7FhaHj3jmzKAr6hovFLAwkFB7I8JeyvKhocy0Io4RMUVtL87yLfKi4xjor0QLrEFw2Ck8N7ay4ebBYoXV8iYQ8GpkORE2Swk89euIsHA6SLfR03RlBRB94Zl4ey_r6e7WCsZqGgXMCNkXW7D1cu9wYEYxjqvQ6d6PHfUKAkdn8I_245exauexyN_F_TScnovSPZm1vgqSJ81roqSLJVifcc8ttwg_wqgWPTsnCYi0D2URSzd9QmzC35NehOKK0q50QjuQwbPiw

✅ Final JWT (first 200 chars):
..NpPtgBpwJjY8_3we5lXMeDoEeezU_477Vd44WPP6sS3fW9GayGDWdwv-2vDrffXqQ0MHgZ3oGdNJ7FhaHj3jmzKAr6hovFLAwkFB7I8JeyvKhocy0Io4RMUVtL87yLfKi4xjor0QLrEFw2Ck8N7ay4ebBYoXV8iYQ8GpkORE2Swk89euIsHA6SLfR03RlBRB94Zl4e ... (truncated)

📄 Full JWT written to jwt.txt











U3lzdGVtLkNvbGxlY3Rpb25zLkFycmF5TGlzdCtBcnJheUxpc3RFbnVtZXJhdG9yU2ltcGxl.U3lzdGVtLkNvbGxlY3Rpb25zLkFycmF5TGlzdCtBcnJheUxpc3RFbnVtZXJhdG9yU2ltcGxl.JYGnLUHED6-Q6fb3FS0xUel8VexTY97O66tQcvAltnazJsH_cyakdczruoqsxVb0ZxRat_JItmHtgxEFm4Zsh2_J-iLcxOVleDT6vZB6qaFO7OC-IyZ6rttNLKgXz3iLHuvhKALD24Bl5RHkjR2GVD7rtHLbLJ6EOgZXkpuY1HyexnzASsdzz13jzIJ5GhB_xJoJx3zPg-hreuLTjxnxirSigU9qJBA_aiflzYxy4a3oYKLhhiQAgd6_GyvcL_Y-8sOcXsBJoPMO9dLcrgNo9gQjVzXLVwADMEC--wdoMkrFw4qh3TDlQmeBu-hXFBQAq3n27a91m_JQluucXyNnbg
