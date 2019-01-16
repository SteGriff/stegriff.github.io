# Easy API testing without Postman

![Example hurl.it response](./posts/easy-postman/response.png)

The big name in API testing is usually [Postman][postman]. It used to be a Chrome extension and now it's standalone, but as a Firefox user I never got into it. A few of my colleagues use it for ad-hoc testing of APIs.
Today I came across a neat web app now operated by the [Runscope][runscope] guys called [hurl.it][hurl], which is a good ad-hoc testing tool if you don't want to download and install a whole thing.

[postman]: https://www.getpostman.com/
[runscope]: https://www.runscope.com/

## For example

I was just using some Microsoft Teams webhooks today and I wanted to send a test message to my connector as described in [this post by Stefan Stranger][webhook]. 

And... actually I started writing this post weeks ago and now I've come back to it, I forgot what I was talking about. Basically [hurl.it][hurl] is neat because you can:

 * Tweak all the tricky parameters that are hard to get right if you just make a basic HTML form for testing your endpoint.
 * See the request and response bodies
 * Look back through previous responses.
 
*What more could you want?!*

Cheers!

[webhook]: https://blogs.technet.microsoft.com/stefan_stranger/2016/11/03/use-webhook-connector-to-send-data-from-powershell-to-microsoft-teams/
[hurl]: https://www.hurl.it/
