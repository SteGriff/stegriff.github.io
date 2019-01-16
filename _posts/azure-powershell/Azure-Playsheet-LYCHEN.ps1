$login = Login-AzureRmAccount

# Test Where filters on local services
$svcs = Get-Service
$svcs | Where Name -like '*Adobe*'

# FInd out how to pipe things to Select-AzureRmSub
Get-Help Select-AzureRmSubscription -Parameter 'SubscriptionName'

# Yesterday I'm sure subs came back with a Name field, but today it's called SubscriptionName?
$subs = Get-AzureRmSubscription
$subs | Where Name -like '*MPN*' | Select @{n='SubscriptionName';e={$_.Name}} | Select-AzureRmSubscription
Get-AzureRmContext

# Simpler selection using old field names
$subs = Get-AzureRmSubscription
$subs | Where SubscriptionName -like '*MPN*' | Select-AzureRmSubscription
Get-AzureRmContext

$eur = 'North Europe'
$proj = 'paprika'
New-AzureRmResourceGroup -Name 'test' -Location $eur

Get-AzureRmResourceGroup -Name 'pap*'

# Register storage and create storage account
# Don't use ZRS if you want Queues or Tables
Register-AzureRmResourceProvider -ProviderNamespace 'Microsoft.Storage'
$properties = @{"AccountType"="Standard_LRS"}
New-AzureRmResource `
    -ResourceGroupName $proj `
    -Name ($proj + "stor2") `
    -ResourceType 'Microsoft.Storage/storageAccounts' `
    -Location $eur `
    -Properties $properties `
    -ApiVersion "2015-06-15" `
    -Force

# Or create storage account using this easier command
New-AzureRmStorageAccount `
	-Location $eur `
	-Name ($proj + "stor") `
	-ResourceGroupName $proj `
	-SkuName Standard_LRS
    
# Set our storage account, and check it
Set-AzureRmCurrentStorageAccount -ResourceGroupName $proj -Name ($proj + "storx1")
Get-AzureRmContext

# Make a container in our storage account (resource group was selected in command above)
New-AzureStorageContainer -Name 'files'

# Get our storage context and view it
$storage = Get-AzureRmStorageAccount -ResourceGroupName $proj -Name ($proj + "stor")
$storage.Context

# Make a queue (won't work on ZRS)
New-AzureStorageQueue -Context $storage.Context -Name 'test-queue' 

$key = Get-AzureRmStorageAccountKey -ResourceGroupName $proj -Name ($proj + "stor")
$key[0]

# Try to make a storage in East US - see if queues work

$eastus = 'East US'
New-AzureRmStorageAccount `
	-Location $eur `
	-Name ("sgtestnortheur") `
	-ResourceGroupName $proj `
	-SkuName Standard_LRS
    
$storage = Get-AzureRmStorageAccount -ResourceGroupName $proj -Name "sgtesteastusa"
$storage = Get-AzureRmStorageAccount -ResourceGroupName $proj -Name "sgtestnortheur"
New-AzureStorageQueue -Context $storage.Context -Name 'test-queue' 

<<<<<<< HEAD
#--------------------------------------
# Make an app service plan and website
# Microsoft.Web/serverFarms
# Microsoft.Web/sites

# Register namespace first
Register-AzureRmResourceProvider -ProviderNamespace 'Microsoft.Web'

#$sku = @{name='S1'; tier='Standard'; size='S1'; family='S'; capacity=1}
$sku = @{name='B1'; tier='Basic'; size='B1'; family='B'; capacity=1}
New-AzureRmResource `
    -ResourceGroupName $proj `
    -Name "$proj-plantest-2" `
    -ResourceType 'Microsoft.Web/serverFarms' `
    -Location $eur `
    -Sku $sku
    
New-AzureRmAppServicePlan `
    -Location $eur `
    -Tier Basic `
    -NumberofWorkers 1 `
    -WorkerSize Small `
    -ResourceGroupName $proj `
    -Name "$proj-plantest-3"

# New-AzureRmAppServicePlan
# New-AzureRmWebApp
=======
Get-AzureRmSubscription -SubscriptionId "8d6daea2-6038-4360-89a9-9944afa3ff6d" -TenantId "a1846dcc-61b9-448e-bfc6-ca63b9697a1f" |
    Select @{n='SubscriptionId';e={$_.Id}} |
    Set-AzureRmContext

Get-Help Set-AzureRmContext -Parameter SubscriptionId

# Failing test of ZRS
New-AzureRmStorageAccount `
	-Location $eur `
	-Name ($proj + "fail") `
	-ResourceGroupName $proj `
	-SkuName Standard_ZRS


$storage = Get-AzureRmStorageAccount -ResourceGroupName $proj -Name ($proj + "fail")

New-AzureStorageQueue -Context $storage.Context -Name 'test-queue' 
>>>>>>> 91e76d05bd6aa08f1c53babd9caa4bc6983f8910
