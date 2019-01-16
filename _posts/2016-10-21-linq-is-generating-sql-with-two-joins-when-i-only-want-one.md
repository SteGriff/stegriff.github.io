# LINQ is generating SQL with two joins when I only want one

If you have a lot of conditions in your LINQ statement, sometimes LINQ-to-SQL does it wrong:

	var query = from
					pp in Context.ProductPrices
				where
					productCodes.Contains(pp.Product.ProductCode) &&
					pp.PriceList == priceList &&
					pp.Product.AccountNumber == customer.AccountNumber
				select new { Price = pp.Price, ProductCode = pp.Product.ProductCode }

Generates this:

	SELECT 
	1 AS [C1], 
	[Extent1].[Price] AS [Price], 
	[Extent3].[ProductCode] AS [ProductCode], 
	...
	[Extent3].[Colour] AS [Colour]
	FROM   [dbo].[ProductPrice] AS [Extent1]
	INNER JOIN [aop].[CustomerProduct] AS [Extent2] ON 	[Extent1].[ProductCode] = [Extent2].[ProductCode]
	LEFT OUTER JOIN [aop].[CustomerProduct] AS [Extent3] ON [Extent1].[ProductCode] = [Extent3].[ProductCode]
	WHERE (N'ABC123' = [Extent1].[ProductCode]) AND ([Extent1].[PriceList] = @p__linq__0) AND ([Extent2].[AccountNumber] = @p__linq__1)

Notice how there is both an `inner join` and a `left outer join` on `CustomerProduct`. This is because of the repeated use of `pp.Product` in the query.

## How to fix it

Use LINQ's `let` keyword to cache the result of the property access:

	var query = from
					pp in Context.ProductPrices
				let
					prod = pp.Product
				where
					productCodes.Contains(prod.ProductCode) &&
					pp.PriceList == priceList &&
					prod.AccountNumber == customer.AccountNumber
				select new { Price = pp.Price, ProductCode = prod.ProductCode }
				
Now you can safely re-use the `prod` variable as many times as you want in the query and LINQ will always use the same database entity instead of creating another join.

	SELECT 
	1 AS [C1], 
	[Extent1].[Price] AS [Price], 
	[Extent2].[ProductCode] AS [ProductCode], 
	...
	[Extent2].[Colour] AS [Colour]
	FROM  [dbo].[ProductPrice] AS [Extent1]
	INNER JOIN [aop].[CustomerProduct] AS [Extent2] ON [Extent1].[ProductCode] = [Extent2].[ProductCode]
	WHERE (N'ABC123' = [Extent2].[ProductCode]) AND ([Extent1].[PriceList] = @p__linq__0) AND ([Extent2].[AccountNumber] = @p__linq__1)
	
So you can see the adjusted query doesn't generate an `Extent3` at all, which is much better!