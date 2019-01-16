# Migrate MSUnit tests Accessors to PrivateObjects

![VSTS Passing Tests](./posts/migrate-msunit-tests-accessors-to-privateobjects/vsts-results.png)

MSUnits tests are fussy at the best of times and don't run in a number of popular environments, such as Travis. If you have invested a lot into white-box MSUnit tests already and need to give your tests better compatability (with Visual Studio Online/Team Services for example) then you can move away from using `Accessor` types to using `PrivateObject`. For more pros/cons, scroll to the bottom of the article.

These examples are in VB and C#:

## How to

Find places where you create Accessor objects:

	Dim target As New MyThing_Accessor() 'Old VB
	var target = new MyThing_Accessor(); //Old C#

Change them to create a normal object instance and add a PrivateObject instantiator below:

	'New VB
	Dim target As New MyThing()
	Dim pTarget As New PrivateObject(target)
	
	//New C#
	var target = new MyThing();
	var pTarget = new PrivateObject(target);
	
Now find the places you call the methods through your `_Accessor` class:

	Dim actual As String = target.FullActiveFileNameWithoutExtension(mockWorkbook) 'Old VB
	var actual = target.FullActiveFileNameWithoutExtension(mockWorkbook); //Old C#

Change them to call `pTarget.Invoke` with the string name of your method, passing all parameters afterwards (in `ParamArray` style):

	'New VB
	Dim actual As String = CStr(pTarget.Invoke("FullActiveFileNameWithoutExtension", mockWorkbook))
	
	//New C#
	var actual = (string)pTarget.Invoke("FullActiveFileNameWithoutExtension", mockWorkbook)

Note that because `Invoke` is dynamic, we no longer have a guarantee (at design time) of what Type will be returned, so you need to convert or cast it to the expected type. We do this above with `CStr()` or `(string)`.

Anywhere you need to get/set a private field or property, you can use `pTarget.SetFieldOrProperty` like this:

	'VB
	Dim target As New MyThing()
	Dim pTarget As New PrivateObject(target)
	pTarget.SetFieldOrProperty("LastMasterFileName", "C:\Users\Bob\Documents\MyWorkbook.xlsm")
	...


## Simple invocation example

Here's a simple test around a method for getting file paths for Excel workbooks (it has to work for local and remote paths, and is basically a wrapper around some `Path` methods - I'm not reinventing the wheel, honest). Extra comments added to show changes.

This is in VB (C# conversion is exercise for the reader):

### Before

    <TestMethod(), _
     DeploymentItem("MyAddIn.dll")> _
    Public Sub FullActiveFileNameWithoutExtension_WindowsFileName()
		'Set up the accessor to let us test the private method
        Dim target As MyThing_Accessor = New MyThing_Accessor()

		'Create mock workbook to pass into the method
        Dim mockWorkbook As New MockWorkbook("C:\Users\Bob\Documents\MyWorkbook.xlsm")

		'Test
        Dim expected As String = "C:\Users\Bob\Documents\MyWorkbook"
        Dim actual As String = target.FullActiveFileNameWithoutExtension(mockWorkbook)
        Assert.AreEqual(expected, actual)
    End Sub

### After

	<TestMethod(), _
     DeploymentItem("MyAddIn.dll")> _
    Public Sub FullActiveFileNameWithoutExtension_WindowsFileName()
		'Create the object using its regular constructor
        Dim target As MyThing = New MyThing()
		
		'Build the private object reflector
        Dim pTarget As New PrivateObject(target)

		'Create mock workbook to pass into the method
        Dim mockWorkbook As New MockWorkbook("C:\Users\Bob\Documents\MyWorkbook.xlsm")

		'Call the private method using Invoke on our pTarget
        Dim expected As String = "C:\Users\Bob\Documents\MyWorkbook"
        Dim actual As String = CStr(pTarget.Invoke("FullActiveFileNameWithoutExtension", mockWorkbook))
        Assert.AreEqual(expected, actual)
    End Sub


## Longer example

Here's a more complex example with field changes and more parameters in invocation:

### Before

    <TestMethod(), _
     DeploymentItem("MyAddIn.dll")> _
    Public Sub WorkingCopyFileName_FromWindowsFileName_ByKnowingLastMasterFileName()

        Dim target As MyThing_Accessor = New MyThing_Accessor()
        target.LastMasterFileName = "C:\Users\Bob\Documents\MyWorkbook.xlsm"

        'Active filename is usually obtained from FullActiveFileNameWithoutExtension
        Dim activeFileName As String = "C:\Users\Bob\Documents\MyWorkbook_abcd1234"

        Dim expected As String = "C:\Users\Bob\Documents\MyWorkbook.xlsm"
        Dim actual As String = target.WorkingCopyFileURI(activeFileName, Nothing)
        Assert.AreEqual(expected, actual)
    End Sub
	
### After

    <TestMethod(), _
     DeploymentItem("MyAddIn.dll")> _
    Public Sub WorkingCopyFileName_FromWindowsFileName_ByKnowingLastMasterFileName()

        Dim target As MyThing = New MyThing()
        Dim pTarget As New PrivateObject(target)

		'Instead of setting field directly, use SetFieldOrProperty on PrivateObject
        pTarget.SetFieldOrProperty("LastMasterFileName", "C:\Users\Bob\Documents\MyWorkbook.xlsm")

        'Active filename is usually obtained from FullActiveFileNameWithoutExtension
        Dim activeFileName As String = "C:\Users\Bob\Documents\MyWorkbook_abcd1234"

		'Pass all parameters to WorkingCopyFileURI after the method name
        Dim expected As String = "C:\Users\Bob\Documents\MyWorkbook.xlsm"
        Dim actual As String = CStr(pTarget.Invoke("WorkingCopyFileURI", activeFileName, Nothing))
        Assert.AreEqual(expected, actual)
    End Sub

	
## Conclusion

Pros:

 * Better compatability
 * More obvious use of reflection
 * No more broken Accessor objects when changing environments
 
Cons:

 * Less obvious method call
 * Can't go to definition as easily
 * Have to manually convert/cast returned objects
 
Good luck, have fun...