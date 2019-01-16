# Set up log4net in 2018

log4net is a logging library for .Net projects, it can be a bit tricky to set up, so here are my personal notes:


## 1. Install the package

Either from the NuGet Package Manager or with `Install-Package log4net`


## 2. Add a log4net.config

Create a new file in your project called `log4net.config`. Open its Properties window (F4) and set the **'Copy to Output Directory'** to 'Copy always' or 'Copy if newer'.

Here is my example content for a console app. For a web app, lose the console `appender` and `appender-ref` nodes:

	<log4net>
	  <root>
		<level value="ALL" />
		<appender-ref ref="console" />
		<appender-ref ref="file" />
	  </root>
	  <appender name="console" type="log4net.Appender.ConsoleAppender">
		<layout type="log4net.Layout.PatternLayout">
		  <conversionPattern value="%date %level %logger - %message%newline" />
		</layout>
	  </appender>
	  <appender name="file" type="log4net.Appender.RollingFileAppender">
		<staticLogFileName value="false" />
		<file value="logs\" />
		<datePattern value="yyyy-MM-dd'.log'" />
		<appendToFile value="true" />
		<rollingStyle value="Size" />
		<maxSizeRollBackups value="5" />
		<maximumFileSize value="10MB" />
		<layout type="log4net.Layout.PatternLayout">
		  <conversionPattern value="%date [%thread] %level %logger - %message%newline" />
		</layout>
	  </appender>
	</log4net>

	
## 3. Tell the assembly where to find the log4net config

Open the `Properties/AssemblyInfo.cs` for your project and add the following somewhere (I like to put it in the middle just after the assembly GUID):

	// Tell log4net where to find its config
	[assembly: log4net.Config.XmlConfigurator(ConfigFile = "log4net.config")]

Contrary to some advice, you don't need a similar `XmlConfigurator.Configure()` line in your web project `Global.asax`, it works fine without.

	
## 4. Log some nets!

At the top of a class where you want to use log4net, add the following field definition:

    private static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

Or slightly tidier:

	using log4net; 
	...
	private static readonly ILog log = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
	
Then, anywhere you want to log something (in a method or property body), call log4net like this:

	log.Info("Found my keys");
	log.Warn("Skipped invalid file " + fileName);
	log.Error("Galaxy collapsed", ex);

	
## 5. There is no five

You're done. Hope this helps you, future people :)
