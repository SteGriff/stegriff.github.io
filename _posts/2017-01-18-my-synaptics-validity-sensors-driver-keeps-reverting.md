# My Synaptics Validity Sensors driver keeps reverting

My HP Pavilion laptop has a fingerprint scanner for login. The laptop shipped with Windows 7, but since 8.1 onwards, the fingerprint sensor driver keeps reverting to a screwy version which doesn't work, and it does this every week (seemingly).

To [set the driver back to the version I want][su1], I use the method described in [this SuperUser answer][su1]:

 > * On the Driver tab of the device properties window, click on Update Driver. Select Browse my computer for driver software, then select Let me pick from a list of device drivers on my computer.
 > * If the correct driver is listed, select it. If not, uncheck Show compatible hardware, select Synaptics for the manufacturer, and select the correct driver. The correct driver should then be used for the [device]. (You may need to restart your computer.)

However, it seems that my preferred driver is getting regularly smushed by Windows Update which deems the online driver to be "newer". To stop this on Windows 10, you can "Roll Back" the driver, and this should have a lasting effect. To do so:

 * Go to Device Manager (Win+X, Device Manager),
 * Locate the device
 * Right click it, Properties
 * Go to the Driver tab
 * Click Roll Back driver
 
You can then specify which driver you would like to roll back to, and answer the questions in a sensible way to convince Windows Update not to undo your hard work yet again.

[su1]: http://superuser.com/a/938656/237118