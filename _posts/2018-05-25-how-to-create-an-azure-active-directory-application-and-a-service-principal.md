# How to create an Azure Active Directory Application and a Service Principal

You can use AAD Applications to add single-sign-on capabilities into your web app. Another use is to authenticate your own program code to call the Azure APIs, or to talk to Kudu (the source control and extension system which is installed in parallel with every Azure Web App)

I just came back to refer to an article I wrote a little while ago about [adding LetsEncrypt to an Azure Function app][adding-le], and I couldn't remember how to add a Service Principal, so I thought I'd expand the wiki-ness a little...

[adding-le]: ./adding-letsencrypt-to-an-azure-function-app-using-another-azure-function-app

## Create an Enterprise Application

![Adding your own application](./posts/how-to-create-an-azure-active-directory-application/add-application.png)

I'm going to tell you what to click on if you want to build muscle memory, but I've also left links for the lazy:

 * In your Azure Portal, go to [Azure Active Directory][aad] in the left nav, or by searching.
 * Navigate to [Enterprise Applications][ea]. Click '+ New Application' in the top controls.
 * Click 'Application you're developing' and then follow the link, "Take me to App Registrations to register my new application"
 * Another blade opens, click '+ New application registration'
 * Fill in a name, and pick the type from 'Native' or 'Web App'
 * If users will really sign into this app, consider the sign-on URL. If this is just a utility, enter some loosely related azurewebsites url in here
 
## After the app is created

The app is created and its new blade opens:

 * Copy the Application ID to a text editor
 * Click Settings
 * Click Keys
 * In the (empty) list of passwords, type into the decription field, something like 'default'
 * Set an expiry, and click Save
 * Copy the 'value' field which will now contain the new application secret
 
**Beware** - you must defend these new credentials (the combination of App ID and Secret) because they are functionally sign-in details for your Azure tenancy. Currently they don't have any permissions assigned, but after you add this app onto some resources or groups, they will be dangerous in the wrong hands. Store them encrypted.

These credentials can be used in the [Azure LetsEncrypt Extension][adding-le]. You can do other stuff with them too I guess.

[aad]: https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/Overview
[ea]: https://portal.azure.com/#blade/Microsoft_AAD_IAM/StartboardApplicationsMenuBlade/AllApps/menuId/
