# My First PowerShell

![PowerShell ISE](./posts/powershell/powershell-ise.png)

A guide to the bits that I needed when starting to use PowerShell, particularly in the context of Azure. Not a complete guide to PowerShell :) For that, try these:

 * (MSDN) [PowerShell Fundamental Concepts][fundamentals]
 * [Effective Windows PowerShell: The Free eBook][effective]
 * [Learn PowerShell in a Month of Lunches][lunches]
 
[fundamentals]: https://msdn.microsoft.com/en-us/powershell/scripting/getting-started/fundamental-concepts
[effective]: https://rkeithhill.wordpress.com/2009/03/08/effective-windows-powershell-the-free-ebook/
[lunches]: https://www.manning.com/books/learn-windows-powershell-in-a-month-of-lunches

## Environment

For my experiments, I'm using the PowerShell ISE. Just hit the Windows key, type 'ise' and it will come up.

**ISE Tips:**

 * Open your first code editor tab with `Ctrl+N`
 * Switch to the terminal (blue part) by clicking in it or pressing `Ctrl+D`
 * Switch to the editor (white part) by pressing `Ctrl+I`
 * Run the content of the editor with F5
 * Run just the selected content of the editor with F8

## Variables and printing to terminal

You can print out text (string literals) with either single or double quotes, no cmdlet needed:

	'Hello'
	"Goodbye"

	Hello
	Goodbye

The difference is that double quotes are dynamic - they expand embedded variables (like in PHP).
Here's how to define a variable and print it within another string:

	$myName = "Ste"
	'Hey $myName'
	"Hey $myName"

	Hey $myName
	Hey Ste

Note that the double quotes expand the variable but the single quotes don't. There are more methods than these for string handling, you can find a good overview in this Scripting Guy blog post, [Use PowerShell to Glue Strings Together][glue].

[glue]: https://blogs.technet.microsoft.com/heyscriptingguy/2014/07/15/keep-your-hands-clean-use-powershell-to-glue-strings-together/

You can store the result of a cmdlet in a variable but you don't have to. Without a variable, the cmdlet will dump its result to the screen. With a variable, it won't print out the result until you manually echo the content of the variable.

	$rg = New-AzureRmResourceGroup -Name '20533-Ste' -Location 'north europe'
	$rg

	ResourceGroupName : 20533-Ste
	Location          : northeurope
	ProvisioningState : Succeeded
	Tags              : 
	ResourceId        : /subscriptions/022db750-...-6e1be5c4a6ae/resourceGroups/20533-Ste

I think the formatting `Name : Value` represents the *properties* of an *object* (but I'm not 100% sure).

## Error handling

You can do try-catch blocks just like in C#. In the example below, `Fake-Cmdlet` will fail, so "Hello World" is never printed:

	"--------"
	try {
		Fake-Cmdlet
		"Hello World"
	}
	catch { "An error occurred" }


	--------
	An error occurred


## Hash Tables

Lots of cmdlets return hash tables (don't be scared - that's just an unsorted collection of key-value pairs). You can create your own and pass them as parameters to certain cmdlets. `@` indicates a hash table. Contents goes in braces `{}`, pairs are separated by a semicolon `;` (not a comma as you might expect). Btw, you **are** allowed dangling semicolons at the end of the list of properties.

	$myObj = @{ name = 'Smurfs'; platform = 'Atari 2600'}

Print it out:

	$myObj

	Name        Value                                                                              
	----        -----                                                                              
	name        Smurfs                                                                             
	platform    Atari 2600 


### Other uses of @

The `@` operator can be used for a couple of other nifty uses, including as the 'SPLAT' operator, beyond the scope of this little guide. Check out this SO Answer about [using the @ operator in PowerShell][splat]

[splat]: https://stackoverflow.com/a/574388/1761974


### Hash tables and Azure cmdlets

Hash tables are used for Tags on an Azure Resource Groups and Resources. I can create a tag `reason=training` on my existing resource group by identifying it by name and changing the Tag parameter:

	Set-AzureRmResourceGroup -Name '20533-Ste' -Tag @{ reason = 'training' }

(I could also have just passed a `-Tag` parameter to the original `New-AzureRmResourceGroup` call)

We can pass in a pre-existing hash table variable. The collection of tags you pass to `-Tag` overwrites the whole existing collection.

	$tags = @{ reason = 'training'; herolevel = '>9000'; }
	Set-AzureRmResourceGroup -Name '20533-Ste' -Tag $tags
