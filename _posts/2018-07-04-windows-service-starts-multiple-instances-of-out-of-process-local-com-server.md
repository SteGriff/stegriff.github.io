# Windows Service starts multiple instances of out-of-process local COM Server

Here is a problem I can't solve. I have a 32-bit client application which calls in to a third party out-of-process COM server (also 32-bit). My client application is a C# app built on Topshelf, so it can run either as a command line app or as a Windows Service.

 * When I run my client application as an exe, as the same user as the COM Server, it connects fine.
 * When I run my client as a Windows Service, even if I specify RunAs options to make it use the same user as the COM Server, **a new instance of the COM Server exe is started**.
 
Because of the implementation details of the COM Server, this means that I can't use it with my Windows Service, because it detects a licensing violation (single instance only) and refuses to run.

A number of other people have spotted this behaviour where Windows Services in particular cause COM-serving apps to start additional instances:

 * [A comment on this Larry Osterman blog post about COM activiation](https://blogs.msdn.microsoft.com/larryosterman/2004/10/12/how-does-com-activation-work-anyway/#comment-18991)
 * [This StackOverflow question](https://stackoverflow.com/questions/5101843/does-com-activation-of-localserver32-exe-from-the-same-user-account-share-an-exi) (and plenty of others)
 
## Things I've tried:

 * Running as same user
 * Ensuring same architecture (both server and client are x86)
 * Trying different CLSCTX options, like `CLSCTX_ENABLE_AAA` and `CLSCTX_DISABLE_AAA` (combined as flags with `CLSCTX_LOCAL_SERVER`)
 
I have no solution, so if you have any ideas, please tweet me @SteGriff or email ste at this domain :)