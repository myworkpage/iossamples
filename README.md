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
