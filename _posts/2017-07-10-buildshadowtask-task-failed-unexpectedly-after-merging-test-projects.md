# BuildShadowTask task failed unexpectedly after merging Test Projects

I merged two branches of a solution which each had new MSUnit test projects in them. After the merge, this build error was raised: Error 91 The "BuildShadowTask" task failed unexpectedly.

	System.NullReferenceException: Object reference not set to an instance of an object.
	   at Microsoft.VisualStudio.TestTools.BuildShadowReferences.BuildShadowTask.Execute()
	   at Microsoft.Build.BackEnd.TaskExecutionHost.Microsoft.Build.BackEnd.ITaskExecutionHost.Execute()
	   at Microsoft.Build.BackEnd.TaskBuilder.<ExecuteInstantiatedTask>d__26.MoveNext()	MyProject.OrderProcessor.Tests

Take a note of which project is causing the problem - here, it's `MyProject.OrderProcessor.Tests`. Now open that particular `.csproj` (or `.vbproj`) in a text editor *other than Visual Studio* (I use Notepad++) and search for 'Shadow'...

	<ItemGroup>
		<Shadow Include="Test References\MyProject.OrderProcessor.accessor" />
	</ItemGroup>

You can simple delete the `Shadow Include` line. When you switch back to VS, it will want to reload the project. Allow this, then Rebuild the project or solution.

## If you needed the Private Accessor

In my case, I didn't need the Private Accessor we just deleted. But if you need yours, you can regenerate it by following the MS guide for [Unit Tests for Private, Internal, and Friend Methods][ms-unit-private].

Hope it helps!

## P.s. This is my 100th post on my upblog!

It has been 1068 days since I started this blog (on 7th August 2014) which means that on average, I post here every 10-and-a-half days :) I think that's quite good...

[ms-unit-private]: https://msdn.microsoft.com/en-us/library/bb385974(v=vs.90).aspx