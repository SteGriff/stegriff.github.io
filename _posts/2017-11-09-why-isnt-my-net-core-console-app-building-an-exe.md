# Why isn't my .Net Core Console App building an exe

Your `csproj` or `vbproj` needs to include RuntimeIdentifiers for the platforms you want to target, and then you need to use the Publish feature (not just build) to export for your target platform.

	<RuntimeIdentifiers>win10-x64;osx.10.11-x64</RuntimeIdentifiers>

Like regular .Net apps, .Net Core apps are expected to run on a .Net runtime which can be found on the target system. This concept has gone one further with Core such that the program is executed by running `dotnet MyApp.dll` on the target system ("framework-dependent deployment"). If you want to have a self-contained exe deployment, then VS must package the whole Core framework up within your app. This package is then specific to the platform, and that's why you have to do the stuff above.

See more on the process and reasoning on the [Microsoft docs for deploying standalone .Net core with VS][msdocs].

[msdocs]: https://docs.microsoft.com/en-us/dotnet/core/deploying/deploy-with-vs#simpleSelf