# Failure to cast an object from Azure TableOperation.Retrieve

If you use `TableOperation.Retrieve` in the Azure Table API, you might struggle to cast the result object into your preferred `TableEntity` type. In my experience, this is because of the `selectColumns` which you specified (or forgot to specify) in the Retrieve operation. Here's some failing code:

	// Make a retrieve operation with no selectColumns argument and run it
	var retrieve = TableOperation.Retrieve<MyEntity>(partitionKey, rowKey);
	var returnedObject = await cloudTable.ExecuteAsync(retrieve).Result
	
	// This cast fails
	var myThing = (MyEntity)returnedObject;

As best as I can tell, this is because the returned object lacks fields which should be present in your type. If `MyEntity` has a `string Name` field, the cast fails, because the `Retrieve` operation did not get a `Name` column in the results. [The docs][docs] are a little light on info.

The fix for this is pretty easy. Amending the code from above:

	// Define the additional columns we want, and pass them into Retrieve
	var columns = new List<string>(){ "Name", "Status" };
	var retrieve = TableOperation.Retrieve<MyEntity>(partitionKey, rowKey, columns);
	var returnedObject = await cloudTable.ExecuteAsync(retrieve).Result
	
	// The cast succeeds
	var myThing = (MyEntity)returnedObject;

Now that we are fetching all of the necessary fields, the cast works ok. To stay DRY, I recommend that in each of your `TableEntity` classes, you implement something like:

	public static List<string> Columns = new List<string>() { "Name", "Status" };
	
...and then, in your retrieve call, use that static Columns definition:

	TableOperation.Retrieve<MyEntity>(partitionKey, rowKey, MyEntity.Columns);
	
Looking at the [source code for the TableOperation][source] class (start at line 442, the method 'GenerateQueryBuilder'), we can see that you don't have to specify PartitionKey, RowKey, and the like, because the framework will always fill those in for you.

[docs]: https://docs.microsoft.com/en-us/dotnet/api/microsoft.windowsazure.storage.table.tableoperation.retrieve
[source]: https://github.com/Azure/azure-storage-net/blob/master/Lib/Common/Table/TableOperation.Common.cs