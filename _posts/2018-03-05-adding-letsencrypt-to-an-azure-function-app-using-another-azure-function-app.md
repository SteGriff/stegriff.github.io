# Adding LetsEncrypt to an Azure Function App using another Azure Function App

Using Let's Encrypt has always seemed a bit daunting but I finally bit the bullet and tried it out in Azure. A guy called Simon J.K Pederson has written some awesome turnkey extensions (Kudu stuff) for grabbing LE certificates on Azure Web Apps. These can be made to work with Function Apps as well. 

This article is a quick ref guide for myself more than anything, but maybe it can help you too.

## Key points

To configure this, you need to:

 1. Create an AAD application and give it Contributor permission in the IAM for the subscription, resource group, or resource which you want it to work on
 2. Make a new Function App specifically for managing Let's Encrypt certs, let's call it your **CertFetcher**, and install the 'Azure Let's Encrypt (No Web Jobs)' Kudu extension (by sjkp) on it
 3. Follow [sjkp's guide to configuring the extension][sjkp]
 4. Configure a new Function in your **target** app (the one you're securing, not your CertFetcher) to allow LetsEncrypt to ping back to your `.well-known/acme-challenge` directory, as shown in the [Azure Functions support for the Let's Encrypt extension][allow-acme].
 
[sjkp]: http://wp.sjkp.dk/lets-encrypt-on-azure-web-apps-using-a-function-app-for-automated-renewal/
[allow-acme]: https://github.com/sjkp/letsencrypt-siteextension/wiki/Azure-Functions-Support

## Filling in the fields of sjkp's CertFetcher function:

The details from the publish profile for the *CertFetcher itself* go in here (the first set, not the FTP set):

	var userName = "$YOUR-PUBLISHING-CREDENTIAL-USER";
	var userPWD = "YOUR-PUBLISHING-CREDENTIAL-PASSWORD";

The `AzureEnvironment` config holds mostly information about *how to authenticate to make changes to the Target app*. This involves global info like your sub and tenant IDs, and the credentials needed by your AAD app which is authorised to make changes to the sub/resource group/resource.

			AzureEnvironment = new {
				WebAppName = "mysite", // The app name of your Target web app 
				ClientId = "0fe33f98-e1cd-47ad-80c1-f8578fe3cfc8", //The GUID of your AAD app
				ClientSecret = "YOUR-CLIENT-SECRET", //The 'key' from your AAD app
				ResourceGroupName = "mysite", //Resource group of your Target web app 
				SubscriptionId = "14fe4c66-c75a-4323-881b-ea53c1d86a9d", //Your subscription ID
				Tenant = "f386b536-faf3-4000-adec-1f6d78dbf0bf", //Azure AD tenant ID 
				},
				
The `AcmeConfig` holds details you want to send to LetsEncrypt to generate your cert.

			AcmeConfig = new {
				RegistrationEmail = "myrealaddress@myrealemail.example", //Your real email address
				Host = "mysite.co.uk", // The URL you want to verify for https
				AlternateNames =  new string[
				]{},
				RSAKeyLength = 2048,
				PFXPassword = "pass@word1", //Replace with your own 
				UseProduction = false //Replace with true if you want production certificate from Lets Encrypt 
			}

