# Windows App Certification Kit - cannot install package because a different package with the same name is already installed

When running the 'Windows App Ceritification Kit', you get an error message like this:

	Windows cannot install package 780a2c2f-f4be-4a7d-83bf-212522026da9_1.0.0.0_neutral_~_m56gs6vrxbyza because a different package 
	780a2c2f-f4be-4a7d-83bf-212522026da9_1.0.0.0_x64__gf73qhakswkrp with the same name is already installed. Remove package 
	780a2c2f-f4be-4a7d-83bf-212522026da9_1.0.0.0_x64__gf73qhakswkrp before installing.
 
...and you might not know how to find the full internal list of installed UAP apps or to remove them. For me, the app in question did not show up in Apps and Features.

## How to fix it

Open PowerShell as Admin (`Win`+`X`, `A`)

Run this `Get-AppxPackage` command, replacing the `780a2c2f` with part of the name from your error message:

	Get-AppxPackage | Where {$_.PackageFullName.Contains("780a2c2f")} | Select Name, PackageFullName
	
This should bring up the offending package:

	Name                                 PackageFullName
	----                                 ---------------
	780a2c2f-f4be-4a7d-83bf-212522026da9 780a2c2f-f4be-4a7d-83bf-212522026da9_1.0.0.0_x64__gf73qhakswkrp
	
Now run `Remove-AppxPackage` on the `PackageFullName` you have identified:

	Remove-AppxPackage 780a2c2f-f4be-4a7d-83bf-212522026da9_1.0.0.0_x64__gf73qhakswkrp
	
A blue progress message will pop over the top of your PowerShell session, then it will go away and the prompt will appear to show you that the process has finished.

You can now run Windows App Ceritification Kit again, hopefully with more luck :)
