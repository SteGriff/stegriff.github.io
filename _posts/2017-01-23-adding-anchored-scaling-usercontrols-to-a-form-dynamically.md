# Adding anchored, scaling UserControls to a Windows Form dynamically

In Windows Forms, you can set the Anchor property on controls so that they "anchor" themselves onto specific edges of the parent Form, so that when the Form is resized, your control also resizes.

In complex applications, you will often have UserControls, which are an assortment of other toolbox controls thrown together onto a canvas which can be added programmatically to a Form at runtime. But it can be tricky to make these scale in the way you expect, so here are some tips:

## 1. No AutoSize on the UserControl

Unless you really need it, leave AutoSize in its default setting of False on your UserControl.

## 2. Set the Anchor and Width/Height properties at runtime

When you're adding the UserControl to the form, set these properties:

	private void addPanel_Click(object sender, EventArgs e)
	{
		_newPanel = new StePanel();
		
		_newPanel.Anchor = (AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right);
		_newPanel.Width = Width - _newPanel.Margin.Horizontal - 10;

		Controls.Add(_newPanel);
	}
	
In the simplest case, it doesn't matter which order you do these operations in. But in more complicated scenarios, I reckon it's most reliable to set the properties *first* and add the control to the parent *last*.

## 3. Create a method (or contructor) that sets up the UserControl up in a repeatable way

The above code would be unwieldy if you had to repeat it, so you should either move it into a subroutine, or even better, a constructor/method of the control itself which accepts a `parentControl`:

	//This is the new, additional constructor in StePanel.cs
	public StePanel(Control parentControl)
	{
		InitializeComponent();
		
		Anchor = (AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right);
		Width = parentControl.Width - Margin.Horizontal - 10;

		parentControl.Controls.Add(this);
	}
	
	//This is the revised calling code on the main Form - much shorter
	private void addPanel_Click(object sender, EventArgs e)
	{
		_newPanel = new StePanel(this);
	}
	
Now you can make copies of the control from many points in code, and be sure that they will resize correctly with their parent.