# Writing .Net Events, the even shorter version

A follow up to my previous [quick start for writing C# events][1]. Let's assume you just want to raise a simple event which can be represented by `EventArgs`. If not, read the guide linked above.

## 1. Add a delegate above the class

    public delegate void FinishedHandler(object sender, EventArgs e);

    public class MyClassWhichFiresEvents
    {
		...
	}

	
## 2. Add a public event and a method to fire it inside the class

	public delegate void FinishedHandler(object sender, EventArgs e);

	public class MyClassWhichFiresEvents
    {
        public event FinishedHandler Finished;

        private void RaiseFinished()
        {
            Finished(this, new EventArgs());
        }

		...
	}
	
You can add more detail by using a properly qualified EventArgs or perhaps passing one into the `RaiseFinished()` method. Call `RaiseFinished()` anywhere you want to fire the event within your class. 


## 3. Handle the event in your consumer (your app or whatever)

	public class ConsumerClass
	{
		private MyClassWhichFiresEvents EventOwner;
		
		public ConsumerClass()
		{
			EventOwner = new MyClassWhichFiresEvents();
			EventOwner.Finished += EventOwner_Finished;
		}

		private void EventOwner_Finished(Object sender, EventArgs e)
		{
			// Handle the event
		}
	}


## Finished!

Hope it helps!

[1]: /upblog/write-your-own-events-in-csharp