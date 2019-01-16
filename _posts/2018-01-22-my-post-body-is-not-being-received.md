# My POST Body is not being received

This one trips me over all the time, lately when I've been triggering a HTTP POST action from Microsoft Flow. 

![Example fix for header on Flow](./posts/my-post-body-is-not-being-received/post-url-form.png)

## Symptoms

You've configured a POST request something like this:

	Method: POST
	URL:    https://my-service.example/Surface/DoThing
	Body:   accessKey=NyahNyah
	
But your tools/logs reveal that when it the request is received, the Body is completely missing. 

## Reason

This is because this Body format with `key=value` is only understood at the server if you send a `content-type` header of `application/x-www-form-urlencoded`

So the solution is to set the `content-type` header to `application/x-www-form-urlencoded`

In Flow, you can do this as pictured.

Future Ste, you're welcome.