# Solve problems with using Office 365 SMTP in an Azure Web/Function App

Office 365 uses an SMTP server like any other, but we got snagged on some weird gotchas for a long time, so here's a blog post.

The turnkey solution for mail in Azure is SendGrid, but in some scenarios you need the increased privacy of using your own privately-controlled outgoing mail service. Using Office 365 SMTP details to send mail from an Azure web mail should be very straightforward.

There is an [MS blog post on sending mail using O365 SMTP here][perkins], which is roughly where we started. In short, use `smtp.office365.com`, port 587, use SSL, use an authenticated O365 account. However, lots of things went wrong for me. Here are the problems and their solutions:

[perkins]: https://blogs.msdn.microsoft.com/benjaminperkins/2017/01/11/sending-email-from-an-azure-web-app-using-an-o365-smtp-server/

## 1. 'From' address doesn't match credentials

The 'from' address which you set on your outgoing email message *must match* the authenticated credential of the mailbox you are using. That's just the way it is!

So in code, that looks like this:

	//Use the same 'from' address for NetworkCredential and MailMessage:
	const string from = "my.sender@contoso.com"
	var credentials = new NetworkCredential(from, "password");
	var mailMessage = new MailMessage(from, "to.person@example.com")

Symptom:

	5.7.1 Client does not have permissions to send as this sender


## 2. Account credentials getting mangled

 * Is your password being loaded from web.config?
 * If so, does your password have XML-encoded characters in it?
 
Change the account password to use only plain characters (uppercase, lowercase, numbers, and dash and underscore if you want). This is more paranoia that solid solution but I definitely don't trust this situation. Eliminate this as a source of doubt.

To change the password, you can log in to <https://portal.office.com> using the mail credentials, and use the `Settings -> Change Password` feature like any human user would.


## 3. Outgoing account not allowed to send mail

If the account you setup as the authenticated mail sender does not have any licenses assigned, then it doesn't have a mailbox, and is therefore not allowed to send mail. You need to assign it an Office 365 license to give it access to web Outlook (and the ability to send mail).

Symptom:

	System.Net.Mail.SmtpException: The SMTP server requires a secure connection or the client was not authenticated. The server response was: 5.7.57 SMTP; Client was not authenticated to send anonymous mail during MAIL FROM [______.eurprd07.prod.outlook.com]


## Conclusion

I hope one of these tips saves your day!