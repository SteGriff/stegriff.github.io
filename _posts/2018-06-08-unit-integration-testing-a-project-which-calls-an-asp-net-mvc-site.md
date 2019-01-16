# Unit/Integration testing a project which calls an ASP.Net MVC site

In Visual Studio, running Tests does not run your Startup Projects. This is a pain if you're integration testing, and your client program calls an endpoint of your ASP.Net MVC or Web API site, because the site needs to be running, but isn't.

It took me a long time to [find a workaround][so], which is why I'm writing it here - I've shortened and amended the process from that answer.

[so]: https://stackoverflow.com/a/14384318/1761974

## Running an ASP.Net project simulatenously with your unit tests

 * On the ASP.Net project which needs to run during the tests, go to Project Properties
 * On the Web tab, change the Start Action to `Don't open a page. Wait for a request from an external application`
 * Now run your tests using either `Run All Tests` or `Debug All Tests` - both work fine
