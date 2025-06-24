System.IO.DirectoryNotFoundException: Could not find a part of the path 'C:\Users\c71383\.nuget\packages\adame.google.ios.googledatatransport\10.1.0\lib\net6.0-ios16.1\Google.GoogleDataTransport.resources\GoogleDataTransport.xcframework\ios-arm64\GoogleDataTransport.framework\GoogleDataTransport_Privacy.bundle\PrivacyInfo.xcprivacy'.
   at System.IO.__Error.WinIOError(Int32 errorCode, String maybeFullPath)
   at System.IO.FileStream.Init(String path, FileMode mode, FileAccess access, Int32 rights, Boolean useRights, FileShare share, Int32 bufferSize, FileOptions options, SECURITY_ATTRIBUTES secAttrs, String msgPath, Boolean bFromProxy, Boolean useLongPath, Boolean checkHost)
   at System.IO.FileStream..ctor(String path, FileMode mode, FileAccess access, FileShare share, Int32 bufferSize)
   at System.IO.File.Create(String path)
   at NuGet.Packaging.StreamExtensions.Testable.MmapCopy(Stream inputStream, String fileFullPath, Int64 size)
   at NuGet.Packaging.StreamExtensions.Testable.CopyToFile(Stream inputStream, String fileFullPath)
   at NuGet.Packaging.PackageFileExtractor.ExtractPackageFile(String source, String target, Stream stream)
   at NuGet.Packaging.PackageArchiveReader.CopyFiles(String destination, IEnumerable`1 packageFiles, ExtractPackageFileDelegate extractFile, ILogger logger, CancellationToken token)
   at NuGet.Packaging.PackageReaderBase.CopyFilesAsync(String destination, IEnumerable`1 packageFiles, ExtractPackageFileDelegate extractFile, ILogger logger, CancellationToken cancellationToken)
   at NuGet.Packaging.PackageExtractor.<>c__DisplayClass5_0.<<InstallFromSourceAsync>b__0>d.MoveNext()


advise them that we have done extensive testing and troubleshooting and we are not having the app crash as reported.  I am testing on ios 18.4.1,

Guideline 2.1 - Performance - App Completeness

We were unable to review the app because it crashed on launch. We have attached detailed crash logs to help troubleshoot this issue.


Review device details:


- Device type: iPad Air 11-inch (M2)

- OS version: iPadOS 18.4.1


Thank you for your feedback.

We have conducted extensive testing and troubleshooting on our end, specifically using devices running iPadOS 18.4.1. During our testing, we were unable to reproduce the crash that was reported. The app launches and functions as expected across all test scenarios.

To assist with further investigation, we would appreciate any additional context or reproduction steps that might help us identify the issue more accurately.

Please let us know if there’s anything specific we can do to help move the review process forward.

Thank you for your time and support.







---------------1//0gONB_M2epRwtCgYIARAAGBASNwF-L9IrOTWEBZXwMDg1vDdp77334TGNcbBwG3FH03jz1SHtz6gpXaNku_81tg1I4T2VQOz1Xqs-------------------

