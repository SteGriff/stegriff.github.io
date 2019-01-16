# Tiny angular pangram app

A pangram is a sentence that contains every letter of the alphabet, like "the quick brown fox jumps over the lazy dog". I set out to make a tiny pangram app this morning in Angular, that would let you type in a box and "tick off" the letters after you fulfilled each one, so that you can try to write your own.

I start with a script block featuring an Angular app and controller definition but after a little iteration, I managed to winnow it down to the point where there is no angular boilerplate whatsoever! The whole thing works in calculated attributes!

P.s. My favourite so far is: "Waive morbid bacon prerequisite - fight exactly zero jocks"

### The app

Here's the app running in this page (I had to use a body-level `style` block... forgive me...):

<div ng-app>
<style>
	.spare{color:red;}
	.used{text-decoration:line-through; color:blue;}
	.w-100{width:100%;}
</style>
<input class="w-100" ng-model="input" placeholder="Type in here...">
<span
	ng-repeat="letter in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('')"
	class="spare"
	ng-class="{'used' : (input.toUpperCase().indexOf(letter) > -1)}">{{letter}} </span>

<script src="/lib/angular157/angular.min.js"></script>
</div>

-----

### The source

As a standalone web page:

<script src="https://gist.github.com/SteGriff/647d8693b1de9de5bd7555045070c07c.js"></script>

Or [view the source of this blog post](./posts/tiny-angular-pangram-app.md)

Angular is cool sometimes!