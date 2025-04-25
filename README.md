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