---------------1//0gNB_EEPeg1KDCgYIARAAGBASNwF-L9IrOzWPD7N00w8Bzmye-1VeeY-4dDEVuzCxyEIzYCEChPiDCIeJdZH0xP5LlHGx2F-UP2U-------------------




          Fatal Exception: android.runtime.JavaProxyThrowable: [System.NullReferenceException]: Object reference not set to an instance of an object
       at Bcbsla.Mobile.App.Droid.Views.Providers.ProviderSearchResultsView+<OnCreate>d__23.MoveNext + 0x406()
       at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw + 0x11()
       at System.Threading.Tasks.Task+<>c.<ThrowAsync>b__128_0 + 0x0()
       at Android.App.SyncContext+<>c__DisplayClass2_0.<Post>b__0 + 0x0()
       at Java.Lang.Thread+RunnableImplementor.Run + 0x8()
       at Java.Lang.IRunnableInvoker.n_Run + 0x8()
       at Android.Runtime.JNINativeWrapper.Wrap_JniMarshal_PP_V + 0x5()
       at mono.java.lang.RunnableImplementor.n_run(RunnableImplementor.java)
       at mono.java.lang.RunnableImplementor.run(RunnableImplementor.java:29)
       at android.os.Handler.handleCallback(Handler.java:958)
       at android.os.Handler.dispatchMessage(Handler.java:99)
       at android.os.Looper.loopOnce(Looper.java:230)
       at android.os.Looper.loop(Looper.java:319)
       at android.app.ActivityThread.main(ActivityThread.java:8919)
       at java.lang.reflect.Method.invoke(Method.java)
       at com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:578)
       at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:1103)


        - task: NodeTool@0
      inputs:
        versionSpec: '16.x'
      displayName: 'Install Node.js'

    - script: |
        npm install -g firebase-tools
      displayName: 'Install Firebase CLI'

    - script: |
        firebase appdistribution:distribute "$(Build.ArtifactStagingDirectory)/UAT/*-Signed.aab" \
        --app $(FirebaseUatAppId) \
        --token $(FirebaseToken) \
        --groups testers
      displayName: 'Distribute AAB to Firebase UAT'






      In order to transition to Epic/MyChart Platform (or have test apps in each store)
As a mobile developer
I need to create a "test" app in the Google Play Store

Assumptions:
Develop an app to be placed in the Google Play Store
Do NOT publish the the app so that we can continue to update the legacy app
The app will be used as a test app for Epic/MyChart mobile app
Name the testing app in alignment for internal, employee only testing
Deprecate the app when MyChart Mobile App is launched
Work with Ryan Kling and George Race from Epic





1. Platform/Framework Choice
Is the new test application expected to be developed using .NET MAUI, or should it be built natively for Android (and separately for iOS)?

2. Purpose and Scope of Integration
Is the intent to fully replace our existing app with a new one built on top of Epic’s MyChart platform, or are we simply integrating MyChart functionalities into the existing app?

3. Testing Strategy and App Lifecycle
How long is the test app expected to be in use before it is deprecated? Is it purely internal (for employee testing), or will it also support limited external test users?

4. Publishing and Deployment
Although the app will not be published publicly, should it be uploaded to the Play Store under a closed/internal track for internal distribution and testing?

5. App Naming and Branding
Do we have a specific naming convention or internal branding guidelines for the test app to differentiate it from the production app?

6. Account and Console Setup
Should this test app be created under our existing Google Play Console account or a separate internal/testing account?


'$Token' is not recognized as an internal or external command,
operable program or batch file.
'Write-Host' is not recognized as an internal or external command,
operable program or batch file.



 - script: |
          echo Setting Firebase App ID and Firebase_Token...
          set AppId=1234
          set Token=xxxx

          echo Checking for .aab file...
          dir "%Build.ArtifactStagingDirectory%\UAT"

          echo Distributing aab to Firebase...
          firebase appdistribution:distribute "$(Build.ArtifactStagingDirectory)/UAT/*-Signed.aab" ^
            --app $AppId `
            --token $Token `
            --groups uat_qa
        displayName: 'Distribute AAB to Firebase UAT'
'Get-ChildItem' is not recognized as an internal or external command,
operable program or batch file.
'Write-Host' is not recognized as an internal or external command,
operable program or batch file.
##[error]Cmd.exe exited with code '1'.



- script: |
    echo Setting Firebase App ID and Firebase_Token...
    set AppId=1234
    set Token=xxxx

    echo Checking for .aab file...
    dir "%Build.ArtifactStagingDirectory%\UAT"

    echo Distributing aab to Firebase...
    firebase appdistribution:distribute "%Build.ArtifactStagingDirectory%\UAT\*-Signed.aab" ^
      --app %AppId% ^
      --token %Token% ^
      --groups uat_qa
  displayName: 'Distribute AAB to Firebase UAT'



  Setting Firebase App ID and Firebase_Token... 
Checking for .aab file... 
 Volume in drive D is Temporary Storage
 Volume Serial Number is 58DB-5D7A

 Directory of D:\
File Not Found

