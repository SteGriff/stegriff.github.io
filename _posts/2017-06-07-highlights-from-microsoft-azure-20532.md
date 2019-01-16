# Highlights from Microsoft Azure 20532

Maybe you read my previous post about [taking the Azure 20532 course with QA][qa]. Here are my highlights from the course:

[qa]: ./developing-azure-solutions-course-20532-at-qa

## 1. Web+SQL

Using the Web+SQL template, you can deploy a web app and Azure SQL database together which have an affinity for each other. This means that when you generate a publish profile and use it in Visual Studio, it knows to automatically use the connection string of the sibling database, making deployment really easy. I wonder how this would work when called from CI like Jenkins?
 
## 2. Storage Storage Storage

I've always wondered about Azure storage - blobs and stuff - what do they do, what are they for? It turns out that despite the name, blob storage stores *files*, and it does it very cheaply and effectively.

By cheap, I mean that at the most basic redundancy level (files stored on three racks in one datacenter) the cost is just £0.02/GB/month! Yes, 2p!! Even better, when you GET from blob storage, the files are served up with the correct `Content-Type` header, which means you can host static web pages in here and it functions as a website! This is an insanely cheap way to host a static site, second only to GitHub pages. Even if you opt for RA-GRS (which is two geo-seprated copies, one of which is Read Access only [n.b. this makes it blisteringly fast]) the cost is still just £0.06/GB/mo. With traditional hosts, a static site hosting like this costs £2/mo, and as an Azure web app with a custom domain, it would cost yet more than that.

All four types of Storage have a built-in REST API, so you can GET/PUT/DELETE. This is going to be such a time saver; no more writing `UploadController` type things in their own MVC site just to get file management.

There are lots of types of blob suited to different purposes. Page blobs for example are optimised for random-read-write... yes, like RAM. As a result, all Virtual Machine disks are implemented in Azure as Page Blobs. 

Blobs can be presented as additional disks to your Azure Virtual Machines. This is neat beacuse your files aren't tied to the machine, so you can easily unmount it from one VM and attach it to another the next minute. Portable!

**Table storage** is Azure's NoSQL offering. It stores arbitrarily-shaped JSON objects in a key-value store which can be looked up lightning fast because it's one big hash table. Miles cheaper than SQL and better suited to the job if you need to capture unpredictably-shaped data.

**Queue storage** was another revelation. This is what I like to call a 'wibbly wobbly' queue - you can add files or segments of up to 64KB onto the back (or at an arbitrary position in the queue[!?]) and then peek, process, or modify(!?) the queued items. This is great for scaling, because you can have *x* clients writing to the queue, and *y* processes reading it, where *y* can be scaled up if the queue is getting a little long. Microservices!

Queue storage has a neat trick where an item is locked for 30 seconds (configurable) when read. If the reading process 
succeeds, it can delete the item. But if the item is still in the queue after the lock period (perhaps because its reader has died) then another reader instance can pick it up. Redundancy! Availability!

Lastly, all of the above have a simple SDK to use in Visual Studio. It's as easy as popping into Package Manager Console with:

	Install-Package WindowsAzure.Storage
	
...and Microsoft have packed their [Azure-Samples][azuresamples] account on GitHub with tons of demos, like [getting started with Blob storage][startblob]. I myself wrote a nifty [introductory demo of Storage Queues][sgq]

[azuresamples]: https://github.com/Azure-Samples/
[startblob]: https://github.com/Azure-Samples/storage-blob-dotnet-getting-started/
[sgq]: https://github.com/SteGriff/StorageQueueDemo/


## 3. Service Bus

Honestly this topic was not covered in enough detail on the course, but I have a prior and continuing interest in it! The ServiceBus is the non-wobbly queue, because it:

 * Guarantees FIFO (first in, first out - you can't insert into the middle and you can't reorder items)
 * Guarantees single read of items in a more strict way than the storage queue
 
So you can use it for more critical, proper real-timey things.

Like most other message queue packages, the bus has exchanges that let you multiplex messages from and to a number of disparate endpoints. 

## 4. Xplat CLI

Azure Powershell commands are obtuse. They're an exercise in memory and [Ducking][ddg]. Wouldn't it make so much more sense if there were a cross-platform CLI that worked just like the familiar Unixy tools we use for everything else, like git?

Well, jump for joy cause the *Azure Cross-platform Command Line Tools* ("Xplat" to their friends) are exactly that:

	$ azure group create --name NewResourceGroup --location "North Europe"
	$ azure resource create --name NewBlogWebAppTest --resource-type "Microsoft.Web/Sites" --api-version "2014-06-01" --location "North Europe" --resource-group NewResourceGroup
	$ azure resource list --resource-group NewResourceGroup
	
And anytime you get stuck, it gives you great help text so you don't need to learn the commands off-by-heart!

[ddg]: https://duckduckgo.com


## Conclusion

There's definitely more stuff I've missed out - this was a really exciting course with loads of content. If you want to chat about any of this stuff, please engage with me on [twitter @SteGriff][tw] or [GitHub/SteGriff][gh]. Thanks!

[tw]: https://twitter.com/stegriff
[gh]: https://github.com/stegriff
