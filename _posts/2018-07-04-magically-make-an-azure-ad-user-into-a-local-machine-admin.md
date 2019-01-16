# Magically make an Azure AD user into a local machine admin

If you have standard Azure AD, it's difficult to make a user into admin on their machine without making them a hardware/global admin across the whole Azure estate (which is not desirable). Through a chain of tricks, it's possible.

## Scenario

Imagine we're setting up a new PC for New Hire (`new.hire@contoso.com`) and you already have a global admin, Team Leader (`team.leader@contoso.com`). New Hire has logged into their PC and wants to install some software, but they're not an admin, so they can't. Here's what we're going to do:

## Steps

### 1. Use Team Leader to enable the secret Windows Administrator account

Open an admin command prompt (when asked for admin details, get `team.leader` to put in their creds). Run the command:

	net user administrator SomeGreatTemporaryPassword1234 /active:yes
	
Now **sign out** from New Hire on Windows (switching user is not enough)

### 2. Use Administrator to make New Hire an admin

Log in as Administrator using the credentials you just created. Open an admin command prompt (doesn't prompt for credentials this time because you're already an admin) and run:

	net localgroup administrators AzureAD\NewHire /add
	
Yes, this is magic. If you ran `net users` prior to this you wouldn't see any `AzureAD`-type accounts. Not only that, but AAD accounts are *always always* referred to by their full email address, yet if you had instead tried `net localgroup administrators new.hire@contoso.com /add` it would have failed. 

### 3. Log back in as New Hire and test it

Sign out of 'Administrator', and sign back in as `new.hire@contoso.com`. To test your new admin rights, disable the Secret Administrator account by opening an admin command prompt (if this has worked, you will **not** be prompted for admin details):

	net user administrator /active:no
	
The New Hire is now a local machine admin without affecting their AAD priveleges (Office365, Azure, etc.) 
