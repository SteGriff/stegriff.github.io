# Quick Reference - .Net File Open Dialog

Making a file open dialog can be a bit laborious and I always forget which fields to fill in, so here's my current copy-pasta for the task.

## In C# ##

	string fileExt = ".xlsx";
	string filter = string.Format("Excel files (*{0})|*{0}", fileExt);
	var loadDialog = new OpenFileDialog()
	{
		Filter = filter,
		Title = "Open a service plan",
		Multiselect  = false,
		DefaultExt = fileExt,
		ValidateNames = true,
		InitialDirectory = Environment.SpecialFolder.MyDocuments
	};

	var result = loadDialog.ShowDialog();

	if (result == DialogResult.OK)
	{
		MessageBox.Show(loadDialog.FileName);
	}
	
## In VB ##

	Dim loadDialog As New OpenFileDialog
	Dim fileExt As String = ".xlsx"
	With loadDialog
		.Filter = String.Format("Excel workbook (*{0})|*{0}", fileExt)
		.Title = "Select a workbook with source data"
		.Multiselect = False
		.DefaultExt = fileExt
		.ValidateNames = True
		.InitialDirectory = Environment.SpecialFolder.MyDocuments
	End With

	Dim result = loadDialog.ShowDialog()

	If result = DialogResult.OK Then
		MessageBox.Show(loadDialog.FileName)
	End If