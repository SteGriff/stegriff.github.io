# Discovering Azure Resource Types

I was inspired by a post I found by Mitch Denny, called [Azure Resource Types][mitch] where he describes a programmatic process for uncovering every AZure resource type used in the Resource Template Gallery. I wanted to repeat his work because it was done almost exactly 3 years ago and is a pretty short and outdated list, but the program he used was not available.

So I took the opportunity to learn a bit more PowerShell, and I built a script to do what Mitch did. It takes advantage of the fact that the gallery is now backed by an enormous GitHub repository. So here's how to do it!

[mitch]: http://mitchdenny.com/known-azure-resource-types/

## Clone the GitHub repo of templates

You need to have Git installed. Open Git bash in your favourite code directory, and try this:

	$ git clone --depth 1 --branch master https://github.com/azure/azure-quickstart-templates
	
I have **intentionally added a depth and branch limit** because this is a very big repository! About 5300 objects at 70MB for just the lastest revision!

## Run the PowerShell

Here's my PowerShell script - I use the PowerShell ISE to run it, but do whatever you're used to. Read the code comments for an explanation of what is going on:

<script src="https://gist.github.com/SteGriff/2d5e53b8c52acb65cc0d37768d4483de.js"></script>
	
### To run it yourself

You need to set the `$directory` variable to the location of your cloned azure-quickstart-templates repository, then execute the script.

## Output

This is my resulting list from 2017-11-06 ([GitHub Gist][resultsgist])

	Microsoft.ApiManagement/service
	Microsoft.ApiManagement/service/providers/diagnosticSettings
	Microsoft.Authorization/roleAssignments
	Microsoft.Automation/automationAccounts
	Microsoft.Automation/automationAccounts/modules
	Microsoft.Automation/automationAccounts/runbooks
	Microsoft.Backup/BackupVault
	Microsoft.Backup/BackupVault/registeredContainers/protectedItems
	Microsoft.Batch/batchAccounts
	Microsoft.Cache/Redis
	Microsoft.Cdn/profiles
	Microsoft.Cdn/profiles/endpoints
	Microsoft.CertificateRegistration/certificateOrders
	Microsoft.CertificateRegistration/certificateOrders/certificates
	Microsoft.CognitiveServices/accounts
	Microsoft.Compute/availabilitySets
	Microsoft.Compute/disks
	Microsoft.Compute/images
	Microsoft.Compute/virtualMachines
	Microsoft.Compute/virtualMachines/extensions
	Microsoft.Compute/virtualMachines/providers/roleAssignments
	Microsoft.Compute/virtualMachineScaleSets
	Microsoft.ContainerInstance/containerGroups
	Microsoft.ContainerRegistry/registries
	Microsoft.ContainerService/containerServices
	Microsoft.DataFactory/datafactories
	Microsoft.DataFactory/dataFactories/gateways
	Microsoft.DataFactory/factories
	Microsoft.DataLakeAnalytics/accounts
	Microsoft.DataLakeStore/accounts
	Microsoft.DBforMySQL/servers
	Microsoft.DBforPostgreSQL/servers
	Microsoft.Devices/iotHubs
	Microsoft.Devices/iotHubs/eventhubEndpoints/ConsumerGroups
	Microsoft.DevTestLab/labs
	Microsoft.DocumentDB/databaseAccounts
	Microsoft.DomainRegistration/domains/domainOwnershipIdentifiers
	Microsoft.EventHub/namespaces
	Microsoft.HDInsight/clusters
	Microsoft.HDInsight/clusters/applications
	Microsoft.Insights/actionGroups
	Microsoft.Insights/activityLogAlerts
	microsoft.insights/alertrules
	Microsoft.Insights/autoscaleSettings
	Microsoft.Insights/components
	microsoft.insights/webtests
	Microsoft.KeyVault/vaults
	Microsoft.KeyVault/vaults/secrets
	Microsoft.Logic/integrationAccounts
	Microsoft.Logic/integrationAccounts/agreements
	Microsoft.Logic/integrationAccounts/maps
	Microsoft.Logic/integrationAccounts/partners
	Microsoft.Logic/integrationAccounts/schemas
	Microsoft.Logic/workflows
	Microsoft.Media/mediaServices
	Microsoft.Network/applicationGateways
	Microsoft.Network/connections
	Microsoft.Network/dnszones
	Microsoft.Network/dnszones/a
	Microsoft.Network/expressRouteCircuits
	Microsoft.Network/loadBalancers
	Microsoft.Network/loadBalancers/inboundNatRules
	Microsoft.Network/localNetworkGateways
	Microsoft.Network/networkInterfaces
	Microsoft.Network/networkSecurityGroups
	Microsoft.Network/publicIPAddresses
	Microsoft.Network/routeTables
	Microsoft.Network/trafficManagerProfiles
	Microsoft.Network/trafficManagerProfiles/azureEndpoints
	Microsoft.Network/virtualNetworkGateways
	Microsoft.Network/virtualNetworks
	Microsoft.Network/virtualNetworks/subnets
	Microsoft.Network/virtualNetworks/virtualNetworkPeerings
	Microsoft.NotificationHubs/namespaces
	Microsoft.NotificationHubs/namespaces/notificationHubs
	Microsoft.OperationalInsights/workspaces
	Microsoft.OperationalInsights/workspaces/savedSearches
	Microsoft.OperationalInsights/workspaces/savedSearches/schedules
	Microsoft.OperationalInsights/workspaces/savedSearches/schedules/actions
	Microsoft.OperationalInsights/workspaces/views
	Microsoft.OperationsManagement/solutions
	Microsoft.PowerBI/workspaceCollections
	Microsoft.RecoveryServices/vaults
	Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems
	Microsoft.RecoveryServices/vaults/backupPolicies
	Microsoft.Relay/Namespaces
	Microsoft.Resources/deployments
	Microsoft.Scheduler/jobCollections
	Microsoft.Search/searchServices
	Microsoft.ServiceBus/namespaces
	Microsoft.ServiceBus/namespaces/authorizationRules
	Microsoft.ServiceBus/namespaces/topics
	Microsoft.ServiceBus/namespaces/topics/subscriptions
	Microsoft.ServiceFabric/clusters
	Microsoft.Sql/servers
	Microsoft.Sql/servers/databases
	Microsoft.Sql/servers/elasticpools
	Microsoft.Sql/servers/firewallrules
	Microsoft.Storage/storageAccounts
	Microsoft.StreamAnalytics/StreamingJobs
	microsoft.visualstudio/account
	Microsoft.Web/certificates
	Microsoft.Web/connections
	Microsoft.Web/hostingEnvironments
	Microsoft.Web/serverFarms
	Microsoft.Web/sites
	Microsoft.Web/sites/domainOwnershipIdentifiers
	Microsoft.Web/sites/functions
	Microsoft.Web/sites/hostnameBindings
	Microsoft.Web/sites/publicCertificates
	SuccessBricks.ClearDB/databases
	
## Contributing

The PowerShell and Results are posted as GitHub gists:

 * [Get-Azure-Resource-Types.ps1][scriptgist]
 * [ResourceTypes-2017-11-06.txt][resultsgist]

Please feel free to comment and contribute on GitHub.
 
[scriptgist]: https://gist.github.com/SteGriff/2d5e53b8c52acb65cc0d37768d4483de
[resultsgist]: https://gist.github.com/SteGriff/e66fefe9f16356db1e884deaf97ac076