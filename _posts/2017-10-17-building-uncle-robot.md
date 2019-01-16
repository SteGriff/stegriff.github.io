# Building Uncle Robot

<div class="w-100 w5-l fr-l m2-l">
	<a class="twitter-timeline" data-height="600" href="https://twitter.com/RoboUncle?ref_src=twsrc%5Etfw">Tweets by RoboUncle</a>
	<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
</div>

This is an article for my muggle friends, to describe how I built my twitter bot, uncle robot.

## How does it write tweets?

In 2015, I created a language called 'Paprika' which is useful for generating random arrangements of language. How do you just 'create a language'? Well, I wrote a program (which runs on a web server) and it reads text files and expects them to fit this certain format I designed. These are 'grammar' files, and they basically work like mad-libs, if you've ever tried one of those. A dead simple (and fairly boring) grammar could be:

	* animal
	cat
	rat
	dog

	* animal ability
	flying
	underwater
	laser

	* animal phrase
	check out my [animal ability] [animal]

I could then call upon Paprika to give me an `[animal phrase]` and it would generate something like 'check out my flying rat' or 'check out my laser dog'. More options leads to more variety.

Over two years, for funsies, I built up more than 60 different templates in the vein of 'animal phrase' (which in turn call on hundreds of other definitions) to generate hopefully "funny" non-sequiturs. And it would be a shame for all this literary work and thesaurus use to go to waste, so I made a twitter bot.

## How does it post tweets?

![Flow to post tweets](./posts/building-uncle-robot/flow.png)

As mentioned above, the Paprika program runs on a web server. There is a bit of this program called an API (a web address which replies with data instead of a web page) to which I can send a grammar request, and it will fill in the blanks, or "resolve" the request and return the finished product. I have crafted the grammars so that basically I ask it for a `[tweet]` and it picks at random from the 60+ aforementioned templates, randomises all the funny bits, and responds with a tweet in plain text. 

I use a service called Microsoft Flow to do a simple 2-step process: Ask the Paprika service for a tweet - Post it to the @RoboUncle account. Flow is authorised for this twitter account like HootSuite or any other application you would give permission to use your account. It's configured to run this process every 10.5 hours currently (to sweep a few different timezones every week). If it tweeted too regularly, the templates would get too obvious.

## How does it interact?

**If you are a twitter employee, you have reached the end of this article. There is nothing more to read here, thanks for visiting**

So, I didn't know this to begin with, but I also wrote some features for uncle robot which turned out to be in breach of twitter's conditions of use. I have since turned the most objectionable of these features off. But when it went live, the toolkit I call "follower stats" (a slight misnomer) had the following abilities:

 * Follow-back anyone who is following me whom I do not currently follow (every 2-3 hours)
 * Pick a follower at random. Follow any of their followers who are in a follower defecit and are not in my list of exiles - limited to 10 new people (every 3-4 hours)
 * Pick 100 people who I follow, but who were not following me 24 hours ago, and are still not following me, and unfollow them (every 24 hours)
 
These are also API endpoints which I can schedule to run from Microsoft Flow, which ran them on the schedules listed above. I intended to carry out all of these tasks in a very responsible way, recording to a text file anyone who the bot had unfollowed so that it would **never bother them with a follow request/notification ever again** but despite this, use of the toolkit resulted in uncle being temporarily locked until I cleared his name by logging into web twitter with that account.

At that point I switched off the unfollow script and have not switched it back on since. I also turned down the schedules and limits on the other jobs, and these combined measures have done the trick - he hasn't been locked out again.

Due to his choice of who to follow, the follow-back rates are very good and this is why the bot has comparatively many followers. A huge proportion of these are in the middle east and india, which I attribute to:

 * Large base of twitter newbies in these territories means the bot is more likely to select them because they follow more accounts than follow them (this is what I call a follower defecit)
 * Snowball effect - the algorithm gets hooked into a given territory by following followers of its followers

 
## Conclusion

I would really like to be able to make it very easy for anyone to set up with these tools but that's not possible right at the moment. You can [play with Paprika in your browser][paprika] and it comes pre-loaded with all of my grammars (I should do something about this so that people can write their own...) and if you're the developer type, you can clone it from GitHub and host your own instance with your own grammars.

There is also a [.Net version of Paprika][paprikanet] which I am interested to make into a Logic App so that it can be neatly integrated with Microsoft Flow and eventually replace the PHP version above.

Anyway, thanks for reading! Be inspired, be silly, or don't.

[paprika]: http://paprika.me.uk
[paprikanet]: https://github.com/stegriff/paprika.net
