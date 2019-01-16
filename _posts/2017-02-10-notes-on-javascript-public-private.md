# Notes on JavaScript public/private

Imagine we want to write a simulation of a `House` class with some private fields for storing internal information, and some public getters, setters, and other methods, which can use the internal information in a safe way. I'm going to use this as an example to explore some deeply JavaScripty concepts. This will be our basic chassis, the defining function:

	function House()
	{
	}
	
## Adding a public variable

[Crockford][js1] tells us that anything added to `this` will behave like a public instance variable.

	function House()
	{
		this.town = "Southport";
	}

	var house1 = new House();
	var house2 = new House();

	console.log("House1", house1.town);
	console.log("House2", house2.town);
	
	//Output:
	//House1 Southport
	//House2 Southport


## Adding a private variable

To make a private variable, we use a regular `var` phrase inside the defining function:

	function House()
	{
		this.town = "Southport";
		var instructions = "Leave parcels under fake rock"
	}

	var house1 = new House();

	//Public - succeeds
	console.log("Town", house1.town);

	//Private - returns undefined
	console.log("Instructions", house1.instructions);


## Adding a public function

Now, what we have been calling the "defining function" is truly known as the "prototype". It is the mold by which other objects will be created. So it's a lot like a class.

We can attach a public function to the prototype in two different ways; when we're creating it, or afterwards.

	function House()
	{
		this.doorIsOpen = false;
		var instructions = "Leave parcels under fake rock"
		
		this.openDoor = function()
		{
			this.doorIsOpen = true;
		}
	}

	var house1 = new House();

	console.log("Door is open?", house1.doorIsOpen);
	house1.openDoor();
	console.log("Door is open?", house1.doorIsOpen);

	//Output:
	//Door is open? false
	//Door is open? true

And the equivalent addition by prototype:

	function House()
	{
		this.doorIsOpen = false;
		var instructions = "Leave parcels under fake rock"
	}

	House.prototype.openDoor = function()
	{
		this.doorIsOpen = true;
	}

	var house1 = new House();

	console.log("Door is open?", house1.doorIsOpen);
	house1.openDoor();
	console.log("Door is open?", house1.doorIsOpen);

	//Output:
	//Door is open? false
	//Door is open? true

	
## Now the gotcha

If you're from a classical background, like me, you might presume to write a public accessor to a private property. You might presume to do so in the **prototypal** way I just described:

	function House()
	{
		this.doorIsOpen = false;
		var instructions = "Leave parcels under fake rock"
	}

	House.prototype.getInstructions = function()
	{
		//Throws an error - doesn't have access to instructions
		return instructions;
	}

	var house1 = new House();

	//It isn't gonna work
	console.log("Instructions", house1.getInstructions());

However, if we write it the **constructor**, there's no problem, because `getInstructions` becomes a *closure*:

	function House()
	{
		this.doorIsOpen = false;
		var instructions = "Leave parcels under fake rock"
		
		this.getInstructions = function()
		{
			//This works; inner functions in js have access to all the variables in the outer function
			return instructions;
		}
	}

	var house1 = new House();

	console.log("Instructions", house1.getInstructions());
	
[js1]: http://javascript.crockford.com/private.html
