# Select items from a LINQ grouping based on multiple criteria

## The data

Say you have a collection of Ships Logs.

	var logs = new List<Log>()
	{
		new Log(){ Id = 1, ShipId = 1, Message = null, CreatedDate = today.AddMinutes(-4)},
		new Log(){ Id = 2, ShipId = 1, Message = "Ready", CreatedDate = today.AddMinutes(-3)}, //Most recent with message for Ship 1
		new Log(){ Id = 3, ShipId = 1, Message = null, CreatedDate = today.AddMinutes(-2)},
		new Log(){ Id = 4, ShipId = 1, Message = null, CreatedDate = today.AddMinutes(-1)}, //Most recent for Ship 1
		
		new Log(){ Id = 5, ShipId = 2, Message = "Ready", CreatedDate = today.AddMinutes(-4)},
		new Log(){ Id = 6, ShipId = 2, Message = "Ready", CreatedDate = today.AddMinutes(-3)}, //Most recent with message for Ship 2
		new Log(){ Id = 7, ShipId = 2, Message = null, CreatedDate = today.AddMinutes(-2)},
		new Log(){ Id = 8, ShipId = 2, Message = null, CreatedDate = today.AddMinutes(-1)}, //Most recent for Ship 2
	};

## Easy things

If you want to get the latest log ID for each ship, that's really easy with LINQ

	//Method syntax style
	List<int> latestShipLogIds = logs
		.GroupBy(sl => sl.ShipId)
		.Select(g => g.Max(sl => sl.Id))
		.ToList();

	//Query syntax style
	IEnumerable<int> latestShipLogIds2 =
		from log in logs
		group log by log.ShipId into groupedLogs
		select groupedLogs.Max(g => g.Id);

This will return a `List<int> = {4, 8}`.

Likewise, if I wanted to find all the logs for each ship which have a non-null message:

	List<int> logsWithMessages = logs
		.GroupBy(sl => sl.ShipId)
		.SelectMany(g => g
			.Where(sl => sl.Message != null)
			.Select(sl=>sl.Id)
			)
		.ToList();
		
That will give me `{2, 5, 6}`, which is fine.

## Tricky things

Now what if I want to get a list with the IDs of:

 * The latest log for each ship
 * All logs with a message

If I want them grouped, I can do:

	from log in logs
	group log by log.ShipId into groupedLogs
	select from glog in groupedLogs
	where glog.Id == groupedLogs.Max(sl => sl.Id) || glog.Message != null
	select glog.Id;
	
And if I don't want them grouped, I just drop the `select` on the 3rd line there.

What if I want:

 * The latest log for each ship
 * The latest log with a message for each ship
 
Such that for each ship, I will have exactly zero, one, or two logs?

I can use separate queries and merge their results, definitely, but that's not a very nice solution and it might mean two hits to the database in a live environment. But this makes me think I must be able to join the collection on itself to acheive the same result. After playing with it for a while, I'm stuck, so the best idea I have is to `union` the queries before they are reified with `.ToList()`:

	var query1 = logs.Where(log => log.Message != null)
		.GroupBy(log => log.ShipId)
		.Select(group => group.Max(log => log.Id));

	var query2 = logs
		.GroupBy(log => log.ShipId)
		.Select(group => group.Max(log => log.Id));

	var results = query1.Union(query2);

Or more simply:

	var results = logs.Where(log => log.Message != null)
		.GroupBy(log => log.ShipId)
		.Select(group => group.Max(log => log.Id))
		.Union(
			logs
				.GroupBy(log => log.ShipId)
				.Select(group => group.Max(log => log.Id))
		);

So in a way, that is a single query, but something about it still feels wrong! I'll let you know!