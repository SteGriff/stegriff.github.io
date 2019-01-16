# Non-blocking wait or sleep in Office VBA

There are a [lot of ways to pause VBA execution][pause] when scripting Office and they're nearly all bad and wrong. The ones I've heard, from worst to best:

 * Loop with `Application.Wait` - this will completely freeze the Office app
 * Loop and call the Windows API to sleep - you can't break out of this one with Ctrl+Break because it's at OS level!
 * Loop with `DoEvents` and a "tight timer loop" - messy
 * Loop and call the Windows API to SetTimer and KillTimer - it's at least async but the implementiation is very long and messy
 * Use Application.OnTime - *tada*, it's async, and it's shorter than everything else
 
[pause]: http://www.cpearson.com/Excel/WaitFunctions.aspx

You can use `Application.OnTime` to schedule when you want a Sub to happen. Let's look at a simple case, a count-up clock where I want to increment the value in Excel cell `A1` once per second.

## Before - a "blocking wait"

A blocking wait looks like this:

    Sub BlockingChange()
        Dim i As Integer
        i = 0
        Do
            Range("A1").Value2 = i
            Application.Wait Now + TimeValue("0:00:01")
            i = i + 1
        Loop
    End Sub

This will work but will freeze Excel. There is no way of stopping it except to press Ctrl+Break.

## After - a non-blocking delay

The alternative with `OnTime` would be:

    Sub NonBlockingChange()
        Update
        Application.OnTime Now + TimeValue("0:00:01"), "NonBlockingChange"
    End Sub
    
    Sub Update()
        Range("A1").Value2 = CInt(Range("A1").Value2) + 1
    End Sub

Now be warned that every time you run this, it will schedule another instance of the running sub, so if you run the macro twice, it will run the sub twice per second, etc.

Pressing Stop in the VBA editor won't actually stop the scheduled events. To do that, you just pass `False` as the fourth parameter to `OnTime`:
    
    Sub StopChanges()
    
    On Error GoTo Catch
        Application.OnTime Now + TimeValue("0:00:01"), "NonBlockingChange", , False
        Exit Sub
    Catch:
        MsgBox ("Nothing to stop")
        
    End Sub

If you're a JavaScript developer, you'll notice that this is very similar to JavaScript's `Window.setTimeout()` method.

## Async programming

This technique can be used more widely than for simple waiting, giving you access to asynchronous method calls for whatever purpose you should desire.

## Troubleshooting

If you get the error, "Cannot run the macro... the macro may not be available in this workbook" then there are a few possible causes. You may have to set ['Trust access to the VBA project object model'][trust]. Or, if you're me, this bug is because you've added your Sub into the code for a Workbook or Spreadsheet instead of a Module.

To make your Sub publicly accessible by its short name, either put it in a Module, or refer to it like `Sheet1!NonBlockingChange`. Whatever you prefer.

[trust]: https://stackoverflow.com/a/21175812/1761974