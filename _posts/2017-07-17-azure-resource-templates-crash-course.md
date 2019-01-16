# Azure Resource Templates - Crash Course

Azure resource templates are a declarative JSON file which describes a load of resources which you want to create on an Azure subscription. They are generally triggered through PowerShell. If you haven't used Azure PowerShell before, follow the first two points from this simple MS tutorial on [Getting started with Azure PowerShell][get-started].


## How do I get a template?

 1. As they're just JSON files, you could craft one from scratch. I don't recommend it!

 2. There is a [huge gallery of Azure QuickStart Templates][gallery] which you can fire up through this special section of the Azure site.
 
 3. The templates from above are actually drawn from the [library of Azure QuickStart Templates on GitHub][azure-quickstart], so you can download them from there and tweak for your use case.
 
 4. Export a template from an existing online resource group. This is as easy as `Export-AzureRmResourceGroup -ResourceGroupName beaconlanguages`

[get-started]: https://docs.microsoft.com/en-us/powershell/azure/get-started-azureps?view=azurermps-4.1.0
[gallery]: https://azure.microsoft.com/en-us/resources/templates/
[azure-quickstart]: https://github.com/Azure/azure-quickstart-templates


## How do I run a template?

Log into the Azure account where you want to run the template. If that's a different account to the one you're currently signed in as, use `Login-AzureRmAccount` again.

To see who you're currently logged in as, use `Get-AzureRmContext`

Run a template with `New-AzureRmResourceGroupDeployment`:

	New-AzureRmResourceGroupDeployment
		-ResourceGroupName ExampleGroup
		-TemplateFile C:\Users\exampleuser\ExampleGroup.json
		-storageAccountType Standard_LRS

At the top of your JSON file are a load of parameters which you can define, like:

	"parameters": {
		"storageAccountType": {
		  "type": "string",
		  "defaultValue": "Standard_LRS",
		  "allowedValues": [
			"Standard_LRS",
			"Standard_GRS",
			"Standard_ZRS",
			"Premium_LRS"
			...

...each of these can be set as a runtime parameter to the `New-AzureRmResourceGroupDeployment` command. So in the PowerShell example above we set the `storageAccountType` parameter to `Standard_LRS`. This value is found in the list of allowedValues, so it's valid. Otherwise, the template deployment would fail with an error message. Handy validation! If you don't set a value, the `defaultValue` is used.

## How do I tune an exported template?

There are some hints about [customizing an exported template][customize] on this MS tutorial.

**\[WIP\]**: I intend to come back to this article and extend it :)

*Written 2017-07-12*

[customize]: https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-export-template-powershell#customize-exported-template