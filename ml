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









- task: PowerShell@2
  displayName: "Distribute AAB via Firebase App Distribution"
  inputs:
    targetType: 'inline'
    pwsh: true
    script: |
      $serviceAccountJsonPath = "$(Build.SourcesDirectory)/android-firebase-uat.json"
      $aabFilePath = "$(Build.ArtifactStagingDirectory)/UAT/com.bcbsla.mobile.droid-Signed.aab"
      $firebaseAppId = "FIREBASE_APP_ID_HERE"  # Replace with your Firebase App ID

      $serviceAccount = Get-Content -Raw -Path $serviceAccountJsonPath | ConvertFrom-Json
      $privateKey = $serviceAccount.private_key
      $clientEmail = $serviceAccount.client_email
      $projectId = $serviceAccount.project_id

      $now = [int][double]::Parse((Get-Date -UFormat %s))
      $exp = $now + 3600

      $jwtHeader = @{
        alg = "RS256"
        typ = "JWT"
      } | ConvertTo-Json -Compress

      $jwtClaims = @{
        iss = $clientEmail
        scope = "https://www.googleapis.com/auth/cloud-platform https://www.googleapis.com/auth/firebase"
        aud = "https://oauth2.googleapis.com/token"
        iat = $now
        exp = $exp
      } | ConvertTo-Json -Compress

      function Base64UrlEncode {
        param([byte[]]$bytes)
        return [Convert]::ToBase64String($bytes).Replace('+', '-').Replace('/', '_').TrimEnd('=')
      }

      $jwtHeaderEncoded = Base64UrlEncode -bytes ([System.Text.Encoding]::UTF8.GetBytes($jwtHeader))
      $jwtClaimsEncoded = Base64UrlEncode -bytes ([System.Text.Encoding]::UTF8.GetBytes($jwtClaims))
      $jwtToSign = "$jwtHeaderEncoded.$jwtClaimsEncoded"

      $privateKeyPem = $privateKey -replace '-----.*?-----', '' -replace '\s+', ''
      $privateKeyBytes = [Convert]::FromBase64String($privateKeyPem)
      $signer = [System.Security.Cryptography.RSA]::Create()
      $signer.ImportPkcs8PrivateKey([ref]$privateKeyBytes, [ref]0)
      $signatureBytes = $signer.SignData([System.Text.Encoding]::UTF8.GetBytes($jwtToSign), [System.Security.Cryptography.HashAlgorithmName]::SHA256, [System.Security.Cryptography.RSASignaturePadding]::Pkcs1)
      $jwtSigned = "$jwtToSign." + (Base64UrlEncode -bytes $signatureBytes)

      $response = Invoke-RestMethod -Method Post -Uri "https://oauth2.googleapis.com/token" -ContentType "application/x-www-form-urlencoded" -Body @{
        grant_type = "urn:ietf:params:oauth:grant-type:jwt-bearer"
        assertion = $jwtSigned
      }

      $accessToken = $response.access_token
      Write-Host "✅ Access token acquired."

      $aabBytes = Get-Content -Encoding Byte -Path $aabFilePath
      $boundary = [System.Guid]::NewGuid().ToString()
      $LF = "`r`n"

      $preamble = (
        "--$boundary$LF" +
        "Content-Disposition: form-data; name=`"file`"; filename=`"app.aab`"$LF" +
        "Content-Type: application/octet-stream$LF$LF"
      )
      $preambleBytes = [System.Text.Encoding]::UTF8.GetBytes($preamble)
      $closing = "$LF--$boundary--$LF"
      $closingBytes = [System.Text.Encoding]::UTF8.GetBytes($closing)

      $memoryStream = New-Object System.IO.MemoryStream
      $memoryStream.Write($preambleBytes, 0, $preambleBytes.Length)
      $memoryStream.Write($aabBytes, 0, $aabBytes.Length)
      $memoryStream.Write($closingBytes, 0, $closingBytes.Length)
      $memoryStream.Seek(0, 'Begin') | Out-Null

      $headers = @{
        "Authorization" = "Bearer $accessToken"
        "Content-Type"  = "multipart/form-data; boundary=$boundary"
      }

      $uploadUri = "https://firebaseappdistribution.googleapis.com/upload/v1/projects/$projectId/apps/$firebaseAppId/releases:upload"
      Write-Host "📤 Uploading AAB to Firebase App Distribution..."
      $response = Invoke-RestMethod -Uri $uploadUri -Method POST -Headers $headers -Body $memoryStream

      Write-Host "✅ Upload successful!"
      $response | ConvertTo-Json -Depth 10



