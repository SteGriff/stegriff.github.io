# Updating Service Reference destroys most members in Reference.cs 

If you update or add a service reference in Visual Studio and you don't get all of the methods you were expecting, there was probably a silent error within the `svcutil` process which adds the reference.

You can check what the error is by running the command yourself. Open a Visual Studio Command Prompt, navigate to a non-admin directory (like C:/temp/) and run a command like this:

	svcutil /t:code http://localhost/Project/Something/MyService.svc /d:test /r:"C:\MyCode\MyAssembly\bin\debug\MyAssembly.dll"
	
The `d` option is the directory to spawn code into, and can be set to anything. The `r` options is a referenced assembly against which you want to check common types. So for example, my service publishes types from an `SG.Common.Messages` project which is also referenced by the project which is trying to add the Service Reference:

 * SG.Services.Common.Messages
 * SG.Services
     - Reference: SG.Services.Common.Messages
 * SG.Web
     - Reference: SG.Services.Common.Messages
	 - Service Ref: SG.Services (not working very well)

The command I ran looked something like this:

	svcutil /t:code http://localhost/SG/WidgetDemands/WidgetDemandsService.svc /d:test /r:"C:\Code\SgWidgetCloud\Src\SG.Services.Common.Messages\bin\Debug\SG.Services.Common.Messages.dll"

And the top of the output looked like this:

	Attempting to download metadata from 'http://localhost/SG/WidgetDemands/WidgetDemandsService.svc' using WS-Metadata Exchange or DISCO.
	Error: Cannot import wsdl:portType
	Detail: An exception was thrown while running a WSDL import extension: System.ServiceModel.Description.DataContractSerializerMessageContractImporter
	Error: List of referenced types contains more than one type with data contract name 'Demand' in namespace 'http://www.stegriff.co.uk/SG/WidgetsDemands/v1.0.0.0/'.
	Need to exclude all but one of the following types. Only matching types can be valid references:
	"SG.Services.Common.Messages.Renewals.Demand, SG.Services.Common.Messages, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null" (not matching)
	"SG.Services.Common.Messages.NewBusiness.Demand, SG.Services.Common.Messages, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null" (matching)
	XPath to Error Source: //wsdl:definitions[@targetNamespace='http://tempuri.org/']/wsdl:portType[@name='IPanelProductQuotationsService']

...so I can see that I have two types in the service namespace both called 'Demand', and that's the error. For me, the fix was to change one of them to 'DemandIdentifier', but I could have rationalised that class altogether and re-used the same class for both purposes.

There are more examples of what could be wrong in this SO answer (which was one of my sources for solving the problem); [Sometimes adding a WCF Service Reference generates an empty reference.cs][so].

[so]: https://stackoverflow.com/a/8749098