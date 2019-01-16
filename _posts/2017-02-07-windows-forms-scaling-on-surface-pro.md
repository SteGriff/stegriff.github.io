# Windows Forms scaling on Surface Pro

We have been working on an Office Add-in which is primarily being deployed on Surface Pro 3s and 4s. These units all have their scaling set to 200% which presents a High DPI challenge.

Here are some conditions unique to our situation:

 * We are not able to develop on high DPI because our development screens only allow Windows to go to 125 or 150% scaling
 * We have to dynamically add lots of different types of UserControl at runtime
 * The dynamically added controls inhabit a scrolling panel which must not AutoSize (because then it wouldn't scroll)
 * Our Windows Forms designs do not use FlowLayoutPanel or TableLayoutPanel and we have too much investment to change this
 
We now have a build which functions nicely at all ranges of DPI settings. The most helpful resource I have found so far was a StackOverflow answer cataloguing the experiences of another developer, ['Creating a DPI aware application'][so1]. It's really a great answer!

The points (credit to [Trygve][try]) are:

 > * Always edit/design your apps in default 96 DPI (100%). If you design in 120DPI (125%) it will get really bad when you go back to 96 DPI to work with it later.
 > * I've used AutoScaleMode.Font with success, I haven't tried AutoScaleMode.DPI much.
 > * Make sure you use the default font size on all your containers (forms, panels, tabpage, usercontrols etc). 8.25 px. Preferrably it shouldn't be set in the `.Designer.cs` file at all for all containers so that it uses the default font from the container class.
 > * All containers must use the same AutoScaleMode
 > * Make sure all containers have the below line set in the Designer.cs file: `this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F); // for design in 96 DPI`
 > * If you need to set different font sizes on labels/textboxes etc. set them per control instead of setting the font on the container class because winforms uses the containers font setting to scale it's contents and having f.ex a panel with a different font size than it's containing form is guaranteed to make problems. It might work if the form and all containers on the form use the same font size, but I haven't tried it.

From this answer, the most important takeaways for me were:

 * Remove all custom fonts. I had changed the font to Segoe UI at a higher point size throughout the app. This was causing nightmareish increases in size when `AutoScaleMode=Font` was set. I searched all `.Designer.vb` files for "Segoe" and deleted every matching line, so all controls used the default font setting. *This totally fixed almost all of my problems*.
 * Set `AutoScaleDimensions`. Some of our forms in design mode had been acting a bit strange, and I found that there were different values for this property on each form. Setting them to the same value seems to have cured this problem.
 * It's OK for us to develop at 100% zoom.
 
If I could start again, I would start with the above advice, unaltered fonts, and correct AutoScaleMode settings! It's also useful to have a 200% display for testing (but not developing).

[try]: http://stackoverflow.com/users/288651/trygve
[so1]: http://stackoverflow.com/questions/4075802/creating-a-dpi-aware-application