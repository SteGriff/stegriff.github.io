# Class Not Registered

I wrote a class which was COM-exposed and registered it using RegAsm. It was a 32-bit library on a 32-bit machine, being called by a 32-bit caller. Yet when the calling program tried to make an instance, it got the error "Class not Registered". 

## My Solution

In my case, the error was actually because a dependency of my class was not registered. I registered my dependency and got a different error. In the end, I needed to use a different version of my dependency DLL which other consumers were using, which was pre-registered.

## Other things to check

Your class is annotated with `ComVisible` and a new, *unique* GUID which you have generated, which is **different** to your `AssemblyGuid` in `AssemblyInfo` (you will get build errors if they are the same)

	[ComVisible(true), Guid("20E9E1BF-EC98-4693-BBE3-BB4E0542B52F")]
	
In Project Properties (in Visual Studio) you have set the following:

 * `Application -> Assembly Information -> Make assembly COM-visible` to true
 * `Build -> Register for COM interop` to true

## Further reading

Here is a [tragic questioner on TekTips](https://www.tek-tips.com/viewthread.cfm?qid=1459182) who never got an answer to their identical question.
