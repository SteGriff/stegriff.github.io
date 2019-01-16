# How to do a 301/302 redirect in an Azure Function App with HttpResponseMessage

Azure Function Apps' use the `HttpRequestMessage` and `HttpResponseMessage` classes introduced with .Net Fx 4.5 (which are heavily used in .Net Core Web API projects). It takes a little bit of re-learning to do the normal web stuff you're used to doing, like redirects.

To do a redirect with `HttpResponseMessage`, make a new message with the `Moved` code (for 302, or `Redirect` for 301), and then set the `Headers.Location` to your target page. For example:

	HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.Moved);
	response.Headers.Location = location;
	return response;
	
In the Azure Function App environment, you may instead wish to use the `req.CreateResponse()` pattern:

	HttpResponseMessage response = req.CreateResponse(HttpStatusCode.Moved);
	response.Headers.Location = location;
	return response;
	
I've tested it and it works just the same.

Happy hacking

