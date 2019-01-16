# Derived classes and Entity Framework Mapping

If you wanted to add extra (unmapped) data to an Entity Framework model, you might think to create a derived class to hold the extra fields, but this is a mistake and will cause more problems.

The usual way to add unmapped data to an EF class is to stick the `[NotMapped]` attribute on the new field, but for some reason on this occassion I did it differently, creating a derived class. Say I originally had a `Ship` class, and then wanted to link some crew but didn't want to map that, I made a new class `ShipWithCrew : Ship`.

The first problem you'll encounter is "Invalid column name 'Discriminator'." as soon as your code touches the derived class. The solution is to decorate the new `ShipWithCrew` class (the whole thing) as `[NotMapped]`, which will get you started. But then when you try to cast back to the base class to write to DB, you'll have a new problem:

	var dbShip = (Ship)shipWithCrew;
	Context.Ships.Add(dbShip);

This gave me the error: "Mapping and metadata information could not be found for EntityType ShipWithCrew". Weird. I cast it... isnt't it just writing a Ship to the ShipRepository? What's the problem? Well, check out this surprising C# fact:

	var shipWithCrew = new ShipWithCrew();
	
	//Strictly cast back to the base class
	Ship usingCast = (Ship)shipWithCrew;
	Ship usingAs = shipWithCrew as Ship;

	//Check the type is now Ship:
	Console.WriteLine(usingCast.GetType().ToString());
	Console.WriteLine(usingAs.GetType().ToString());
	
	//Both output 'ShipWithCrew'!!
	
Even if you cast into an explicitly base-class-typed variable, the type *will still be the derived class*. And that's why EF won't write it to the database.

So the best approach is to go back to basics, suck it up, and just add a new `[NotMapped]` property to the original model class!