Distributing aab to Firebase... 
'firebase' is not recognized as an internal or external command,
operable program or batch file.
'--app' is not recognized as an internal or external command,
operable program or batch file.
'--token' is not recognized as an internal or external command,
operable program or batch file.
'--groups' is not recognized as an internal or external command,
operable program or batch file.
##[error]Cmd.exe exited with code '1'.
Finishing: Distribute AAB to Firebase UAT



Starting: Install Firebase CLI and Distribute AAB with Service Account
==============================================================================
Task         : Command line
Description  : Run a command line script using Bash on Linux and macOS and cmd.exe on Windows
Version      : 2.250.1
Author       : Microsoft Corporation
Help         : https://docs.microsoft.com/azure/devops/pipelines/tasks/utility/command-line
==============================================================================
Generating script.
========================== Starting Command Output ===========================
"C:\Windows\system32\cmd.exe" /D /E:ON /V:OFF /S /C "CALL "D:\a\_temp\0cf0aefe-ef07-4623-93e1-ed52f1010ead.cmd""
Installing Firebase CLI...

added 700 packages in 3m

79 packages are looking for funding
  run `npm fund` for details
Finishing: Install Firebase CLI and Distribute AAB with Service Account



- task: PowerShell@2
  displayName: 'Distribute AAB with Firebase CLI (Service Account)'
  inputs:
    targetType: 'inline'
    script: |
      echo Installing Firebase CLI...
      npm install -g firebase-tools

      echo Setting GOOGLE_APPLICATION_CREDENTIALS...
      $env:GOOGLE_APPLICATION_CREDENTIALS = "$(Agent.TempDirectory)/$(downloadFirebaseJson.secureFileName)"

      echo Checking for AAB file in: $(Build.ArtifactStagingDirectory)/UAT
      Get-ChildItem "$(Build.ArtifactStagingDirectory)/UAT"

      $aabPath = Get-ChildItem "$(Build.ArtifactStagingDirectory)/UAT/*-Signed.aab" | Select-Object -First 1

      if ($null -eq $aabPath) {
        Write-Error "No signed AAB file found to distribute."
        exit 1
      }

      echo Distributing to Firebase...
      firebase appdistribution:distribute "$($aabPath.FullName)" `
        --app "$env:FirebaseAppId_UAT" `
        --groups uat_qa
  env:
    GOOGLE_APPLICATION_CREDENTIALS: "$(Agent.TempDirectory)/$(downloadFirebaseJson.secureFileName)"
    FirebaseAppId_UAT: "$(FirebaseAppId_UAT)"





Z Installing
2025-06-05T15:41:33.1527357Z Firebase
2025-06-05T15:41:33.1528925Z CLI...
2025-06-05T15:44:33.0058381Z 
2025-06-05T15:44:33.0059348Z added 701 packages in 3m
2025-06-05T15:44:33.0059654Z 
2025-06-05T15:44:33.0059910Z 79 packages are looking for funding
2025-06-05T15:44:33.0060175Z   run `npm fund` for details
2025-06-05T15:44:33.0556247Z Setting
2025-06-05T15:44:33.0556732Z GOOGLE_APPLICATION_CREDENTIALS...
2025-06-05T15:44:33.6629178Z downloadFirebaseJson.secureFileName : The term 'downloadFirebaseJson.secureFileName' is not recognized as the name of 
2025-06-05T15:44:33.6630166Z a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, 
2025-06-05T15:44:33.6630491Z verify that the path is correct and try again.
2025-06-05T15:44:33.6631744Z At D:\a\_temp\a5d7b46d-8cb6-4a13-9ce6-273b973c37c5.ps1:8 char:53
2025-06-05T15:44:33.6632557Z + ... ION_CREDENTIALS = "D:\a\_temp/$(downloadFirebaseJson.secureFileName)"
2025-06-05T15:44:33.6632928Z +                                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2025-06-05T15:44:33.6633521Z     + CategoryInfo          : ObjectNotFound: (downloadFirebaseJson.secureFileName:String) [], ParentContainsErrorReco 
2025-06-05T15:44:33.6633864Z    rdException
2025-06-05T15:44:33.6634535Z     + FullyQualifiedErrorId : CommandNotFoundException
2025-06-05T15:44:33.6634994Z  
2025-06-05T15:44:33.8220250Z ##[error]PowerShell exited with code '1'.
2025-06-05T15:44:33.8938109Z ##[section]Finishing: Distribute AAB with Firebase CLI (Service Account)




