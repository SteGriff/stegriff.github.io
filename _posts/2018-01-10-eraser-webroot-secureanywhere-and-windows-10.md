# Eraser, Webroot SecureAnywhere, and Windows 10

Nasty, unintended interactions between software packages are the worst thing about software. Here's one for the list!

**The short version:** On Windows 10 Fall Creators Update, Webroot SecureAnywhere will lock files when they are modified or when deletion is attempted. There is a [report][webroot] for this on the Webroot site.

[webroot]: https://community.webroot.com/t5/Product-Releases/Windows-10-Fall-Creator-Update-Bug-Fix/m-p/305469/highlight/true#M453

## The problem

I worked with some very secure laptops which, as well as being BitLocker'd, must have each project wiped off with a secure overwrite when the project is finished with. We use Eraser from <https://eraser.heidi.ie/> for this, countering 'data remanance'.

After a recent update to Windows 10 Fall Creators Update on these machines, all our Eraser tasks were aborting with errors.

The files and folders under the directory to be deleted now had garbled names like '[,agihn' or just 'H' (this is something Eraser does while in progress) and none of these files/folders could be processed. Furthermore, the folders could not be opened in Explorer, either as the folder owner, an Admin user, or even the Windows 'Administrator' account (enabled with `net user Administrator [new password] /active:yes`).

No user on the whole machine could open or delete this directories, it always said "Access Denied". Helpful people on StackExchange suggested opening the Security properties of the dirs and tweaking a few things to allow access, but the buttons to do this were completely shut off to me.

## The first workaround

The first, most obvious fix for the problem was to turn the PC off and on again. The Eraser job could now progress further and it usually finished. The next Eraser job to start would fail, but this chain of restarting and rerunning could be employed to securely delete as much stuff as you want (with the annoying slowdown of repeated reboots).

So this now appeared to be a file locking problem. We used [Microsoft's Process Monitor][procmon] to search for handles on the files in question, and found that `WRSA.exe` was locking all of them.

[procmon]:https://docs.microsoft.com/en-us/sysinternals/downloads/procmon

## The solution

There is a patched version of WSA which corrects this bug, but it must be applied manually to the affected machines.

Alteratively, you can look for a tool to release file handles on the files you want to delete. I could not acheive this with Procmon because it kept crashing when I asked it to inspect the list of files held by `WRSA.exe` - great...

If you have the admin rights over the WSA estate, you can relax the "Shield" on "Check files for threats when written or modified" as [described by webroot support][webroot].

Hope this helps!