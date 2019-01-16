# Enable ligatures and emoji in Notepad++

By default, emoji don't work very well in Notepad++ and font ligatures don't work at all. I have pieced together this guide from other people who have worked on the problems, notably this [GitHub issue about ligatures in Notepad++][enable-ligatures-github] and this [newsgroup post about character encoding detection][do-not-guess-encoding]. Shoulders of giants etc.

[enable-ligatures-github]: https://github.com/notepad-plus-plus/notepad-plus-plus/issues/2287#issuecomment-256638098
[do-not-guess-encoding]: https://notepad-plus-plus.org/community/topic/11074.rss


## Enable DirectWrite

Scintilla is the text editor control within Npp. Enabling DirectWrite in Scintilla lets Windows do some Windows-y things to the text drawn to screen, like rendering the advanced typography features of OpenType (read more on the [docs for DirectWrite][directwrite]).

[directwrite]: https://msdn.microsoft.com/en-us/library/windows/desktop/dd368038(v=vs.85).aspx

To do this,

 * Install LuaScript via the Plugin Manager (mine took many update-restarts because I'm naughty and never update Npp or the plugin manager)
 * Edit the LuaScript startup file in `Plugins > LuaScript > Edit Startup Script`

Add the following code:

	editor1.Technology = SC_TECHNOLOGY_DIRECTWRITE
	editor2.Technology = SC_TECHNOLOGY_DIRECTWRITE

To actually appreciate this effect, you should [install Fira Code][fira] (use either normal font or retina as those are the only ones that seem to work - 'light' etc do not).

 * Install the font as you usually do in Windows (unzip, select all, right click, Install)
 * Select the font in Npp via `Settings > Style Configurator > Global Styles > Global Override`
 * Select "Fira Code" for the font style and turn on `Enable global font`

You need to **Restart Notepad++** to see the benefits. To test, try typing `=>` which should turn into a cool arrow operator.
 
[fira]: https://github.com/tonsky/FiraCode#solution


## Emoji

Firstly, I have noticed that using the Touch Keyboard in Windows 10 to add Emoji into Notepad++ *does not work right*, it always yields a Rat and some other character (it varies). You need to copy and paste from a different source for Emoji to work right in Npp.

Make sure that your Encoding is **UTF-8**.

Enabling DirectWrite will immediately improve the display of emoji. One remaining hassle is that the encoding will keep reverting to ANSI when you open a file. One thing that can help with this (although it's not working great for me) is to turn off 'Autodetect character encoding':

 * Go to `Settings > Preferences > MISC`
 * Untick `Autodetect character encoding`

Apart from that, remember to check your encoding if your emoji look garbled! Emoji are Unicode characters, so you must use UTF-8!

Good luck, have fun! :)
