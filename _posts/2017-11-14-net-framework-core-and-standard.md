# .Net Framework, Core, and Standard

![New Dot Net Standard Project](./posts/net-core/new-standard-project.png)

The distinction between these three concepts of .Net Framework, Core, and Standard, has long lay in a foggy corner of my brain saying "Danger! You do not understand the future of the primary technologies you use for everything!". So I was glad when recently I was forced into understanding these things when I tried to create a NuGet package.

By far the best post I have found on this is from the .Net blog; [Introducing .NET Standard][introducing].

[introducing]: https://blogs.msdn.microsoft.com/dotnet/2016/09/26/introducing-net-standard/

## A parable

So to explain, imagine you are making an `Acme.Utilities` library which you want to publish as a package. You build it in .Net Framework 4.5, and pack it up. 

You go to test your package by starting a new Console App and importing it. You feel that Visual Studio 2017 is twisting your arm into making a Console App using .Net Core, so you go for that. Unsurprisingly, when you import your package, it complains that your app and the package are not compatible - this is because .Net Core 1.x and .Net Framework 4.5 are "not compatible" (please excuse this simplification for now).

So now you're thinking, "Well, do I have to make a copy of my package code for every single framework I want to target?" - **No!**

## What to do

To integrate with the .Net Framework *and* with .Net Core, your library project needs to target **.Net Standard**, check out this kickin' table ([source][tablesource]):

[tablesource]: https://github.com/dotnet/standard/blob/master/docs/versions.md

<table>
<thead>
<tr>
<th align="left"><div align="right">.NET Standard</div></th>
<th align="right"><a href="/dotnet/standard/blob/master/docs/versions/netstandard1.0.md">1.0</a></th>
<th align="right"><a href="/dotnet/standard/blob/master/docs/versions/netstandard1.1.md">1.1</a></th>
<th align="right"><a href="/dotnet/standard/blob/master/docs/versions/netstandard1.2.md">1.2</a></th>
<th align="right"><a href="/dotnet/standard/blob/master/docs/versions/netstandard1.3.md">1.3</a></th>
<th align="right"><a href="/dotnet/standard/blob/master/docs/versions/netstandard1.4.md">1.4</a></th>
<th align="right"><a href="/dotnet/standard/blob/master/docs/versions/netstandard1.5.md">1.5</a></th>
<th align="right"><a href="/dotnet/standard/blob/master/docs/versions/netstandard1.6.md">1.6</a></th>
<th align="right"><a href="/dotnet/standard/blob/master/docs/versions/netstandard2.0.md">2.0</a></th>
</tr>
</thead>
<tbody>
<tr>
<td align="left">.NET Core</td>
<td align="right">1.0</td>
<td align="right">1.0</td>
<td align="right">1.0</td>
<td align="right">1.0</td>
<td align="right">1.0</td>
<td align="right">1.0</td>
<td align="right"><strong>1.0</strong></td>
<td align="right"><strong>2.0</strong></td>
</tr>
<tr>
<td align="left">.NET Framework</td>
<td align="right">4.5</td>
<td align="right"><strong>4.5</strong></td>
<td align="right"><strong>4.5.1</strong></td>
<td align="right"><strong>4.6</strong></td>
<td align="right">4.6.1</td>
<td align="right">4.6.1 <del>4.6.2</del></td>
<td align="right">4.6.1 <del>vNext</del></td>
<td align="right"><strong>4.6.1</strong></td>
</tr>
<tr>
<td align="left">Mono</td>
<td align="right">4.6</td>
<td align="right">4.6</td>
<td align="right">4.6</td>
<td align="right">4.6</td>
<td align="right">4.6</td>
<td align="right">4.6</td>
<td align="right"><strong>4.6</strong></td>
<td align="right"><strong>5.4</strong></td>
</tr>
<tr>
<td align="left">Xamarin.iOS</td>
<td align="right">10.0</td>
<td align="right">10.0</td>
<td align="right">10.0</td>
<td align="right">10.0</td>
<td align="right">10.0</td>
<td align="right">10.0</td>
<td align="right"><strong>10.0</strong></td>
<td align="right"><strong>10.14</strong></td>
</tr>
<tr>
<td align="left">Xamarin.Mac</td>
<td align="right">3.0</td>
<td align="right">3.0</td>
<td align="right">3.0</td>
<td align="right">3.0</td>
<td align="right">3.0</td>
<td align="right">3.0</td>
<td align="right"><strong>3.0</strong></td>
<td align="right"><strong>3.8</strong></td>
</tr>
<tr>
<td align="left">Xamarin.Android</td>
<td align="right">7.0</td>
<td align="right">7.0</td>
<td align="right">7.0</td>
<td align="right">7.0</td>
<td align="right">7.0</td>
<td align="right">7.0</td>
<td align="right"><strong>7.0</strong></td>
<td align="right"><strong>8.0</strong></td>
</tr>
<tr>
<td align="left">Universal Windows Platform</td>
<td align="right">10.0</td>
<td align="right">10.0</td>
<td align="right">10.0</td>
<td align="right">10.0</td>
<td align="right"><strong>10.0</strong></td>
<td align="right">10.0.16299</td>
<td align="right">10.0.16299</td>
<td align="right"><strong>10.0.16299</strong></td>
</tr>
<tr>
<td align="left">Windows</td>
<td align="right">8.0</td>
<td align="right"><strong>8.0</strong></td>
<td align="right"><strong>8.1</strong></td>
<td align="right"></td>
<td align="right"></td>
<td align="right"></td>
<td align="right"></td>
<td align="right"></td>
</tr>
<tr>
<td align="left">Windows Phone</td>
<td align="right">8.1</td>
<td align="right">8.1</td>
<td align="right"><strong>8.1</strong></td>
<td align="right"></td>
<td align="right"></td>
<td align="right"></td>
<td align="right"></td>
<td align="right"></td>
</tr>
<tr>
<td align="left">Windows Phone Silverlight</td>
<td align="right"><strong>8.0</strong></td>
<td align="right"></td>
<td align="right"></td>
<td align="right"></td>
<td align="right"></td>
<td align="right"></td>
<td align="right"></td>
<td align="right"></td>
</tr></tbody></table>

When you are making a new class library project in VS, you may have noticed that you can pick between "Classic Windows Desktop", ".Net Core", and ".Net Standard". I would say that if you want interoperability, then .Net Standard is always the one to go for.

You should aim to support the **lowest .Net Standard version you possibly can**, bearing in mind that some of the features you want won't be available in lower Standard versions. For example, I make use of `Path.DirectorySeparatorChar` in one project, and this API is only available in Standard 1.3+

## Conclusion

In essence, .Net Standard gives you a way of writing .Net code which can work in multiple different calling frameworks as long as they support the API standard which you wrote it to.

