# State Machine from Scratch

In most languages and frameworks, good State Machine libraries exist, like [Stateless][stateless]. Use them when possible. When it's not possible, there are principles you need to have in your head before you start.

**tl;dr:** A `FromState` can go to a `ToState` when some `Trigger` causes a `Transition` only if some `GuardCondition` is met.

Decide whether you're building a generic state machine or a specialised one. Are you going to need *other*, differently-configured StateMachines in this solution? Or is this the only one? Are you building a library or a user story? Maybe you want to write the simplest thing that works, and refactor later.

**This is not a definitive guide;** it's more a like a public notebook page :)

[stateless]: https://github.com/dotnet-state-machine/stateless


## A StateMachine Class

Can have:

 * A Current State (usually an enum, the state that the machine is in now)
 * A Model (the data which the user has interacted with, which may be valid or invalid for some given transition trigger) although you may instead wish to uncouple the model from the SM and have it as a sibling member of whatever class is doing the work.
 * A list of allowed transitions `<FromState, Trigger, ToState, GuardCondition>`
 * Events which correspond to transitions between particular states `Event(FromState, ToState, Trigger)` so that the consuming class can do something when a particular transition takes place. The trigger is a necessary disambiguator because there might be two valid transitions from state A to state B for two different reasons. 

 
## Naive Implementation

If you know up front that all states have the same triggers then these could be methods of the SM:

	class StateMachine
		- State
		- Model
		- ForwardTransitions<State,State>
		- BackTransitions<State,State>
		+ Forward()
		+ Back()
		+ Reset()
		
And the Forward subroutine checks that the transition exists and the condition is met:

	void Forward()
		Transition = ForwardTransitions.For(State)
		If Transition?.ConditionMet(Model)
			State = Transition.NextState

Even lazier, if you don't want to shape out a Transition class but instead are maintaining a list of `<FromState, ToState>` and want to hard-code the guard conditions to get an 80% solution:

	void Forward()
		Allow = False
		Switch (State)
			Case WelcomeState:
				Allow = Model.Name.IsSomething
			Case AgeState:
				Allow = Model.Age >= 18
				
		If Allow
			Transition = ForwardTransitions.For(State)
			State = Transition.NextState

	
## More Sophisticated

In any more complex scenario, you won't be able to hard-code either the triggers or the guard clauses. They should be given to the StateMachine at config time; triggers could be Enums and Guard clauses could be lambdas (or `Func` or similar in C#).


## Doing a Transition when a Trigger happens

Your code which calls the StateMachine trigger needs to know the result. Two ways to acheive this are:

 * Trigger sub returns a bool or a nicer Status object of some kind
 * The StateMachine fires an event having `<FromState, ToState, Trigger>` and your calling code is attached to that event

 
## Conclusion

Like I said, not a definitive guide, but hopefully future me/someone else finds this helpful to get a quick overview of state machine code concepts.