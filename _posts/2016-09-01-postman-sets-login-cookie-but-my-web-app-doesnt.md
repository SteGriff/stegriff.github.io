# Postman sets login cookie but my web app doesn't

I just lost a lot of time on this one! I have a web app written in HTML/Javascript/Angular and hosted by grunt (at `localhost:8000`), and a back-end API written in C# and hosted by pressing play in Visual Studio (which uses a default ASP.Net Express instance at `localhost:8001`).

I have an API Controller Action at `localhost:8001/api/login/login` which sets a loginDetails cookie. If you use Postman (the chrome extension) to POST to it, then the cookie is created, and I could see from our `/login/GetCurrentUser` action that the cookie was there and could be used to retrieve a user.

However, the login screen of the web app would not set the cookie, and could not authenticate, even though it hit the same controller action. Weirdly, the response from the `login` action was the same whether it was responding to the login page or to Postman, and had the same `Set-Cookie` header.

## The Solution

The blog post that eventually pointed us to the problem was [Cookies with my CORS][ql] from QuickLeft. The problem lay with the browser, which was refusing to set the cookie described by the `Set-Cookie` header because we had missed a `withCredentials : true` on the POST to the action. It's that simple. So I basically made the following change in the Angular:

	//Before:
	post(url, data);
	
	//After:
	post(url, data, {withCredentials : true});
	
For more detail, check out the [blog post linked above][ql], and the Angular docs for [$http.post][post] and the [$http config object][config]

[ql]: https://quickleft.com/blog/cookies-with-my-cors/
[post]: https://docs.angularjs.org/api/ng/service/$http#post
[config]: https://docs.angularjs.org/api/ng/service/$http#usage
