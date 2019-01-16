# Tail a file in Powershell

I had to split down a 42 billion line log file. To get the last `n` lines of a file using PowerShell, like Linux' `tail` program does:

	Get-Content .\file.log -Tail 470000 > output.txt
	