2025-06-11T20:29:16.5174679Z ##[section]Starting: Distribute AAB via Firebase App Distribution
2025-06-11T20:29:16.5193237Z ==============================================================================
2025-06-11T20:29:16.5193423Z Task         : PowerShell
2025-06-11T20:29:16.5193495Z Description  : Run a PowerShell script on Linux, macOS, or Windows
2025-06-11T20:29:16.5193598Z Version      : 2.247.1
2025-06-11T20:29:16.5193682Z Author       : Microsoft Corporation
2025-06-11T20:29:16.5193762Z Help         : https://docs.microsoft.com/azure/devops/pipelines/tasks/utility/powershell
2025-06-11T20:29:16.5193889Z ==============================================================================
2025-06-11T20:29:18.5192532Z Generating script.
2025-06-11T20:29:18.6232056Z ========================== Starting Command Output ===========================
2025-06-11T20:29:18.6582767Z ##[command]"C:\Program Files\PowerShell\7\pwsh.exe" -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Unrestricted -Command ". 'D:\a\_temp\d974dded-ac24-4a89-9cfb-620e4777f6e3.ps1'"
2025-06-11T20:29:20.9558643Z [31;1mGet-Content : [31;1mCannot find path 'D:\a\1\s\android-firebase-uat.json' because it does not exist.[0m
2025-06-11T20:29:20.9559628Z [31;1m[31;1mAt D:\a\_temp\d974dded-ac24-4a89-9cfb-620e4777f6e3.ps1:8 char:19[0m
2025-06-11T20:29:20.9560141Z [31;1m[31;1m+ … rviceAccount = Get-Content -Raw -Path $serviceAccountJsonPath | Conve …[0m
2025-06-11T20:29:20.9560532Z [31;1m[31;1m+                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~[0m
2025-06-11T20:29:20.9561032Z [31;1m[31;1m+ CategoryInfo          : ObjectNotFound: (D:\a\1\s\android-firebase-uat.json:String) [Get-Content], ItemNotFoundException[0m
2025-06-11T20:29:20.9561508Z [31;1m[31;1m+ FullyQualifiedErrorId : PathNotFound,Microsoft.PowerShell.Commands.GetContentCommand[0m
2025-06-11T20:29:21.0677767Z ##[error]PowerShell exited with code '1'.
2025-06-11T20:29:21.1280687Z ##[section]Finishing: Distribute AAB via Firebase App Distribution








- task: DownloadSecureFile@1
  name: downloadFirebaseJson
  displayName: 'Download Firebase Service Account JSON'
  inputs:
    secureFile: 'android-firebase-uat.json'

- powershell: |
    $ErrorActionPreference = 'Stop'

    # 🔐 Inputs
    $serviceAccountJson = "$(downloadFirebaseJson.secureFilePath)"
    $aabFilePath = "$(Build.ArtifactStagingDirectory)/UAT/com.bcbsla.mobile.droid-Signed.aab"
    $firebaseAppId = "1:1076824969090:android:52c3d66c9ea0e4afc1c99b"
    $distributionGroup = "uat-testers"
    $releaseNotes = "Automated UAT build"

    if (-Not (Test-Path $aabFilePath)) {
      Write-Error "❌ AAB not found at $aabFilePath"
      exit 1
    }

    Write-Host "🔐 Getting access token..."

    # Install required assemblies
    Install-PackageProvider -Name NuGet -Force -Scope CurrentUser
    Install-Module -Name Google.Apis.Auth -Force -Scope CurrentUser -AllowClobber

    Add-Type -TypeDefinition @"
    using System;
    using Google.Apis.Auth.OAuth2;
    using System.Threading.Tasks;

    public class TokenHelper {
      public static string GetAccessToken(string jsonPath) {
        GoogleCredential cred = GoogleCredential.FromFile(jsonPath)
          .CreateScoped(new[] {
            "https://www.googleapis.com/auth/cloud-platform",
            "https://www.googleapis.com/auth/firebase"
          });
        var tokenTask = cred.UnderlyingCredential.GetAccessTokenForRequestAsync();
        tokenTask.Wait();
        return tokenTask.Result;
      }
    }
    "@ -ReferencedAssemblies "Google.Apis.Auth.dll"

    $accessToken = [TokenHelper]::GetAccessToken($serviceAccountJson)
    Write-Host "✅ Access token acquired."

    Write-Host "📤 Uploading AAB to Firebase App Distribution..."

    $headers = @{
      "Authorization" = "Bearer $accessToken"
      "X-Goog-Upload-Protocol" = "raw"
      "X-Goog-Upload-File-Name" = [System.IO.Path]::GetFileName($aabFilePath)
      "X-Goog-Upload-Command" = "upload, finalize"
      "X-Goog-Upload-Header-Content-Length" = (Get-Item $aabFilePath).Length
    }

    $uploadUrl = "https://firebaseappdistribution.googleapis.com/upload/v1/apps/$firebaseAppId/releases:upload"

    $response = Invoke-RestMethod -Uri $uploadUrl `
                                  -Method POST `
                                  -Headers $headers `
                                  -InFile $aabFilePath `
                                  -ContentType "application/octet-stream"

    $releaseId = $response.name.Split("/")[-1]
    Write-Host "✅ AAB uploaded. Release ID: $releaseId"

    # 📨 Add testers/group
    $distributeUrl = "https://firebaseappdistribution.googleapis.com/v1/apps/$firebaseAppId/releases/$releaseId:distribute"

    $body = @{
      testerEmails = @()  # optional
      groupAliases = @($distributionGroup)
    } | ConvertTo-Json -Depth 3

    Invoke-RestMethod -Uri $distributeUrl `
                      -Method POST `
                      -Headers @{ Authorization = "Bearer $accessToken" } `
                      -ContentType "application/json" `
                      -Body $body

    Write-Host "✅ Release distributed to group '$distributionGroup'."
  displayName: 'Distribute .aab to Firebase (REST API)'



  =================================================================================================================================


      - task: PowerShell@2
      displayName: 'Upload .aab to Firebase App Distribution (via REST API)'
      inputs:
        targetType: inline
        script: |
          $ErrorActionPreference = "Stop"

          $serviceAccountJsonPath = "$(downloadFirebaseJson.secureFilePath)"
          $aabFilePath = "$(Build.ArtifactStagingDirectory)/UAT/com.bcbsla.mobile.droid-Signed.aab"
          $appId = "1:1076824969090:android:52c3d66c9ea0e4afc1c99b"
          $distributionGroup = "uat-testers"

          if (-Not (Test-Path $aabFilePath)) {
            Write-Error "❌ AAB file not found at path: $aabFilePath"
            exit 1
          }

          Write-Host "✅ Found AAB at $aabFilePath"

          if (-not (Get-Module -ListAvailable -Name Google.Apis.Auth)) {
            Install-PackageProvider -Name NuGet -Force -Scope CurrentUser
            Install-Module -Name 'Google.Apis.Auth' -Force -Scope CurrentUser
          }

          Add-Type -TypeDefinition @"
          using System;
          using Google.Apis.Auth.OAuth2;
          using System.Threading.Tasks;

          public class TokenHelper {
              public static string GetAccessToken(string jsonPath) {
                  var credential = GoogleCredential.FromFile(jsonPath)
                      .CreateScoped(new[] {
                          "https://www.googleapis.com/auth/cloud-platform",
                          "https://www.googleapis.com/auth/firebase"
                      });

                  var tokenTask = credential.UnderlyingCredential.GetAccessTokenForRequestAsync();
                  tokenTask.Wait();
                  return tokenTask.Result;
              }
          }
"@ -ReferencedAssemblies "Google.Apis.Auth.dll"

          $accessToken = [TokenHelper]::GetAccessToken($serviceAccountJsonPath)
          Write-Host "✅ Access token acquired."

          $headers = @{
            "Authorization" = "Bearer $accessToken"
            "X-Goog-Upload-Protocol" = "raw"
            "X-Goog-Upload-File-Name" = [System.IO.Path]::GetFileName($aabFilePath)
            "X-Goog-Upload-Command" = "upload, finalize"
            "X-Goog-Upload-Header-Content-Length" = (Get-Item $aabFilePath).Length
          }

          $uploadUrl = "https://firebaseappdistribution.googleapis.com/upload/v1/apps/$appId/releases:upload"
          Write-Host "📤 Uploading AAB..."

          $response = Invoke-RestMethod -Uri $uploadUrl `
            -Method POST `
            -Headers $headers `
            -InFile $aabFilePath `
            -ContentType "application/octet-stream"

          Write-Host "✅ AAB uploaded. Release ID: $($response.name)"

          $distributionUrl = "https://firebaseappdistribution.googleapis.com/v1/$($response.name):distribute"
          $distributionBody = @{
            testerEmails = @()
            groupAliases = @($distributionGroup)
          } | ConvertTo-Json -Depth 5

          Invoke-RestMethod -Uri $distributionUrl `
            -Method POST `
            -Headers @{ "Authorization" = "Bearer $accessToken" } `
            -Body $distributionBody `
            -ContentType "application/json"

          Write-Host "🚀 AAB distributed to group: $distributionGroup"







2025-06-12T19:22:03.4948268Z ##[section]Starting: Upload .aab to Firebase App Distribution (via REST API)
2025-06-12T19:22:03.4966664Z ==============================================================================
2025-06-12T19:22:03.4966836Z Task         : PowerShell
2025-06-12T19:22:03.4966907Z Description  : Run a PowerShell script on Linux, macOS, or Windows
2025-06-12T19:22:03.4967184Z Version      : 2.247.1
2025-06-12T19:22:03.4967255Z Author       : Microsoft Corporation
2025-06-12T19:22:03.4967341Z Help         : https://docs.microsoft.com/azure/devops/pipelines/tasks/utility/powershell
2025-06-12T19:22:03.4967450Z ==============================================================================
2025-06-12T19:22:05.1533934Z Generating script.
2025-06-12T19:22:05.2522357Z ========================== Starting Command Output ===========================
2025-06-12T19:22:05.2812599Z ##[command]"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Unrestricted -Command ". 'D:\a\_temp\bed5adb9-2435-46ce-942d-815e6b021e3f.ps1'"
2025-06-12T19:22:05.6670404Z At D:\a\_temp\bed5adb9-2435-46ce-942d-815e6b021e3f.ps1:80 char:35
2025-06-12T19:22:05.6671797Z +                                   ~~~~~~~~~~~~~~
2025-06-12T19:22:05.6672334Z Variable reference is not valid. ':' was not followed by a valid variable name character. Consider using ${} to 
2025-06-12T19:22:05.6672811Z delimit the name.
2025-06-12T19:22:05.6673145Z At D:\a\_temp\bed5adb9-2435-46ce-942d-815e6b021e3f.ps1:23 char:26
2025-06-12T19:22:05.6673482Z + Add-Type -TypeDefinition @"
2025-06-12T19:22:05.6673764Z +                          ~~
2025-06-12T19:22:05.6674061Z The string is missing the terminator: "@.
2025-06-12T19:22:05.6675666Z     + CategoryInfo          : ParserError: (:) [], ParseException
2025-06-12T19:22:05.6675945Z     + FullyQualifiedErrorId : InvalidVariableReferenceWithDrive
2025-06-12T19:22:05.6676412Z  
2025-06-12T19:22:05.7584915Z ##[error]PowerShell exited with code '1'.
2025-06-12T19:22:05.8065233Z ##[section]Finishing: Upload .aab to Firebase App Distribution (via REST API)







Add-Type -TypeDefinition @"
using System;
using System.Threading;
using System.Threading.Tasks;
using Google.Apis.Auth.OAuth2;

public class TokenHelper {
    public static string GetAccessToken(string jsonPath) {
        GoogleCredential credential = GoogleCredential.FromFile(jsonPath)
            .CreateScoped("https://www.googleapis.com/auth/cloud-platform", "https://www.googleapis.com/auth/firebase");
        var tokenTask = credential.UnderlyingCredential.GetAccessTokenForRequestAsync();
        tokenTask.Wait();
        return tokenTask.Result;
    }
}
"@ -ReferencedAssemblies "Google.Apis.Auth.dll"

