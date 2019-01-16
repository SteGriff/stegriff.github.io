# Visual Studio 2017 underlining all MVC code in red even though it builds

![Build succeeded - OR DID IT?!](./posts/visual-studio-2017-underlining-all-mvc-code-in-red-even-though-it-builds/screenshot.png)

This project builds fine, but in VS 2017 it shows a lot of errors, which is counterproductive for developers. 

The following is a reduced set of instructions from the long-titled Microsoft article, [How to Upgrade an ASP.NET MVC 4 and Web API Project to ASP.NET MVC 5 and Web API 2][upgrademvc]

[upgrademvc]: https://docs.microsoft.com/en-us/aspnet/mvc/overview/releases/how-to-upgrade-an-aspnet-mvc-4-and-web-api-project-to-aspnet-mvc-5-and-web-api-2#update-the-application-webconfig-file

## Fixing MVC Version references

You might not think you upgraded the project from an older MVC version. In our case, I assume that either the previous developers of this project did it at some time, or VS mucked it up all by itself (not unheard of)

We didn't have a Web API component to the system, so it was just MVC that needed work.

**To find out your MVC version**, in Solution Explorer: expand References, find `System.Web.Mvc`, right-click, Properties, and find 'Version'. Mine is `5.2.3.0`.

### Fix the application `web.config`

Find all references to `System.Web.Mvc` in this file. Their `bindingRedirect` configurations should all look something like this:

	<bindingRedirect oldVersion="0.0.0.0-5.2.3.0" newVersion="5.2.3.0" />

For `System.Web.Helpers`, `System.Web.WebPages`, it should be:

	<bindingRedirect oldVersion="0.0.0.0-3.0.0.0" newVersion="3.0.0.0" />

That bit didn't actually affect us. The only bit we needed to change was in `<appSettings>`, the `webpages:Version` should be updated to `3.0.0.0`:

	<add key="webpages:Version" value="3.0.0.0" />

### Fix the `Views/web.config`

This had more problems to fix in my instance:

 * As above, change all instances of Mvc 4.x to 5.x according to the version used in your project
 * In the `sectionGroup` part, change all lines with `System.Web.WebPages.Razor` from 2.x to 3.x
 
## Finally

Once you have done all this, close Visual Studio. Reopen it, clean, and build. This should fix your problems!

For more info, check out the following SO question; [Visual Studio MVC 5 shows error but compiles and runs okay][so].

[so]: https://stackoverflow.com/questions/20443581/visual-studio-mvc-5-shows-errors-but-compiles-and-runs-okay

Hope it helps :)