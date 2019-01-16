# Paprika For All

![New Paprika](./posts/paprika-for-all/new-paprika.png)

When I first made Paprika in 2015, I wanted to give everyone access to it. I am very excited to announce that from today, anyone can try Paprika with their own custom grammars, in their browser, for free, without even creating an account!

I hope that it's so simple to set up and use that it's irresistible. 

To get started, go to <https://paprika.me.uk>. It will create a temporary anonymous user account for you (which can be upgraded for free to a full account anytime), and then I recommend clicking on the shiny 'Tutorial!' button. It should all work on your phone/tablet but is probably best on a PC where you get a full keyboard experience 😊

## A quick cookbook

If you do try Paprika, please take the Tutorial first - it's dead simple. But after that, here's a quick cookbook of fun ideas and patterns I like to use.

### 1. Take your fave queries and make them into grammars

Any time you come up with a fun query that generates cool results, put it into your grammar under a "master" category like `* sentence`. This is how [Uncle Robot][uncle] works; he has a top level `* tweet` category that calls on all sorts of other grammars from around his files. So you could take all of the tutorial examples and put them like this:

	* sentence

	what a [cool] [colour] [animal]
	[animal]!! [animal] in [place]!!
	[colour#1] [animal#1], [colour#2] [animal#2]
	from [place#from] to [place#to]
	my [animal] [does] [[does] thing]
	[!thing][[thing]] is [a] [thing]
	Choose [a] [thing]. Choose [[thing]]
	[my/this] day [could/can't] get any [worse/better]
	[/so, ]how about [those/them] [apples/oranges][, huh/, eh/]?

Now the great thing about this is that you can make a request for `[sentence#1]! [sentence#2]!` and get some really quirky results.

[uncle]: ./building-uncle-robot

### 2. Use nesting for context

I alluded to this in the tutorial with `[[thing]]` but you can extend the idea to make really smart monologues really easily. Start with something simple:

	* observation
	this old guy keeps [talking/going on] about [old guy topic]
	
	* old guy topic
	teeth
	the war
	his trains
	mussolini
	
Now what can we vary? Well, what if we want more than just an 'old guy'?

	* observation
	this [person] keeps [talking/going on] about [[person] topic]
	
	* person
	old guy
	baby
	
	* old guy topic
	teeth
	the war
	his trains
	mussolini
	
	* baby topic
	blankie
	how great he is for walking, like [2/3] steps
	potty
	
You can add loads of different people types under the `* person` tag, as long as you create a `____ topic` category for each of them. This is my personal favourite feature in Paprika.

Just remember, if you want to put the nested tags first in the query, you need to do a hidden tag call with `[!person]`

### 3. Slash every word

To make really natural non-sequiturs, vary every word you possibly can. Use slashes for this:

	* this sentence
	[/if you want ]to [make/write] [really/truly/very] [natural/realistic] [non-sequiturs/monologues/tweets], [/you should /you can ][vary/switch up/change] every word you [/possibly ]can.
	
Notice how fully optional parts of the sentence need their space within the brackets and then push right up to the next word. That stops you from having lots of double-spaces.

This technique is handy in a tweet bot because it makes the output less same-y.

### 4. Recursion

If you've not encountered recursion before, let me just explain by saying that to understand recursion, you should re-read this sentence.

Recursion in Paprika is where a category calls upon itself. You must provide at least some entries in the category which are 'base cases' - which *don't* reference their parent category.

	* muttering
	ehhh
	ummm
	gah
	ermm
	[muttering] darned memes...
	[muttering] wait a sec...
	[muttering] i don't get it...
	
Can produce: "ummm", or "ehhh darned memes..." but also "gah wait a sec... darned memes... i don't get it..."

It can get a bit out of control.

## How it got made

![Old Paprika](./posts/paprika-for-all/old-paprika.png)

Turning the rapid prototype that I wrote years ago (pictured) into a multi-user environment would have been a crazy task. Instead, over the last 4 months, I have used my Paprika.Net Nuget package to create a stateless Function App on Microsoft Azure. It has been really fun! I am also really stoked to have implemented LetsEncrypt for the first time, so Paprika.me.uk always uses HTTPS for your security.

My next step is to write up some extra pages for the Paprika site that make it super easy to set up your own twitter bot using the platform. For now I'll say that if you're a web dev, just mimic the way the Paprika.me.uk site sends its data to the API (username and password in headers, request in POST body) and that'll get you started!

## Thank you

If you read to the end, thanks so much. I hope you have a lot of fun with this project as I have for the last 3 years... hmmm that's a little sad 😀
