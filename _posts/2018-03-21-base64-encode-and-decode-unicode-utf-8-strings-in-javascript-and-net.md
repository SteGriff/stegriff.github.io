# Base64 Encode and Decode Unicode (UTF-8) strings in JavaScript and .Net

The Base64 functions in JavaScript are made for ASCII values only. [MDN has an excellent code sample][MDN] for making this work with what *they* label UCS-2, but the [original source][source] labels as UTF-8. Hmm... in any case, it makes it safe for Unicode strings instead of just ASCII:

## JavaScript

(From MDN):

### Encode

	// ucs-2 string to base64 encoded ascii
	function utoa(str) {
		return window.btoa(unescape(encodeURIComponent(str)));
	}

### Decode

	// base64 encoded ascii to ucs-2 string
	function atou(str) {
		return decodeURIComponent(escape(window.atob(str)));
	}


## .Net

We can write an equivalent thing in .Net and choose our encoding (UTF-8 or otherwise) to make sure the data round-trips. I have tweaked these functions [I found on SO][SO] to be extensions (called like `myString.Base64Encode()`) using the `this` keyword but you could remove that to use them in `myString = Base64Encode(myString)` style.

### Encode

	public static string Base64Encode(this string plainText) {
	  var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
	  return System.Convert.ToBase64String(plainTextBytes);
	}

### Decode

	public static string Base64Decode(this string base64EncodedData) {
	  var base64EncodedBytes = System.Convert.FromBase64String(base64EncodedData);
	  return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
	}

[MDN]: https://developer.mozilla.org/en-US/docs/Web/API/WindowOrWorkerGlobalScope/btoa#Unicode_Strings
[source]: http://ecmanaut.blogspot.co.uk/2006/07/encoding-decoding-utf8-in-javascript.html
[SO]: https://stackoverflow.com/a/11743162/1761974