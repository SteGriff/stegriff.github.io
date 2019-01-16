# Outer join without an 'on' clause in SQL

You can do an old-style join using a comma `,` between table selections to perform a full outer join which has no 'on' clause.

Say you have a table for Ships and a table for ShipAttributes which lets you extend Ship by adding arbitrary extra data fields. You want to add two new attributes to every ship matching a certain condition (like ID starting with 'NCC-'). So what you really want is to select every ship matching the condition, and full outer join it on your two attributes, such that every ship gets "every" new attribute.

	insert into ShipAttributes (ShipAttributeId, Name, Value, ShipId)
	select *
	from
	(
		select ShipId from Ship where ShipId like 'NCC-%'
	) as ships
	,
	(
		select CONVERT(uniqueidentifier, NEWID()) as ShipAttributeId, 'Manufacturer' as Name, 'TerranIndustrial' as Value
		union select CONVERT(uniqueidentifier, NEWID()) as ShipAttributeId, 'SubspaceScanRange' as Name, '8200' as Value
	) as attributes

This can also save you from certain errors in MS SQL syntax.

In another scenario, you may want to filter some of the results to emulate a left or right outer join, and you can do so with a simple `where`:

	select *
	from
		someTableOrSubQuery as ship,
		someOtherTableOrSubQuery as crew
	where crew.ShipId = ship.ShipId
	
This style of SQL is actually the only one supported in certain older engines which don't have the `join` keyword! So enjoy that trivia :)