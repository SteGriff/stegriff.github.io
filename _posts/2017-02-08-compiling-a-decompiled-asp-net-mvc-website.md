# Compiling a decompiled ASP.Net MVC website

We recently took delivery of a codebase with no code... well, it might actually turn out that the original developer comes through but I started this process anyway! Currently the binaries on the FTP server are the only resource available.

## Set up the environment

 * Make an SVN repo and set it up with trunk/branches
 * Create an empty solution directory in there
 * Download all the `bin` files from the website FTP server
 * Use **Telerik JustDecompile** to decompile the main named one (`MyWebsite.dll`, let's say)
 * Use the 'Create Project' feature in JD to build a project, put it in newly created project folder in the solution directory.
 
## Flatten the main project

At this point, the project folder needs to be flattened so that the csproj is in the same directory as all the website files. 

 * Hack the csproj in Notepad++ by replacing all instances of `MyWebsite\` with nothing.
 * Add ProjectTypeGuids in web.config

You can copy the ProjectTypeGuids from another website project, or you might be able to use these:

	<ProjectTypeGuids>{349c5851-65df-11da-9384-00065b846f21};{fae04ec0-301f-11d3-bf4b-00c04f79efbc}</ProjectTypeGuids>
	
Add IIS stuff to the bottom of web.config, copied from another website project (change the `FlavorProperties` GUID to a new randomly generated GUID):

	<ProjectExtensions>
		<VisualStudio>
		  <FlavorProperties GUID="{d597882c-d741-470d-bba0-d7bd6ca0568a}">
			<WebProjectProperties>
			  <UseIIS>True</UseIIS>
			  <AutoAssignPort>True</AutoAssignPort>
			  <DevelopmentServerPort>0</DevelopmentServerPort>
			  <DevelopmentServerVPath>/</DevelopmentServerVPath>
			  <IISUrl>http://localhost:57441/</IISUrl>
			  <NTLMAuthentication>False</NTLMAuthentication>
			  <UseCustomServer>False</UseCustomServer>
			  <CustomServerUrl>
			  </CustomServerUrl>
			  <SaveServerSettingsInUserFile>False</SaveServerSettingsInUserFile>
			</WebProjectProperties>
		  </FlavorProperties>
		</VisualStudio>
	</ProjectExtensions>

## Decompile references

Now I went back to navigating the project tree in JustDecompile to discover any other projects I needed

 * Click around references in JustDecompile until you've decompiled all the user-written projects (don't do the core Microsoft or Newtonsoft ones...)
 * Create project folders, and export each project to its own folder in the solution dir
 * Delete the `.sln` file that gets created by JustDecompile in each dir - we're going to make a master solution
 
## Create a solution

 * Open a new empty VS 2013+ window
 * Go to New, look for Visual Studio Solution items, make a new Empty Solution
 * Save it in your solution directory and then clear up the mess of any extra folders that VS manufactures...
 * Open your solution
 * Add all the projects using Add Existing Project
 * For each project, open its references. Delete the references they have to one another, and re-add them as Solution references (so the projects reference each others code, not artifact DLLs)
 * Also delete the appropriate DLLs from each project's references folder in explorer.
 * Set the website project as the main one
 * Check the solution build order looks right
 
## Try it

You're roughly ready to start building and testing it. Visual Studio should present the correct browser-play button in the debug toolbar. If it doesn't, the website csproj is still set up wrong (see the code snippets above). Maybe restart Visual Studio?

You will probably get errors the first time you start the site, you'll have to triage and fix them with liberal use of [DuckDuckGo][ddg].

## Fix global.asax

This might not happen to you, but my website, when launched, complained that it couldn't locate the `MyWebsite.MvcApplication` class, which had been written to overload `HttpApplication`. The problem was due to the [project output path being `bin/Debug` instead of just `bin`][1].

[1]: http://stackoverflow.com/a/15415141
[ddg]: https://duckduckgo.com