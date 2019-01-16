# "The specified dimension is not valid for the current chart type" on ChartObject.Duplicate

## Background

We have an Excel Add-In product which builds charts (among other things). Last week (Aug 2017), the chart generator suddenly stopped working in Office 2016 for two developers. One developer who uses Office 2010 was unaffected. When we checked out older versions of our code which used to work, they too now exhibited this bug.
This leads me to believe that there was a breaking change in Office but I'm not sure. 

The bug would also fatally crash Excel (the 'sending problem report' window would pop up)

Our VSTO add-in is written in VB.Net

## Potential causes for people who are not me

As every problem is different, your cause might be different to ours. Here are some things I found online but which did not help us *at all*:

 1. It can be useful to deselect any selected ranges. Excel might assume that you want to duplicate the chart using the selected data as a source, and may decide that it won't fit, throwing this error.
 2. It can be useful to clear the clipboard. As above.
 3. If the source data for the chart has been moved or removed, the duplication may fail. You can reset the `SourceData` property of the chart prior to Duplication to avoid this
 
## Our Solution/Workaround

**We did not find a way to make ChartObject.Duplicate not crash.**  Instead, we re-evaluated our approach and changed what was essentially 'Duplicate, Cut, and Paste' to 'Copy and Paste'. It's so simple it's stupid. In real terms, this is how the change looks:

_Old code_

	chartTemplate = CType(templatePage.ChartObjects(1), ChartObject)

	'Duplicate the chart object in-situ (this creates a Shape for some reason??)
	newChartBounds = CType(chartTemplate.Duplicate(), Shape)

	'Move it to the report page
	newChartBounds.Cut()
	_parent.ReportSheet.Paste()

_New code_

	chartTemplate = CType(templatePage.ChartObjects(1), ChartObject)

	'Copy it to the report page
	chartTemplate.Copy()
	_parent.ReportSheet.Paste()
	Utilities.ClearClipboard(chartTemplate.Application)

We have decided to clear the clipboard defensively after the copy-paste operation to avoid any nasty surprises. So, it's not crucial to the process. Our original code was probably due to a false assumption (by me) that it would be safer to Cut+Paste a `Shape` than a `ChartObject` 

## Special things about our use-case

After emergence of the bug, I reopened my original proof-of-concept file for chart duplication. This is VBA only (but VBA calls the same Excel API as VSTO, so no difference really). It still worked! Dismayed, I moved that VBA code into a workbook from our actual product. Now the code failed, just like the VB.Net, crashing Excel.

The succeeding and failing charts were visually identical. The one that succeeded had a `SourceData` reference pointing to a range of cells. The failing one had literal data coded into it. This could have something to do with Potential Cause #3 from above.

I truly hope this helps you!