- task: PowerShell@2
  displayName: 'Distribute AAB with Firebase CLI (Service Account)'
  inputs:
    targetType: 'inline'
    script: |
      echo "Installing Firebase CLI..."
      npm install -g firebase-tools

      echo "Using GOOGLE_APPLICATION_CREDENTIALS: $env:GOOGLE_APPLICATION_CREDENTIALS"

      echo "Checking for AAB file in: $(Build.ArtifactStagingDirectory)\UAT"
      $aabPath = Get-ChildItem "$(Build.ArtifactStagingDirectory)\UAT\*-Signed.aab" | Select-Object -First 1

      if ($null -eq $aabPath) {
        Write-Error "❌ No signed AAB file found to distribute."
        exit 1
      }

      echo "Distributing to Firebase App Distribution..."
      firebase appdistribution:distribute "$($aabPath.FullName)" `
        --app "$env:FirebaseAppId_UAT" `
        --groups uat_qa
  env:
    GOOGLE_APPLICATION_CREDENTIALS: "$(Agent.TempDirectory)/firebase-uat-service-account.json"
    FirebaseAppId_UAT: "$(FirebaseAppId_UAT)"

Installing Firebase CLI...
2025-06-05T18:22:29.5779032Z 
2025-06-05T18:22:29.5780995Z added 701 packages in 2m
2025-06-05T18:22:29.5781406Z 
2025-06-05T18:22:29.5781752Z 79 packages are looking for funding
2025-06-05T18:22:29.5782047Z   run `npm fund` for details
2025-06-05T18:22:29.6074898Z Using GOOGLE_APPLICATION_CREDENTIALS: D:\a\_temp/android-firebase-uat.json
2025-06-05T18:22:29.6076016Z Checking for AAB file in: D:\a\1\a\UAT
2025-06-05T18:22:29.7077382Z Distributing to Firebase App Distribution...
2025-06-05T18:22:32.4626909Z 
2025-06-05T18:22:32.5807728Z [1m[31mError:[39m[22m Failed to authenticate, have you run [1mfirebase login[22m?
2025-06-05T18:22:33.3057961Z ##[error]PowerShell exited with code '1'.
2025-06-05T18:22:33.3576928Z ##[section]Finishing: Distribute AAB with Firebase CLI (Service Account)
2025-06-05T18:22:33.3604935Z Skipping step due to condition evaluation.
Evaluating: SucceededNode()
Result: False




# 🔐 Download the service account JSON
    - task: DownloadSecureFile@1
      name: downloadFirebaseJson
      displayName: 'Download Firebase Service Account JSON'
      inputs:
        secureFile: 'firebase-uat-service-account.json'

    # 🛠️ Install Google Cloud SDK
    - powershell: |
        Invoke-WebRequest -Uri "https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe" -OutFile "gcloud_installer.exe"
        Start-Process .\gcloud_installer.exe -Wait -ArgumentList "/S"
        $env:Path += ";C:\Program Files (x86)\Google\Cloud SDK\google-cloud-sdk\bin"
        gcloud --version
      displayName: 'Install Google Cloud SDK'

    # 🚀 Use REST API to upload AAB to Firebase
    - powershell: |
        $jsonPath = "$(Agent.TempDirectory)\$(downloadFirebaseJson.secureFileName)"
        $env:Path += ";C:\Program Files (x86)\Google\Cloud SDK\google-cloud-sdk\bin"

        Write-Host "Activating service account..."
        gcloud auth activate-service-account --key-file="$jsonPath"

        $accessToken = gcloud auth print-access-token

        $aabFile = Get-ChildItem "$(Build.ArtifactStagingDirectory)\UAT\*-Signed.aab" | Select-Object -First 1
        if (-not $aabFile) {
          Write-Error "❌ No signed AAB file found."
          exit 1
        }

        Write-Host "Uploading AAB to Firebase App Distribution..."
        $uri = "https://firebaseappdistribution.googleapis.com/v1/projects/-/apps/$(FirebaseAppId_UAT)/releases:upload"

        $headers = @{
          "Authorization" = "Bearer $accessToken"
          "X-Goog-Upload-Protocol" = "raw"
          "X-Goog-Upload-File-Name" = "$($aabFile.Name)"
          "Content-Type" = "application/octet-stream"
        }

        $response = Invoke-RestMethod -Uri $uri -Method POST -Headers $headers -InFile $aabFile.FullName
        Write-Output "✅ Uploaded: $($response.name)"
      displayName: 'Distribute AAB via Firebase REST API'
      env:
        FirebaseAppId_UAT: "$(FirebaseAppId_UAT)"





        Task         : PowerShell
2025-06-05T19:08:10.6166303Z Description  : Run a PowerShell script on Linux, macOS, or Windows
2025-06-05T19:08:10.6166405Z Version      : 2.247.1
2025-06-05T19:08:10.6166542Z Author       : Microsoft Corporation
2025-06-05T19:08:10.6166627Z Help         : https://docs.microsoft.com/azure/devops/pipelines/tasks/utility/powershell
2025-06-05T19:08:10.6166755Z ==============================================================================
2025-06-05T19:08:12.4855531Z Generating script.
2025-06-05T19:08:12.5777578Z ========================== Starting Command Output ===========================
2025-06-05T19:08:12.6108045Z ##[command]"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Unrestricted -Command ". 'D:\a\_temp\66563948-3f55-4c49-9e6e-578f491c6691.ps1'"
2025-06-05T19:12:05.9173117Z Google Cloud SDK 525.0.0
2025-06-05T19:12:05.9174154Z bq 2.1.17
2025-06-05T19:12:05.9174532Z core 2025.05.30
2025-06-05T19:12:05.9174819Z gcloud-crc32c 1.0.0
2025-06-05T19:12:05.9175112Z gsutil 5.34
2025-06-05T19:12:06.2632158Z ##[section]Finishing: Install Google Cloud SDK
2025-06-05T19:12:06.2690748Z ##[section]Starting: Distribute AAB via Firebase REST API
2025-06-05T19:12:06.2708697Z ==============================================================================
2025-06-05T19:12:06.2708858Z Task         : PowerShell
2025-06-05T19:12:06.2708927Z Description  : Run a PowerShell script on Linux, macOS, or Windows
2025-06-05T19:12:06.2709029Z Version      : 2.247.1
2025-06-05T19:12:06.2709145Z Author       : Microsoft Corporation
2025-06-05T19:12:06.2709224Z Help         : https://docs.microsoft.com/azure/devops/pipelines/tasks/utility/powershell
2025-06-05T19:12:06.2709356Z ==============================================================================
2025-06-05T19:12:07.6855442Z Generating script.
2025-06-05T19:12:07.7414420Z ========================== Starting Command Output ===========================
2025-06-05T19:12:07.7750911Z ##[command]"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Unrestricted -Command ". 'D:\a\_temp\a39c370b-7085-4f8c-b833-66071e052e9a.ps1'"
2025-06-05T19:12:09.0148857Z downloadFirebaseJson.secureFileName : The term 'downloadFirebaseJson.secureFileName' is not recognized as the name of 
2025-06-05T19:12:09.0150224Z a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, 
2025-06-05T19:12:09.0151812Z verify that the path is correct and try again.
2025-06-05T19:12:09.0152270Z At D:\a\_temp\a39c370b-7085-4f8c-b833-66071e052e9a.ps1:4 char:27
2025-06-05T19:12:09.0152706Z + $jsonPath = "D:\a\_temp\$(downloadFirebaseJson.secureFileName)"
2025-06-05T19:12:09.0153143Z +                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2025-06-05T19:12:09.0153585Z     + CategoryInfo          : ObjectNotFound: (downloadFirebaseJson.secureFileName:String) [], ParentContainsErrorReco 
2025-06-05T19:12:09.0154185Z    rdException
2025-06-05T19:12:09.0154565Z     + FullyQualifiedErrorId : CommandNotFoundException
2025-06-05T19:12:09.0155183Z  
2025-06-05T19:12:09.2047711Z ##[error]PowerShell exited with code '1'.
2025-06-05T19:12:09.2630367Z ##[section]Finishing: Distribute AAB via Firebase REST API
2025-06-05T19:12:09.2667192Z Skipping step due to condition evaluation.
Evaluating: SucceededNode()
Result: False





- task: PowerShell@2
  displayName: 'Distribute AAB via Firebase REST API'
  inputs:
    targetType: 'inline'
    script: |
      $jsonPath = "$(Agent.TempDirectory)\$(downloadFirebaseJson.secureFileName)"
      Write-Host "Using service account: $jsonPath"

      $env:Path += ";C:\Program Files (x86)\Google\Cloud SDK\google-cloud-sdk\bin"
      gcloud auth activate-service-account --key-file="$jsonPath"
      
      $accessToken = gcloud auth print-access-token

      $aabFile = Get-ChildItem "$(Build.ArtifactStagingDirectory)\UAT\*-Signed.aab" | Select-Object -First 1
      if (-not $aabFile) {
        Write-Error "❌ No signed AAB file found."
        exit 1
      }

      $headers = @{
        "Authorization" = "Bearer $accessToken"
        "X-Goog-Upload-Protocol" = "raw"
        "X-Goog-Upload-File-Name" = "$($aabFile.Name)"
        "Content-Type" = "application/octet-stream"
      }

      $uri = "https://firebaseappdistribution.googleapis.com/v1/projects/-/apps/$(FirebaseAppId_UAT)/releases:upload"
      $response = Invoke-RestMethod -Uri $uri -Method POST -Headers $headers -InFile $aabFile.FullName

      Write-Output "✅ Uploaded to Firebase: $($response.name)"
  env:
    FirebaseAppId_UAT: $(FirebaseAppId_UAT)







   ##[command]"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Unrestricted -Command ". 'D:\a\_temp\1dcabb97-d01e-471b-a59d-a99be4ef95f6.ps1'"
2025-06-09T19:13:27.8864190Z Using service account: D:\a\_temp\android-firebase-uat.json
2025-06-09T19:13:28.5352530Z gcloud : The term 'gcloud' is not recognized as the name of a cmdlet, function, script file, or operable program. 
2025-06-09T19:13:28.5353387Z Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
2025-06-09T19:13:28.5354085Z At D:\a\_temp\1dcabb97-d01e-471b-a59d-a99be4ef95f6.ps1:8 char:1
2025-06-09T19:13:28.5354986Z + gcloud auth activate-service-account --key-file="$jsonPath"
2025-06-09T19:13:28.5355624Z + ~~~~~~
2025-06-09T19:13:28.5358054Z     + CategoryInfo          : ObjectNotFound: (gcloud:String) [], ParentContainsErrorRecordException
2025-06-09T19:13:28.5358934Z     + FullyQualifiedErrorId : CommandNotFoundException
2025-06-09T19:13:28.5359356Z  
2025-06-09T19:13:28.6678681Z ##[error]PowerShell exited with code '1'.
2025-06-09T19:13:28.7252370Z ##[section]Finishing: Distribute AAB via Firebase REST API
2025-06-09T19:13:28.7287770Z Skipping step due to condition evaluation.
Evaluating: SucceededNode()
Result: False

##[error]Error: Not found SourceFolder: /Users/runner/work/1/s/src/app/Bcbsla.Mobile.App.IOS/bin/Release_Test/net9.0-ios/ios-arm64/publish



Error: Failed to upload release. Request to https://firebaseappdistribution.googleapis.com/upload/v1/projects/658107755795/apps/1:658107755795:ios:0a47d2f3e85903eb273ee6/releases:upload had HTTP Error: 403, The caller does not have permission

