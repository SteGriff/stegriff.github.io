# ASMX Service raises 500 error and returns binary nonsense

There are a few cases when an ASMX service in ASP.Net can return a 500 error and a load of junk binary data. Here are the probable causes and solutions:

## "I attach Visual Studio to the running code, but the server-side function is never even reached"

The parameters to the function were passed incorrectly. Check the names, **cases**, and data types of the parameters to your serverside function. These need to be passed exactly by a JSON object in your calling code.

**Server method in MyWebService.asmx:**

	[WebMethod]
	[ScriptMethod]
	public bool CheckValidity(string discountCode)
	{
		//Do stuff
	}
	
**Calling code in HTML/JS:**
	
	var promoCode = "FREESTUFF";
	var res = $.ajax({
		type: "POST",
		async: false,
		url: location.protocol + "//" + location.host + "/Services/MyWebService.asmx/CheckValidity",
		data: "{discountCode:'" + promoCode + "'}",
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		success: function (data) {
			if (!data || !data.d) {
				IsValid = false;
				return;
			}
			if (data.d === true) {
				IsValid = true;
				return;
			}
		},
		error: function () {
			IsValid = false;
			return;
		}
	});

## "I can attach and the function gets called"

You simply have a fatal error in your code, which you should be able to see and diagnose.

