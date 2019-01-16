# Intellisense in SSMS doesn't work any more

In my last job Intellisense stopped working in SSMS and I just lived with it for years. When I came to a new office, it worked for a while, and then stopped one day. But it's so much extra typing, I decided to try to fix it.

Here are the culprits, in order of ease-to-fix, ending with what I had to do :)

1. Enable Intellisense (`Query -> Intellisense Enabled`)
2. Turn off SQLCMD mode (`Query -> SQLCMD Mode`)
3. Refresh the Intellisense cache (`Ctrl+Shift+R`)
4. Check settings are alright in `Tools -> Options -> Text Editor -> Transact-SQL -> Intellisense`
5. If you are working with a particularly big script file, increase the Max file size in the settings above
6. **Install or reinstall the latest Service Pack for SQL Server**

## Service Packs

It turns out that Intellisense stopped working for me in both instances because I had reinstalled/repaired Visual Studio. 

I didn't have full-blown SQL Server on my last PC, so I don't know how installing a SQL Server Service Pack would help. Maybe all you really need to patch is SSMS (which has [a standalone installer][ssms]).

Here I am on SQL Server 2008 R2, so the latest service pack is [Service Pack 3][sp3].

Hope it helps!

Sources: [IntelliSense not working but it is enabled][1], [IntelliSense is not working at SQL Server Management Studio][2]

[1]: https://dba.stackexchange.com/questions/6145/intellisense-not-working-but-it-is-enabled
[2]: https://stackoverflow.com/questions/31580885/intellisense-is-not-working-at-sql-server-management-studio
[ssms]: https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-2017
[sp3]: https://www.microsoft.com/en-us/download/confirmation.aspx?id=44271
