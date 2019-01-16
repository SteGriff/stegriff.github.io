# New-AzureStorageQueue : No queue endpoint configured

![Comparison of portal views of LRS and ZRS storage accounts](./posts/new-azurestoragequeue/comparison.png)

If you create an Azure Storage Account with a replication setting of ZRS (Zone Redundant Storage) then you will not have access to Queues or Tables; only Blobs.

Here is an example of a failing PowerShell:

	# Failing test of ZRS
	$storage = New-AzureRmStorageAccount `
		-Location 'northeurope' `
		-Name 'zrstestfail' `
		-ResourceGroupName 'some-group' `
		-SkuName Standard_ZRS

	# Inspect the context and you'll see that TableEndPoint and QueueEndPoint are empty
	$storage.Context
	
	# Try to create a queue and it will fail
	New-AzureStorageQueue -Context $storage.Context -Name 'test-queue' 

The resulting error message is:

	New-AzureStorageQueue : No queue endpoint configured.
	At line:2 char:1
	+ New-AzureStorageQueue -Context $storage.Context -Name 'test-queue'
	+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		+ CategoryInfo          : NotSpecified: (:) [New-AzureStorageQueue], InvalidOperationException
		+ FullyQualifiedErrorId : System.InvalidOperationException,Microsoft.WindowsAzure.Commands.Storage.Queue.NewAzureStorageQueueCommand

## Deducing the solution

When I logged into the portal, I noticed that the storage account didn't have the 'Services' panels for Blobs, Files, Tables, and Queues which I expected to see. This tipped me off so I tried varying the region and the service level until they appeared.

## Solution

Use a lower tier (LRS) or a higher tier (GRS). Since you were shooting for some redundant replication, you probably should shoot higher (i.e. GRS) rather than lower. Again, you cannot use ZRS if you want queues, tables, or SMB file shares.